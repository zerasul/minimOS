; COLUMNS for Durango-X
; original idea by SEGA
; (c) 2022 Carlos J. Santisteban
; last modified 20221231-1302

; ****************************
; *** hardware definitions ***
; ****************************

screen3	= $6000
IO8attr	= $DF80
IO8blk	= $DF88
IO9nes0	= $DF9C
IO9nlat	= IO9nes0
IO9nes1	= $DF9D
IO9nclk	= IO9nes1
IOAie	= $DFA0
IOBeep	= $DFB0

; *************************
; *** memory allocation ***
; *************************
status	= 128				; array of player status [0=game over, 1=playing, 2=level select, 3=flashing?]
speed	= status+2			; array of 16-bit counters for next event
pad0mask= speed+4			; gamepad masking values
pad1mask= pad0mask+1
pad0val	= pad1mask+1		; gamepad current status
pad1val	= pad0val+1
yb		= pad1val+1			; base row for death animation
limit	= yb+1				; right column for death animation
temp	= limit+1
bcd_arr	= temp+1			; scores etc array, includes _lim and colour $EC
bcd_lim	= bcd_arr+1			; $ED
colour	= bcd_arr+8			; $F4
seed	= bcd_arr+14		; PRNG seed, $FA
; may let these at $FC for minimOS compliance
src		= seed+2			; $FC
ptr		= src+2				; $FE
; these save a few bytes and cycles in ZP
irq_ptr	= ptr+2				; $0200 is standard minimOS, may save a few bytes putting these on ZP
ticks	= irq_ptr+2			; $0206 but no NMI or BRK in use, and only 16-bit
_end_zp	= ticks+2
; these MUST be outside ZP, change start address accordingly
fields	= $0200				; 8x16 (6x13 actually used) game status arrays (player2 = +128)
delta	= $0300				; screen change log [0=unchanged, 1=display, 2=flashing counter?]

; *****************
; *** main code ***
; *****************

* = $C000					; will 16K suffice?

reset:
	SEI						; usual 6502 init
	CLD
	LDX #$FF
	TXS
; Durango-X specifics
	STX IOAie				; enable interrupts, as X is an odd value
	STX ticks
	STX ticks+1				; will reach zero upon the very first interrupt
	LDA #$38				; colour mode, screen 3, RGB
	STA IO8attr				; set video mode
; show splash screen
	INX						; was $FF, now 0 is the index of compressed file entry
	JSR dispic				; decompress!
; setup controllers etc (assume minstrel-type kbd)
	STZ pad0mask
	STZ pad1mask			; need these reset the very first time
	JSR read_pad			; get initial values
	LDX pad0val
	LDY pad1val
	STX pad0mask			; ...and store them
	STY pad1mask
	JSR read_pad			; just for clearing the values
; TODO * may check here for supported keyboard presence (col 6 = $2C) * TODO
; * init game stuff *
	LDA #0
	LDX #seed-1-status		; will clear everything below seed
rst_loop:
		STA status, X
		DEX
		BPL rst_loop		; OK if less than 128 bytes
; setup interrupt system
	LDY #<isr
	LDX #>isr				; ISR address
	STY irq_ptr				; standard FW adress
	STX irq_ptr+1
	CLI						; enable interrupts!
; let at least one player start the game
	JSR continue			; wait for user action
	LDA ticks
	STA seed
	STX seed+1				; quite random seed
	PHY						; save selected player
; display game field
	LDX #2					; set compressed file index
	JSR dispic				; decompress!
; brief EG arpeggio
	LDA #228				; brief E5
	JSR tone
	LDA #192				; longest G5
	LDX #0
	JSR tone
; then level selection according to player
	PLA						; retieve selected player
	JSR sel_ban

; ====== TEST CODE ======/*
stz 0;y
stz 1;x
pinta:
jsr rnd
and#7
ldx 1
ldy 0
jsr tiledis
inc 0
inc 1
lda 1
cmp#6
bne not6
lda#9
sta 1
not6:
lda 0
cmp#12
bne pinta
ldy#<levelsel
ldx#>levelsel
sty src
stx src+1
ldx#22
lda#9
jsr banner
lock:
jsr continue
ldx#0
jsr palmatoria
jmp lock
; ====== END OF TEST CODE ======*/
end:jmp end

; ***********************
; *** useful routines ***
; ***********************

; ** display one full screen from list index in X (always even) **
dispic:
	LDY cmpr_pics, X
	LDA cmpr_pics+1, X
	STY src
	STA src+1				; set source pointer
	LDY #<screen3
	LDX #>screen3			; screen 3 start address
	STY ptr
	STX ptr+1				; set destination pointer
;	JMP rle_loop			; decompress and return!

; ** RLE decompressor **
rle_loop:
		LDY #0				; always needed as part of the loop
		LDA (src), Y		; get command
		INC src				; advance read pointer
		BNE rle_0
			INC src+1
rle_0:
		TAX					; command is just a counter
			BMI rle_u		; negative count means uncompressed string
; * compressed string decoding ahead *
		BEQ rle_exit		; 0 repetitions means end of 'file'
; multiply next byte according to count
		LDA (src), Y		; read immediate value to be repeated
rc_loop:
			STA (ptr), Y	; store one copy
			INY				; next copy, will never wrap as <= 127
			DEX				; one less to go
			BNE rc_loop
; burst generated, must advance to next command!
		INC src
		BNE rle_next		; usually will skip to common code
			INC src+1
			BNE rle_next	; no need for BRA
; alternate code, more compact but a bit slower
;		LDA #1
;		BNE rle_adv			; just advance source by 1 byte
; * uncompressed string decoding ahead *
rle_u:
			LDA (src), Y	; read immediate value to be sent, just once
			STA (ptr), Y	; store it just once
			INY				; next byte in chunk, will never wrap as <= 127
			INX				; one less to go
			BNE rle_u
		TYA					; how many were read?
rle_adv:
		CLC
		ADC src				; advance source pointer accordingly (will do the same with destination)
		STA src
		BCC rle_next		; check possible carry
			INC src+1
; * common code for destination advence, either from compressed or un compressed
rle_next:
		TYA					; once again, these were the transferred/repeated bytes
		CLC
		ADC ptr				; advance desetination pointer accordingly
		STA ptr
		BCC rle_loop		; check possible carry
			INC ptr+1
		BNE rle_loop		; no need for BRA
rle_exit:					; exit decompressor
	RTS						; EEEEEEEK

; ** display column from 8x16 matrix (6x13 in use) **
; input
;	X, Y	coordinates in matrix
;	A		player [0-1]
coldisp:
	LSR						; extract d0...
	ROR						; ...thru d7...
	LSR						; ...and into d6
	STA temp
	TYA
	ASL
	ASL
	ASL						; times 8 bytes per row
	ADC id_table, X			; add X (1...6), C clear
	ORA temp				; select between playfield
	TAX						; use as index
	LDY #3					; number of tiles per column
cd_loop:
		LDA fields, X		; get this tile
		
; ** display tile **
; input
;	X = column from player 1 left (player 2 is +9)
;	Y = row from top
;	A = tile number [0-10, where 0 is blank]
; affects 'colour'
tiledis:
	PHA
	TYA						; will be MSB...
	ASL						; ...two pages per row
	ADC #$63				; place into screen 3, 12 rasters below
	STA ptr+1				; first address is ready!
	TXA
	ASL
	ASL						; times four bytes per column
	ADC #2					; first pixel in line is 4, C known clear
	STA ptr					; LSB is ready
	PLA						; retrieve tile index
tileprn:					; * external interface with tile index in A, for next piece *
	STA src+1				; temporary MSB
	LDA #0					; will be LSB
	LSR src+1
	ROR
	LSR src+1
	ROR
	LSR src+1
	ROR						; MSB/8 is A times 32
	ADC #<sprites			; C was clear, add base address
	STA src
	LDA src+1
	ADC #>sprites			; ditto for MSB
	STA src+1				; pointer complete!
	LDX #8					; number of rasters
s_rloop:
		LDY #3				; max index per raster
s_bloop:
			LDA (src), Y	; get sprite data...
			STA (ptr), Y	; ...and place on screen
			DEY
			BPL s_bloop		; for all 4 bytes in raster
		LDA src
		CLC
		ADC #4				; next raster in sprite file
		STA src
		BCC s_rnw
			INC src+1		; in case of page crossing
s_rnw:
		LDA ptr
		CLC
		ADC #64				; next raster in screen
		STA ptr
		BCC s_wnw
			INC ptr+1		; in case of page crossing
s_wnw:
		DEX
		BNE s_rloop			; until all rasters done
	RTS

; ** number display **
; input
;	Y		type of display (0=level, 2=jewels, 4=score)
;	X		player [0-1]
; fixed size; score=6 digits, level=2 digits, jewels=4 digits
; BCD data array [LxJJSSS] thus Y-indexed, then another one for player two
; fixed player 1 base addresses; score $6007 (14,0), level $6C5C (56,49), jewels $7E4A (20,121)
; player 2 level adds 52 Y-offset! (64,101)
; fixed player 2 offset; score $26 (90-14), level 4 (actually $D04) (64-56), jewels $24 (92-20)
numdisp:
	LDA play_col, X			; get colour according to player
	STA colour				; set colour
	TXA						; player offset
	CLC
	ADC disp_id, Y			; select type of display
	TAY						; offset to base address
	LDA num_bl, Y
	STA ptr
	LDA num_bh, Y
	STA ptr+1				; screen pointer is ready
	TAX						; this must be reset after each digit!
	LDA disp_top, Y
	STA bcd_lim				; keep offset limit! eeeeeeek
	LDA disp_id, Y
	TAY						; reindex
bcd_loop:
		LDA bcd_arr, Y		; get one BCD byte
		PHA					; save for LSB
		LSR
		LSR
		LSR
		LSR					; keep MSN
		JSR bcd_disp		; show it
		STX ptr+1			; restore page
		PLA					; retrieve full value
		AND #15				; just LSN
		JSR bcd_disp		; and show it too
		STX ptr+1			; restore page again
		INY					; next two digits!
		CPY bcd_lim 		; is it the last one?
		BNE bcd_loop
	RTS
; actual printing, A has BCD nibble
bcd_disp:
	PHX
	PHY
	ASL						; two bytes per raster
	TAX						; first raster address
	LDY #0
n_rast:
		LDA numbers, X
		AND colour
		STA (ptr), Y		; copy glyph raster into screen
		INX
		INY
		LDA numbers, X
		AND colour
		STA (ptr), Y		; copy glyph raster into screen
		TYA
		CLC
		ADC #63				; one raster minus 2 bytes of a number
		TAY
		BCC ras_nw
			INC ptr+1
ras_nw:
		TXA
		CLC
		ADC #19				; advance to next raster in font
		TAX
		CPX #140			; within valid raster? (10 numbers * 2 bytes * 7 rasters)
		BCC n_rast
	INC ptr					; advance digit position
	INC ptr
	PLY
	PLX
	RTS

; ** death animation ** (non concurrent)
; input
;	X	player (0-1)
palmatoria:
	LDY #12					; yb=12
	STY yb
	TXA						; compute base X, always the same
	BEQ n_p2
		LDA #9
n_p2:
	STA temp				; will be constant initial X
	CLC
	ADC #6					; compute limit
	STA limit				; hack!!
dz_row:
		LDY yb
dz_tile:
		TYA
		CLC
		ADC #8				; initial explosion tile
		SEC
		SBC yb				; A = Y + 8 - yb
		CMP #11
		BCC dz_nw
			SBC #11			; 0, then 1 for exit
dz_nw:
		CPY #0
			BMI dz_show
		CPY #13
			BCS dz_show;dz_abort		; if Y >= 0 and Y <=12...
			LDX temp		; retrieve coordinates
dz_col:
				PHA
				PHX
				PHY
				JSR tiledis
				PLY
				PLX
				PLA
				INX			; next column
				CPX limit	; limit!!
				BCC dz_col
dz_show:
			INY				; next row
			DEC				; was tile zero (clear)?
			BPL dz_tile
dz_abort:
		JSR vsync			; wait a bit
		JSR vsync			; wait a bit
		LDA #30
		PHY
		JSR tone			; brief beep!
		PLY
		DEC yb				; next row
		LDA yb
		CMP #252			; -4
		BNE dz_row
; now print the game over banner
	LDY #<gameover
	LDX #>gameover
	STY src
	STX src+1				; set origin pointer
	LDA temp				; get X for player field
	LDX #10					; raster counter
banner:
; alternate input
;	X	= rasters - 1
;	A	= base column [0 for player 1, 9 for player 2]
;	src		points to .sv24
	ASL
	ASL						; times four bytes per column
	ADC #2					; two extra bytes
	STA ptr
	LDA #$6C				; two rows above centre
	STA ptr+1
go_vloop:
		LDY #23				; max horizontal offset
go_hloop:
			LDA (src), Y
			STA (ptr), Y
			DEY
			BPL go_hloop
		DEX					; one raster is ready
	BMI go_end
		LDA src
		CLC
		ADC #24				; next raster in image
		STA src
		BCC go_nw
			INC src+1
go_nw:
		LDA ptr
		CLC
		ADC #64				; next raster in screen
		STA ptr
		BCC go_vloop
			INC ptr+1		; there was page crossing
		BRA go_vloop
go_end:
	RTS

; ** gamepad read **
read_pad:
	LDA #8
	STA IO9nlat				; latch controller status
pad_rdl:
		STA IO9nclk			; send clock pulse
		DEC					; CMOS only but interesting...
		BNE pad_rdl
	LDA IO9nes0				; controller 1
	EOR pad0mask			; compare with base status
	STA pad0val
	LDA IO9nes1				; controller 2
	EOR pad1mask			; compare with base status
	STA pad1val
	RTS

; ** (busy) wait for action **
; output
;	Y	selected player [0,9] note values!!
continue:
	LDY #0					; default player number 1
	LDA #%11000000			; look for start or fire
wait_s:
		INX					; just for random seed setting
		BIT pad0val
	BNE start
		BIT pad1val
		BEQ wait_s
	LDY #9					; if arrived here, was player 2
start:
; must wait for release also
		BIT pad0val
	BNE start
		BIT pad1val
	BNE start
	RTS

; ** VSYNC **
vsync:
		BIT IO8blk
		BVS vsync			; if already in VBlank
wait_v:
		BIT IO8blk
		BVC wait_v			; wait for VBlank
	RTS

; ** PRNG **
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

; ** draw select level menu **
sel_ban:
	LDY #<levelsel
	LDX #>levelsel
	STY src
	STX src+1				; set origin pointer
	LDX #22					; raster counter
	JMP banner				; display and return

; ** clear playfield structure **
; input
;	Y	player [0,36] note special player 2 value!!
clearfield:
	TYA						; check player
	BEQ pl1a
		LDX #232			; 13th row, player 2
		BRA cl_loop
pl1a:
		LDX #104			; 13th row, player 1
cl_loop:
		LDA #$FF			; invalid tile
		STA fields, X		; sentinel
		STZ fields+1, X
		STZ fields+2, X
		STZ fields+3, X
		STZ fields+4, X
		STZ fields+5, X
		STZ fields+6, X
		STA fields+7, X		; sentinel
		TXA
		SEC
		SBC #8
		TAX
		AND #$7F			; eeeek
		BNE cl_loop
	LDA #$FF				; invalid tile
	TYA						; check player
	BEQ pl1b
		LDX #136			; max horiz offset+1, player 2
		BRA sfh_loop
pl1b:
		LDX #8				; max horiz offset+1, player 1
sfh_loop:
		LDA #$FF			; invalid tile
		STA fields-1, X		; note offsets
		STA fields+111, X
		DEX
		TXA
		AND #127			; player-independent offset
		BNE sfh_loop
; should clear mode selection banner as well, pretty much like 'banner'
	LDX #22					; banner rasters - 1
	TYA						; check player
	CLC
	ADC #2					; will be 2 for player 1, 38 for player 2
	STA ptr
	LDA #$6C				; two rows above centre
	STA ptr+1
clp_vloop:
		LDY #23				; max horizontal offset
		LDA #0				; will clear area
clp_hloop:
			STA (ptr), Y
			DEY
			BPL clp_hloop
		DEX					; one raster is ready
	BMI clp_end
		LDA ptr
		CLC
		ADC #64				; next raster in screen
		STA ptr
		BCC clp_vloop
			INC ptr+1		; there was page crossing
		BRA clp_vloop
clp_end:
	RTS

; **********************
; *** sound routines ***
; **********************
match:
; ** sound after matching, depending on number of them **
; input Y=0...12 for number of achieved group (plays higher)
	PHY
	LDA m_tone+2, Y			; initial value
	JSR tone				; play
	PLY
	PHY
	LDA m_tone+1, Y			; ditto for second one, a semitone lower
	JSR tone
	PLY
	LDA m_tone+1, Y			; last tone
;	JMP tone

tone:
; ** play tone for 50 cycles **
; input A	= period (10+5y)
; might call x_tone with X	= number of semicycles
	LDX #99					; 100 semicycles
x_tone:
	SEI						; disable interrupts!
s_tone:
		STX IOBeep
		TAY					; reload frecuency
s_cyc:
			DEY
			BNE s_cyc		; delay for tone
		DEX					; next semicycle
		BPL s_tone			; will end at zero, thus buzzer off
	CLI						; reenable interrupts!
	RTS

pulse:
; ** play short single pulse **
	LDX #13					; will do ~65 µs
	STX IOBeep				; enable...
ps_loop:
		DEX
		BNE ps_loop			; ends with buzzer off
	STX IOBeep
	RTS

; *********************************
; *** interrupt service routine ***
; *********************************
isr:
	INC ticks
	BNE tk_nw
		INC ticks+1
tk_nw:
	PHA						; only register to save for read_pad
	JSR read_pad
	PLA
; TODO * read keyboard too? * TODO * as keypad emulation
isr_end:					; common interrupt exit
	RTI

; **************
; *** tables ***
; **************
cmpr_pics:					; to be displayed by dispic
	.word	splash
	.word	field

id_table:
	.byte	0, 1, 2, 3, 4, 5, 6, 7		; useful for ADX/ADY emulation

num_bl:						; base addresses of numeric displays (LSB, interleaved $P2P1)
	.word	$605C			; level $6C5C, $7960 (!)
	.word	$6E4A			; jewels $7E4A, $7E6E
	.word	$2D07			; score $6007, $602D
num_bh:						; base addresses of numeric displays (MSB, interleaved $P2P1)
	.word	$796C			; level $6C5C, $7960 (!)
	.word	$7E7E			; jewels $7E4A, $7E6E
	.word	$6060			; score $6007, $602D
play_col:					; player display colour
	.byt	$99, $BB		; sky blue and lavender pink
disp_id:					; identity array (every 2)
	.byt	0, 7
	.byt	2, 9
	.byt	4, 11			; index value, also start index for BCD array (even=player1, odd=player2)
disp_top:
	.byt	1, 8
	.byt	4, 11
	.byt	7, 14			; limit index for 1, 2 or 3 BCD bytes (2-4-6 digits)

m_tone:
;			C#6  D6   D#6  E6   F6   F#6  G6  G#6 A6  A#6 B6  C7  C#7 D7  D#7
	.byt	136, 129, 121, 114, 108, 102, 96, 90, 85, 80, 76, 71, 67, 63, 60	; C#6 to D#7

; ********************
; *** picture data ***
; ********************
splash:
	.bin	0, 0, "art/start.rle"
field:
	.bin	0, 0, "art/columns.rle"
sprites:
	.dsb	32, 0									; first tile is blank
	.bin	0, 0, "art/jewels.sv4"					; uncompressed file, 4-byte wide!
gameover:
	.bin	0, 0, "art/gameover.sv24"				; uncompressed, 24-byte wide
numbers:
	.bin	0, 0, "../../other/data/numbers.sv20"	; generic number images, 20-byte wide
levelsel:
	.bin	0, 0, "art/level.sv24"					; uncompressed, 24-byte wide, 23 lines tall

; ***************************
; *** ROM padding and end ***
; ***************************

	.dsb	$FFD6-*, $FF		; ROM fill
	.asc	"DmOS"				; minimOS-compliant signature
irq_hndl:
	JMP (irq_ptr)				; standard IRQ handler

	.dsb	$FFFA-*, $FF		; ROM fill, not using cehcksum
; 6502 hardware vectors
	.word	isr_end				; null handler
	.word	reset
	.word	irq_hndl
