/* Perdita 65C02 Durango-X emulator!
 * (c)2007-2022 Carlos J. Santisteban
 * last modified 20220711-1001
 * */

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <unistd.h>
// SDL Install: apt-get install libsdl2-dev. Build with -lSDL2 flag
#include <SDL2/SDL.h>
// arguments parser
#include <unistd.h>

/* type definitions */
	typedef uint8_t byte;
	typedef uint16_t word;

/* global variables */
	byte mem[65536];		// unified memory map

	byte a, x, y, s, p;		// 8-bit registers
	word pc;				// program counter

	word screen = 0;		// Durango screen switcher, xSSxxxxx xxxxxxxx *** may not use it
	int dec;				// decimal flag for speed penalties (CMOS only)
	int run = 1;			// allow execution
	int ver = 0;			// verbosity mode, 0 = none, 1 = warnings, 2 = interrupts, 3 = jumps, 4 = all; will stop on BRK unless < 2
	int fast = 0;			// speed flag
	int graf = 1;			// enable SDL2 graphic display
	int safe = 0;			// enable safe mode (stops on warnings)
	int stat_flag = 0;		// external control
	int nmi_flag = 0;		// interrupt control
	int irq_flag = 0;
	long cont = 0;			// total elapsed cycles

/* global vdu variables */
	// Screen width in pixels
	int VDU_SCREEN_WIDTH;
	// Screen height in pixels
	int VDU_SCREEN_HEIGHT;
	// Pixel size, both colout and HIRES modes
	int pixel_size, hpixel_size;
	//The window we'll be rendering to
	SDL_Window *sdl_window;
	//The window renderer
	SDL_Renderer* sdl_renderer;
	// Display mode
	SDL_DisplayMode sdl_display_mode;
	// Game Controllers
	SDL_Joystick *sdl_gamepads[2];
	// Do not close GUI after program end
	int keep_open = 0;

/* ******************* */
/* function prototypes */
/* ******************* */
/* emulator control */
	void load(const char name[], word adr);		// load firmware
	void ROMload(const char name[]);			// load ROM at the end, calling load()
	void stat(void);		// display processor status
	void dump(word dir);	// display 16 bytes of memory
	void run_emulation();	// Run emulator
	int  exec(void);		// execute one opcode, returning number of cycles
	void illegal(byte s, byte op);				// if in safe mode, abort on illegal opcodes
	void process_keyboard(SDL_Event*);

/* memory management */
	byte peek(word dir);			// read memory or I/O
	void poke(word dir, byte v);	// write memory or I/O
	void push(byte b)		{ poke(0x100 + s--, b); }		// standard stack ops
	byte pop(void)			{ return peek(++s + 0x100); }

/* interrupt support */
	void intack(void);		// save status for interrupt acknowledge
	void reset(void);		// RESET & hardware interrupts
	void nmi(void);
	void irq(void);

/* opcode support */
	void bits_nz(byte b);	// set N&Z flags

	void asl(byte *d);		// shift left
	void lsr(byte *d);		// shift right
	void rol(byte *d);		// rotate left
	void ror(byte *d);		// rotate right

	void adc(byte d);		// add to A with carry
	void sbc(byte d);		// subtract from A with borrow, 6502-style
	void cmp(byte reg, byte d);		// compare, based on subtraction result

/* addressing modes */
	word am_a(void);		// absolute
	word am_ax(int*);		// absolute indexed X, possible penalty
	word am_ay(int*);		// absolute indexed Y, possible penalty
	byte am_zx(void)		{ return (peek(pc++) + x) & 255; }	// ZeroPage indexed X
	byte am_zy(void)		{ return (peek(pc++) + y) & 255; }	// ZeroPage indexed Y (rare)
	word am_ix(void);		// pre-indexed indirect X (rare)
	word am_iy(int*);		// indirect post-indexed Y, possible penalty
	word am_iz(void);		// indirect (CMOS only)
	word am_ai(void)		{ word j=am_a(); return peek(j)  |(peek(j+1)  <<8); }	// absolute indirect, not broken
	word am_aix(void)		{ word j=am_a(); return peek(j+x)|(peek(j+x+1)<<8); }	// absolute pre-indexed indirect (CMOS only)
	void rel(int*);			// relative branches, possible penalty

/* *********************** */
/* vdu function prototypes */
/* *********************** */

	int  init_vdu();		// Initialize vdu display window
	void close_vdu();		// Close vdu display window
	void vdu_draw_full();	// Draw full screen
	void vdu_read_keyboard();	// Read keyboard
/* vdu internal functions */
	void vdu_set_color_pixel(byte);
	void vdu_set_hires_pixel(byte);
	void vdu_draw_color_pixel(word);
	void vdu_draw_hires_pixel(word);


/* ************************************************* */
/* ******************* main loop ******************* */
/* ************************************************* */
int main(int argc, char *argv[])
{
	int index;
	int arg_index;
	int c;
	char *filename;
	char *rom_addr=NULL;
	int rom_addr_int;

	if(argc==1) {
		printf("usage: %s [-a rom_address] [-v] rom_file\n", argv[0]);	// in case user renames the executable
		printf("-a: load ROM at supplied address, example 0x8000\n");
		printf("-f fast mode\n");
		printf("-s safe mode (will stop on warnings and BRK)\n");
		printf("-k keep GUI open after program end\n");
		printf("-h headless (no graphics!)\n");
		printf("-v verbose\n");
		return 1;
	}

	opterr = 0;

	while ((c = getopt (argc, argv, "a:fvksh")) != -1)
	switch (c) {
		case 'a':
			rom_addr = optarg;
			break;
		case 'f':
			fast = 1;
			break;
		case 'k':
			keep_open = 1;
			break;
		case 'v':
			ver++;			// not that I like this, but...
			break;
		case 's':
			safe = 1;
			break;
		case 'h':
			graf = 0;
			break;
		case '?':
			fprintf (stderr, "Unknown option\n");
			return 1;
		default:
			abort ();
	}

	for (arg_index = 0, index = optind; index < argc; index++, arg_index++) {
		switch(arg_index) {
			case 0: filename = argv[index]; break;
		}
	}

	if(arg_index == 0) {
		printf("Filename is mandatory\n");
		return 1;
	}
	
	if(rom_addr != NULL && (strlen(rom_addr) != 6 || rom_addr[0]!='0' || rom_addr[1]!='x')) {
		printf("ROM address format: 0x0000\n");
		return 1;
	}

	if(rom_addr == NULL) {
		ROMload(filename);
	}
	else {
		rom_addr_int = (int)strtol(rom_addr, NULL, 0);
		load(filename, rom_addr_int);
		mem[0xFFFC] = rom_addr_int & 0xFF;	// set RESET vector pointing to loaded code
		mem[0xFFFD] = rom_addr_int >> 8;
		mem[0xDF80] = 0x38;					// just in case, set default screen, colour mode
	}

	run_emulation();

	return 0;
}

void run_emulation () {
	int cyc=0, it=0;		// instruction and interrupt cycle counter
	int ht=0;				// horizontal counter
	int line=0;				// line count for vertical retrace flag
	clock_t next;			// delay counter
	clock_t sleep_time;		// delay time
	clock_t render_start;	// for SDL/GPU performance evaluation
	long frames = 0;		// total elapsed frames (for performance evaluation)
	long ticks = 0;			// total added microseconds of DELAY
	long us_render = 0;		// total microseconds of rendering
	long skip = 0;			// total skipped frames

	printf("[F1=STOP, F2=NMI, F3=IRQ, F4=RESET, F5=STATUS, F6=DUMP]\n");
	init_vdu();
	reset();				// ready to start!

	next=clock()+4000;		// set delay counter, assumes CLOCKS_PER_SEC is 1000000!
	while (run) {
/* execute current opcode */
		cyc = exec();		// count elapsed clock cycles for this instruction
		cont += cyc;		// add last instruction cycle count
		it += cyc;			// advance interrupt counter
		ht += cyc;			// both get slightly out-of-sync during interrupts, but...
/* check horizontal counter for HSYNC flag and count lines for VSYNC */
		if (ht >= 98) {
			ht -= 98;
			line++;
			if (line >= 312) {
				line = 0;				// 312-line field limit
				frames++;
				render_start = clock();
				if (graf)	vdu_draw_full();		// seems worth updating screen every VSYNC
				us_render += clock()-render_start;	// compute rendering time
/* make a suitable delay for speed accuracy */
				if (!fast) {
					sleep_time=next-clock();
					ticks += sleep_time;		// for performance measurement
					if(sleep_time>0) {
						usleep(sleep_time);		// should be accurate enough
					} else {
						skip++;
						if (!ver) {
							printf("!");		// not enough CPU power!
						}
					}
					next=clock()+20000;			// set next frame time (more like 19932)
				}
			}
			mem[0xDF88] &= 0b10111111;			// replace bit 6 (VSYNC)...
			mem[0xDF88] |= (line&256)>>2;		// ...by bit 8 of line number (>=256)
		}
		mem[0xDF88] &= 0b01111111;		// replace bit 7 (HSYNC)...
		mem[0xDF88] |= (ht&64)<<1;		// ...by bit 6 of bye counter (>=64)
/* check hardware interrupt counter */
		if (it >= 6144)		// 250 Hz interrupt @ 1.536 MHz
		{
			it -= 6144;		// restore for next
/* get keypresses from SDL here, as this get executed every 4 ms */
			vdu_read_keyboard();	// ***is it possible read keys without initing graphics?
/* generate periodic interrupt */ 
			if (mem[0xDFA0] & 1) {
				irq();							// if hardware interrupts are enabled, send signal to CPU
			}
			fflush(stdout);						// update terminal screen
		}
/* generate asynchronous interrupts */ 
		if (irq_flag) {		// 'spurious' cartridge interrupt emulation!
			irq_flag = 0;
 			irq();
 		}
		if (nmi_flag) {
			nmi_flag = 0;
			nmi();			// NMI gets executed always
		}
		if (stat_flag) {
			stat_flag = 0;
			stat();
		}
	}

	if (graf)	vdu_draw_full();		// last screen update
	printf(" *** CPU halted after %ld clock cycles ***\n", cont);
	stat();								// display final status

/* performance statistics */
	printf("\nSkipped frames: %ld (%f%%)\n", skip, skip*100.0/frames);
	printf("Average CPU time use: %f%%\n", 100-(ticks/200.0/frames));
	printf("Average Rendering time: %ld µs (%f%%)\n", us_render/frames, us_render/frames/200.0);
	if(keep_open) {
		printf("\nPress ENTER key to exit\n");
		getchar();
	}

	close_vdu();
}

/* **************************** */
/* support functions definition */
/* **************************** */

/* display CPU status */
void stat(void)	{ 
	int i;
	byte psr = p;			// local copy of status
	const char flag[8]="NV.bDIZC";	// flag names

	pc--;
	printf("<PC=$%04X, A=$%02X, X=$%02X, Y=$%02X, S=$%02X>\n<PSR: ", pc, a, x, y, s);
	for (i=0; i<8; i++) {
		if (psr&128)	printf("%c", flag[i]);
		else			printf("·");
		psr<<=1;			// next flag
	}
	printf(">\n");
}

/* display 16 bytes of memory */
void dump(word dir) {
	int i;

	printf("$%04X: ", dir);
	for (i=0; i<16; i++)		printf("%02X ", mem[dir+i]);
	printf ("[");
	for (i=0; i<16; i++)
		if ((mem[dir+i]>31)&&(mem[dir+i]<127))	printf("%c", mem[dir+i]);
		else 									printf("·");
	printf ("]\n");
}

void full_dump() {
	FILE *f;
	
	f = fopen("dump.bin", "wb");
	if (f != NULL) {
		fwrite(mem, sizeof(byte), 65536, f); 

		fclose(f);
		printf("dump.bin generated\n");
	}
	else {
		printf("*** Could not write dump ***\n");
		run = 0;
	}
}

/* load firmware, arbitrary position */
void load(const char name[], word adr) {
	FILE *f;
	int c, b = 0;

	f = fopen(name, "rb");
	if (f != NULL) {
		do {
			c = fgetc(f);
			mem[adr+(b++)] = c;	// load one byte
		} while( c != EOF);

		fclose(f);
		printf("%s: %d bytes loaded at $%04X\n", name, b, adr);
	}
	else {
		printf("*** Could not load image ***\n");
		run = 0;
	}
}

/* load ROM at the end of memory map */
void ROMload(const char name[]) {
	FILE *f;
	word pos = 0;
	long siz;

	f = fopen(name, "rb");
	if (f != NULL) {
		fseek(f, 0, SEEK_END);	// go to end of file
		siz = ftell(f);			// get size
		fclose(f);				// done for now, load() will reopen
		if (siz > 32768) {
			printf("*** ROM too large! ***\n");
			run = 0;
		} else {
			pos -= siz;
			printf("Loading %s... (%ld K ROM image)\n", name, siz>>10);
			load(name, pos);	// get actual ROM image
		}
	}
	else {
		printf("*** Could not load ROM ***\n");
		run = 0;
	}
}

/* *** memory management *** */
/* read from memory or I/O */
byte peek(word dir) {
	byte d = 0xFF;				// supposed floating databus value?

	if (dir>=0xDF80 && dir<=0xDFFF) {	// *** I/O ***
		if (dir<=0xDF87)		// video mode (high nibble readable)
			d = mem[0xDF80] | 0x0F;		// assume RGB mode and $FF floating value
		else if (dir<=0xDF8F)	// sync flags
			d = mem[0xDF88];
		else if (dir<=0xDF9F) {	// expansion port
			d = mem[dir];		// *** is this OK?
		} else if (dir<=0xDFBF) {		// interrupt control and beeper are NOT readable and WILL be corrupted otherwise
			if (ver)	printf("\n*** Reading from Write-only ports at $%04X ***\n", pc);
			if (safe)	run = 0;
		} else {				// cartridge I/O
			d = mem[dir];		// *** is this OK?
		}
	} else {
		d = mem[dir];			// default memory read, either RAM or ROM
	}

	return d;
}

/* write to memory or I/O */
void poke(word dir, byte v) {
	if (dir<=0x7FFF) {			// 32 KiB static RAM
		mem[dir] = v;
//		if ((dir & 0x6000) == screen) {			// VRAM area *** no need as whole screen will be updated every frame
			// send (dir&0x1FFF, v) to VDU
//		}
	} else if (dir>=0xDF80 && dir<=0xDFFF) {	// *** I/O ***
		if (dir<=0xDF87) {		// video mode?
			mem[0xDF80] = v;	// canonical address
			screen = (v & 0b00110000) << 9;		// screen switching *** may not use 'screen' anymore
			// VDU-redraw all VRAM at selected screen! *** may not need it
			// may add more flags for VDU
		} else if (dir<=0xDF8F) {				// sync flags not writable!
			if (ver)	printf("\n*** Writing to Read-only ports at $%04X ***\n", pc);
			if (safe)	run = 0;
		} else if (dir<=0xDF9F) {				// expansion port?
			mem[dir] = v;		// *** is this OK?
		} else if (dir<=0xDFAF)	// interrupt control?
			mem[0xDFA0] = v;	// canonical address, only D0 matters
		else if (dir<=0xDFBF) {	// beeper?
			mem[0xDFB0] = v;	// canonical address, only D0 matters *** anything else for SDL audio?
		} else {
			mem[dir] = v;		// otherwise is cartridge I/O *** anything else?
		}
	} else {					// any other address is ROM, thus no much sense writing there?
		if (ver)	printf("\n*** Writing to ROM at $%04X ***\n", pc);
		if (safe)	run=0;
	}
}

/* *** interrupt support *** */
/* acknowledge interrupt and save status */
void intack(void) {
	push(pc >> 8);							// stack standard status
	push(pc & 255);
	push(p);

	p |= 0b00000100;						// set interrupt mask
	p &= 0b11110111;						// and clear Decimal mode (CMOS only)
	dec = 0;

	cont += 7;								// interrupt acknowledge time
}

/* reset CPU, like !RES signal */
void reset(void) {
	pc = peek(0xFFFC) | peek(0xFFFD)<<8;	// RESET vector

	if (ver > 1)	printf(" RESET: PC=>%04X\n", pc);

	p &= 0b11110111;						// CLD on 65C02
	p |= 0b00110100;						// these always 1, includes SEI
	dec = 0;								// per CLD above
	mem[0xDFA0] = 0;						// interrupt gets disabled on RESET!

	cont = 0;								// reset global cycle counter?
}

/* emulate !NMI signal */
void nmi(void) {
	intack();								// acknowledge and save

	pc = peek(0xFFFA) | peek(0xFFFB)<<8;	// NMI vector
	if (ver > 1)	printf(" NMI: PC=>%04X\n", pc);
}

/* emulate !IRQ signal */
void irq(void) {
	if (!(p & 4)) {								// if not masked...
		p &= 0b11101111;						// clear B, as this is IRQ!
		intack();								// acknowledge and save
		p |= 0b00010000;						// retrieve current status

		pc = peek(0xFFFE) | peek(0xFFFF)<<8;	// IRQ/BRK vector
		if (ver > 1)	printf(" IRQ: PC=>%04X\n", pc);
	}
}

/* *** addressing modes *** */
/* absolute */
word am_a(void) {
	word pt = peek(pc) | (peek(pc+1) <<8);
	pc += 2;

	return pt;
}

/* absolute indexed X */
word am_ax(int *bound) {
	word ba = am_a();		// pick base address and skip operand
	word pt = ba + x;		// add offset
	*bound = ((pt & 0xFF00)==(ba & 0xFF00))?0:1;	// check page crossing

	return pt;
}

/* absolute indexed Y */
word am_ay(int *bound) {
	word ba = am_a();		// pick base address and skip operand
	word pt = ba + y;		// add offset
	*bound = ((pt & 0xFF00)==(ba & 0xFF00))?0:1;	// check page crossing

	return pt;
}

/* indirect */
word am_iz(void) {
	word pt = peek(peek(pc)) | (peek(peek(pc)+1)<<8);
	pc++;

	return pt;
}

/* indirect post-indexed */
word am_iy(int *bound) {
	word ba = am_iz();		// pick base address and skip operand
	word pt = ba + y;		// add offset
	*bound = ((pt & 0xFF00)==(ba & 0xFF00))?0:1;	// check page crossing

	return pt;
}

/* pre-indexed indirect */
word am_ix(void) {
	word pt = (peek(peek(pc)+x)|(peek(peek(pc)+x+1)<<8));
	pc++;

	return pt;
}

/* relative branch */
void rel(int *bound) {
	byte off = peek(pc++);	// read offset and skip operand
	word old = pc;

	pc += off;
	pc -= (off & 128)?256:0;						// check negative displacement

	*bound = ((old & 0xFF00)==(pc & 0xFF00))?0:1;	// check page crossing
}

/* *** opcode assistants *** */
/* compute usual N & Z flags from value */
void bits_nz(byte b) {
	p &= 0b01111101;		// pre-clear N & Z
	p |= (b & 128);			// set N as bit 7
	p |= (b==0)?2:0;		// set Z accordingly
}

/* ASL, shift left */
void asl(byte *d) {
	p &= 0b11111110;		// clear C
	p |= ((*d) & 128) >> 7;	// will take previous bit 7
	(*d) <<= 1;				// EEEEEEEEK
	bits_nz(*d);
}

/* LSR, shift right */
void lsr(byte *d) {
	p &= 0b11111110;		// clear C
	p |= (*d) & 1;			// will take previous bit 0
	(*d) >>= 1;				// eeeek
	bits_nz(*d);
}

/* ROL, rotate left */
void rol(byte *d) {
	byte tmp = (p & 1);		// keep previous C

	p &= 0b11111110;		// clear C
	p |= ((*d) & 128) >> 7;	// will take previous bit 7
	(*d) <<= 1;				// eeeeeek
	(*d) |= tmp;			// rotate C
	bits_nz(*d);
}

/* ROR, rotate right */
void ror(byte *d) {
	byte tmp = (p & 1)<<7;	// keep previous C (shifted)

	p &= 0b11111110;		// clear C
	p |= (*d) & 1;			// will take previous bit 0
	(*d) >>= 1;				// eeeek
	(*d) |= tmp;			// rotate C
	bits_nz(*d);
}

/* ADC, add with carry */
void adc(byte d) {
	byte old = a;
	word big = a;

	big += d;				// basic add... but check for Decimal mode!
	big += (p & 1);			// add with Carry
	a = big & 255;

	if (p & 0b00001000) {						// Decimal mode!
		if ((a & 0x0F) > 9) {					// LSN overflow?
			a += 6;								// get into next decade
		}
		if ((a & 0xF0) > 0x90) {				// MSN overflow?
			a += 0x60;							// correct it
		}
	}

	if (big & 256)			p |= 0b00000001;	// set Carry if needed
	else					p &= 0b11111110;
	if ((a&128)^(old&128))	p |= 0b01000000;	// set oVerflow if needed
	else					p &= 0b10111111;
	bits_nz(a);									// set N & Z as usual
}

/* SBC, sutract with borrow */	// *** check
void sbc(byte d) {
	byte old = a;
	word big = a;

	big += ~d;				// basic subtract, 6502-style... but check for Decimal mode!
	big += (p & 1);			// add with Carry
	a = big & 255;

	if (p & 0b00001000) {						// Decimal mode!
		if ((a & 0x0F) > 9) {					// LSN overflow?
			a -= 6;								// get into next decade *** check
		}
		if ((a & 0xF0) > 0x90) {				// MSN overflow?
			a -= 0x60;							// correct it
		}
	}

	if (big & 256)			p |= 0b00000001;	// set Carry if needed
	else					p &= 0b11111110;
	if ((a&128)^(old&128))	p |= 0b01000000;	// set oVerflow if needed
	else					p &= 0b10111111;
	bits_nz(a);									// set N & Z as usual
}

/* CMP/CPX/CPY compare register to memory */
void cmp(byte reg, byte d) {
	word big = reg;

	big -= d;				// apparent subtract, always binary

	if (big & 256)			p &= 0b11111110;	// set Carry if needed (note inversion)
	else					p |= 0b00000001;
	bits_nz(reg - d);							// set N & Z as usual
}

/* execute a single opcode, returning cycle count */
int exec(void) {
	int per = 2;			// base cycle count
	int page = 0;			// page boundary flag, for speed penalties
	byte opcode, temp;
	word adr;

	opcode = peek(pc++);	// get opcode and point to next one (or operand)

	switch(opcode) {
/* *** ADC: Add Memory to Accumulator with Carry *** */
		case 0x69:
			adc(peek(pc++));
			if (ver > 3) printf("[ADC#]");
			per += dec;
			break;
		case 0x6D:
			adc(peek(am_a()));
			if (ver > 3) printf("[ADCa]");
			per = 4 + dec;
			break;
		case 0x65:
			adc(peek(peek(pc++)));
			if (ver > 3) printf("[ADCz]");
			per = 3 + dec;
			break;
		case 0x61:
			adc(peek(am_ix()));
			if (ver > 3) printf("[ADC(x)]");
			per = 6 + dec;
			break;
		case 0x71:
			adc(peek(am_iy(&page)));
			if (ver > 3) printf("[ADC(y)]");
			per = 5 + dec + page;
			break;
		case 0x75:
			adc(peek(am_zx()));
			if (ver > 3) printf("[ADCzx]");
			per = 4 + dec;
			break;
		case 0x7D:
			adc(peek(am_ax(&page)));
			if (ver > 3) printf("[ADCx]");
			per = 4 + dec + page;
			break;
		case 0x79:
			adc(peek(am_ay(&page)));
			if (ver > 3) printf("[ADCy]");
			per = 4 + dec + page;
			break;
		case 0x72:			// CMOS only
			adc(peek(am_iz()));
			if (ver > 3) printf("[ADC(z)]");
			per = 5 + dec;
			break;
/* *** AND: "And" Memory with Accumulator *** */
		case 0x29:
			a &= peek(pc++);
			bits_nz(a);
			if (ver > 3) printf("[AND#]");
			break;
		case 0x2D:
			a &= peek(am_a());
			bits_nz(a);
			if (ver > 3) printf("[ANDa]");
			per = 4;
			break;
		case 0x25:
			a &= peek(peek(pc++));
			bits_nz(a);
			if (ver > 3) printf("[ANDz]");
			per = 3;
			break;
		case 0x21:
			a &= peek(am_ix());
			bits_nz(a);
			if (ver > 3) printf("[AND(x)]");
			per = 6;
			break;
		case 0x31:
			a &= peek(am_iy(&page));
			bits_nz(a);
			if (ver > 3) printf("[AND(y)]");
			per = 5 + page;
			break;
		case 0x35:
			a &= peek(am_zx());
			bits_nz(a);
			if (ver > 3) printf("[ANDzx]");
			per = 4;
			break;
		case 0x3D:
			a &= peek(am_ax(&page));
			bits_nz(a);
			if (ver > 3) printf("[ANDx]");
			per = 4 + page;
			break;
		case 0x39:
			a &= peek(am_ay(&page));
			bits_nz(a);
			if (ver > 3) printf("[ANDy]");
			per = 4 + page;
			break;
		case 0x32:			// CMOS only
			a &= peek(am_iz());
			bits_nz(a);
			if (ver > 3) printf("[AND(z)]");
			per = 5;
			break;
/* *** ASL: Shift Left one Bit (Memory or Accumulator) *** */
		case 0x0E:
			adr = am_a();
			temp = peek(adr);
			asl(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ASLa]");
			per = 6;
			break;
		case 0x06:
			temp = peek(peek(pc));
			asl(&temp);
			poke(peek(pc++), temp);
			if (ver > 3) printf("[ASLz]");
			per = 5;
			break;
		case 0x0A:
			asl(&a);
			if (ver > 3) printf("[ASL]");
			break;
		case 0x16:
			adr = am_zx();
			temp = peek(adr);
			asl(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ASLzx]");
			per = 6;
			break;
		case 0x1E:
			adr = am_ax(&page);
			temp = peek(adr);
			asl(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ASLx]");
			per = 6 + page;	// 7 on NMOS
			break;
/* *** Bxx: Branch on flag condition *** */
		case 0x90:
			if(!(p & 0b00000001)) {
				rel(&page);
				per = 3 + page;
				if (ver > 2) printf("[BCC]");
			} else pc++;	// must skip offset if not done EEEEEK
			break;
		case 0xB0:
			if(p & 0b00000001) {
				rel(&page);
				per = 3 + page;
				if (ver > 2) printf("[BCS]");
			} else pc++;	// must skip offset if not done EEEEEK
			break;
		case 0xF0:
			if(p & 0b00000010) {
				rel(&page);
				per = 3 + page;
				if (ver > 2) printf("[BEQ]");
			} else pc++;	// must skip offset if not done EEEEEK
			break;
/* *** BIT: Test Bits in Memory with Accumulator *** */
		case 0x2C:
			temp = peek(am_a());
			p &= 0b00111101;			// pre-clear N, V & Z
			p |= (temp & 0b11000000);	// copy bits 7 & 6 as N & Z
			p |= (a & temp)?0:2;		// set Z accordingly
			if (ver > 3) printf("[BITa]");
			per = 4;
			break;
		case 0x24:
			temp = peek(peek(pc++));
			p &= 0b00111101;			// pre-clear N, V & Z
			p |= (temp & 0b11000000);	// copy bits 7 & 6 as N & Z
			p |= (a & temp)?0:2;		// set Z accordingly
			if (ver > 3) printf("[BITz]");
			per = 3;
			break;
		case 0x89:			// CMOS only
			temp = peek(pc++);
			p &= 0b11111101;			// pre-clear Z only, is this OK?
			p |= (a & temp)?0:2;		// set Z accordingly
			if (ver > 3) printf("[BIT#]");
			break;
		case 0x3C:			// CMOS only
			temp = peek(am_ax(&page));
			p &= 0b00111101;			// pre-clear N, V & Z
			p |= (temp & 0b11000000);	// copy bits 7 & 6 as N & Z
			p |= (a & temp)?0:2;		// set Z accordingly
			if (ver > 3) printf("[BITx]");
			per = 4 + page;
			break;
		case 0x34:			// CMOS only
			temp = peek(am_zx());
			p &= 0b00111101;			// pre-clear N, V & Z
			p |= (temp & 0b11000000);	// copy bits 7 & 6 as N & Z
			p |= (a & temp)?0:2;		// set Z accordingly
			if (ver > 3) printf("[BITzx]");
			per = 4;
			break;
/* *** Bxx: Branch on flag condition *** */
		case 0x30:
			if(p & 0b10000000) {
				rel(&page);
				per = 3 + page;
			} else pc++;	// must skip offset if not done EEEEEK
			if (ver > 2) printf("[BMI]");
			break;
		case 0xD0:
			if(!(p & 0b00000010)) {
				rel(&page);
				per = 3 + page;
			} else pc++;	// must skip offset if not done EEEEEK
			if (ver > 2) printf("[BNE]");
			break;
		case 0x10:
			if(!(p & 0b10000000)) {
				rel(&page);
				per = 3 + page;
			} else pc++;	// must skip offset if not done EEEEEK
			if (ver > 2) printf("[BPL]");
			break;
		case 0x80:			// CMOS only
			rel(&page);
			per = 3 + page;
			if (ver > 2) printf("[BRA]");
			break;
/* *** BRK: force break *** */
		case 0x00:
			pc++;
			if (ver > 1) printf("[BRK]");
			if (safe)	run = 0;
			else {
				p |= 0b00010000;		// set B, just in case
				intack();
				p &= 0b11101111;		// clear B, just in case
				pc = peek(0xFFFE) | peek(0xFFFF)<<8;	// IRQ/BRK vector
				if (ver > 1) printf("\b PC=>%04X]", pc);
			}
			break;
/* *** Bxx: Branch on flag condition *** */
		case 0x50:
			if(!(p & 0b01000000)) {
				rel(&page);
				per = 3 + page;
			} else pc++;	// must skip offset if not done EEEEEK
			if (ver > 2) printf("[BVC]");
			break;
		case 0x70:
			if(p & 0b01000000) {
				rel(&page);
				per = 3 + page;
			} else pc++;	// must skip offset if not done EEEEEK
			if (ver > 2) printf("[BVS]");
			break;
/* *** CLx: Clear flags *** */
		case 0x18:
			p &= 0b11111110;
			if (ver > 3) printf("[CLC]");
			break;
		case 0xD8:
			p &= 0b11110111;
			dec = 0;
			if (ver > 3) printf("[CLD]");
			break;
		case 0x58:
			p &= 0b11111011;
			if (ver > 3) printf("[CLI]");
			break;
		case 0xB8:
			p &= 0b10111111;
			if (ver > 3) printf("[CLV]");
			break;
/* *** CMP: Compare Memory And Accumulator *** */
		case 0xC9:
			cmp(a, peek(pc++));
			if (ver > 3) printf("[CMP#]");
			break;
		case 0xCD:
			cmp(a, peek(am_a()));
			if (ver > 3) printf("[CMPa]");
			per = 4;
			break;
		case 0xC5:
			cmp(a, peek(peek(pc++)));
			if (ver > 3) printf("[CMPz]");
			per = 3;
			break;
		case 0xC1:
			cmp(a, peek(am_ix()));
			if (ver > 3) printf("[CMP(x)]");
			per = 6;
			break;
		case 0xD1:
			cmp(a, peek(am_iy(&page)));
			if (ver > 3) printf("[CMP(y)]");
			per = 5 + page;
			break;
		case 0xD5:
			cmp(a, peek(am_zx()));
			if (ver > 3) printf("[CMPzx]");
			per = 4;
			break;
		case 0xDD:
			cmp(a, peek(am_ax(&page)));
			if (ver > 3) printf("[CMPx]");
			per = 4 + page;
			break;
		case 0xD9:
			cmp(a, peek(am_ay(&page)));
			if (ver > 3) printf("[CMPy]");
			per = 4 + page;
			break;
		case 0xD2:			// CMOS only
			cmp(a, peek(am_iz()));
			if (ver > 3) printf("[CMP(z)]");
			per = 5;
			break;
/* *** CPX: Compare Memory And Index X *** */
		case 0xE0:
			cmp(x, peek(pc++));
			if (ver > 3) printf("[CPX#]");
			break;
		case 0xEC:
			cmp(x, peek(am_a()));
			if (ver > 3) printf("[CPXa]");
			per = 4;
			break;
		case 0xE4:
			cmp(x, peek(peek(pc++)));
			if (ver > 3) printf("[CPXz]");
			per = 3;
			break;
/* *** CPY: Compare Memory And Index Y *** */
		case 0xC0:
			cmp(y, peek(pc++));
			if (ver > 3) printf("[CPY#]");
			break;
		case 0xCC:
			cmp(y, peek(am_a()));
			if (ver > 3) printf("[CPYa]");
			per = 4;
			break;
		case 0xC4:
			cmp(y, peek(peek(pc++)));
			if (ver > 3) printf("[CPYz]");
			per = 3;
			break;
/* *** DEC: Decrement Memory (or Accumulator) by One *** */
		case 0xCE:
			adr = am_a();	// EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEK
			temp = peek(adr);
			temp--;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[DECa]");
			per = 6;
			break;
		case 0xC6:
			temp = peek(peek(pc));
			temp--;
			poke(peek(pc++), temp);
			bits_nz(temp);
			if (ver > 3) printf("[DECz]");
			per = 5;
			break;
		case 0xD6:
			adr = am_zx();	// EEEEEEEEEEK
			temp = peek(adr);
			temp--;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[DECzx]");
			per = 6;
			break;
		case 0xDE:
			adr = am_ax(&page);	// EEEEEEEEK
			temp = peek(adr);
			temp--;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[DECx]");
			per = 7;		// 6+page for WDC?
			break;
		case 0x3A:			// CMOS only (OK)
			a--;
			bits_nz(a);
			if (ver > 3) printf("[DEC]");
			break;
/* *** DEX: Decrement Index X by One *** */
		case 0xCA:
			x--;
			bits_nz(x);
			if (ver > 3) printf("[DEX]");
			break;
/* *** DEY: Decrement Index Y by One *** */
		case 0x88:
			y--;
			bits_nz(y);
			if (ver > 3) printf("[DEY]");
			break;
/* *** EOR: "Exclusive Or" Memory with Accumulator *** */
		case 0x49:
			a ^= peek(pc++);
			bits_nz(a);
			if (ver > 3) printf("[EOR#]");
			break;
		case 0x4D:
			a ^= peek(am_a());
			bits_nz(a);
			if (ver > 3) printf("[EORa]");
			per = 4;
			break;
		case 0x45:
			a ^= peek(peek(pc++));
			bits_nz(a);
			if (ver > 3) printf("[EORz]");
			per = 3;
			break;
		case 0x41:
			a ^= peek(am_ix());
			bits_nz(a);
			if (ver > 3) printf("[EOR(x)]");
			per = 6;
			break;
		case 0x51:
			a ^= peek(am_iy(&page));
			bits_nz(a);
			if (ver > 3) printf("[EOR(y)]");
			per = 5 + page;
			break;
		case 0x55:
			a ^= peek(am_zx());
			bits_nz(a);
			if (ver > 3) printf("[EORzx]");
			per = 4;
			break;
		case 0x5D:
			a ^= peek(am_ax(&page));
			bits_nz(a);
			if (ver > 3) printf("[EORx]");
			per = 4 + page;
			break;
		case 0x59:
			a ^= peek(am_ay(&page));
			bits_nz(a);
			if (ver > 3) printf("[EORy]");
			per = 4 + page;
			break;
		case 0x52:			// CMOS only
			a ^= peek(am_iz());
			bits_nz(a);
			if (ver > 3) printf("[EOR(z)]");
			per = 5;
			break;
/* *** INC: Increment Memory (or Accumulator) by One *** */
		case 0xEE:
			adr = am_a();	// EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEK
			temp = peek(adr);
			temp++;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[INCa]");
			per = 6;
			break;
		case 0xE6:
			temp = peek(peek(pc));
			temp++;
			poke(peek(pc++), temp);
			bits_nz(temp);
			if (ver > 3) printf("[INCz]");
			per = 5;
			break;
		case 0xF6:
			adr = am_zx();	// EEEEEEEEEEK
			temp = peek(adr);
			temp++;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[INCzx]");
			per = 6;
			break;
		case 0xFE:
			adr = am_ax(&page);	// EEEEEEEEEEK
			temp = peek(adr);
			temp++;
			poke(adr, temp);
			bits_nz(temp);
			if (ver > 3) printf("[INCx]");
			per = 7;		// 6+page for WDC?
			break;
		case 0x1A:			// CMOS only
			a++;
			bits_nz(a);
			if (ver > 3) printf("[INC]");
			break;
/* *** INX: Increment Index X by One *** */
		case 0xE8:
			x++;
			bits_nz(x);
			if (ver > 3) printf("[INX]");
			break;
/* *** INY: Increment Index Y by One *** */
		case 0xC8:
			y++;
			bits_nz(y);
			if (ver > 3) printf("[INY]");
			break;
/* *** JMP: Jump to New Location *** */
		case 0x4C:
			pc = am_a();
			if (ver > 2)	printf("[JMP]");
			per = 3;
			break;
		case 0x6C:
			pc = am_ai();
			if (ver > 2)	printf("[JMP()]");
			per = 6;		// 5 for NMOS!
			break;
		case 0x7C:			// CMOS only
			pc = am_aix();
			if (ver > 2)	printf("[JMP(x)]");
			per = 6;
			break;
/* *** JSR: Jump to New Location Saving Return Address *** */
		case 0x20:
			push((pc+1)>>8);		// stack one byte before return address, right at MSB
			push((pc+1)&255);
			pc = am_a();			// get operand
			if (ver > 2)	printf("[JSR]");
			per = 6;
			break;
/* *** LDA: Load Accumulator with Memory *** */
		case 0xA9:
			a = peek(pc++);
			bits_nz(a);
			if (ver > 3) printf("[LDA#]");
			break;
		case 0xAD:
			a = peek(am_a());
			bits_nz(a);
			if (ver > 3) printf("[LDAa]");
			per = 4;
			break;
		case 0xA5:
			a = peek(peek(pc++));
			bits_nz(a);
			if (ver > 3) printf("[LDAz]");
			per = 3;
			break;
		case 0xA1:
			a = peek(am_ix());
			bits_nz(a);
			if (ver > 3) printf("[LDA(x)]");
			per = 6;
			break;
		case 0xB1:
			a = peek(am_iy(&page));
			bits_nz(a);
			if (ver > 3) printf("[LDA(y)]");
			per = 5 + page;
			break;
		case 0xB5:
			a = peek(am_zx());
			bits_nz(a);
			if (ver > 3) printf("[LDAzx]");
			per = 4;
			break;
		case 0xBD:
			a = peek(am_ax(&page));
			bits_nz(a);
			if (ver > 3) printf("[LDAx]");
			per = 4 + page;
			break;
		case 0xB9:
			a = peek(am_ay(&page));
			bits_nz(a);
			if (ver > 3) printf("[LDAy]");
			per = 4 + page;
			break;
		case 0xB2:			// CMOS only
			a = peek(am_iz());
			bits_nz(a);
			if (ver > 3) printf("[LDA(z)]");
			per = 5;
			break;
/* *** LDX: Load Index X with Memory *** */
		case 0xA2:
			x = peek(pc++);
			bits_nz(x);
			if (ver > 3) printf("[LDX#]");
			break;
		case 0xAE:
			x = peek(am_a());
			bits_nz(x);
			if (ver > 3) printf("[LDXa]");
			per = 4;
			break;
		case 0xA6:
			x = peek(peek(pc++));
			bits_nz(x);
			if (ver > 3) printf("[LDXz]");
			per = 3;
			break;
		case 0xB6:
			x = peek(am_zy());
			bits_nz(x);
			if (ver > 3) printf("[LDXzy]");
			per = 4;
			break;
		case 0xBE:
			x = peek(am_ay(&page));
			bits_nz(x);
			if (ver > 3) printf("[LDXy]");
			per = 4 + page;
			break;
/* *** LDY: Load Index Y with Memory *** */
		case 0xA0:
			y = peek(pc++);
			bits_nz(y);
			if (ver > 3) printf("[LDY#]");
			break;
		case 0xAC:
			y = peek(am_a());
			bits_nz(y);
			if (ver > 3) printf("[LDYa]");
			per = 4;
			break;
		case 0xA4:
			y = peek(peek(pc++));
			bits_nz(y);
			if (ver > 3) printf("[LDYz]");
			per = 3;
			break;
		case 0xB4:
			y = peek(am_zx());
			bits_nz(y);
			if (ver > 3) printf("[LDYzx]");
			per = 4;
			break;
		case 0xBC:
			y = peek(am_ax(&page));
			bits_nz(y);
			if (ver > 3) printf("[LDYx]");
			per = 4 + page;
			break;
/* *** LSR: Shift One Bit Right (Memory or Accumulator) *** */
		case 0x4E:
			adr=am_a();
			temp = peek(adr);
			lsr(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[LSRa]");
			per = 6;
			break;
		case 0x46:
			temp = peek(peek(pc));
			lsr(&temp);
			poke(peek(pc++), temp);
			if (ver > 3) printf("[LSRz]");
			per = 5;
			break;
		case 0x4A:
			lsr(&a);
			if (ver > 3) printf("[LSR]");
			break;
		case 0x56:
			adr = am_zx();
			temp = peek(adr);
			lsr(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[LSRzx]");
			per = 6;
			break;
		case 0x5E:
			adr = am_ax(&page);
			temp = peek(adr);
			lsr(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[LSRx]");
			per = 6 + page;	// 7 for NMOS
			break;
/* *** NOP: No Operation *** */
		case 0xEA:
			if (ver > 3) printf("[NOP]");
			break;
/* *** ORA: "Or" Memory with Accumulator *** */
		case 0x09:
			a |= peek(pc++);
			bits_nz(a);
			if (ver > 3) printf("[ORA#]");
			break;
		case 0x0D:
			a |= peek(am_a());
			bits_nz(a);
			if (ver > 3) printf("[ORAa]");
			per = 4;
			break;
		case 0x05:
			a |= peek(peek(pc++));
			bits_nz(a);
			if (ver > 3) printf("[ORAz]");
			per = 3;
			break;
		case 0x01:
			a |= peek(am_ix());
			bits_nz(a);
			if (ver > 3) printf("[ORA(x)]");
			per = 6;
			break;
		case 0x11:
			a |= peek(am_iy(&page));
			bits_nz(a);
			if (ver > 3) printf("[ORA(y)]");
			per = 5 + page;
			break;
		case 0x15:
			a |= peek(am_zx());
			bits_nz(a);
			if (ver > 3) printf("[ORAzx]");
			per = 4;
			break;
		case 0x1D:
			a |= peek(am_ax(&page));
			bits_nz(a);
			if (ver > 3) printf("[ORAx]");
			per = 4 + page;
			break;
		case 0x19:
			a |= peek(am_ay(&page));
			bits_nz(a);
			if (ver > 3) printf("[ORAy]");
			per = 4 + page;
			break;
		case 0x12:			// CMOS only
			a |= peek(am_iz());
			bits_nz(a);
			if (ver > 3) printf("[ORA(z)]");
			per = 5;
			break;
/* *** PHA: Push Accumulator on Stack *** */
		case 0x48:
			push(a);
			if (ver > 3) printf("[PHA]");
			per = 3;
			break;
/* *** PHP: Push Processor Status on Stack *** */
		case 0x08:
			push(p);
			if (ver > 3) printf("[PHP]");
			per = 3;
			break;
/* *** PHX: Push Index X on Stack *** */
		case 0xDA:			// CMOS only
			push(x);
			if (ver > 3) printf("[PHX]");
			per = 3;
			break;
/* *** PHY: Push Index Y on Stack *** */
		case 0x5A:			// CMOS only
			push(y);
			if (ver > 3) printf("[PHY]");
			per = 3;
			break;
/* *** PLA: Pull Accumulator from Stack *** */
		case 0x68:
			a = pop();
			if (ver > 3) printf("[PLA]");
			bits_nz(a);
			per = 4;
			break;
/* *** PLP: Pull Processor Status from Stack *** */
		case 0x28:
			p = pop();
			if (p & 0b00001000)	dec = 1;	// check for decimal flag
			else				dec = 0;
			if (ver > 3) printf("[PLP]");
			per = 4;
			break;
/* *** PLX: Pull Index X from Stack *** */
		case 0xFA:			// CMOS only
			x = pop();
			if (ver > 3) printf("[PLX]");
			per = 4;
			break;
/* *** PLX: Pull Index X from Stack *** */
		case 0x7A:			// CMOS only
			y = pop();
			if (ver > 3) printf("[PLY]");
			per = 4;
			break;
/* *** ROL: Rotate One Bit Left (Memory or Accumulator) *** */
		case 0x2E:
			adr = am_a();
			temp = peek(adr);
			rol(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ROLa]");
			per = 6;
			break;
		case 0x26:
			temp = peek(peek(pc));
			rol(&temp);
			poke(peek(pc++), temp);
			if (ver > 3) printf("[ROLz]");
			per = 5;
			break;
		case 0x36:
			adr = am_zx();
			temp = peek(adr);
			rol(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ROLzx]");
			per = 6;
			break;
		case 0x3E:
			adr = am_ax(&page);
			temp = peek(adr);
			rol(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[ROLx]");
			per = 6 + page;	// 7 for NMOS
			break;
		case 0x2A:
			rol(&a);
			if (ver > 3) printf("[ROL]");
			break;
/* *** ROR: Rotate One Bit Right (Memory or Accumulator) *** */
		case 0x6E:
			adr = am_a();
			temp = peek(adr);
			ror(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[RORa]");
			per = 6;
			break;
		case 0x66:
			temp = peek(peek(pc));
			ror(&temp);
			poke(peek(pc++), temp);
			if (ver > 3) printf("[RORz]");
			per = 5;
			break;
		case 0x6A:
			ror(&a);
			if (ver > 3) printf("[ROR]");
			break;
		case 0x76:
			adr = am_zx();
			temp = peek(adr);
			ror(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[RORzx]");
			per = 6;
			break;
		case 0x7E:
			adr = am_ax(&page);
			temp = peek(adr);
			ror(&temp);
			poke(adr, temp);
			if (ver > 3) printf("[RORx]");
			per = 6 + page;	// 7 for NMOS
			break;
/* *** RTI: Return from Interrupt *** */
		case 0x40:
			p = pop();					// retrieve status
			p |= 0b00010000;			// forget possible B flag
			pc = pop();					// extract LSB...
			pc |= (pop() << 8);			// ...and MSB, address is correct
			if (ver > 2)	printf("[RTI]");
			per = 6;
			break;
/* *** RTS: Return from Subroutine *** */
		case 0x60:
			pc = pop();					// extract LSB...
			pc |= (pop() << 8);			// ...and MSB, but is one byte off
			pc++;						// return instruction address
			if (ver > 2)	printf("[RTS]");
			per = 6;
			break;
/* *** SBC: Subtract Memory from Accumulator with Borrow *** */
		case 0xE9:
			sbc(peek(pc++));
			if (ver > 3) printf("[SBC#]");
			per += dec;
			break;
		case 0xED:
			sbc(peek(am_a()));
			if (ver > 3) printf("[SBCa]");
			per = 4 + dec;
			break;
		case 0xE5:
			sbc(peek(peek(pc++)));
			if (ver > 3) printf("[SBCz]");
			per = 3 + dec;
			break;
		case 0xE1:
			sbc(peek(am_ix()));
			if (ver > 3) printf("[SBC(x)]");
			per = 6 + dec;
			break;
		case 0xF1:
			sbc(peek(am_iy(&page)));
			if (ver > 3) printf("[SBC(y)]");
			per = 5 + dec + page;
			break;
		case 0xF5:
			sbc(peek(am_zx()));
			if (ver > 3) printf("[SBCzx]");
			per = 4 + dec;
			break;
		case 0xFD:
			sbc(peek(am_ax(&page)));
			if (ver > 3) printf("[SBCx]");
			per = 4 + dec + page;
			break;
		case 0xF9:
			sbc(peek(am_ay(&page)));
			if (ver > 3) printf("[SBCy]");
			per = 4 + dec + page;
			break;
		case 0xF2:			// CMOS only
			sbc(peek(am_iz()));
			if (ver > 3) printf("[SBC(z)]");
			per = 5 + dec;
			break;
// *** SEx: Set Flags *** */
		case 0x38:
			p |= 0b00000001;
			if (ver > 3) printf("[SEC]");
			break;
		case 0xF8:
			p |= 0b00001000;
			dec = 1;
			if (ver > 3) printf("[SED]");
			break;
		case 0x78:
			p |= 0b00000100;
			if (ver > 3) printf("[SEI]");
			break;
/* *** STA: Store Accumulator in Memory *** */
		case 0x8D:
			poke(am_a(), a);
			if (ver > 3) printf("[STAa]");
			per = 4;
			break;
		case 0x85:
			poke(peek(pc++), a);
			if (ver > 3) printf("[STAz]");
			per = 3;
			break;
		case 0x81:
			poke(am_ix(), a);
			if (ver > 3) printf("[STA(x)]");
			per = 6;
			break;
		case 0x91:
			poke(am_iy(&page), a);
			if (ver > 3) printf("[STA(y)]");
			per = 6;		// ...and not 5, as expected
			break;
		case 0x95:
			poke(am_zx(), a);
			if (ver > 3) printf("[STAzx]");
			per = 4;
			break;
		case 0x9D:
			poke(am_ax(&page), a);
			if (ver > 3) printf("[STAx]");
			per = 5;		// ...and not 4, as expected
			break;
		case 0x99:
			poke(am_ay(&page), a);
			if (ver > 3) printf("[STAy]");
			per = 5;		// ...and not 4, as expected
			break;
		case 0x92:			// CMOS only
			poke(am_iz(), a);
			if (ver > 3) printf("[STA(z)]");
			per = 5;
			break;
/* *** STX: Store Index X in Memory *** */
		case 0x8E:
			poke(am_a(), x);
			if (ver > 3) printf("[STXa]");
			per = 4;
			break;
		case 0x86:
			poke(peek(pc++), x);
			if (ver > 3) printf("[STXz]");
			per = 3;
			break;
		case 0x96:
			poke(am_zy(), x);
			if (ver > 3) printf("[STXzy]");
			per = 4;
			break;
/* *** STY: Store Index Y in Memory *** */
		case 0x8C:
			poke(am_a(), y);
			if (ver > 3) printf("[STYa]");
			per = 4;
			break;
		case 0x84:
			poke(peek(pc++), y);
			if (ver > 3) printf("[STYz]");
			per = 3;
			break;
		case 0x94:
			poke(am_zx(), y);
			if (ver > 3) printf("[STYzx]");
			per = 4;
			break;
// *** STZ: Store Zero in Memory, CMOS only ***
		case 0x9C:
			poke(am_a(), 0);
			if (ver > 3) printf("[STZa]");
			per = 4;
			break;
		case 0x64:
			poke(peek(pc++), 0);
			if (ver > 3) printf("[STZz]");
			per = 3;
			break;
		case 0x74:
			poke(am_zx(), 0);
			if (ver > 3) printf("[STZzx]");
			per = 4;
			break;
		case 0x9E:
			poke(am_ax(&page), 0);
			if (ver > 3) printf("[STZx]");
			per = 5;		// ...and not 4, as expected
			break;
/* *** TAX: Transfer Accumulator to Index X *** */
		case 0xAA:
			x = a;
			bits_nz(x);
			if (ver > 3) printf("[TAX]");
			break;
/* *** TAY: Transfer Accumulator to Index Y *** */
		case 0xA8:
			y = a;
			bits_nz(y);
			if (ver > 3) printf("[TAY]");
			break;
/* *** TRB: Test and Reset Bits, CMOS only *** */
		case 0x1C:
			adr = am_a();
			temp = peek(adr);
			if (temp & a)		p &= 0b11111101;	// set Z accordingly
			else 				p |= 0b00000010;
			poke(adr, temp & ~a);
			if (ver > 3) printf("[TRBa]");
			per = 6;
			break;
		case 0x14:
			adr = peek(pc++);
			temp = peek(adr);
			if (temp & a)		p &= 0b11111101;	// set Z accordingly
			else 				p |= 0b00000010;
			poke(adr, temp & ~a);
			if (ver > 3) printf("[TRBz]");
			per = 5;
			break;
/* *** TSB: Test and Set Bits, CMOS only *** */
		case 0x0C:
			adr = am_a();
			temp = peek(adr);
			if (temp & a)		p &= 0b11111101;	// set Z accordingly
			else 				p |= 0b00000010;
			poke(adr, temp | a);
			if (ver > 3) printf("[TSBa]");
			per = 6;
			break;
		case 0x04:
			adr = peek(pc++);
			temp = peek(adr);
			if (temp & a)		p &= 0b11111101;	// set Z accordingly
			else 				p |= 0b00000010;
			poke(adr, temp | a);
			if (ver > 3) printf("[TSBz]");
			per = 5;
			break;
/* *** TSX: Transfer Stack Pointer to Index X *** */
		case 0xBA:
			x = s;
			bits_nz(x);
			if (ver > 3) printf("[TSX]");
			break;
/* *** TXA: Transfer Index X to Accumulator *** */
		case 0x8A:
			a = x;
			bits_nz(a);
			if (ver > 3) printf("[TXA]");
			break;
/* *** TXS: Transfer Index X to Stack Pointer *** */
		case 0x9A:
			s = x;
			bits_nz(s);
			if (ver > 3) printf("[TXS]");
			break;
/* *** TYA: Transfer Index Y to Accumulator *** */
		case 0x98:
			a = y;
			bits_nz(a);
			if (ver > 3) printf("[TYA]");
			break;
/* *** Display Status (WAI on WDC) *** */
		case 0xCB:
			if (ver)	printf(" Status @ $%x04:", pc-1);	// must allow warnings to display status request
			stat();
			break;
/* *** Graceful Halt (STP on WDC) *** */
		case 0xDB:
			printf(" ...HALT!");
			run = per = 0;
			break;
/* *** remaining opcodes (illegal on NMOS) executed as pseudoNOPs, according to 65C02 byte and cycle usage *** */
		case 0x03:
		case 0x13:
		case 0x23:
		case 0x33:
		case 0x43:
		case 0x53:
		case 0x63:
		case 0x73:
		case 0x83:
		case 0x93:
		case 0xA3:
		case 0xB3:
		case 0xC3:
		case 0xD3:
		case 0xE3:
		case 0xF3:
		case 0x0B:
		case 0x1B:
		case 0x2B:
		case 0x3B:
		case 0x4B:
		case 0x5B:
		case 0x6B:
		case 0x7B:
		case 0x8B:
		case 0x9B:
		case 0xAB:
		case 0xBB:
		case 0xEB:
		case 0xFB:	// minus WDC opcodes, used for emulator control
		case 0x07:
		case 0x17:
		case 0x27:
		case 0x37:
		case 0x47:
		case 0x57:
		case 0x67:
		case 0x77:
		case 0x87:
		case 0x97:
		case 0xA7:
		case 0xB7:
		case 0xC7:
		case 0xD7:
		case 0xE7:
		case 0xF7:	// Rockwell RMB/SMB opcodes
		case 0x0F:
		case 0x1F:
		case 0x2F:
		case 0x3F:
		case 0x4F:
		case 0x5F:
		case 0x6F:
		case 0x7F:
		case 0x8F:
		case 0x9F:
		case 0xAF:
		case 0xBF:
		case 0xCF:
		case 0xDF:
		case 0xEF:
		case 0xFF:	// Rockwell BBR/BBS opcodes
			per = 1;		// ultra-fast 1 byte NOPs!
			if (ver)	printf("[NOP!]");
			if (safe)	illegal(1, opcode);
			break;
		case 0x02:
		case 0x22:
		case 0x42:
		case 0x62:
		case 0x82:
		case 0xC2:
		case 0xE2:
			pc++;			// 2-byte, 2-cycle NOPs
			if (ver)	printf("[NOP#]");
			if (safe)	illegal(2, opcode);
			break;
		case 0x44:
			pc++;
			per++;			// only case of 2-byte, 3-cycle NOP
			if (ver)	printf("[NOPz]");
			if (safe)	illegal(2, opcode);
			break;
		case 0x54:
		case 0xD4:
		case 0xF4:
			pc++;
			per = 4;		// only cases of 2-byte, 4-cycle NOP
			if (ver)	printf("[NOPzx]");
			if (safe)	illegal(2, opcode);
			break;
		case 0xDC:
		case 0xFC:
			pc += 2;
			per = 4;		// only cases of 3-byte, 4-cycle NOP
			if (ver)	printf("[NOPa]");
			if (safe)	illegal(3, opcode);
			break;
		case 0x5C:
			pc += 2;
			per = 8;		// extremely slow 8-cycle NOP
			if (ver)	printf("[NOP?]");
			if (safe)	illegal(3, opcode);
			break;			// not needed as it's the last one, but just in case
	}

	return per;
}

/* *** *** *** halt CPU on illegal opcodes *** *** *** */
void illegal(byte s, byte op) {
	printf("\n*** ($%04X) Illegal opcode $%02X ***\n", pc-s, op);
	run = 0;
}

/* *** *** VDU SECTION *** *** */

/* Initialize vdu display window */
int init_vdu() {
	//Initialize SDL
	if( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_JOYSTICK ) < 0 )
	{
		printf("SDL could not be initialized! SDL Error: %s\n", SDL_GetError());
		return -1;
	}

	//Set texture filtering to linear
	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");

	//Check for joysticks
	for(int i=0; i<2 && i<SDL_NumJoysticks(); i++)
	{
		//Load joystick
		sdl_gamepads[i] = SDL_JoystickOpen(i);
		if(sdl_gamepads[i] == NULL)
		{
		 printf("Unable to open game controller #%d! SDL Error: %s\n", i, SDL_GetError());
		 return -2;
		}
	}

	// Get display mode
	if (SDL_GetDesktopDisplayMode(0, &sdl_display_mode) != 0) {
		printf("SDL_GetDesktopDisplayMode faile! SDL Error: %s\n", SDL_GetError());
		return -3;
	}

	pixel_size=4;
	hpixel_size=2;
	VDU_SCREEN_WIDTH=128*pixel_size;
	VDU_SCREEN_HEIGHT=VDU_SCREEN_WIDTH;

	//Create window
	sdl_window = SDL_CreateWindow("Durango", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, VDU_SCREEN_WIDTH, VDU_SCREEN_HEIGHT, SDL_WINDOW_OPENGL);
	if( sdl_window == NULL )
	{
		printf("Window could not be created! SDL Error: %s\n", SDL_GetError());
		return -4;
	}

	//Create renderer for window
	sdl_renderer = SDL_CreateRenderer( sdl_window, -1, SDL_RENDERER_ACCELERATED );
	if(sdl_renderer == NULL)
	{
		printf("Renderer could not be created! SDL Error: %s\n", SDL_GetError());
		return -5;
	}

    //Clear screen
    SDL_SetRenderDrawColor(sdl_renderer, 0x00, 0x00, 0x00, 0xFF);
    SDL_RenderClear(sdl_renderer);
    SDL_RenderPresent(sdl_renderer);
    
    return 0;
}

/* Close vdu display window */
void close_vdu() {
	//Destroy renderer
	if(sdl_renderer!=NULL)
	{
		SDL_DestroyRenderer(sdl_renderer);
		sdl_renderer=NULL;
	}

	if(sdl_window != NULL)
	{
		// Destroy window
		SDL_DestroyWindow(sdl_window);
		sdl_window=NULL;
	}

	// Close gamepads
	for(int i=0; i<2 && i<SDL_NumJoysticks(); i++)
	{
		SDL_JoystickClose(sdl_gamepads[i]);
		sdl_gamepads[i]=NULL;
	}

	// Close SDL
	SDL_Quit();
}

/* Set current color in SDL from palette */
void vdu_set_color_pixel(byte c) {
	// Color components
	byte red=0, green=0, blue=0;

	// Process invert flag
	if(mem[0xdf80] & 0x40) {
		c ^= 0x0F;		// just invert the index
	}

	// Durango palette
	switch(c) {
		case 0x00: red = 0x00; green = 0x00; blue = 0x00; break; // 0
		case 0x01: red = 0x00; green = 0xaa; blue = 0x00; break; // 1
		case 0x02: red = 0xff; green = 0x00; blue = 0x00; break; // 2
		case 0x03: red = 0xff; green = 0xaa; blue = 0x00; break; // 3
		case 0x04: red = 0x00; green = 0x55; blue = 0x00; break; // 4
		case 0x05: red = 0x00; green = 0xff; blue = 0x00; break; // 5
		case 0x06: red = 0xff; green = 0x55; blue = 0x00; break; // 6
		case 0x07: red = 0xff; green = 0xff; blue = 0x00; break; // 7
		case 0x08: red = 0x00; green = 0x00; blue = 0xff; break; // 8
		case 0x09: red = 0x00; green = 0xaa; blue = 0xff; break; // 9
		case 0x0a: red = 0xff; green = 0x00; blue = 0xff; break; // 10
		case 0x0b: red = 0xff; green = 0xaa; blue = 0xff; break; // 11
		case 0x0c: red = 0x00; green = 0x55; blue = 0xff; break; // 12
		case 0x0d: red = 0x00; green = 0xff; blue = 0xff; break; // 13
		case 0x0e: red = 0xff; green = 0x55; blue = 0xff; break; // 14
		case 0x0f: red = 0xff; green = 0xff; blue = 0xff; break; // 15
	}

	// Process RGB flag
	if(!(mem[0xdf80] & 0x08)) {
		red   = ((c&1)?0x88:0) | ((c&2)?0x44:0) | ((c&4)?0x22:0) | ((c&8)?0x11:0);
		green = red;
		blue  = green;	// that, or a switch like above for some sort of gamma correction, note bits are in reverse order!
	}

	SDL_SetRenderDrawColor(sdl_renderer, red, green, blue, 0xff);
}

/* Set current color in SDL HiRes mode */
void vdu_set_hires_pixel(byte color_index) {
	byte color = color_index ? 0xFF : 0x00;

	// Process invert flag
	if(mem[0xdf80] & 0x40) {
		color = ~color;
	}

	SDL_SetRenderDrawColor(sdl_renderer, color, color, color, 0xff);
}

/* Draw color pixel in supplied address */
void vdu_draw_color_pixel(word addr) {
	SDL_Rect fill_rect;
	// Calculate screen address
	word screen_address = (mem[0xdf80] & 0x30) << 9;

	// Calculate screen y coord
	int y = floor((addr - screen_address) >> 6);
	// Calculate screen x coord
	int x = ((addr - screen_address) << 1) & 127;

	// Draw Left Pixel
	vdu_set_color_pixel((mem[addr] & 0xf0) >> 4);
	fill_rect.x = x << 2;				// * pixel_size;
	fill_rect.y = y << 2;				// * pixel_size;
	fill_rect.w = pixel_size;
	fill_rect.h = pixel_size;
	SDL_RenderFillRect(sdl_renderer, &fill_rect);
	// Draw Right Pixel
	vdu_set_color_pixel(mem[addr] & 0x0f);
	fill_rect.x += pixel_size;
	SDL_RenderFillRect(sdl_renderer, &fill_rect);
}

void vdu_draw_hires_pixel(word addr) {
	SDL_Rect fill_rect;
	int i;
	// Calculate screen address
	word screen_address = (mem[0xdf80] & 0x30) << 9;
	// Calculate screen y coord
	int y = floor((addr - screen_address) >> 5);
	// Calculate screen x coord
	int x = ((addr - screen_address) << 3) & 255;
	byte b = mem[addr];

	fill_rect.x = x << 1;				// * hpixel_size;
	fill_rect.y = y << 1;				// * hpixel_size;
	fill_rect.w = hpixel_size;
	fill_rect.h = hpixel_size;
	for(i=0; i<8; i++) {
		vdu_set_hires_pixel(b & 0x80);		// set function doesn't tell any non-zero value
		b <<= 1;
		fill_rect.x += hpixel_size;
		SDL_RenderFillRect(sdl_renderer, &fill_rect);
	}
}

/* Render Durango screen. */
void vdu_draw_full() {
	word i;
	byte hires_flag = mem[0xdf80] & 0x80;
	word screen_address = (mem[0xdf80] & 0x30) << 9;
	word screen_address_end = screen_address + 0x2000;

	//Clear screen
    SDL_SetRenderDrawColor(sdl_renderer, 0x00, 0x00, 0x00, 0xFF);
    SDL_RenderClear(sdl_renderer);

	// Color
	if(!hires_flag) {
		for(i=screen_address; i<screen_address_end; i++) {
			vdu_draw_color_pixel(i);
		}
	}
	// HiRes
	else {
		for(i=screen_address; i<screen_address_end; i++) {
			vdu_draw_hires_pixel(i);
		}
	}

	//Update screen
	SDL_RenderPresent(sdl_renderer);
}

/* Process keyboard / mouse events */
void process_keyboard(SDL_Event *e) {
	int asc;
	/*
	 * Type:
	 * SDL_KEYDOWN
	 * SDL_KEYUP
	 * SDL_JOYAXISMOTION
	 * SDL_JOYBUTTONDOWN
	 * SDL_JOYBUTTONUP
	 * SDL_MOUSEMOTION
	 * SDL_MOUSEBUTTONDOWN
	 * SDL_MOUSEBUTTONUP
	 * SDL_MOUSEWHEEL
	 * 
	 * Code:
	 * https://wiki.libsdl.org/SDL_Keycode
	 * 
	 * Modifiers:
	 * KMOD_NONE -> no modifier is applicable
	 * KMOD_LSHIFT -> the left Shift key is down
	 * KMOD_RSHIFT -> the right Shift key is down
	 * KMOD_LCTRL -> the left Ctrl (Control) key is down
	 * KMOD_RCTRL -> the right Ctrl (Control) key is down
	 * KMOD_LALT -> the left Alt key is down
	 * KMOD_RALT -> the right Alt key is down
	 * KMOD_CTRL -> any control key is down
	 * KMOD_SHIFT-> any shift key is down
	 * KMOD_ALT -> any alt key is down
	 * KMOD_CAPS -> caps key is down
	 */
	if(e->type == SDL_KEYDOWN) {
		printf("key: %c (%d)\n", e->key.keysym.sym, e->key.keysym.sym);
		
		if(SDL_GetModState() & KMOD_LSHIFT) {
			printf("Left shift key is pressed\n");
		}
		if(SDL_GetModState() & KMOD_RSHIFT) {
			printf("Right shift key is pressed\n");
		}
		if(SDL_GetModState() & KMOD_LCTRL) {
			printf("Left ctrl key is pressed\n");
		}
		if(SDL_GetModState() & KMOD_RCTRL) {
			printf("Right ctrl key is pressed\n");
		}
		if(SDL_GetModState() & KMOD_LALT) {
			printf("Left alt key is pressed\n");
		}
		if(SDL_GetModState() & KMOD_RALT) {
			printf("Right alt key is pressed\n");
		}
		if (SDL_GetModState() & KMOD_CTRL)
		{
//			printf("Control key state is pressed\n");
		}
		if (SDL_GetModState() & KMOD_SHIFT)
		{
//			printf("KMOD_SHIFT is pressed\n");
		}

		if (SDL_GetModState() & KMOD_CAPS)
		{
			printf("KMOD_CAPS is pressed\n");
		}
		asc = e->key.keysym.sym;
		if (asc<256)	mem[0xDF9A] = asc;		// will temporarily store ASCII at 0xDF9A, as per PASK standard :-)
	}
	// detect key release for PASK compatibility
	else if(e->type == SDL_KEYUP) {
		mem[0xDF9A] = 0;
	}
}

/* Process GUI events in VDU window */
void vdu_read_keyboard() {
	//Event handler
    SDL_Event e;
	//Handle events on queue
	while( SDL_PollEvent( &e ) != 0 )
	{
		// Vdu window is closed
		if(e.type == SDL_QUIT)
		{
			run = 0;
		}
		// Press F1 = STOP
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F1) {
			run = 0;
		}
		// Press F2 = NMI
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F2) {
			nmi_flag = 1;
		}
		// Press F3 = IRQ?
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F3) {
			irq_flag = 1;
		}
		// Press F4 = RESET
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F4) {
			reset();
		}
		// Press F5 = STATUS
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F5) {
			stat_flag = 1;
		}
		// Press F6 = DUMP memory to file
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F6) {
			full_dump();
		}
		// Press F7
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F7) {
		}
		// Press F8
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F8) {
		}
		// Press F9
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F9) {
		}
		// Press F10
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F10) {
		}
		// Press F11
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F11) {
		}
		// Press F12
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym==SDLK_F12) {
			run = 0;
		}
		// Event forwarded to Durango
		else {
			process_keyboard(&e);
		}
	}
}
