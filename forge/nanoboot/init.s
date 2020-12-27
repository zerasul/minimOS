; startup nanoBoot for 6502, v0.3a3
; (c) 2018-2020 Carlos J. Santisteban
; last modified 20201227-1600

; *** needed zeropage variables ***
; nb_rcv, received byte (no longer need to be reset!)
; nb_flag, counter of shifted bits, goes zero when a byte is received
; nb_ptr (word) for initial address, will use as pointer
; nb_fin (word) is final address, MUST be right after nb_ptr
; nb_ex (word) keeps initial address, should be consecutive
; *** will temporarily use 3 more bytes, the last one for checking valid header ***

nb_init:
	SEI						; make sure interrupts are off (2)
; ******************************
; *** set interrupt handlers ***
; ******************************
#ifndef	SETOVER
; regular NMI/IRQ version full install
	LDX #3					; copy 4 bytes (2)
nb_svec:
		LDA nb_tab, X		; get origin from table (4)
		STA fw_isr, X		; and write for FW (5)
#ifdef	DISPLAY
		LDA nb_boot, X		; while we are on it, prepare display message (4+4)
		STA nb_disp, X
#endif
		DEX					; next (2)
		BPL nb_svec			; no need to preset X (3)
#else
; *** alternate code in case /SO is used, no ISR is set ***
	CLV						; reset this ASAP!
	LDY #<nb_nmi			; copy routine address...
	LDA #>nb_nmi
	STY fw_nmi				; ...and store it into firmware
	STA fw_nmi+1
#endif
; *** wait for a valid nanoBoot link *** $4B, end.H, end.L, start.H, start.L
; 'end' is actually first free address after code
; note big-endian for simpler memory filling!
; the magic byte ($4B) could be ignored as well
; *** get nanoBoot header ***
	LDY #4					; will receive five bytes 0...4 (2)
nb_lnk:
; ************************************************************
; *** receive byte on A, perhaps with feedback and timeout *** affects X
; ************************************************************

; *** standard overhead per byte is 16t, or 24t with timeout ***
		LDX #8				; number of bits per byte (2)
		STX nb_flag			; preset bit counter (3)
#ifdef	TIMEBOOT
		LDX #0				; or use STZs (2)
		STX timeout			; preset timeout counter for ~0.92 s @ 1 MHz (3+3)
		STX timeout+1
nb_lbit:
; *** optional timeout adds typically 8 or 15 (0.4% of times) cycles to loop ***
			DEC timeout			; one less to go (5)
			BNE nb_cont			; if still within time, continue waiting after 8 extra cycles (3/2)
				DEC timeout+1	; update MSB too otherwise (5)
			BNE nb_cont			; not yet expired, continue after 15 extra cycles (3/2)
				PLA				; discard return address otherwise... (4+4)
				PLA
				JMP nb_exit		; ...and proceed with standard boot!
nb_cont:
#else
nb_lbit:
; *** base loop w/o feedback is 6 cycles, plus interrupts => 64t/bit => 512t/byte ***
; make that 84t/bit and 672t/byte if LTC display is enabled 
#endif
#ifdef	DISPLAY
; ** sample code for LED display, constant 28t overhead (224 per byte) **
;		LDX nb_cur			; current position (3)
;		LDA nb_disp, X		; get pattern (4)
;		STA via_pb			; put on anodes (4)
;		LDA nb_col, X		; get selected common cathode (4)
;		STA via_pa			; set it (4)
;		INX					; next char (2+2)
;		TXA
;		AND #3				; on a four digit display (2)
;		STA nb_cur			; update for next round (3)
; ** another sample for LTC display, 20t per bit, 160 per byte **
		LDX nb_cur			; current position (3)
		LDA nb_disp, X		; get pattern (4)
		STA $FFF0			; put on display (4)
		INX					; next anode (2+2)
		TXA
		AND #3				; four anodes on a single LTC4622 display (2)
		STA nb_cur			; update for next round (3)
; ** end of feedback **
#endif
		LDX nb_flag			; received something? (3)
		BNE nb_lbit			; no, keep trying (3/2)
		LDA nb_rcv			; get received (3)
		EOR #$FF			; must invert byte, as now works the opposite (2)
; **************************
; *** byte received in A ***
; **************************
		STA nb_ptr, Y		; store in variable (4)
		STA nb_ex, Y		; simpler way, nb_ex should be after both pointers (4)
		DEY					; next (2)
		BPL nb_lnk			; until done (3/2)
; *** may check here for a valid header ***
#ifdef	SAFE
	LDY nb_ex+4				; this holds the magic byte (3)
	CPY #$4B				; valid nanoBoot link? (2)
		BNE nb_exit			; no, abort (2/3)
; could check for address boundaries as well
#endif
; prepare variables for transfer
	TAY						; last byte loaded is the index! (2)
	LDX #0
	STX nb_ptr				; ready for indirect-indexed (X known to be zero, or use STZ)
#ifdef	DISPLAY
; create acknowledge message while loading first page (16t)
	LDA #%11101000			; dot on second digit
	STA nb_disp+2
	LDA #%11100010			; dot on first digit
	STA nb_disp
	STX nb_disp+1			; clear remaining segments (known to be zero)
	STX nb_disp+3
#endif
; *** execute transfer ***
; *** performance when using NMI/IRQ ***
; total overhead per byte (over nb_rec execution) is typically ?t
; *** performance when using SO (no IRQ) ***
nb_rec:
; **********************************************************
; *** receive byte on A, without any feedback or timeout *** simpler and faster
; **********************************************************
; *** standard overhead per byte is 10t, plus 64t/bit equals ***
	LDX #8					; number of bits per byte (2)
	STX nb_flag				; preset bit counter (3)
; not really using timeout, as a valid server was detected
nb_gbit:
; feedback, if any, is updated after each received byte
		LDX nb_flag			; received something? (3)
		BNE nb_gbit			; no, keep trying (3/2)
	LDA nb_rcv				; get received (3)
	EOR #$FF				; must invert byte, as now works the opposite (2)
; **************************
; *** byte received in A ***
; **************************
		STA (nb_ptr), Y		; store at destination (5 or 6)
#ifdef	DISPLAY
; *** this is a god place to update display *** single LTC, for instance
		LDX nb_cur			; current position (3)
		LDA nb_disp, X		; get pattern (4)
		STA $FFF0			; put on display (4)
		INX					; next anode (2+2)
		TXA
		AND #3				; four anodes on a single LTC4622 display (2)
		STA nb_cur			; update for next round (3)
; *** end of display update *** 20t per byte
#endif
		INY					; next (2)
		BNE nbg_nw			; check MSB too (3/7)
			INC nb_ptr+1
; *** page has changed, may be reflected on display ***
#ifdef	DISPLAY
; show page LSN, takes 35t each 256 bytes
			LDA nb_ptr+1	; get new page number (3)
			AND #15			; LSN only (2)
			TAX				; as index (2)
			LDA nb_pat, X	; low pattern first (4)
			AND #240		; MSN as cathodes (2)
			ORA #%0010		; enable first anode of second digit (2+3)
			STA nb_disp+2
			LDA nb_pat, X	; load again full pattern (4)
			ASL				; keep LSN only (2+2+2+2)
			ASL
			ASL
			ASL
			ORA #%0001		; enable second anode of second digit (2+3)
			STA nb_disp+3
#endif
nbg_nw:
		CPY nb_fin			; check whether ended (3)
		BNE nb_rec			; no, continue (3/11/10)
			LDA nb_ptr+1	; check MSB too
			CMP nb_fin+1
		BNE nb_rec			; no, continue
; ********************************************
; *** transfer ended, execute loaded code! ***
; ********************************************
	JMP (nb_ex)				; go!

; *************************************
; *** table with interrupt pointers *** and diverse data
; *************************************
#ifndef	SETOVER
nb_tab:
	.word	nb_irq
	.word	nb_nmi
#endif
#ifdef	DISPLAY
nb_boot:
	.byt	%11010010, %10100001, %11011000, %00000100	; patterns to show 'nb' on LTC display (integrated anodes)
nb_pat:						; segment patterns for hex numbers
	.byt	%00010001		; 0
	.byt	%10011111		; 1
	.byt	%00110010		; 2
	.byt	%00010110		; 3
	.byt	%10011100		; 4
	.byt	%01010100		; 5
	.byt	%01010000		; 6
	.byt	%00011111		; 7
	.byt	%00010000		; 8
	.byt	%00011100		; 9
	.byt	%00011000		; A
	.byt	%11010000		; B
	.byt	%01110001		; C
	.byt	%10010010		; D
	.byt	%01110000		; E
	.byt	%01111000		; F
#endif

; **********************************************************************
; *** in case nonvalid header is detected, reset or continue booting ***
; **********************************************************************
nb_exit:
#ifndef	TIMEBOOT
	JMP ($FFFC)				; reset, hopefully will go elsewhere
#endif
