; minimOS generic Kernel API
; v0.5.1rc3, must match kernel.s
; (c) 2012-2017 Carlos J. Santisteban
; last modified 20170512-0915

; no way for standalone assembly...

; ***************************************
; *** dummy function, non implemented ***
; ***************************************

unimplemented:			; placeholder here, not currently used
	_ERR(UNAVAIL)		; go away!


; ********************************
; *** COUT, output a character ***
; ********************************
;		INPUT
; Y		= dev
; io_c	= char
;		OUTPUT
; C = I/O error
;		USES iol_dev, plus whatever the driver takes
; cio_lock is a kernel structure
; LOWRAM version uses da_ptr!!!

cout:
	TYA					; for indexed comparisons (2)
	BNE co_port			; not default (3/2)
		LDA stdout			; new per-process standard device
		BNE co_port			; already a valid device
			LDA default_out		; otherwise get system global (4)
co_port:
	BMI co_phys			; not a logic device (3/2)
		CMP #64				; first file-dev??? ***
			BCC co_win			; below that, should be window manager
; ** optional filesystem access **
#ifdef	FILESYSTEM
		CMP #64+MAX_FILES	; still within file-devs?
			BCS co_log			; that value or over, not a file
; *** manage here output to open file ***
		_ERR(NO_RSRC)		; not yet implemented ***placeholder***
#endif
; ** end of filesystem access **
co_log:
; investigate rest of logical devices
		CMP #DEV_NULL		; lastly, ignore output
			BNE cio_nfound		; final error otherwise
		_EXIT_OK			; "/dev/null" is always OK
co_win:
; *** virtual windows manager TO DO ***
	_ERR(NO_RSRC)		; not yet implemented

co_phys:
; arrived here with dev # in A
; new per-phys-device MUTEX for COUT, no matter if singletask!
	ASL					; convert to index (2+2)
	STA iol_dev			; keep device-index temporarily, worth doing here (3)
	_ENTER_CS			; needed for a MUTEX (5)
co_loop:
		LDX iol_dev			; retrieve index!
		LDA cio_lock, X		; check whether THAT device is in use (4)
			BEQ co_lckd			; resume operation if free (3)
; otherwise yield CPU time and repeat
; faster KERNEL(B_YIELD)
		LDX #MM_YIELD		; internal multitasking index (2)
		JSR yield			; direct to driver skipping the kernel (6)
		_BRA co_loop		; try again! (3)
co_lckd:
	LDA run_pid			; get ours in A, faster!
	STA cio_lock, X		; *reserve this (4)
	_EXIT_CS
; continue with mutually exclusive COUT
	JSR co_call			; direct CALL!!! driver should end in RTS as usual via the new DR_ macros

; *** common I/O calls ***
cio_unlock:
	LDX iol_dev			; **need to clear new lock! (3)
	_STZA cio_lock, X	; ...because I have to clear MUTEX! *new indexed form (4)
	RTS					; exit with whatever error code

cio_nfound:
	_ERR(N_FOUND)		; unknown device

; ****************************
; *** CIN, get a character ***
; ****************************
;		INPUT
; Y = dev
;		OUTPUT
; io_c	= char
; C		= not available
;		USES iol_dev, and whatever the driver takes
; cio_lock & cin_mode are kernel structures

cin:
	TYA					; for indexed comparisons
	BNE ci_port			; specified
		LDA std_in			; new per-process standard device
		BNE ci_port			; already a valid device
			LDA default_in		; otherwise get system global
ci_port:
	BPL ci_nph			; logic device
; new MUTEX for CIN, physical devs only!
	ASL					; convert to proper physdev index (2)
	STA iol_dev			; keep physdev temporarily, worth doing here (3)
; * this has to be done atomic! *
	_ENTER_CS
ci_loop:
	LDX iol_dev			; *restore previous status (3)
	LDA cio_lock, X		; *check whether THAT device in use (4)
	BEQ ci_lckd			; resume operation if free (3)
; otherwise yield CPU time and repeat
; but first check whether it was me (waiting on binary mode)
		LDA run_pid			; who am I?
		CMP cio_lock, X		; *was it me who locked? (4)
			BEQ ci_lckdd		; *if so, resume execution (3)
; if the above, could first check whether the device is in binary mode, otherwise repeat loop!
; continue with regular mutex
; faster KERNEL(B_YIELD)
		LDX #MM_YIELD		; internal multitasking index (2)
		JSR yield			; direct to driver skipping the kernel (6+)
		_BRA ci_loop		; try again! (3)
ci_lckd:
	LDA run_pid			; who is me?
	STA cio_lock, X		; *reserve this (4)
ci_lckdd:
	_EXIT_CS
; * end of atomic operation *
		JSR ci_call			; direct CALL!!!
			BCS cio_unlock		; clear MUTEX and return whatever error!

; ** EVENT management **
; this might be revised, or supressed altogether!
		LDX iol_dev			; **use physdev as index! worth doing here (3)
		LDA io_c			; get received character
		CMP #' '			; printable?
			BCS ci_exitOK		; if so, will not be an event, exit with NO error
; otherwise might be an event ** REVISE
; check for binary mode first
		LDY cin_mode, X		; *get flag, new sysvar 20150617
		BEQ ci_event		; should process possible event
			_STZA cin_mode, X	; *back to normal mode
ci_exitOK:
			CLC					; *otherwise mark no error... (2)
			BCC cio_unlock		; ...clear mutex and exit, no need for BRA (3)
ci_event:
		CMP #16				; is it DLE?
		BNE ci_notdle		; otherwise check next
			STA cin_mode, X		; *set binary mode! puts 16, safer and faster!
			_ERR(EMPTY)			; and supress received character (will stay locked!)
ci_notdle:
		CMP #3				; is it ^C? (TERM)
		BNE ci_noterm		; otherwise check next
			LDA #SIGTERM
			BRA ci_signal		; send signal
ci_noterm:
		CMP #4				; is it ^D? (KILL) somewhat dangerous...
		BNE ci_nokill		; otherwise check next
			LDA #SIGKILL
			BRA ci_signal		; send signal
ci_nokill:
		CMP #26				; is it ^Z? (STOP)
			BNE ci_exitOK		; otherwise there is no more to check
		LDA #SIGSTOP		; last signal to be sent
ci_signal:
		STA b_sig			; set signal as parameter
		LDY run_pid			; faster GET_PID
; faster KERNEL(B_SIGNAL)
		LDX #MM_SIGNAL		; internal multitasking index (2)
		JSR signal			; usual API entry
; continue after having filtered the error
		LDY #EMPTY			; no character was received
		SEC					; eeeeeeeek
		BCS cio_unlock		; release device and exit!

; *** some common I/O calls ***

; *** for 02 systems without indexed CALL ***
co_call:
	_JMPX(drv_opt)		; direct jump to output routine

ci_call:
	_JMPX(drv_ipt)		; direct jump to input routine

; logical devices management, * placeholder *
ci_nph:
	CMP #64				; first file-dev??? ***
		BCC ci_win			; below that, should be window manager
; ** optional filesystem access **
#ifdef	FILESYSTEM
	CMP #64+MAX_FILES	; still within file-devs?
		BCS ci_log			; that or over, not a file
; *** manage here input from open file ***
#endif
; *** virtual window manager TO DO ***
ci_win:
	_ERR(NO_RSRC)		; not yet implemented ***placeholder***
; manage logical devices...
ci_log:
	CMP #DEV_RND		; getting a random number?
		BEQ ci_rnd			; compute it!
	CMP #DEV_NULL		; lastly, ignore input
		BEQ ci_ok			; "/dev/null" is always OK
	JMP cio_nfound		; final error otherwise

ci_rnd:
; *** generate random number (TO DO) ***
	LDY ticks			; simple placeholder
	STA io_c			; eeeeeeeeeeeeeeeeek
ci_ok:
	_EXIT_OK


; ******************************
; *** MALLOC, reserve memory ***
; ******************************
;		INPUT
; ma_rs		= size (0 means reserve as much memory as available)
; ma_align	= page mask (0=page/not aligned, 1=512b, $FF=bank aligned)
;		OUTPUT
; ma_pt	= pointer to reserved block
; ma_rs	= actual size (esp. if ma_rs was 0, but check LSB too)
; C		= not enough memory/corruption detected
;		USES ma_ix.b
; ram_stat & ram_pid (= ram_stat+1) are interleaved in minimOS-16
malloc:
	LDX #0				; reset index
	LDY ma_rs			; check individual bytes, just in case
	BEQ ma_nxpg			; no extra page needed
		INC ma_rs+1			; otherwise increase number of pages
		STX ma_rs			; ...and just in case, clear asked bytes!
ma_nxpg:
	_ENTER_CS			; this is dangerous! enter critical section, new 160119
	LDA ma_rs+1			; get number of asked pages
	BNE ma_scan			; work on specific size
; otherwise check for biggest available block
ma_biggest:
#ifdef	SAFE
			CPX #MAX_LIST		; already past?
				BEQ ma_corrupt		; something was wrong!!!
; *** self-healing feature for full memory assignment! ***
			LDA ram_pos+1, X	; get end position (4)
			SEC
			SBC ram_pos, X		; subtract current for size! (2+4)
				BCC ma_corrupt		; corruption detected!
#endif
			LDY ram_stat, X		; get status of block (4)
;			CPY #FREE_RAM		; not needed if FREE_RAM is zero! (2)
			BNE ma_nxbig		; go for next as this one was not free (3/2)
				JSR ma_alsiz		; **compute size according to alignment mask**
				CMP ma_rs+1			; compare against current maximum (3)
				BCC ma_nxbig		; this was not bigger (3/2)
					STA ma_rs+1			; otherwise keep track of it... (3)
					STX ma_ix			; ...and its index! (3)
ma_nxbig:
			INX					; advance index (2)
			LDY ram_stat, X		; peek next status (4)
			CPY #END_RAM		; check whether at end (2)
			BNE ma_biggest		; or continue (3/2)
; is there at least one available block?
		LDA ma_rs+1			; should not be zero
		BNE ma_fill			; there is at least one block to allocate
			_EXIT_CS			; eeeeeeek! we are going
			_ERR(FULL)			; otherwise no free memory!
; report allocated size
ma_fill:
		LDX ma_ix			; retrieve index
		_BRA ma_falgn		; nothing to scan, only if aligned eeeeeek
ma_scan:
; *** this is the place for the self-healing feature! ***
#ifdef	SAFE
		CPX #MAX_LIST		; already past?
			BEQ ma_corrupt		; something was wrong!!!
; check UNALIGNED size for self-healing feature! worth a routine?
		LDA ram_pos+1, X	; get end position (4)
		SEC
		SBC ram_pos, X		; subtract current for size! (2+4)
		BCS ma_nobad		; no corruption was seen (3/2) **instead of BPL** eeeeeek
ma_corrupt:
			LDX #>user_sram		; otherwise take beginning of user RAM...
			LDY #<user_sram		; LSB misaligned?
			BEQ ma_zlsb			; nothing to align
				INX					; otherwise start at next page
ma_zlsb:
			LDY #LOCK_RAM		; ...that will become locked (new value)
			STX ram_pos			; create values
			STY ram_stat		; **should it clear the PID field too???**
			LDA #SRAM			; physical top of RAM...
			LDY #END_RAM		; ...as non-plus-ultra
			STA ram_pos+1		; create second set of values
			STY ram_stat+1
			_EXIT_CS			; eeeeeeeeeek
			_ERR(CORRUPT)		; report but do not turn system down
ma_nobad:
#endif
		LDY ram_stat, X		; get state of current entry (4)
;		CMP #FREE_RAM		; looking for a free one (2) not needed if free is zero
			BEQ ma_found		; got one (2/3)
		CPY #END_RAM		; got already to the end? (2)
			BEQ ma_nobank		; could not found anything suitable (2/3)
ma_cont:
		INX					; increase index (2)
;		CPX #MAX_LIST		; until the end (2)
		BNE ma_scan			; will not be zero anyway (3)
ma_nobank:
	_EXIT_CS			; non-critical when aborting!
	_ERR(FULL)			; no room for it!
ma_found:
	JSR ma_alsiz		; **compute size according to alignment mask**
	CMP ma_rs+1			; compare (5)
		BCC ma_cont			; smaller, thus continue searching (2/3)
; here we go! first of all check whether aligned or not
ma_falgn:
	PHA					; save current size
	LDA ram_pos, X		; check start address for alignment failure
	BIT ma_align		; any offending bits?
	BEQ ma_aok			; already aligned, nothing needed
		ORA ma_align		; set disturbing bits...
		_INC				; ...and reset them after increasing the rest
		PHA					; need to keep the new aligned pointer!
		JSR ma_adv			; create room for assigned block (BEFORE advancing eeeeeeeek)
		INX					; skip the alignment blank
		PLA					; retrieve aligned address
		STA ram_pos, X		; update pointer on assigned block
ma_aok:
	PLA					; retrieve size
; make room for new entry... if not exactly the same size
	CMP ma_rs+1			; compare this block with requested size eeeeeeeek
	BEQ ma_updt			; was same size, will not generate new entry
; **should I correct stack balance for safe mode?
		JSR ma_adv			; make room otherwisemake room otherwise, and set the following one as free padding
; **should I correct stack balance for safe mode?
; create after the assigned block a FREE entry!
		LDA ram_pos, X		; newly assigned slice will begin there eeeeeeeeeek
		CLC
		ADC ma_rs+1			; add number of assigned pages
		STA ram_pos+1, X	; update value
		LDA #FREE_RAM		; let us mark it as free, PID is irrelevant!
		STA ram_stat+1, X	; next to the assigned one, no STY abs,X!!!
ma_updt:
	_STZA ma_pt			; clear pointer LSB
	LDA ram_pos, X		; get address of block to be assigned
	STA ma_pt+1			; note this is address of PAGE
	LDA #USED_RAM		; now is reserved
	STA ram_stat, X		; update table entry
; ** new 20161106, store PID of caller **
	_PHX				; will need this index
	JSR get_pid			; who asked for this?
	_PLX				; retrieve index
	TYA					; unfortunately no STY abs,X
	STA ram_pid, X		; store PID
; theoretically we are done, end of CS
	_EXIT_CS			; end of critical section, new 160119
	_EXIT_OK			; we're done

; **** routine for aligned-block size computation ****
; returns found size in A, sets C if OK, error otherwise (C clear!)
ma_alsiz:
	LDA ram_pos, X		; get bottom address (4)
	BIT ma_align		; check for set bits from mask (4)
	BEQ ma_fit			; none was set, thus already aligned (3/2)
		ORA ma_align		; set masked bits... (3)
		_INC				; ...and increase address for alignment (2)
ma_fit:
; how could an ORA (str_pt), Y arrive here????
	EOR #$FF			; invert bits as will be subtracted to next entry (2)
	SEC					; needs one more for twos-complement (2)
	ADC ram_pos+1, X	; compute size from top ptr MINUS bottom one (5)
	RTS

; **** routine for making room for an entry ****
ma_adv:
	STX ma_ix			; store current index
ma_2end:
		INX					; previous was free, thus check next
#ifdef	SAFE
		CPX #MAX_LIST-1		; just in case, check offset!!! (needs -1?)
		BCC ma_notend		; could expand
			PLA					; discard return address
			PLA
			JMP ma_nobank		; notice error
ma_notend:
#endif
		LDY ram_stat, X		; check status of block
		CPY #END_RAM		; scan for the end-of-memory marker
		BNE ma_2end			; hope will eventually finish!
ma_room:
		LDA ram_pos, X		; get block address
		STA ram_pos+1, X	; one position forward
		LDA ram_stat, X		; get block status
		STA ram_stat+1, X	; advance it
		LDA ram_pid, X		; same for PID, non-interleaved!
		STA ram_pid+1, X	; advance it
		DEX					; down one entry
		CPX ma_ix			; position of updated entry
		BNE ma_room			; continue until done
; no longer creates at the beginning of the moved block a FREE entry!
	RTS


; ****************************
; *** FREE, release memory *** revamped 20150209
; ****************************
;		INPUT
; ma_pt = addr
;		OUTPUT
; C = no such used block
;
; ram_pos & ram_stat are kernel structures

free:
#ifdef	SAFE
	LDY ma_pt			; LSB currently not implemented
		BNE fr_nos			; could not find
#endif
	LDX #0				; reset index
	LDA ma_pt+1			; get comparison PAGE eeeeeeeeek
	_ENTER_CS			; supposedly dangerous
fr_loop:
		CMP ram_pos, X		; is what we are looking for?
			BEQ fr_found		; go free it!
		INX					; advance index
		LDY ram_stat, X		; anyway check status
		CPY #END_RAM		; no more in list?
		BNE fr_loop			; continue until end
; was not found, thus exit CS and abort
fr_no:
	_EXIT_CS
fr_nos:
	_ERR(N_FOUND)		; no block to be freed!
fr_found:
	LDY ram_stat, X		; only used blocks can be freed!
	CPY #USED_RAM		; was it in use?
		BNE fr_no			; if not, cannot free it!
	LDA #FREE_RAM		; most likely zero, might use STZ instead
	STA ram_stat, X		; this block is now free, but...
; really should join possible adjacent free blocks
	LDY ram_stat+1, X	; check status of following entry
;	CPY #FREE_RAM		; was it free? could be supressed if value is zero
	BNE fr_notafter		; was not free, thus nothing to optimise forward
		_PHX				; keep actual position eeeeeeeek
		JSR fr_join			; integrate following free block
		_PLX				; retrieve position
	BEQ fr_ok			; if the first block, cannot look back eeeeeeeeeek
fr_notafter:
	TXA					; check whether it was the first block
		BEQ fr_ok			; do not even try to look back eeeeeeeeeeek
	DEX					; let us have a look to the previous block
	LDY ram_stat, X		; is this one free?
;	CPY #FREE_RAM		; could be supressed if value is zero
	BNE fr_ok			; nothing to optimise backwards
		JSR fr_join			; otherwise integrate it too

; ** already optimized **
fr_ok:
	_EXIT_CS
	_EXIT_OK

; routine for obliterating the following empty entry
fr_join:
		INX					; go for next entry
		LDA ram_pos+1, X	; get following address
		STA ram_pos, X		; store one entry below
		LDA ram_pid+1, X	; copy PID of following, but keep status for last!
		STA ram_pid, X		; no longer interleaved
		LDA ram_stat+1, X	; check status of following!
		STA ram_stat, X		; store one entry below
		CMP #END_RAM		; end of list?
		BNE fr_join			; repeat until done
	DEX					; return to previous position
	RTS


; **************************************
; *** OPEN_W, get I/O port or window ***
; **************************************
;		INPUT
; w_rect	= size VV.HH
; w_rect+2	= pos VV.HH
; str_pt	= pointer to title string
;		OUTPUT
; Y = dev
; C = not supported/not available

open_w:
	LDA w_rect			; asking for some size?
	ORA w_rect+1
	BEQ ow_no_window	; wouldn't do it
		_ERR(NO_RSRC)
ow_no_window:
	LDY #DEVICE			; constant default device, REVISE
; ***** EXIT_OK on subsequent system calls!!! *****

; ********************************************************
; *** CLOSE_W,  close window *****************************
; *** FREE_W, release window, will be closed by kernel ***
; ********************************************************
;		INPUT
; Y = dev

close_w:				; doesn't do much
free_w:					; doesn't do much, either
	_EXIT_OK


; **************************************
; *** UPTIME, get approximate uptime *** revised 20150208, corrected 20150318
; **************************************
;		OUTPUT
; up_ticks	= ticks, new standard format 20161006
; up_sec	= 32-bit uptime in seconds

uptime:
	LDX #1			; first go for elapsed ticks (2 bytes) (2)
	_ENTER_CS		; don't change while copying
up_loop:
		LDA ticks, X		; get system variable byte (not uptime, corrected 20150125) (4)
		STA up_ticks, X		; and store them in output parameter (3)
		DEX					; go for next (2+3/2)
		BPL up_loop
	LDX #3			; now for the uptime in seconds (now 4 bytes) (2)
up_upt:
		LDA ticks+2, X		; get system variable uptime, new 20150318 (4)
		STA up_sec, X		; and store it in output parameter (3) corrected 150610
		DEX					; go for next (2+3/2)
		BPL up_upt
	_EXIT_CS
	_EXIT_OK


; ***************************************************************
; *** LOAD_LINK, get address once in RAM/ROM (in development) ***
; ***************************************************************
;		INPUT
; str_pt = points to filename path (will be altered!)
;		OUTPUT
; ex_pt		= pointer to executable code
;		USES rh_scan

load_link:
; *** look for that filename in ROM headers ***
; first of all, correct parameter pointer as will be aligned with header!
	LDA str_pt			; get LSB
	SEC
	SBC #8				; subtract name position in header! beware of 816 non-wrapping!
	STA str_pt			; modified value
	BCS ll_reset		; nothing else to do if no borrow
		DEC str_pt+1		; otherwise will point to previous PAGE eeeeeeek
ll_reset:
; get initial address! beacuse of the above, no longer adds filename offset!
	LDA #<ROM_BASE		; begin of ROM contents LSB, most likely zero
	STA	rh_scan			; set local pointer
	LDA #>ROM_BASE		; same for MSB
	STA rh_scan+1		; internal pointer set
ll_geth:
; ** check whether we are on a valid header!!! **
		_LDAY(rh_scan)		; first of all should be a NUL
			BNE ll_nfound		; link was lost, no more to scan
		LDY #7				; after type and size, a CR is expected
		LDA (rh_scan), Y	; get eigth byte in header!
		CMP #CR				; was it a CR?
			BNE ll_nfound		; if not, go away
; look for the name
		INY					; reset scanning index (now at name position, was @7)
ll_nloop:
			LDA (rh_scan), Y	; get character in found name
			CMP (str_pt), Y		; compare with what we are looking for
				BNE ll_nthis		; difference found
			ORA (str_pt), Y		; otherwise check whether at EOL
				BEQ ll_found		; all were zero, both ended names are the same!
			INY					; otherwise continue search
			BNE ll_nloop		; will not do forever, no need for BRA
ll_nthis:
; not this one, correct local pointer for the next header
		LDY #253			; relative offset to number of pages
		LDA (rh_scan), Y	; get it now
		TAX					; save for a while
		DEY					; relative offset to FILE SIZE eeeeek
		LDA (rh_scan), Y	; check whether crosses boundary
		BEQ ll_bound		; if it does not, do not advance page
			INX					; otherwise goes into next page
ll_bound:
		TXA					; retrieve number of pages to skip...
		SEC					; ...plus header itself! eeeeeeek
		ADC rh_scan+1		; add to previous value
		STA rh_scan+1		; update pointer
		BCC ll_geth			; inspect new header (if no overflow! 16-bit addressing)
ll_nfound:
	_ERR(N_FOUND)		; all was scanned and the query was not found
ll_found:
; this was the original load_link code prior to 20161202, will be executed after the header was found!
	LDY #1			; offset for filetype
	LDA (rh_scan), Y	; check filetype
	CMP #'m'		; must be minimOS app!
		BNE ll_wrap		; error otherwise
	INY				; next byte is CPU type
	LDA (rh_scan), Y	; get it
	LDX fw_cpu		; *** UGLY HACK, this is a FIRMWARE variable ***
	CPX #'R'		; is it a Rockwell/WDC CPU?
		BEQ ll_rock		; from R down is OK
	CPX #'B'		; generic 65C02?
		BEQ ll_cmos		; from B down is OK
	CPX #'V'		; 65816 is supported but no better than a generic 65C02
		BEQ ll_cmos
	CPX #'N'		; old NMOS?
		BEQ ll_nmos			; only NMOS code will do
		_PANIC("{CPU?}")	; *** should NEVER arrive here, unless firmware variables are corrupt! ***
ll_rock:
	CMP #'R'		; code has Rockwell extensions?
		BEQ ll_valid
ll_cmos:
	CMP #'B'		; generic 65C02 code?
		BEQ ll_valid
ll_nmos:
	CMP #'N'		; every supported CPU can run NMOS code
		BNE ll_wrap		; otherwise is code for another architecture!
; present CPU is able to execute supplied code
ll_valid:
;	STA cpu_ll		; store just to tell it is XIP!
;	LDA rh_scan		; get pointer LSB, most likely zero
	LDY rh_scan+1	; and MSB
	INY				; start from next page
	_STZA ex_pt		; *** assume all headers are page-aligned ***
	STY ex_pt+1		; save rest of execution pointer
	_EXIT_OK
ll_wrap:
	_ERR(INVALID)	; something was wrong


; *** SU_POKE, write to protected addresses ***
; WILL be deprecated, not sure if of any use in other architectures
; Y <- value, zpar <- addr
; destroys A (and maybe Y on NMOS)

su_poke:
	TYA				; transfer value
	_STAY(zpar)		; store value, macro for NMOS
	_EXIT_OK

; *** SU_PEEK, read from protected addresses ***
; WILL be deprecated, not sure if of any use in other architectures
; Y -> value, zpar <- addr
; destroys A

su_peek:
	_LDAY(zpar)		; store value, macro for NMOS
	TAY				; transfer value
	_EXIT_OK


; *********************************
; *** STRING, prints a C-string ***
; *********************************
;		INPUT
; Y			= dev
; str_pt	= pointer to string (might be altered!) 24-bit mandatory
;		OUTPUT
; C = device error
;		USES iol_dev and whatever the driver takes
;
; cio_lock is a kernel structure

string:
; ** actual code from COUT here, might save space using a common routine, but adds a bit of overhead
#ifdef	MULTITASK
	STY iol_dev			; **keep device temporarily, worth doing here (3)
	_ENTER_CS			; needed for a MUTEX (5)
str_wait:
	LDA cio_lock, Y		; *check whether THAT device in use (4)
	BEQ str_lckd		; resume operation if free (3)
; otherwise yield CPU time and repeat
		JSR yield			; give way... scheduler would switch on interrupts as needed *** direct internal API call!
		LDY iol_dev			; restore previous status, *new style (3)
		_BRA str_wait		; try again! (3)
str_lckd:
	JSR get_pid			; **standard internal call, 816 prefers indexed JSR
	TYA					; **current PID in A (2)
	LDY iol_dev			; **restore device number (3)
	STA cio_lock, Y		; *reserve this (4)
	_EXIT_CS			; proceed normally (4)
#endif
; continue with mutually exclusive COUT
	TYA				; for indexed comparisons (2)
	BNE str_port	; not default (3/2)
		LDA stdout		; new per-process standard device
		BNE str_port	; already a valid device
			LDA default_out	; otherwise get system global (4)
str_port:
	BMI str_phys	; not a logic device (3/2)
		CMP #64			; first file-dev??? ***
			BCC str_win		; below that, should be window manager
; ** optional filesystem access **
#ifdef	FILESYSTEM
		CMP #64+MAX_FILES	; still within file-devs?
			BCS str_log		; that value or over, not a file
; *** manage here output to open file ***
		_ERR(NO_RSRC)	; not yet implemented ***placeholder***
#endif
; ** end of filesystem access **
str_log:
; investigate rest of logical devices
		CMP #DEV_NULL	; lastly, ignore output
			BNE str_nfound	; final error otherwise
str_exit:
#ifdef	MULTITASK
		LDX iol_dev			; retrieve driver index
		_STZA cio_lock, X	; clear mutex
#endif
		_EXIT_OK		; "/dev/null" is always OK
str_win:
; *** virtual windows manager TO DO ***
	LDY #NO_RSRC		; not yet implemented
	SEC					; eeek
	_BRA str_abort		; notify error code AND unlock device!
str_nfound:
	LDY #N_FOUND		; unknown device
	SEC					; eeeek
	_BRA str_abort		; notify error code AND unlock device!
str_phys:
; ** new direct indexing, revamped 20160407 **
	ASL					; convert to index (2+2)
	STA iol_dev			; store for indexed call! (3)
	LDY #0				; eeeeeeeek! (2)
; ** the actual printing loop **
str_loop:
		_PHY				; save just in case COUT destroys it (3)
		LDA (str_pt), Y		; get character from string, new approach (5)
		BNE str_cont		; not terminated! (3/2)
			PLA					; otherwise discard saved Y (4)
			_EXIT_OK			; and go away!
str_cont:
		STA io_c			; store output character for COUT (3)
		JSR str_call		; indirect subroutine call (6...)
			BCS str_err			; error from driver, but keeping Y eeeeeek^2
		_PLY				; restore index (4)
		INY					; eeeeeeeeeeeek (2)
		BNE str_loop		; still within same page
	INC str_pt+1		; otherwise increase, parameter has changed! will it have to restore parameter?
	_BRA str_loop		; continue, will check for termination later (3)
str_call:
	LDX iol_dev			; get driver pointer position (3)
	_JMPX(drv_opt)		; go at stored pointer (...6)
str_err:
	PLA					; discard saved Y while keeping error code
str_abort:
#ifdef	MULTITASK
	LDX iol_dev			; retrieve driver index
	_STZA cio_lock, X	; clear mutex
#endif
	RTS					; return whatever error code

; ******************************
; *** READLN, buffered input *** new 20161223
; ******************************
; Y <- dev, str_pt <- *buffer (24-bit mandatory), ln_siz <- max offset
; uses rl_dev, rl_cur

readLN:
	STY rl_dev			; preset device ID!
	_STZY rl_cur		; reset variable
rl_l:
		JSR yield			; always useful!
		LDY rl_dev			; use device
		JSR cin				; get one character
		BCC rl_rcv			; got something
			CPY #EMPTY			; otherwise is just waiting?
		BEQ rl_l			; continue then
			LDA #0
			_STAX(str_pt)		; if any other error, terminate string
			RTS					; and return whatever error
rl_rcv:
		LDA io_c			; get received
		LDY rl_cur			; retrieve index
		CMP #CR				; hit CR?
			BEQ rl_cr			; all done then
		CMP #BS				; is it backspace?
		BNE rl_nbs			; delete then
			TYA					; check index
				BEQ rl_l			; ignore if already zero
			DEC rl_cur			; otherwise reduce index
			_BRA rl_echo		; and resume operation
rl_nbs:
		CPY ln_siz			; overflow? EEEEEEEEEEK
			BCS rl_l			; ignore if so
		STA (str_pt), Y		; store into buffer
		INC	rl_cur			; update index
rl_echo:
		LDY rl_dev			; retrieve device
		JSR cout			; echo received character
		_BRA rl_l			; and continue
rl_cr:
	LDA #CR				; newline
	LDY rl_dev			; retrieve device
	JSR cout			; print newline (ignoring errors)
	LDY rl_cur			; retrieve cursor!!!!!
	LDA #0				; no STZ indirect indexed
	STA (str_pt), Y		; terminate string
	_EXIT_OK			; and all done!


; *** SU_SEI, disable interrupts *** revised 20150209
; C -> not authorized (?)
; probably not needed on 65xx, _CS macros are much more interesting anyway
su_sei:
	SEI				; disable interrupts
	_EXIT_OK		; no error so far


; *** SU_CLI, enable interrupts *** revised 20150209
; probably not needed on 65xx, _CS macros are much more interesting anyway

su_cli:				; not needed for 65xx, even with protection hardware
	CLI				; enable interrupts
	_EXIT_OK		; no error


; *** SET_FG, enable/disable frequency generator (Phi2/n) on VIA *** revised 20150208...
; ** should use some firmware interface, just in case it doesn't affect jiffy-IRQ! **
; should also be Phi2-rate independent... input as Hz, or 100uS steps?
; zpar.W <- dividing factor (times two?), C -> busy
; destroys A, X...

; *******TO BE REVISED*********
set_fg:
	LDA zpar
	ORA zpar+1
		BEQ fg_dis		; if zero, disable output
	LDA VIA+ACR		; get current configuration
		BMI fg_busy	; already in use
	LDX VIA+T1LL	; get older T1 latch values
	STX old_t1		; save them
	LDX VIA+T1LH
	STX old_t1+1
; *** TO_DO - should compare old and new values in order to adjust quantum size accordingly ***
	LDX zpar			; get new division factor
	STX VIA+T1LL	; store it
	LDX zpar+1
	STX VIA+T1LH
	STX VIA+T1CH	; get it running!
	ORA #$C0		; enable free-run PB7 output
	STA VIA+ACR		; update config
fg_none:
	_EXIT_OK		; finish anyway
fg_dis:
	LDA VIA+ACR		; get current configuration
		BPL fg_none	; it wasn't playing!
	AND #$7F		; disable PB7 only
	STA VIA+ACR		; update config
	LDA old_t1		; older T1L_L
	STA VIA+T1LL	; restore old value
	LDA old_t1+1
	STA VIA+T1LH	; it's supposed to be running already
; *** TO_DO - restore standard quantum ***
		_BRA fg_none
fg_busy:
	_ERR(BUSY)		; couldn't set


; *** GO_SHELL, launch default shell *** new 20150604
; no interface needed
go_shell:
	JMP shell		; simply... *** SHOULD initialise SP and other things anyway ***


; *** SHUTDOWN, proper shutdown, with or without poweroff ***
; Y <- subfunction code new ABI 20150603, 20160408
; C -> couldn't poweroff or reboot (?)

shutdown:
	CPY #PW_CLEAN		; from scheduler only!
		BEQ sd_2nd			; continue with second stage
	CPY #PW_STAT		; is it going to suspend?
		BEQ sd_stat			; don't shutdown system then!
	STY sd_flag			; store mode for later, first must do proper system shutdown
; ask all braids to terminate
	LDY #0				; PID=0 means ALL braids
	LDA #SIGTERM		; will be asked to terminate
	STA b_sig			; store signal type
	JSR signal			; ask braids to terminate
	CLI					; make sure all will keep running!
	_EXIT_OK

; firmware interface
sd_off:
	LDY #PW_OFF			; poweroff
sd_fw:
	_ADMIN(POWEROFF)	; except for suspend, shouldn't return...
	RTS					; just in case was not implemented!
sd_stat:
	LDY #PW_STAT		; suspend
	BNE sd_fw			; no need for BRA
sd_cold:
	LDY #PW_COLD		; cold boot
	BNE sd_fw			; will reboot, shared code, no need for BRA
sd_warm:
	SEI					; maybe a better place to do it
	CLD
	JMP warm			; firmware no longer should take pointer, generic kernel knows anyway

; the scheduler will wait for NO braids active
; now let's disable all drivers
sd_2nd:
	LDA sd_flag		; check what was pending
	BNE sd_shut		; something to do
		_PANIC("{sched}")	; otherwise an error!
sd_shut:
	SEI				; disable interrupts
#ifdef	SAFE
	_STZA dpoll_mx	; disable interrupt queues, just in case
	_STZA dreq_mx
	_STZA dsec_mx
#endif
; call each driver's shutdown routine *** new system 20151015
	LDX #0			; reset index
; first get the pointer to each driver table
sd_loop:
; get address index
		LDA drivers_ad, X	; get address from original list
		STA da_ptr			; store temporarily eeeeeek
		LDA drivers_ad+1, X	; same for MSB
			BEQ sd_done			; no more drivers to shutdown!
		STA da_ptr+1
; check here whether the driver was successfully installed, get ID as index for drv_opt/ipt
		LDY #D_ID			; point to ID of driver
		LDA (da_ptr), Y		; get ID
		ASL					; convert to index
			BCC sd_next			; invalid device ID!
		TAY					; use as index
		LDA drv_opt, Y		; check LSB****revise
		EOR drv_ipt, Y		; only the same if not installed...
		BNE sd_msb			; but check MSB too!
			INY					; point to MSB
			LDA drv_opt, Y		; check MSB
			EOR drv_ipt, Y		; only the same if not installed!
			BEQ sd_next			; nothing to shutoff
sd_msb:
		LDY #D_BYE			; shutdown LSB offset eeeeeeek
		_PHX				; save index for later
		JSR dr_call			; call routine from generic code!!!
		_PLX				; retrieve index
sd_next:
		INX					; advance to next entry (2+2)
		INX
		BNE sd_loop			; repeat
; system cleanly shut, time to let the firmware turn-off or reboot
sd_done:
	LDX sd_flag			; retrieve mode as index!
	_JMPX(sd_tab)		; do as appropriate

sd_tab:					; check order in abi.h!
	.word	sd_stat		; suspend
	.word	sd_warm		; warm boot direct by kernel
	.word	sd_cold		; cold boot via firmware
	.word	sd_off		; shutdown system


; *********************************
; *** B_FORK, get available PID *** properly interfaced 20150417
; *********************************
; Y -> PID

b_fork:
; ** might be replaced with LDY pid on optimized builds **
	LDX #MM_FORK	; subfunction code
	_BRA sig_call	; go for the driver


; *****************************************
; *** B_EXEC, launch new loaded process *** properly interfaced 20150417 with changed API!
; *****************************************
; API still subject to change... (default I/O, rendez-vous mode TBD)
; Y <- PID, ex_pt <- addr, def_io <- std_in & stdout
; *** should need some flag to indicate XIP or not! stack frame is different

b_exec:
; ** might be repaced with driver code on optimized builds **
	LDX #MM_EXEC	; subfunction code
	_BRA sig_call	; go for the driver


; **************************************************
; *** B_SIGNAL, send UNIX-like signal to a braid ***
; **************************************************
; b_sig <- signal to be sent , Y <- addressed braid

signal:
	LDX #MM_SIGNAL	; subfunction code
	_BRA sig_call	; go for the driver


; ************************************************
; *** B_STATUS, get execution flags of a braid ***
; ************************************************
; Y <- addressed braid
; Y -> flags, TBD
; do not know of possible errors, maybe just a bad PID

status:
	LDX #MM_STATUS	; subfunction code
	_BRA sig_call	; go for the driver


; **************************************
; *** GET_PID, get current braid PID ***
; **************************************
; Y -> PID, TBD
; *****think about making this the direct call as is the fastest one!

get_pid:
	LDX #MM_PID		; subfunction code
; * unified calling procedure, get subfunction code in X * new faster interface 20161102
sig_call:			; NEW unified calling procedure
	JMP (drv_opt)	; just enter into preinstalled driver, will exit with appropriate error code!


; **************************************************************
; *** SET_HNDL, set SIGTERM handler, default is like SIGKILL ***
; **************************************************************
; Y <- PID, ex_pt <- SIGTERM handler routine (ending in RTI!!!)
; bad PID is probably the only feasible error

set_handler:
	LDX #MM_HANDL	; subfunction code
	_BRA sig_call	; go for the driver


; *********************************************
; *** B_YIELD, Yield CPU time to next braid ***
; *********************************************
; supposedly no interface needed, I do not think I need to tell if ignored

yield:
	LDX #MM_YIELD	; subfunction code
	_BRA sig_call	; go for the driver


; ***************************************************************
; *** TS_INFO, get taskswitching info for multitasking driver *** new API 20161019
; ***************************************************************
; Y -> number of bytes, ex_pt -> pointer to the proposed stack frame
ts_info:
#ifdef	MULTITASK
	LDX #<tsi_str			; pointer to proposed stack frame
	LDA #>tsi_str			; including MSB
	STX ex_pt				; store LSB
	STA ex_pt+1				; and MSB
	LDY #tsi_end-tsi_str	; number of bytes
	_EXIT_OK
#else
	_ERR(UNAVAIL)			; non-supporting kernel!
#endif

tsi_str:
; pre-created reversed stack frame for firing tasks up, regardless of multitasking driver implementation
	.word	isr_sched_ret-1	; corrected reentry address **standard label** REVISE REVISE************++
	.byt	0				; stored X value, best if multitasking driver is the first one
	.byt	0, 0, 0			; irrelevant Y, X, A values
tsi_end:
; end of stack frame for easier size computation

; *********************************************************
; *** RELEASE, release ALL memory for a PID, new 20161115
; Y <- PID

release:
	TYA					; as no CPY abs,X
	LDX #0				; reset index
rls_loop:
		LDY ram_stat, X		; will check stat of this block
		CPY #USED_RAM
			BNE rls_oth			; it is not in use
		CMP ram_pid, X		; check whether mine!
		BNE rls_oth			; it is not mine
			PHA					; otherwise save status
			_PHX
			LDY ram_pos, X		; get pointer to targeted block
			LDA ram_pos+1, X	; MSB too
			STY ma_pt			; will be used by FREE
			STA ma_pt+1
			JSR free			; release it!
			_PLX				; retrieve status
			PLA
			BCC rls_next		; keep index IF current entry was deleted!
rls_oth:
		INX					; advance to next block
rls_next:
		LDY ram_stat, X		; look status only
		CPY #END_RAM		; are we done?
		BNE rls_loop		; continue if not yet
	_EXIT_OK			; no errors...

; *******************************
; *** end of kernel functions ***
; *******************************

; **************************************************
; *** jump table, if not in separate 'jump' file ***
; **************************************************
#ifndef		DOWNLOAD
k_vec:
	.word	cout		; output a character
	.word	cin			; get a character
	.word	malloc		; reserve memory
	.word	free		; release memory
	.word	open_w		; get I/O port or window
	.word	close_w		; close window
	.word	free_w		; will be closed by kernel
	.word	uptime		; approximate uptime in ticks (new)
	.word	b_fork		; get available PID
	.word	b_exec		; launch new process
	.word	load_link	; get addr. once in RAM/ROM
	.word	su_poke		; write protected addresses
	.word	su_peek		; read protected addresses
	.word	string		; prints a C-string
	.word	readLN		; buffered input, INSERTED 20161223
	.word	su_sei		; disable interrupts, aka dis_int
	.word	su_cli		; enable interrupts (not needed for 65xx) aka en_int
	.word	set_fg		; enable frequency generator (VIA T1@PB7)
	.word	go_shell	; launch default shell, INSERTED 20150604
	.word	shutdown	; proper shutdown procedure, new 20150409, renumbered 20150604
	.word	signal		; send UNIX-like signal to a braid, new 20150415, renumbered 20150604
	.word	get_pid		; get PID of current braid, new 20150415, renumbered 20150604
	.word	set_handler	; set SIGTERM handler, new 20150417, renumbered 20150604
	.word	yield		; give away CPU time for I/O-bound process, new 20150415, renumbered 20150604
	.word	ts_info		; get taskswitching info, new 20150507-08, renumbered 20150604
	.word	release		; release ALL memory for a PID, new 20161115
#endif
