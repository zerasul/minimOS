; test of preliminary connection
; (c) 2021 Carlos J. Santisteban

	* =	$400
	LDA #0
start:
	LDY #0
	LDX #$0
loop:
	STX $8000
	STY $8001
	STA $8002	;***
	JSR delay
	INY
	BNE loop
	INX
	CPX #$8
	BNE loop
	INC
wait:
	INY
	BNE wait
	TAY
	BNE start
	BEQ start
delay:
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
	JSR ret
ret:
	RTS
