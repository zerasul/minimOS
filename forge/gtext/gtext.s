; print text on arbitrary pixel boundaries
; 65(C)02-version
; (c) 2020-2021 Carlos J. Santisteban
; last modified 20210108-1427

; assume MAXIMUM 32x32 pixel font, bitmap VRAM layout (might be adapted to planar as well)
; supports variable width fonts!
; this code assumes Amstrad VRAM layout, but could use C64-style layout as well, just changing the y-offset LUT

; reducing MAX width to 16px dramatically improves things
#define	GW16	_GW16

; *** zero page variables ***

f_ptr	.dsb	2			; indirect pointer for font reading
v_ptr	.dsb	2			; indirect pointer for screen writing

; these are recommended to be in ZP because of performance reasons
#ifdef	GW16
mask	.dsb	3			; shiftable 16+8-bit mask for printing
scan	.dsb	3			; copy of font scanline to be shifted
#else
mask	.dsb	5			; shiftable 32+8-bit mask for printing
scan	.dsb	5			; copy of font scanline to be shifted
#endif
l_byt	.dsb	1			; last font byte for each scanline (number of bytes minus 1)
l_msk	.dsb	1			; last mask byte for each scanline (number of bytes minus 1, usually l_byt+1 but not always)

; *** variables not necessarily in ZP ***
x_pos	.dsb	2			; 16-bit x-position, fixed-point (5b LSB first, then 8b MSB)
; that MUST be equalized so the "low" part is 3b ONLY, incrementing column as needed
; systems with "wide" hardware chars (e.g. SIXtation) would take that into account when computing addresses
y_pos	.dsb	2			; 16-bit y-position, fixed-point (5b LSB first, then 8b MSB)
char	.dsb	1			; ASCII to be printed
count	.dsb	1			; RAM variable for loops, allowing free use of X

; *** required constants *** may be in RAM for versatilty

font	.dsb	2			; font definition start pointer
wdth	.dsb	2			; font widths pointer
vram	.dsb	2			; screen start pointer
hght	.dsb	1			; font height

; ****************************************************************************
; *** font format TBD, but is very important, especially if variable width ***
; ****************************************************************************
; for performance reasons, a highly extravagant binary is desired... even if it may take up to 32.25 kiB!
; planar-style storage for every scanline
; assuming i[x,y] where i is the character, x is the horizontal byte 0...3 (0 the leftmost) and y the scanline
; 0[0,0]-0[1,0]-0[2,0]-0[3,0]-1[0,0] ... 255[3,0]-0[0,1]-0[1,1]-0[2,1] ... 255[3,31] maximum
; *** could be cut in half if font is known to be up to 16 pixels wide (bytes 0...1) ***
; widths array is as simple as a 256-byte structure, in pixels (minus one!)
; every scanline is 1024 bytes apart (512 if 16px maximum width)
; glyph pointer is base+asc*4 (or *2)

	.text

; *** init code, before any printing ***

init:
; must load 'font', 'wdth' with font data, also 'hght' and 'vram'
	LDA font				; use base address for pointer
	STA f_ptr
	LDA font
; needs to fill offset tables! *** TO DO
	RTS						; anything else to do?

; ********************
; *** actual stuff *** give or take, worst case is ~15000t
; ********************

print:
; first thing should be to equalise the coordinates...
; *** perhaps systems with wide chars should do an 11-bit shift left on x_pos+1 ***
	LDA x_pos				; get original coordinate (3)
	AND #7					; extract intra-byte offset (2)
; perhaps shifting that would make a REAL fixed-point coordinate...
	TAX						; keep for later (2)
	LDA x_pos				; retrieve original, faster if in ZP (3)
	LSR						; divide by 8 (2+2+2+2)
	LSR
	LSR
	CLC
	ADC x_pos+1				; use long offset as address increment *** check above *** (3+3)
	STA x_pos+1
	STX x_pos				; and let LSB with minimal offset (3)
; determine sizes
	LDY char				; get ASCII as index (3)
	LDA (wdth), Y			; that character width (5)
	TAY						; this is the number of bits to insert (2)
	LSR						; how many bytes does it take? divide by 8! (2+2+2)
	LSR
	LSR
	STA l_byt				; store for later (glyph scanline size) (3+2+2)
	TYA						; retrieve original bit-width value
	CLC
	ADC x_pos				; interestingly, add offset for mask positioning (already equalised) (3)
	TAX						; how many bits must our mask be shifted? compute first! (2)
	LSR						; how many bytes does it take? divide by 8! (2+2+2)
	LSR
	LSR
	STA l_msk				; store for later (last byte of mask) (3)
; create mask of appropriate width
; *** current is 22/30b, 350/1012t for w16/w32 unshifted (X=Y=15/31) ***
	LDA #$FF				; set mask before rotating EEEEEEEEK (2)
	STA mask+1				; remaining bytes in memory (3+3)
	STA mask+2
#ifndef	GW16
	STA mask+3				; (3+3)
	STA mask+4
#endif
mk_set:
		CLC					; insert a LOW bit... EEEEEK (2)*w
mk_rot:
; not sure if worth optimising
			ROR				; ...into LSB... (2)*(w+o)
			ROR mask+1		; ...and the rest (5+5)*(w+o)
			ROR mask+2
#ifndef	GW16
			ROR mask+3		; might take up to 5 bytes (5+5)*(w+o)
			ROR mask+4
#endif
			DEX
			DEY
			BPL mk_set		; there is one more bit to CLEAR (2+2+3')*?
		CPX #0				; what happened to the shift counter instead?
		BPL mk_rot			; there is one more bit to rotate (C is known to be SET)
	STA mask				; mask is complete!
; make f_ptr point to base glyph data
	_STZA f_ptr+1			; MSB of offset will be computed here
	LDA char				; multiply ASCII by 2 or 4
	ASL
	ROL f_ptr+1
#ifndef	GW16
	ASL						; in case of 32-bit width, it's 4 bytes per scanline/char
	ROL f_ptr+1
#endif
	CLC						; add base pointer
	ADC font				; LSB
	STA f_ptr
	LDA f_ptr+1				; high offset...
	ADC font+1				; ...plus high base (and possible carry)...
	STA f_ptr+1				; ...makes MSB
; must prepare base v_ptr! *** TO DO

; *** performance evaluation, s=scanlines, b=scan top byte, m=mask top, o=offset ***
; prepare scanline counter
	LDX #0				; worth doing forward this time (3) [grand total from here is ]
gs_loop:
; *** this must be done for every scanline ***
; copy (unshifted) scanline at 'scan' [takes up to ]
		LDY l_byt			; get bytes to be copied (n-1)
gs_cp:
			LDA (f_ptr), Y
			STA scan, Y		; this is absolute! may not work on '816 (5+5+2+3')*s*b
			DEY
			BPL gs_cp
; shift scanline pretty much like the mask after inserting all bits [takes up to ]
		LDY x_pos			; thanks to now equalised fixed-point, this is the number of bits to be shifted (3+3)*s
		BEQ v_draw			; EEEEEEEEEEEK
;		LDA scan			; should be already in A!
gs_mr:
			LSR				; rotate right all bytes (2+5+5)*s*o
			ROR scan+1
			ROR scan+2
#ifndef	GW16
			ROR scan+3		; (add 5+5)*s*o
			ROR scan+4
#endif
			DEY				; (2+3')*s*o
			BPL gs_mr
		STA scan			; EEEEEEEEK (3)*s
; *** now read from VRAM, AND with 'mask' and OR with glyph data at 'scan' [takes up to 3104t]
v_draw:
		LDY l_msk			; get last byte for drawing!
blit:
			LDA (v_ptr), Y	; get screen data (5)*s*b
			AND mask, Y		; clear where the glyph goes *** note for 65816 (4)*s*b
			ORA scan, Y		; set glyph pixels *** ditto for 65816 (4)*s*b
			STA (v_ptr), Y	; update screen (6+2+3')*s*b
			DEY
			BPL blit
; now prepare for the next scanline! [up to 1439t, including all overhead except mask creation]
		LDA f_ptr+1			; get font pointer MSB (3)*s
		CLC					; will jump to next scanline, note planar-like format (2)*s
		ADC l_byt			; advance 512 or 1K *** CHECK
		STA f_ptr+1			; (3)*s
; ...but now must advance v_ptr too, with the help of the offset array!
		LDY y_pos			; get this part of the coordinate (no need to equalise this) (3+3+2)*s
		LDA v_ptr
		CLC
		ADC off_l, Y		; add from offset table *** careful with 65816! (4+3)*s
		STA v_pos
		LDA v_ptr+1			; ditto for MSB (3+4+3)*s
		ADC off_h, Y
		STA v_pos+1
; fortunately respected X
		INX
		CPX hght			; all scanlines done? (2+3+3')*s
		BNE gs_loop
; *** *** is it all done now? *** ***





/* old code ***
	STZ f_ptr+1				; reset for temporary use
	LDA char				; get ascii
	ASL						; 16-bit rotation, three times
	ROL f_ptr+1
	ASL
	ROL f_ptr+1
	ASL
	ROL f_ptr+1
	TAY						; keep offset LSB as index (always < 248)
	LDA #>FONT				; prepare MSB too
	CLC
	ADC f_ptr+1				; add offset to base
	STA f_ptr+1
; with C64-style, VRAM offset is (x-x MOD 8)+INT(y/8)*320, thus the remaining is the pointer LSB, other layouts will differ
	LDA x_pos				; get X position again, now for the rest
	AND #248
;	CLC
;	ADC #<VRAM				; in case is not page aligned (rare)
	STA v_ptr				; still missing Y-offset
;	LDA y_pos+1				; in case Y.H is relevant
;	STA v_ptr+1
	LDA y_pos
;	ASL v_ptr+1				; if used, the following istruction is to be ROL instead
	ASL						; divide-by-eight
;	ASL v_ptr+1				; the same, three times
	ASL
;	ASL v_ptr+1
	ASL
		
s_loop:
		LDA (f_ptr), Y		; get font data
		STA scan			; put on LSB...
		STZ scan+1			; ...with clear MSB
		STZ mask			; mask is 0 where printed...
		LDA #$FF			; ...and 1 where original pixel is to be kept
		STA mask+1
		LDA x_pos			; get X position, just for the bit-offset
		AND #7
		TAX					; number of pixels to shift within byte
x_loop:
			ASL scan		; rotate font data...
			ROL scan+1
			ASL mask		; ...and mask
			ROL masl+1
			DEX
			BPL x_loop
		
*** */
