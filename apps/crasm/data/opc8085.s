; minimOS opcode list for (dis)assembler modules
; (c) 2015-2017 Carlos J. Santisteban
; last modified 20170504-1116

; ***** for 80asm i8080/8085 cross assembler *****
; 8085 set
; Opcode list as bit-7 terminated strings
; @ expects single byte, & expects word
; % expects RELATIVE addressing

	.asc	"NO", 'P'+$80		; $00=NOP
	.asc	"LXI B, ", '&'+$80	; $01=LXI B
	.asc	"STAX ", 'B'+$80	; $02=STAX B
	.asc	"INX ", 'B'+$80		; $03=INX B
	.asc	"INR ", 'B'+$80		; $04=INR B
	.asc	"DCR ", 'B'+$80		; $05=DCR B
	.asc	"MVI B, ", '@'+$80	; $06=MVI B
	.asc	"RL", 'C'+$80		; $07=RLC
	.asc	"?", ' '+$80		; $08=*DSUB		UNDOCUMENTED!
	.asc	"DAD", 'B'+$80		; $09=DAD B
	.asc	"LDAX ", 'B'+$80	; $0A=LDAX B
	.asc	"DCX ", 'B'+$80		; $0B=DCX B
	.asc	"INR ", 'C'+$80		; $0C=INR C
	.asc	"DCR ", 'C'+$80		; $0D=DCR C
	.asc	"MVI C, ", '@'+$80	; $0E=MVI C
	.asc	"RR", 'C'+$80		; $0F=RRC

	.asc	"?", ' '+$80		; $10=*ARHL		UNDOCUMENTED!
	.asc	"LXI D, ", '&'+$80	; $11=LXI D
	.asc	"STAX ", 'D'+$80	; $12=STAX D
	.asc	"INX ", 'D'+$80		; $13=INX D
	.asc	"INR ", 'D'+$80		; $14=INR D
	.asc	"DCR ", 'D'+$80		; $15=DCR D
	.asc	"MVI D, ", '@'+$80	; $16=MVI D
	.asc	"RA", 'L'+$80		; $17=RAL
	.asc	"?", ' '+$80		; $18=*RDEL		UNDOCUMENTED!
	.asc	"DAD", 'D'+$80		; $19=DAD D
	.asc	"LDAX ", 'D'+$80	; $1A=LDAX D
	.asc	"DCX ", 'D'+$80		; $1B=DCX D
	.asc	"INR ", 'E'+$80		; $1C=INR E
	.asc	"DCR ", 'E'+$80		; $1D=DCR E
	.asc	"MVI E, ", '@'+$80	; $1E=MVI E
	.asc	"RA", 'R'+$80		; $1F=RAR

	.asc	"RI ", 'M'+$80		; $20=RIM
	.asc	"LXI H, ", '&'+$80	; $21=LXI H
	.asc	"SHL ", 'D'+$80		; $22=SHLD
	.asc	"INX ", 'H'+$80		; $23=INX H
	.asc	"INR ", 'H'+$80		; $24=INR H
	.asc	"DCR ", 'H'+$80		; $25=DCR H
	.asc	"MVI H, ", '@'+$80	; $26=MVI H
	.asc	"DA", 'A'+$80		; $27=DAA
	.asc	"? ", '@'+$80		; $28=*LDHI		UNDOCUMENTED!
	.asc	"DAD", 'H'+$80		; $29=DAD H
	.asc	"LDHL ", '&'+$80	; $2A=LDHL
	.asc	"DCX ", 'H'+$80		; $2B=DCX H
	.asc	"INR ", 'L'+$80		; $2C=INR L
	.asc	"DCR ", 'L'+$80		; $2D=DCR L
	.asc	"MVI L, ", '@'+$80	; $2E=MVI L
	.asc	"CM", 'A'+$80		; $2F=CMA

	.asc	"SI ", 'M'+$80		; $30=SIM
	.asc	"LXI SP, ", '&'+$80	; $31=LXI SP
	.asc	"STA ", '&'+$80		; $32=STA
	.asc	"INX ", 'SP'+$80	; $33=INX SP
	.asc	"INR ", 'M'+$80		; $34=INR M
	.asc	"DCR ", 'M'+$80		; $35=DCR M
	.asc	"MVI M, ", '@'+$80	; $36=MVI M
	.asc	"ST", 'C'+$80		; $37=STC
	.asc	"? ", '@'+$80		; $38=*LDSI		UNDOCUMENTED!
	.asc	"DAD", 'SP'+$80		; $39=DAD SP
	.asc	"LDA ", '&'+$80		; $3A=LDA
	.asc	"DCX ", 'SP'+$80	; $3B=DCX SP
	.asc	"INR ", 'A'+$80		; $3C=INR A
	.asc	"DCR ", 'A'+$80		; $3D=DCR A
	.asc	"MVI A, ", '@'+$80	; $3E=MVI A
	.asc	"CM", 'C'+$80		; $3F=CMC

	.asc	"MOV B, ", 'B'+$80	; $40=MOV B,B
	.asc	"MOV B, ", 'C'+$80	; $41=MOV B,C
	.asc	"MOV B, ", 'D'+$80	; $42=MOV B,D
	.asc	"MOV B, ", 'E'+$80	; $43=MOV B,E
	.asc	"MOV B, ", 'H'+$80	; $44=MOV B,H
	.asc	"MOV B, ", 'L'+$80	; $45=MOV B,L
	.asc	"MOV B, ", 'M'+$80	; $46=MOV B,M
	.asc	"MOV B, ", 'A'+$80	; $47=MOV B,A
	.asc	"MOV C, ", 'B'+$80	; $48=MOV C,B
	.asc	"MOV C, ", 'C'+$80	; $49=MOV C,C
	.asc	"MOV C, ", 'D'+$80	; $4A=MOV C,D
	.asc	"MOV C, ", 'E'+$80	; $4B=MOV C,E
	.asc	"MOV C, ", 'H'+$80	; $4C=MOV C,H
	.asc	"MOV C, ", 'L'+$80	; $4D=MOV C,L
	.asc	"MOV C, ", 'M'+$80	; $4E=MOV C,M
	.asc	"MOV C, ", 'A'+$80	; $4F=MOV C,A

	.asc	"MOV D, ", 'B'+$80	; $50=MOV D,B
	.asc	"MOV D, ", 'C'+$80	; $51=MOV D,C
	.asc	"MOV D, ", 'D'+$80	; $52=MOV D,D
	.asc	"MOV D, ", 'E'+$80	; $53=MOV D,E
	.asc	"MOV D, ", 'H'+$80	; $54=MOV D,H
	.asc	"MOV D, ", 'L'+$80	; $55=MOV D,L
	.asc	"MOV D, ", 'M'+$80	; $56=MOV D,M
	.asc	"MOV D, ", 'A'+$80	; $57=MOV D,A
	.asc	"MOV E, ", 'B'+$80	; $58=MOV E,B
	.asc	"MOV E, ", 'C'+$80	; $59=MOV E,C
	.asc	"MOV E, ", 'D'+$80	; $5A=MOV E,D
	.asc	"MOV E, ", 'E'+$80	; $5B=MOV E,E
	.asc	"MOV E, ", 'H'+$80	; $5C=MOV E,H
	.asc	"MOV E, ", 'L'+$80	; $5D=MOV E,L
	.asc	"MOV E, ", 'M'+$80	; $5E=MOV E,M
	.asc	"MOV E, ", 'A'+$80	; $5F=MOV E,A

	.asc	"MOV H, ", 'B'+$80	; $60=MOV H,B
	.asc	"MOV H, ", 'C'+$80	; $61=MOV H,C
	.asc	"MOV H, ", 'D'+$80	; $62=MOV H,D
	.asc	"MOV H, ", 'E'+$80	; $63=MOV H,E
	.asc	"MOV H, ", 'H'+$80	; $64=MOV H,H
	.asc	"MOV H, ", 'L'+$80	; $65=MOV H,L
	.asc	"MOV H, ", 'M'+$80	; $66=MOV H,M
	.asc	"MOV H, ", 'A'+$80	; $67=MOV H,A
	.asc	"MOV L, ", 'B'+$80	; $68=MOV L,B
	.asc	"MOV L, ", 'C'+$80	; $69=MOV L,C
	.asc	"MOV L, ", 'D'+$80	; $6A=MOV L,D
	.asc	"MOV L, ", 'E'+$80	; $6B=MOV L,E
	.asc	"MOV L, ", 'H'+$80	; $6C=MOV L,H
	.asc	"MOV L, ", 'L'+$80	; $6D=MOV L,L
	.asc	"MOV L, ", 'M'+$80	; $6E=MOV L,M
	.asc	"MOV L, ", 'A'+$80	; $6F=MOV L,A

	.asc	"MOV M, ", 'B'+$80	; $70=MOV M,B
	.asc	"MOV M, ", 'C'+$80	; $71=MOV M,C
	.asc	"MOV M, ", 'D'+$80	; $72=MOV M,D
	.asc	"MOV M, ", 'E'+$80	; $73=MOV M,E
	.asc	"MOV M, ", 'H'+$80	; $74=MOV M,H
	.asc	"MOV M, ", 'L'+$80	; $75=MOV M,L
	.asc	"MOV M, ", 'M'+$80	; $76=MOV M,M
	.asc	"MOV M, ", 'A'+$80	; $77=MOV M,A
	.asc	"MOV A, ", 'B'+$80	; $78=MOV A,B
	.asc	"MOV A, ", 'C'+$80	; $79=MOV A,C
	.asc	"MOV A, ", 'D'+$80	; $7A=MOV A,D
	.asc	"MOV A, ", 'E'+$80	; $7B=MOV A,E
	.asc	"MOV A, ", 'H'+$80	; $7C=MOV A,H
	.asc	"MOV A, ", 'L'+$80	; $7D=MOV A,L
	.asc	"MOV A, ", 'M'+$80	; $7E=MOV A,M
	.asc	"MOV A, ", 'A'+$80	; $7F=MOV A,A

	.asc	"ADD  ", 'B'+$80	; $80=ADD B
	.asc	"ADD  ", 'C'+$80	; $81=ADD C
	.asc	"ADD  ", 'D'+$80	; $82=ADD D
	.asc	"ADD  ", 'E'+$80	; $83=ADD E
	.asc	"ADD  ", 'H'+$80	; $84=ADD H
	.asc	"ADD  ", 'L'+$80	; $85=ADD L
	.asc	"ADD  ", 'M'+$80	; $86=ADD M
	.asc	"ADD  ", 'A'+$80	; $87=ADD A
	.asc	"ADC  ", 'B'+$80	; $88=ADC B
	.asc	"ADC  ", 'C'+$80	; $89=ADC C
	.asc	"ADC  ", 'D'+$80	; $8A=ADC D
	.asc	"ADC  ", 'E'+$80	; $8B=ADC E
	.asc	"ADC  ", 'H'+$80	; $8C=ADC H
	.asc	"ADC  ", 'L'+$80	; $8D=ADC L
	.asc	"ADC  ", 'M'+$80	; $8E=ADC M
	.asc	"ADC  ", 'A'+$80	; $8F=ADC A

	.asc	"SUB  ", 'B'+$80	; $90=SUB B
	.asc	"SUB  ", 'C'+$80	; $91=SUB C
	.asc	"SUB  ", 'D'+$80	; $92=SUB D
	.asc	"SUB  ", 'E'+$80	; $93=SUB E
	.asc	"SUB  ", 'H'+$80	; $94=SUB H
	.asc	"SUB  ", 'L'+$80	; $95=SUB L
	.asc	"SUB  ", 'M'+$80	; $96=SUB M
	.asc	"SUB  ", 'A'+$80	; $97=SUB A
	.asc	"SBB  ", 'B'+$80	; $98=SBB B
	.asc	"SBB  ", 'C'+$80	; $99=SBB C
	.asc	"SBB  ", 'D'+$80	; $9A=SBB D
	.asc	"SBB  ", 'E'+$80	; $9B=SBB E
	.asc	"SBB  ", 'H'+$80	; $9C=SBB H
	.asc	"SBB  ", 'L'+$80	; $9D=SBB L
	.asc	"SBB  ", 'M'+$80	; $9E=SBB M
	.asc	"SBB  ", 'A'+$80	; $9F=SBB A

	.asc	"ANA  ", 'B'+$80	; $A0=ANA B
	.asc	"ANA  ", 'C'+$80	; $A1=ANA C
	.asc	"ANA  ", 'D'+$80	; $A2=ANA D
	.asc	"ANA  ", 'E'+$80	; $A3=ANA E
	.asc	"ANA  ", 'H'+$80	; $A4=ANA H
	.asc	"ANA  ", 'L'+$80	; $A5=ANA L
	.asc	"ANA  ", 'M'+$80	; $A6=ANA M
	.asc	"ANA  ", 'A'+$80	; $A7=ANA A
	.asc	"XRA  ", 'B'+$80	; $A8=XRA B
	.asc	"XRA  ", 'C'+$80	; $A9=XRA C
	.asc	"XRA  ", 'D'+$80	; $AA=XRA D
	.asc	"XRA  ", 'E'+$80	; $AB=XRA E
	.asc	"XRA  ", 'H'+$80	; $AC=XRA H
	.asc	"XRA  ", 'L'+$80	; $AD=XRA L
	.asc	"XRA  ", 'M'+$80	; $AE=XRA M
	.asc	"XRA  ", 'A'+$80	; $AF=XRA A

	.asc	"ORA  ", 'B'+$80	; $B0=ORA B
	.asc	"ORA  ", 'C'+$80	; $B1=ORA C
	.asc	"ORA  ", 'D'+$80	; $B2=ORA D
	.asc	"ORA  ", 'E'+$80	; $B3=ORA E
	.asc	"ORA  ", 'H'+$80	; $B4=ORA H
	.asc	"ORA  ", 'L'+$80	; $B5=ORA L
	.asc	"ORA  ", 'M'+$80	; $B6=ORA M
	.asc	"ORA  ", 'A'+$80	; $B7=ORA A
	.asc	"CMP  ", 'B'+$80	; $B8=CMP B
	.asc	"CMP  ", 'C'+$80	; $B9=CMP C
	.asc	"CMP  ", 'D'+$80	; $BA=CMP D
	.asc	"CMP  ", 'E'+$80	; $BB=CMP E
	.asc	"CMP  ", 'H'+$80	; $BC=CMP H
	.asc	"CMP  ", 'L'+$80	; $BD=CMP L
	.asc	"CMP  ", 'M'+$80	; $BE=CMP M
	.asc	"CMP  ", 'A'+$80	; $BF=CMP A

	.asc	"RN", 'Z'+$80		; $C0=RNZ
	.asc	"POP ", 'B'+$80		; $C1=POP B
	.asc	"JNZ ", '&'+$80		; $C2=JNZ
	.asc	"JMP ", '&'+$80		; $C3=JMP
	.asc	"CNZ ", '&'+$80		; $C4=CNZ
	.asc	"PUSH ", 'B'+$80	; $C5=PUSH B
	.asc	"ADI ", '@'+$80		; $C6=ADI
	.asc	"RST ", '0'+$80		; $C7=RST 0
	.asc	"R", 'Z'+$80		; $C8=RZ
	.asc	"RE", 'T'+$80		; $C9=RET
	.asc	"JZ ", '&'+$80		; $CA=JZ
	.asc	"?", ' '+$80		; $CB=*RSTV		UNDOCUMENTED!
	.asc	"CZ ", '&'+$80		; $CC=CZ
	.asc	"CALL ", '&'+$80	; $CD=CALL
	.asc	"ACI ", '@'+$80		; $CE=ACI
	.asc	"RST ", '1'+$80		; $CF=RST 1
; SEGUIR EN http://pastraiser.com/cpu/i8085/i8085_opcodes.html
