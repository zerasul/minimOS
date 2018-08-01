; 64-key ASCII keyboard for minimOS!
; v0.6a1
; (c) 2012-2018 Carlos J. Santisteban
; last modified 20180801-2308

; VIA bit functions
; PA0...3	= input from selected column
; PA4...7	= output (selected column)
; PB3		= caps lock LED (hopefully respected!)

; new VIA-connected device ID is $25/A5/2D/AD (%x010x101), will go into PB
; could it be combined with LCD, saving one 688?

; ***********************
; *** minimOS headers ***
; ***********************
#include "../usual.h"

; *** begins with sub-function addresses table ***
	.byt	145		; physical driver number D_ID (TBD)
	.byt	A_BLIN|A_POLL	; input driver, periodic interrupt-driven
	.word	ak_read		; read at least 1 byte
	.word	ak_err		; no output
	.word	ak_init		; initialise 'device', called by POST only
	.word	ak_poll		; periodic interrupt...
	.word	1		; as fast as possible
	.word	ak_nreq		; D_ASYN does nothing
	.word	ak_nreq		; no config
	.word	ak_nreq		; no status
	.word	ak_exit		; shutdown procedure, leave VIA as it was...
	.word	ak_info		; points to descriptor string
	.word	0		; non-relocatable, D_MEM

; *** driver description ***
ak_info:
	.asc	"ASCII keyboard v0.6", 0

; *** some definitions ***

PA_MASK		= %11110000	; PA0-3 as input, PA4-7 as output
PB_MASK		= %01111111	; all used, PB7 free

; ****************************************************************
; *** read key (only one byte of buffer will be filled at most ***
; ****************************************************************
ak_read:
#ifdef	SAFE
	LDA bl_siz			; check remaining
	ORA bl_siz+1
		BEQ blck_end			; nothing to do
#endif
	JSR ak_get			; *** get one byte ***
		BCS blck_end		; any error ends transfer!
	LDA io_c			; received byte...
	_STAY(bl_ptr)			; ...goes into buffer
	DEC bl_siz			; one less to go
	LDA bl_siz			; check whether wrapped
	CMP #$FF
	BNE blck_end			; no wrap, all done
		DEC bl_siz+1			; ...or one page less
blck_end:
	RTS				; respect whatever error code


; ************************
; *** initialise stuff ***
; ************************
ak_init:
	_DR_OK				; succeeded


; *********************
; *** read one byte ***
; *********************
ak_get:
	_DR_OK

