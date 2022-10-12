; Durango-X lines demo!
; (c) 2022 Carlos J. Santisteban
; last modified 20221012-1827

*	= $F000

#include "../../OS/firmware/modules/durango-line.s"
#include "../../OS/firmware/modules/durango-plot.s"

seed	= $FE

;#define	HIRES

#ifdef	HIRES
#define	LIMIT	255
#else
#define	LIMIT	127
#endif

reset:
	SEI						; usual 6502 stuff
	CLD
	LDX #$FF
	TXS
	STX $DFA0				; will turn off LED for peace of mind
	STX px_col				; original colour (white)

#ifdef	HIRES
	LDA #$B0
#else
	LDA #$38
#endif

	STA IO8attr				; set proper video mode
	JSR randomize

loop:
		JSR random			; get random coordinates and colour
		JSR dxline			; draw line
		JMP loop			; in aeternum

; *** set random seed ***
randomize:
	LDX #$88
	STX seed
	INX
	STX seed+1
;	JSR rnd					; further randomizing
	RTS

; *** fill coordinates (and colour) randomly ***
random:
	JSR rnd
	AND #LIMIT
	STA x1
	JSR rnd
	AND #LIMIT
	STA x2
	JSR rnd
	AND #LIMIT
	STA y1
	JSR rnd		; comment for horizontal only
	AND #LIMIT
	STA y2
	JSR rnd		; this will be colour
#ifndef	HIRES
	AND #15
	STA tmp
	ASL
	ASL
	ASL
	ASL
	ORA tmp		; II format, for HIRES will just look for d7
#endif
	STA px_col
	RTS

; *** generate random number ***
; based on code from https://codebase64.org/doku.php?id=base:small_fast_16-bit_prng
rnd:
	LDA seed
		BEQ lo_z
	ASL seed
	LDA seed+1
	ROL
	BCC no_eor
do_eor:
		STA seed+1
do_eor2:
		LDA seed
		EOR #$2D
		STA seed
	RTS
lo_z:
	LDA seed+1
		BEQ do_eor2
	ASL
	BEQ no_eor
	BCS do_eor
no_eor:
	STA seed+1
	RTS

; *** fill and vectors ***
	.dsb	$FFFA-*, $FF

	.word reset
	.word reset
	.word reset
	
