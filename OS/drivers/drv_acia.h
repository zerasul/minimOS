; 65(C)51 ACIA driver variables for minimOS
; v0.5a1
; (c) 2012-2015 Carlos J. Santisteban
; last modified 20150211-0907

ser_cont	.byt	0	; number of characters stored in buffer
ser_read	.byt	0	; queue output pointer
ser_write	.byt	0	; queue input pointer
ser_buf		.dsb	16, 0	; the serial buffer itself

