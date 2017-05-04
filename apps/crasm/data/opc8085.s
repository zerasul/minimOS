; minimOS opcode list for (dis)assembler modules
; (c) 2015-2017 Carlos J. Santisteban
; last modified 20170504-1013

; ***** for 80asm i8080/8085 cross assembler *****
; 8085 set
; Opcode list as bit-7 terminated strings
; @ expects single byte, & expects word
; % expects RELATIVE addressing

	.asc	"NO", 'P'+$80	; $00=NOP
	.asc	"LXI B, ", '&'+$80	; $01=LXI B
	.asc	"STAX ", 'B'+$80	; $02=STAX B
	.asc	"INX ", 'B'+$80	; $03=INX B
	.asc	"INR ", 'B'+$80	; $04=INR B
	.asc	"DCR ", 'B'+$80	; $05=DCR B
	.asc	"MVI B, ", '@'+$80	; $06=MVI B
	.asc	"RL", 'C'+$80	; $07=RLC
	
	; CHECK http://ralferoo.blogspot.com.es/2013/02/
	
	.asc	"IN", 'X'+$80	; $08=INX
	.asc	"DE", 'X'+$80	; $09=DEX
	.asc	"CL", 'V'+$80	; $0A=CLV
	.asc	"SE", 'V'+$80	; $0B=SEV
	.asc	"CL", 'C'+$80	; $0C=CLC
	.asc	"SE", 'C'+$80	; $0D=SEC
	.asc	"CL", 'I'+$80	; $0E=CLI
	.asc	"SE", 'I'+$80	; $0F=SEI

	.asc	"SB", 'A'+$80	; $10=SBA
	.asc	"CB", 'A'+$80	; $11=CBA
	.asc	"?", ' '+$80	; $12=?
	.asc	"?", ' '+$80	; $13=?
	.asc	"?NB", 'A'+$80	; $14=NBA	UNDOCUMENTED!
	.asc	"?", ' '+$80	; $15=?
	.asc	"TA", 'B'+$80	; $16=TAB
	.asc	"TB", 'A'+$80	; $17=TBA
	.asc	"?", ' '+$80	; $18=?
	.asc	"DA", 'A'+$80	; $19=DAA
	.asc	"?", ' '+$80	; $1A=?
	.asc	"AB", 'A'+$80	; $1B=ABA
	.asc	"?", ' '+$80	; $1C=?
	.asc	"?", ' '+$80	; $1D=?
	.asc	"?", ' '+$80	; $1E=?
	.asc	"?", ' '+$80	; $1F=?

	.asc	"BRA ", '%'+$80	; $20=BRA rel
	.asc	"?", '@'+$80	; $21=?
	.asc	"BHI ", '%'+$80	; $22=BHI rel
	.asc	"BLS ", '%'+$80	; $23=BLS rel
	.asc	"BCC ", '%'+$80	; $24=BCC rel
	.asc	"BCS ", '%'+$80	; $25=BCS rel
	.asc	"BNE ", '%'+$80	; $26=BNE rel
	.asc	"BEQ ", '%'+$80	; $27=BEQ rel
	.asc	"BVC ", '%'+$80	; $28=BVC rel
	.asc	"BVS ", '%'+$80	; $29=BVS rel
	.asc	"BPL ", '%'+$80	; $2A=BPL rel
	.asc	"BMI ", '%'+$80	; $2B=BMI rel
	.asc	"BGE ", '%'+$80	; $2C=BGE rel
	.asc	"BLT ", '%'+$80	; $2D=BLT rel
	.asc	"BGT ", '%'+$80	; $2E=BGT rel
	.asc	"BLE ", '%'+$80	; $2F=BLE rel

	.asc	"TS", 'X'+$80	; $30=TSX
	.asc	"IN", 'S'+$80	; $31=INS
	.asc	"PUL ", 'A'+$80	; $32=PUL A
	.asc	"PUL ", 'B'+$80	; $33=PUL B
	.asc	"DE", 'S'+$80	; $34=DES
	.asc	"TX", 'S'+$80	; $35=TXS
	.asc	"PSH ", 'A'+$80	; $36=PSH A
	.asc	"PSH ", 'B'+$80	; $37=PSH B
	.asc	"?", ' '+$80	; $38=?
	.asc	"RT", 'S'+$80	; $39=RTS
	.asc	"?", ' '+$80	; $3A=?
	.asc	"RT", 'I'+$80	; $3B=RTI
	.asc	"?", ' '+$80	; $3C=?
	.asc	"?", ' '+$80	; $3D=?
	.asc	"WA", 'I'+$80	; $3E=WAI
	.asc	"SW", 'I'+$80	; $3F=SWI

	.asc	"NEG ", 'A'+$80	; $40=NEG A
	.asc	"?", ' '+$80	; $41=?
	.asc	"?", ' '+$80	; $42=?
	.asc	"COM ", 'A'+$80	; $43=COM A
	.asc	"LSR ", 'A'+$80	; $44=LSR A
	.asc	"?", ' '+$80	; $45=?
	.asc	"ROR ", 'A'+$80	; $46=ROR A
	.asc	"ASR ", 'A'+$80	; $47=ASR A
	.asc	"ASL ", 'A'+$80	; $48=ASL A
	.asc	"ROL ", 'A'+$80	; $49=ROL A
	.asc	"DEC ", 'A'+$80	; $4A=DEC A
	.asc	"?", ' '+$80	; $4B=?
	.asc	"INC ", 'A'+$80	; $4C=INC A
	.asc	"TST ", 'A'+$80	; $4D=TST A
	.asc	"?", ' '+$80	; $4E=?
	.asc	"CLR ", 'A'+$80	; $4F=CLR A

	.asc	"NEG ", 'B'+$80	; $50=NEG B
	.asc	"?", ' '+$80	; $51=?
	.asc	"?", ' '+$80	; $52=?
	.asc	"COM ", 'B'+$80	; $53=COM B
	.asc	"LSR ", 'B'+$80	; $54=LSR B
	.asc	"?", ' '+$80	; $55=?
	.asc	"ROR ", 'B'+$80	; $56=ROR B
	.asc	"ASR ", 'B'+$80	; $57=ASR B
	.asc	"ASL ", 'B'+$80	; $58=ASL B
	.asc	"ROL ", 'B'+$80	; $59=ROL B
	.asc	"DEC ", 'B'+$80	; $5A=DEC B
	.asc	"?", ' '+$80	; $5B=?
	.asc	"INC ", 'B'+$80	; $5C=INC B
	.asc	"TST ", 'B'+$80	; $5D=TST B
	.asc	"?", ' '+$80	; $5E=?
	.asc	"CLR ", 'B'+$80	; $5F=CLR B

	.asc	"NEG @, ", 'X'+$80	; $60=NEG idx
	.asc	"?", ' '+$80	; $61=?
	.asc	"?", ' '+$80	; $62=?
	.asc	"COM @, ", 'X'+$80	; $63=COM idx
	.asc	"LSR @, ", 'X'+$80	; $64=LSR idx
	.asc	"?", ' '+$80	; $65=?
	.asc	"ROR @, ", 'X'+$80	; $66=ROR idx
	.asc	"ASR @, ", 'X'+$80	; $67=ASR idx
	.asc	"ASL @, ", 'X'+$80	; $68=ASL idx
	.asc	"ROL @, ", 'X'+$80	; $69=ROL idx
	.asc	"DEC @, ", 'X'+$80	; $6A=DEC idx
	.asc	"?", ' '+$80	; $6B=?
	.asc	"INC @, ", 'X'+$80	; $6C=INC idx
	.asc	"TST @, ", 'X'+$80	; $6D=TST idx
	.asc	"JMP @, ", 'X'+$80	; $6E=JMP idx
	.asc	"CLR @, ", 'X'+$80	; $6F=CLR idx

	.asc	"NEG ", '&'+$80	; $70=NEG ext
	.asc	"?", ' '+$80	; $71=?
	.asc	"?", ' '+$80	; $72=?
	.asc	"COM ", '&'+$80	; $73=COM ext
	.asc	"LSR ", '&'+$80	; $74=LSR ext
	.asc	"?", ' '+$80	; $75=?
	.asc	"ROR ", '&'+$80	; $76=ROR ext
	.asc	"ASR ", '&'+$80	; $77=ASR ext
	.asc	"ASL ", '&'+$80	; $78=ASL ext
	.asc	"ROL ", '&'+$80	; $79=ROL ext
	.asc	"DEC ", '&'+$80	; $7A=DEC ext
	.asc	"?", ' '+$80	; $7B=?
	.asc	"INC ", '&'+$80	; $7C=INC ext
	.asc	"TST ", '&'+$80	; $7D=TST ext
	.asc	"JMP ", '&'+$80	; $7E=JMP ext
	.asc	"CLR ", '&'+$80	; $7F=CLR ext

	.asc	"SUB A #", '@'+$80	; $80=SUB A #
	.asc	"CMP A #", '@'+$80	; $81=CMP A #
	.asc	"SBC A #", '@'+$80	; $82=SBC A #
	.asc	"?", ' '+$80	; $83=?
	.asc	"AND A #", '@'+$80	; $84=AND A #
	.asc	"BIT A #", '@'+$80	; $85=BIT A #
	.asc	"LDA A #", '@'+$80	; $86=LDA A #
	.asc	"?", ' '+$80	; $87=?
	.asc	"EOR A #", '@'+$80	; $88=EOR A #
	.asc	"ADC A #", '@'+$80	; $89=ADC A #
	.asc	"ORA A #", '@'+$80	; $8A=ORA A #
	.asc	"ADD A #", '@'+$80	; $8B=ADD A #
	.asc	"CPX # ", '&'+$80	; $8C=CPX #
	.asc	"BSR ", '%'+$80	; $8D=BSR rel
	.asc	"LDS #", '&'+$80	; $8E=LDS #
	.asc	"?", ' '+$80	; $8F=?

	.asc	"SUB A ", '@'+$80	; $90=SUB A dir
	.asc	"CMP A ", '@'+$80	; $91=CMP A dir
	.asc	"SBC A ", '@'+$80	; $92=SBC A dir
	.asc	"?", ' '+$80	; $93=?
	.asc	"AND A ", '@'+$80	; $94=AND A dir
	.asc	"BIT A ", '@'+$80	; $95=BIT A dir
	.asc	"LDA A ", '@'+$80	; $96=LDA A dir
	.asc	"STA A ", '@'+$80	; $97=STA A dir
	.asc	"EOR A ", '@'+$80	; $98=EOR A dir
	.asc	"ADC A ", '@'+$80	; $99=ADC A dir
	.asc	"ORA A ", '@'+$80	; $9A=ORA A dir
	.asc	"ADD A ", '@'+$80	; $9B=ADD A dir
	.asc	"CPX ", '@'+$80	; $9C=CPX dir
	.asc	"?HCF", '!'+$80	; $9D=HCF	UNDOCUMENTED!
	.asc	"LDS ", '@'+$80	; $9E=LDS dir
	.asc	"STS ", '@'+$80	; $9F=STS dir

	.asc	"SUB A @, ", 'X'+$80	; $A0=SUB A idx
	.asc	"CMP A @, ", 'X'+$80	; $A1=CMP A idx
	.asc	"SBC A @, ", 'X'+$80	; $A2=SBC A idx
	.asc	"?", ' '+$80	; $A3=?
	.asc	"AND A @, ", 'X'+$80	; $A4=AND A idx
	.asc	"BIT A @, ", 'X'+$80	; $A5=BIT A idx
	.asc	"LDA A @, ", 'X'+$80	; $A6=LDA A idx
	.asc	"STA A @, ", 'X'+$80	; $A7=STA A idx
	.asc	"EOR A @, ", 'X'+$80	; $A8=EOR A idx
	.asc	"ADC A @, ", 'X'+$80	; $A9=ADC A idx
	.asc	"ORA A @, ", 'X'+$80	; $AA=ORA A idx
	.asc	"ADD A @, ", 'X'+$80	; $AB=ADD A idx
	.asc	"CPX @, ", 'X'+$80	; $AC=CPX idx
	.asc	"JSR @, ", 'X'+$80	; $AD=JSR idx
	.asc	"LDS @, ", 'X'+$80	; $AE=LDS A idx
	.asc	"STS @, ", 'X'+$80	; $AF=STS A idx

	.asc	"SUB A ", '&'+$80	; $B0=SUB A ext
	.asc	"CMP A ", '&'+$80	; $B1=CMP A ext
	.asc	"SBC A ", '&'+$80	; $B2=SBC A ext
	.asc	"?", ' '+$80	; $B3=?
	.asc	"AND A ", '&'+$80	; $B4=AND A ext
	.asc	"BIT A ", '&'+$80	; $B5=BIT A ext
	.asc	"LDA A ", '&'+$80	; $B6=LDA A ext
	.asc	"STA A ", '&'+$80	; $B7=STA A ext
	.asc	"EOR A ", '&'+$80	; $B8=EOR A ext
	.asc	"ADC A ", '&'+$80	; $B9=ASC A ext
	.asc	"ORA A ", '&'+$80	; $BA=ORA A ext
	.asc	"ADD A ", '&'+$80	; $BB=ADD A ext
	.asc	"CPX ", '&'+$80	; $BC=CPX ext
	.asc	"JSR ", '&'+$80	; $BD=JSR ext
	.asc	"LDS ", '&'+$80	; $BE=LDS ext
	.asc	"STS ", '&'+$80	; $BF=STS ext

	.asc	"SUB B #", '@'+$80	; $C0=SUB B #
	.asc	"CMP B #", '@'+$80	; $C1=CMP B #
	.asc	"SBC B #", '@'+$80	; $C2=SBC B #
	.asc	"?", ' '+$80	; $C3=?
	.asc	"AND B #", '@'+$80	; $C4=AND B #
	.asc	"BIT B #", '@'+$80	; $C5=BIT B #
	.asc	"LDA B #", '@'+$80	; $C6=LDA B #
	.asc	"STA B #", '@'+$80	; $C7=STA B #
	.asc	"EOR B #", '@'+$80	; $C8=EOR B #
	.asc	"ADC B #", '@'+$80	; $C9=ADC B #
	.asc	"ORA B #", '@'+$80	; $CA=ORA B #
	.asc	"ADD B #", '@'+$80	; $CB=ADD B #
	.asc	"?", ' '+$80	; $CC=?
	.asc	"?", ' '+$80	; $CD=?
	.asc	"LDX #", '&'+$80	; $CE=LDX #
	.asc	"?", ' '+$80	; $CF=?

	.asc	"SUB B ", '@'+$80	; $D0=SUB B dir
	.asc	"CMP B ", '@'+$80	; $D1=CMP B dir
	.asc	"SBC B ", '@'+$80	; $D2=SBC B dir
	.asc	"?", ' '+$80	; $D3=?
	.asc	"AND B ", '@'+$80	; $D4=AND B dir
	.asc	"BIT B ", '@'+$80	; $D5=BIT B dir
	.asc	"LDA B ", '@'+$80	; $D6=LDA B dir
	.asc	"STA B ", '@'+$80	; $D7=STA B dir
	.asc	"EOR B ", '@'+$80	; $D8=EOR B dir
	.asc	"ADC B ", '@'+$80	; $D9=ADC B dir
	.asc	"ORA B ", '@'+$80	; $DA=ORA B dir
	.asc	"ADD B ", '@'+$80	; $DB=ADD B dir
	.asc	"?", ' '+$80	; $DC=?
	.asc	"?HCF", '!'+$80	; $DD=HCF	UNDOCUMENTED!
	.asc	"LDX ", '@'+$80	; $DE=LDX dir
	.asc	"STX ", '@'+$80	; $DF=STX dir

	.asc	"SUB B @, ", 'X'+$80	; $E0=SUB B idx
	.asc	"CMP B @, ", 'X'+$80	; $E1=CMP B idx
	.asc	"SBC B @, ", 'X'+$80	; $E2=SBC B idx
	.asc	"?", ' '+$80	; $E3=?
	.asc	"AND B @, ", 'X'+$80	; $E4=AND B idx
	.asc	"BIT B @, ", 'X'+$80	; $E5=BIT B idx
	.asc	"LDA B @, ", 'X'+$80	; $E6=LDA B idx
	.asc	"STA B @, ", 'X'+$80	; $E7=STA B idx
	.asc	"EOR B @, ", 'X'+$80	; $E8=EOR B idx
	.asc	"ADC B @, ", 'X'+$80	; $E9=ADC B idx
	.asc	"ORA B @, ", 'X'+$80	; $EA=ORA B idx
	.asc	"ADD B @, ", 'X'+$80	; $EB=ADD B idx
	.asc	"?", ' '+$80	; $EC=?
	.asc	"?", ' '+$80	; $ED=?
	.asc	"LDX @, ", 'X'+$80	; $EE=LDX idx
	.asc	"STX @, ", 'X'+$80	; $EF=STX idx

	.asc	"SUB B ", '&'+$80	; $F0=SUB B ext
	.asc	"CMP B ", '&'+$80	; $F1=CMP B ext
	.asc	"SBC B ", '&'+$80	; $F2=SBC B ext
	.asc	"?", ' '+$80	; $F3=?
	.asc	"AND B ", '&'+$80	; $F4=AND B ext
	.asc	"BIT B ", '&'+$80	; $F5=BIT B ext
	.asc	"LDA B ", '&'+$80	; $F6=LDA B ext
	.asc	"STA B ", '&'+$80	; $F7=STA B ext
	.asc	"EOR B ", '&'+$80	; $F8=EOR B ext
	.asc	"ADC B ", '&'+$80	; $F9=ADC B ext
	.asc	"ORA B ", '&'+$80	; $FA=ORA B ext
	.asc	"ADD B ", '&'+$80	; $FB=ADD B ext
	.asc	"?", ' '+$80	; $FC=?
	.asc	"?", ' '+$80	; $FD=?
	.asc	"LDX B ", '&'+$80	; $FE=LDX B ext
	.asc	"STX B ", '&'+$80	; $FF=STX B ext
