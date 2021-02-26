; music player for breadboard!
; (c) 2021 Carlos J. Santisteban
; last modified 20210226-1903

; *** required variables (not necessarily in ZP) ***

	.zero

	* = 3					; minimOS-savvy ZP address

cur		.byt	0			; current score position

	.text

; *** player code ***

	* = $400				; downloadable version

	SEI						; standard init
	CLD
	LDX #$FF
	TXS

	STX $FFF0				; turn off display, just in case

	INX						; now it's zero
	STX cur					; reset cursor (or use STZ)
loop:
		LDY cur				; get index
		LDA len, Y			; get length from duration array
			BEQ end			; length=0 means END of score
		TAX
		LDA note, Y			; get note period (10A+20 t) from its array
		BEQ rest			; if zero, no sound!

; *****************************
; *** ** beeping routine ** *** inlined
; *** X = length, A = freq. ***
; *** tcyc = 10 A + 20      ***
; *****************************
mt_beep:
			TAY				; determines frequency (2)
			STX $BFF0		; send X's LSB to beeper (4)
rb_zi:
				DEY			; count pulse length (y*2)
				BNE rb_zi	; stay this way for a while (y*3-1)
			DEX				; toggles even/odd number (2)
			BNE mt_beep		; new half cycle (3)
		STX $BFF0			; turn off the beeper!
; *****************************

		BEQ next			; go for next note

; **************************
; *** ** rest routine ** *** inlined
; ***     X = length     ***
; ***    t = X 1.28 ms   ***
; **************************
rest:
		TAY					; if period is zero for rests, this resets the counter
r_loop:
			INY
			BNE r_loop		; this will take ~ 1.28 ms
		DEX					; continue
		BNE rest
; **************************

next:
		INC cur				; advance cursor to next note
		BNE loop
end:
	LDA #%01100101			; put dashes on display
	STA $FFF0
	BNE end					; *** repeats at the end ***

; *******************
; *** music score ***
; *******************
; PacMan theme for testing

; array of lengths (rests are computed like G5)
len:
/*.byt 105,156,210,156,105,156,210,156
.byt 105,156,210,156,105,156,210,156
.byt 105,156,210,156,105,156,210,156
.byt 105,156,210,156,105,156,210,156

.byt 105,105,210,210,105,105,210,210
.byt 105,105,210,210,105,105,210,210
.byt 105,105,210,210,105,105,210,210
.byt 105,105,210,210,105,105,210,210,0
*/
	.byt	 35,  52,  70,  52,  52,  52,  44,  52,  70,2,  52, 104,  88, 104
	.byt	 37,  52,  74,  52,  55,  52,  46,  52,  74,2,  55, 104,  92, 104
	.byt	 35,  52,  70,  52,  52,  52,  44,  52,  70,2,  52, 104,  88, 104
	.byt	 41,2,  44,2,  46,  52,  46,2,  49,2,  52,  52,  52,2,  55,2,  58,  52, 140, 104,   0	; *** end of score ***

; array of notes (rests are 0)
note:
/*.byt 190,0,94,0,190,0,94,0
.byt 190,0,94,0,190,0,94,0
.byt 190,0,94,0,190,0,94,0
.byt 190,0,94,0,190,0,94,0
.byt 190,190,94,94,190,190,94,94
.byt 190,190,94,94,190,190,94,94
.byt 190,190,94,94,190,190,94,94
.byt 190,190,94,94,190,190,94,94
*/
	.byt	190,   0,  94,   0, 126,   0, 150,   0,  94,0, 126,   0, 150,   0
	.byt	179,   0,  88,   0, 118,   0, 141,   0,  88,0, 118,   0, 141,   0
	.byt	190,   0,  94,   0, 126,   0, 150,   0,  94,0, 126,   0, 150,   0
	.byt	159,0, 150,0, 141,   0, 141,0, 133,0, 126,   0, 126,0, 118,0, 112,   0,  94,   0		; no need for extra byte as will be discarded
