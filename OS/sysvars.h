; minimOS 0.5.1a8 System Variables
; (c) 2012-2017 Carlos J. Santisteban
; last modified 20170207-0952

.bss

; **** I/O management ****
; ** pointer tables for drivers, new order suggested for alternative version **
#ifndef	LOWRAM
drv_opt		.dsb	256			; full page of output driver pointers, new direct scheme 160406
drv_ipt		.dsb	256			; full page of input driver pointers, new direct scheme 160406
#else
drv_num		.byt	0			; number of installed drivers
drivers_id	.dsb	MAX_DRIVERS	; space for reasonable number of drivers
#endif

; ** I/O flags and locks **
#ifdef	MULTITASK
cin_mode	.dsb	256			; CIN binary mode flag for event management, new 20150618, per-driver 161124
cio_lock	.dsb	256			; PID-reserved MUTEX for CIN & COUT, new 20161121 per-driver 161124 *** might integrate with above as PID is irrelevant as long as it is locked?
#else
cin_mode	.byt	0			; flag always needed, singletask will not use locks!
#endif

; **** interrupt queues ****
dpoll_mx	.byt	0			; bytes used for drivers with polling routines, might make things faster
drv_poll	.dsb	MAX_QUEUE	; space for periodic routines
dreq_mx		.byt	0			; bytes used for drivers with async routines
drv_async	.dsb	MAX_QUEUE	; space for async routines
dsec_mx		.byt	0			; bytes used for drivers with 1-sec routines
drv_sec		.dsb	MAX_QUEUE	; space for 1-sec routines

; **** integrated SIGTERM handler(s), no longer on driver memory! ****
; assume MAX_BRAIDS defined as 1 on non multitasking systems!
mm_term		.dsb	2*MAX_BRAIDS	; unified space 20160406
#ifdef	C816
mm_stbnk	.dsb	MAX_BRAIDS		; bank addresses 20161024 eeeeeeeeeek
#endif

; **** new memory management table 150209, revamped 161106 ****
#ifndef		LOWRAM
#ifdef		C816
ram_pos		.dsb	MAX_LIST*2	; location of blocks, new var 20161103
ram_stat	.dsb	MAX_LIST*2	; status of each block, interleaved with PID for 65816!
ram_pid		= ram_stat + 1		; interleaved array!
#else
ram_pos		.dsb	MAX_LIST	; location of blocks, new var 20161103
ram_stat	.dsb	MAX_LIST	; status of each block, non interleaved
ram_pid		.dsb	MAX_LIST	; non-interleaved PID array
#endif
#endif

; *************************************************
; ** these are the older variables, up to 150126 **
; *************************************************
irq_freq	.word	200	; IRQs per second (originally set from options.h)
ticks		.dsb	6	; second fraction in jiffy IRQs, then approximate uptime in seconds (2+4 bytes) new format 161006
default_in	.byt	0	; GLOBAL default devices
default_out	.byt	0
old_t1		.word	0	; keep old T1 latch value for FG, revised 150208 *** might be revised or moved to firmware vars!
sd_flag		.byt	0	; *** default task upon no remaining braids! 160408 ***

; ** driver-specific system variables come after this one, in main source **
