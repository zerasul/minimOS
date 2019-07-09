; 8 KiB micro-VDU for minimOS!
; v0.6a1
; (c) 2019 Carlos J. Santisteban
; last modified 20190709-1511

#include "../usual.h"

; this for debugging only!
#include "vdu-aca.h"

; ***********************
; *** minimOS headers ***
; ***********************
.(
; *** begins with sub-function addresses table ***
	.byt	192			; physical driver number D_ID (TBD)
	.byt	A_BOUT		; output driver, non-interrupt-driven
	.word	va_err		; does not read
	.word	va_prn		; print N characters
	.word	va_init		; initialise device
	.word	va_rts		; no periodic interrupt, thus...
	.word	0			; frequency makes no sense
	.word	va_err		; D_ASYN does nothing
	.word	va_err		; no config
	.word	va_err		; no status
	.word	va_rts		; shutdown procedure does nothing
	.word	va_text		; points to descriptor string
	.word	0			; reserved, D_MEM

; *** driver description ***
va_text:
	.asc	"8 kiB micro-VDU v0.6", 0

va_err:
	_DR_ERR(UNAVAIL)	; unavailable function

; *** define some constants ***
	VA_BASE	= $6000		; screen start, not necessarily 8K-aligned if smaller screen
	VA_END	= $7FFF		; must specify last address, in case the whole 8K block is not used

	VA_WDTH = 36			; screen size
	VA_HGHT = 28			; screen size

	VA_SCAN	= 8			; number of scanlines (pretty hardwired)

	crtc_rs	= VA_END-1		; *** 6845 addresses at VRAM end ***
	crtc_da	= VA_END


; define SEPARATORS in order to use a shorter table by letting 28-31 as printable!
#define	SEPARATORS	_SEPARATORS

; *** zeropage variables ***
	v_dest	= $E8		; generic writes, was local2, perhaps including this on zeropage.h? aka ptc
	v_src	= $EA		; font read, is this OK? aka ptl

; ************************
; *** initialise stuff *** should create line addresses table...
; ************************
va_init:
; first must make sure desired address range is free! TO DO TO DO

; must set up CRTC
	LDX #11				; last common register
; load 6845 CRTC registers
vi_crl:
		STX crtc_rs			; select this register
		LDA va_data, X		; get value for it
		STA crtc_da			; set value
		DEX					; next address
		BPL vi_crl			; continue until done
	INX
; reset inverse video mask! X is 0
	STX va_xor			; clear mask is true video
	STX va_cur			; eeeeeeeeeeeeek
; new, set RAM pointer to supplied font!
	LDA #<vs_font		; get supplied LSB (2) *** now using a RAM pointer
	STA va_font			; store locally (4)
	LDA #>vs_font		; same for MSB (2+4) *** ditto for flexibility
	STA va_font+1
; start address and software cursor will be set by CLS routine!

; CLC makes little sense even if there is no splash code
;	JSR va_cls			; reuse code from Form Feed, but needs to return for the SPLASH screen!
; **************************
; *** splash screen code ***
; **************************
; ****************************
; *** end of splash screen ***
; ****************************
; if not used may just use CLC above and let it fall into CLS routine ***
;	_DR_OK				; installation succeeded

; ***************************************
; *** routine for clearing the screen ***
; ***************************************
va_cls:
	LDA #>VA_BASE		; base address (2+2) NOT necessarily page aligned!
	LDY #<VA_BASE
; must set this as start & cursor address!
	LDX #12				; CRTC screen start register, then comes cursor address (2)
vc_crs:					; * this loops takes 49t *
		STX crtc_rs
		STA crtc_da			; set MSB... (4+4)
		INX					; next register (2)
		STX crtc_rs
		STY crtc_da			; ...and LSB (4+4)
		INX					; try next value (2)
		CPX #16				; all done? (2+3 twice, minus 1)
		BNE vc_crs
; clear VRAM area
	LDX #0					; reset index (2)
	STX va_x			; ...plus coordinates as well (4+4)
	STX va_y
	STX v_dest			; keep LSB zero as will use Y as index
	STA v_dest+1			; set pointer MSB (3)
	TXA					; clear value, as no STX (zp), Y
vcl_c:
		STA (v_dest), Y		; set this byte (5)
		INY					; go for next (2+3)
		BNE vcl_c
			INC v_dest+1		; check following page eeeeeeeeek (5)
			LDX v_dest+1		; how far are we? (3) eeeeeeeeeeek
			CPX #>VA_END		; already at last page? (2)
		BNE vcl_c			; no, continue as usual (3)
; otherwise, do not fill the whole page as will affect the 6845!
; this takes 7 bytes & 3047 clocks
vcl_l:
		STA (v_dest), Y		; set this byte (5)
		INY					; go for next (2)
		CPY #<VA_END			; all except last two? (2+3)
		BNE vcl_l
	_EXIT_OK			; worth it as comparisons set C

; *********************************
; *** print block of characters *** mandatory loop
; *********************************
va_prn:
	LDA bl_ptr+1		; get pointer MSB
	PHA					; in case gets modified...
	LDY #0				; reset index
vp_l:
		_PHY				; keep this
		LDA (bl_ptr), Y		; buffer contents...
		STA io_c			; ...will be sent
		JSR va_char			; *** print one byte *** might be inlined
;			BCS va_exit			; any error ends transfer!
		_PLY				; restore index
		INY					; go for next
		DEC bl_siz			; one less to go
			BNE vp_l			; no wrap, continue
		LDA bl_siz+1		; check MSB otherwise
			BEQ va_end			; no more!
		DEC bl_siz+1		; ...or one page less
		_BRA vp_l
va_exit:
	PLA					; discard saved index
va_end:
	PLA					; get saved MSB...
	STA bl_ptr+1		; ...and restore it
va_rts:
	RTS					; exit, perhaps with an error code

; ******************************
; *** print one char in io_c ***
; ******************************
va_char:
	LDA io_c			; get char (3)
; ** first of all, check whether was waiting for an extra byte (or two) **
	LDX va_col			; something being set?
	BEQ va_nbin			; if not, continue with regular code
		_JMPX(va_xtb-16)	; otherwise process accordingly (using another table, note offset)

; *** *** much closer control code, may be elsewhere *** ***
; * * expects row byte... * *
vch_atyx:
	SEC
	SBC #' '			; from space and beyond
; compute new Y pointer...
#ifdef	SAFE
	CMP #VA_HGHT			; over screen size?
	BCC vat_yok
		_DR_ERR(INVALID)	; ignore if outside range
vat_yok:
#endif
	STA va_y			; set new value
	INC va_col			; flag expects second coordinate... routine pointer placed TWO bytes after!
	INC va_col
	_DR_OK				; just wait for the next coordinate

; * * ...and then expects column byte, note it is now 25, no longer 24! * *
vch_atcl:
	SEC
	SBC #' '			; from space and beyond
; add X and set cursor...
#ifdef	SAFE
	CMP #VA_WDTH			; over screen size?
	BCC vat_xok
		_DR_ERR(INVALID)	; ignore if outside range
vat_xok:
#endif
	STA va_x			; coordinates are set
	JSR vch_scs			; set cursor
		_BRA va_mbres		; reset flag and we are done

; * * take byte as FG colour * * set inverse if zero!
vch_ink:
	_STZX va_col			; clear flag before!
	TAX					; check whether zero
	BNE vch_cend			; no, just ignore
		_BRA vch_so			; yes, enable inverse
; * * take byte as BG colour * * disable inverse if zero (vch_ink reuses some code)
vch_papr:
	_STZX va_col			; clear flag before!
	TAX					; check whether zero
		BEQ vch_si			; yes, disable inverse
vch_cend:
	RTS						; *** no need for DR_OK as BCS is not being used

; ** check whether control char or printable **
va_nbin:
#ifdef	SEPARATORS
	CMP #28				; from this one, all printable!
#else
	CMP #' '			; printable? (2)
#endif
		BCS vch_prn			; it is! skip further comparisons (3)
; **** identify possible control codes ****
	ASL					; character code times two
	TAX					; is now an index
		_JMPX(va_c0)		; new, operate according to C0 code table

; *** *** much closer control routines, can be placed anywhere *** ***
; * * EON (inverse video) * *
vch_so:
	LDA #$FF			; mask for reverse video
	BNE vso_xor			; set mask and finish, no need for BRA

; * * EOF (true video) * * vch_so reuses some code
vch_si:
		LDA #0				; mask for true video eeeeeeeeeek
; common code for EON & EOFF
vso_xor:
	STA va_xor			; set new mask
	RTS					; all done for this setting *** no need for DR_OK as BCS is not being used

; * * XON (cursor on) * *
vch_sc:
	LDA #96				; value for visible cursor, slowly blinking
	BNE vc_set			; put this value on register, no need for BRA

; * * XOFF (cursor off) * * vch_sc reuses some code
vch_hc:
		LDA #32				; value for hidden cursor
; common code for XON & XOFF
vc_set:
	LDX #10				; CRTC cursor register
	STX crtc_rs			; select register...
	STA crtc_da			; ...and set data
	RTS					; all done for this setting

; * * HOME (without clearing) * *
va_home:
	_STZA va_y			; reset row... and fall into HOML

; * * HOML (CR without LF) * *
va_homl:
	_STZA va_x			; just reset column
	_BRA va_rtnw			; update cursor and exit

; * * cursor left * *
vch_left:
	LDX va_x			; check whether at leftmost column
	BNE vcl_nl			; no, proceed
		RTS				; yes, simply ignore!
vcl_nl:
	DEC va_x			; previous column
	_BRA va_rtnw			; standard end

; * * cursor right * * also used by normal printing
vch_rght:
	INC va_x			; point to following column
	CMP #VA_WDTH			; over line length?
	BNE va_rtnw
		_STZX va_x			; if so, back to left...
; ...and fall into cursor down!

; * * cursor down * *
vch_down:
		INC va_y			; advance row
va_rtnw:				; **** common exit point ***
	JMP vch_scs			; update cursor and exit

; * * cursor up * *
; this is expected to be much longer, as may need to scroll up!
vch_up:
	LDX va_y			; check if already at top
	BNE vcu_nt			; no, just update coordinate
; otherwise, scroll up... TO DO
vcu_nt:
	DEC va_y			; one row up
	JMP vch_scs			; update cursor and exit (already checked for scrolling, may skip that)

; * * request for extra bytes * *
vch_dcx:
	STA va_col			; set flag if any colour or coordinate is to be set
	RTS					; all done for this setting *** no need for DR_OK as BCS is not being used

; * * direct glyph printing (was above) * * should be close to actual printing
vch_dle:				; * process byte as glyph *
	_STZX va_col		; ...but reset flag! eeeeeeeek^2
		_BRA vch_prn		; NMOS might use BEQ instead, but not for CMOS!

; * * non-printable neither accepted control, thus use substitution character * *
vch_npr:
	LDA #'?'			; unrecognised char
	STA io_c			; store as required

; **** actual printing ****
; *** convert ASCII into pointer offset, needs 11 bits ***
vch_prn:
	_STZA io_c+1		; clear MSB (3)
	LDX #3				; will shift 3 bits left (2)
vch_sh:
		ASL io_c			; shift left (5+5)
		ROL io_c+1
		DEX					; next shift (2+3)
		BNE vch_sh
; add offset to font base address
	LDA va_font			; add to base... (4+2) *** now using a RAM pointer
	CLC
	ADC io_c			; ...the computed offset (3)
	STA v_src			; store locally (3)
	LDA va_font+1		; same for MSB (4+3) *** ditto for flexibility
	ADC io_c+1
;	DEC					; in case the font has no non-printable glyphs
	STA v_src+1			; is source pointer (3)
; create local destination pointer
	LDA va_y			; current absolute row
; multiply by 36 (32+4), change code if different width
	ASL
	ASL					; times 4
	STA va_col			; store 4x
	ASL
; must check carry! TO DO TO DO
	ASL
	ASL					; times 32
	CLC
	ADC va_col			; 32y + 4y = 36y

	ADC va_x			; and now add column offset
	STA v_dest			; will be destination pointer (3+3)
	STY v_dest+1
; copy from font to VRAM
	LDY #VA_SCAN-1		; scanline counter (2)
vch_pl:
		LDA (v_src), Y		; get glyph data (5)
		EOR va_xor			; apply mask! (4)
		STA (v_dest), Y		; store into VRAM (5)
; advance to next scanline
		DEY					; next (previous) font byte (2)
		BNE vch_pl			; continue otherwise (3)
; printing is done, now advance current position
	JMP vch_rght		; *** this is actually cursor right! ***
vch_scs:
; check whether scrolling is needed *** RECOMPUTE USING TABLE
; it is assumed that only UPCU may issue a scroll up, thus not checked here
	LDA va_y		; actual row
	CMP #VA_HGHT		; over last line?
	BNE vch_ok		; no, just exit (3/2)

vch_ok:
; set cursor position from separate coordinates, might be inlined
	LDA va_y			; current absolute row
; TODO TODO TODO
vsc_cok:
; set CRTC registers, note MSB is on Y and LSB on A! worth another?
	LDX #14				; cur_h register on CRTC (2)
	STX crtc_rs			; select register
	STY crtc_da			; ...and set data MSB
; go for next
	INX					; next reg (2)
	STX crtc_rs			; select register
	STA crtc_da			; ...and set data LSB
	_DR_OK

; **** several printing features ****
; *** carriage return ***
va_cr:
	INC va_y		; line feed...
	JMP va_homl		; ...and finish with simple CR

; *** tab (8 spaces) ***
va_tab:
	LDA va_x			; get column (4)
	AND #%11111000		; modulo 8 (2+2)
	CLC
	ADC #8				; increment target position (2)
	CMP #VA_WDTH			; over the limit?
	BCC vtb_l
		LDA #0
vtb_l:
		PHA					; save desired position (3)
		LDA #' '			; will print spaces (2+3)
		STA io_c
		JSR vch_prn			; direct space printing, A holds 32 too (...)
		PLA					; retrieve target column (4)
		CMP va_x			; reached? (4)
		BNE vtb_l			; no, continue (3/2)
	_DR_OK				; yes, all done

; *** backspace ***
va_bs:
; first get cursor one position back...
	JSR vch_left			; standard
; ...then print a space, the regular way...
	LDA #' '			; code of space (2)
	STA io_c			; store as single char... (3)
	JSR va_prn			; print whatever is in io_c (...)
; ...and back again!
	JMP vch_left			; will return

; ********************
; *** several data ***
; ********************

va_c0:
; new C0 codes managament table
	.word	vch_npr		; NULL, not accepted... or might just generate a NEWL
	.word	va_homl		; HOML, CR without LF
	.word	vch_left	; LEFT, move cursor
	.word	vch_npr		; TERM, does not affect screen
	.word	va_cls		; ENDT, end of text, may just issue a FF
	.word	vch_npr		; ENDL, not accepted... or might just put cursor at the rightmost column
	.word	vch_rght	; RGHT, move cursor
	.word	vch_npr		; BELL, should make something conspicuous***
	.word	va_bs		; BKSP, backspace
	.word	va_tab		; HTAB, move to next tab column
	.word	vch_down	; DOWN, move cursor
	.word	vch_up		; UPCU, move cursor
	.word	va_cls		; FORM, clear screen
	.word	va_cr		; NEWL, new line
	.word	vch_so		; EON,  inverse video
	.word	vch_si		; EOFF, true video
	.word	vch_dcx		; DLE,  disable next control char
	.word	vch_sc		; XON,  turn cursor on
	.word	vch_dcx		; INK,  set foreground colour (set inverse video if zero)
	.word	vch_hc		; XOFF, turn cursor off
	.word	vch_dcx		; PAPR, set background colour (disable inverse video if zero)
	.word	va_home		; HOME, move cursor to top left without clearing
	.word	va_cls		; PGDN, page down, may issue a FF
	.word	vch_dcx		; ATYX, takes two more chars!
; further savings can be done if these left printed anyway!
	.word	vch_npr		; BKTB, no direct effect on screen
	.word	vch_npr		; PGUP, no direct effect on screen, might do CLS anyway
	.word	vch_npr		; STOP, no effect on screen
	.word	vch_npr		; ESC,  no effect on screen (this far!)
; here come the ASCII separators, might be left printed anyway, saving 8 bytes from the table
#ifndef	SEPARATORS
	.word	vch_npr		; FS,   no effect on screen or just print the glyph
	.word	vch_npr		; GS,   no effect on screen or just print the glyph
	.word	vch_npr		; RS,   no effect on screen or just print the glyph
	.word	vch_npr		; US,   no effect on screen or just print the glyph
#endif

va_xtb:
; new table for extra-byte codes
; note offset as managed X codes are 16, 18, 20 and 23, thus padding byte
	.word	vch_dle		; 16, process byte as glyph
	.word	vch_ink		; 18, take byte as FG colour (discard if not zero)
	.word	vch_papr	; 20, take byte as BG colour (discard if not zero)
	.byt	$FF			; *** padding as ATYX is 23, not 22 ***
	.word	vch_atyx	; 23, expects row byte
	.word	vch_atcl	; 25, expects column byte, note it is no longer 24!

va_data:
; CRTC registers initial values

; *** values for 25.175 MHz dot clock *** 31.47 kHz Hsync, 59.94 Hz Vsync
; unlikely to work on 24.576 MHz crystal (30.72 kHz Hsync, 58.5 Hz Vsync)

; standard mode is 288x224 (36x28) 1-6-3, fully compatible
	.byt 49				; R0, horizontal total chars - 1
	.byt 36				; R1, horizontal displayed chars
	.byt 39				; R2, HSYNC position - 1
	.byt 38				; R3, HSYNC width (may have VSYNC in MSN) =6
	.byt 31				; R4, vertical total chars - 1
	.byt 13				; R5, total raster adjust
	.byt 28				; R6, vertical displayed chars
	.byt 28				; R7, VSYNC position - 1
	.byt 50				; R8, non-interlaced and 1 ch. skew
	.byt 15				; R9, maximum raster - 1

; *** glyphs ***
vs_font:
#include "fonts/8x8.s"
.)
