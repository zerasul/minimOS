; test of colour Durango-X screen
; (c) 2021 Carlos J. Santisteban 

	* =	$400

ptr = 0

	LDA #$30
	STA $8000				; set all flags
	LDX #$60
	LDY #0
	STX ptr+1
	STY ptr
loop:
		TYA
		AND #63				; 64 bytes per line
		CMP #61
		BNE norm			; something near the edge
			TXA				; high-byte address
			BRA put
norm:
		CMP #63				; seeking for the last column
		BNE blk
			LDA #%01111000	; yellow/blue
			CPX #$70		; modify middle lines
			BNE put
				LDA #%0001111	; just rightmost white pixel
			BNE put
blk:
		LDA #0
put:
		STA (ptr), Y
		INY
		BNE loop
	INX
	STX ptr+1
	BPL loop
lock:
	BMI lock
