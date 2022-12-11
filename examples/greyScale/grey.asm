;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _make_gradient
	.globl _clearGreyScaleBuffer
	.globl ______copied_to_position
	.globl __________SET_INTERUPTS
	.globl _grey_interupt
	.globl _wait
	.globl _setCpuSpeed
	.globl _getCpuSpeed
	.globl _hexdump
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _hexTab
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../../lib/textio.c:5: void setPenRow(char row) __naked{
;	---------------------------------
; Function setPenRow
; ---------------------------------
_setPenRow::
;../../lib/textio.c:17: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:18: }
;../../lib/textio.c:19: void setPenCol(char col) __naked{
;	---------------------------------
; Function setPenCol
; ---------------------------------
_setPenCol::
;../../lib/textio.c:31: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:32: }
;../../lib/textio.c:33: void resetPen() __naked{
;	---------------------------------
; Function resetPen
; ---------------------------------
_resetPen::
;../../lib/textio.c:40: __endasm;
	xor	a, a
	ld	(#0x86D7), a
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:41: }
;../../lib/textio.c:43: void fputs(char* loc) __naked {
;	---------------------------------
; Function fputs
; ---------------------------------
_fputs::
;../../lib/textio.c:60: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc ; ret value
	push	hl
	 the_char_loop_i_need_more_good_names_for_labels:
	ld	a, (bc)
	or	a, a
	ret	z
	rst	40 
	.dw 0x455E
	inc	bc
	jr	the_char_loop_i_need_more_good_names_for_labels
;../../lib/textio.c:61: }
;../../lib/textio.c:63: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:64: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:73: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:74: }
	pop	ix
	ret
;../../lib/textio.c:75: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:85: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:86: }
;../../lib/textio.c:87: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:99: __endasm;
	pop	hl ; Get input
	pop	bc
	push	bc
	push	hl
	ld	a, c
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	ret
;../../lib/textio.c:100: }
;../../lib/textio.c:136: void hexdump(char v)__naked{
;	---------------------------------
; Function hexdump
; ---------------------------------
_hexdump::
;../../lib/textio.c:172: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl
	push	ix
	ld	a, c
	ld	hl, #_hexTab
	and	a, #0xF0
	SRL	a
	SRL	a
	SRL	a
	SRL	a
	ld	e, a
	ld	d, #0
	add	hl, de
	ld	a, (hl)
	rst	40 
	.dw 0x455E
	ld	a, c
	ld	hl, #_hexTab
	and	a, #0x0F
	ld	e, a
	ld	d, #0
	add	hl, de
	ld	a, (hl)
	rst	40 
	.dw 0x455E
	pop	ix
	ret
;../../lib/textio.c:173: }
;../../lib/misc.c:8: char getCpuSpeed() __naked{
;	---------------------------------
; Function getCpuSpeed
; ---------------------------------
_getCpuSpeed::
;../../lib/misc.c:13: __endasm;
	in	a, (0x20)
	ld	l, a
	ret
;../../lib/misc.c:14: }
;../../lib/misc.c:15: void setCpuSpeed(char speed){
;	---------------------------------
; Function setCpuSpeed
; ---------------------------------
_setCpuSpeed::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:19: __endasm;
	ld	a, 4 (ix)
	out	(0x20), a
;../../lib/misc.c:20: }
	pop	ix
	ret
_hexTab:
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
;../../lib/misc.c:36: void wait(unsigned char x){ // Wait for amount of time (1/8th of sec)
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:53: __endasm;
	ld	a,#0x47 ;8 hz
	out	(#0x30),a
	ld	a,#0x00 ; no loop, no interrupt
	out	(#0x31),a
	ld	a,4(ix) ;16 ticks / 8 hz equals 2 seconds
	out	(#0x32),a
	    wait:
	in	a,(4)
	bit	5,a ;bit 5 tells if timer 1
	jr	z,wait ;is done
	xor	a
	out	(#0x30),a ;Turn off the timer.
	out	(#0x31),a
;../../lib/misc.c:54: }
	pop	ix
	ret
;../../lib/greyscale.c:95: void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
;	---------------------------------
; Function grey_interupt
; ---------------------------------
_grey_interupt::
;../../lib/greyscale.c:97: scanKeys();
	rst	40 
	.dw 0x4015 
;../../lib/greyscale.c:211: __endasm;
	in	a, (4)
	bit	3, a
	jp	nz, NO_EXIT
	im	1
	ret
	  NO_EXIT:
	in	a, (4)
	bit	6, a
	ret	z
	ld	a, #0x40
	out	(0x33), a ;10922 Hz
	ld	a, #2
	out	(0x34), a
	ld	a, (0x85BE)
	out	(0x35), a
	ld	a, (0x8447)
	ld	b, a
	ld	a, ((0x85BE +1))
	cp	b
	jp	z, AFTER_CONTRAST
	ld	(0x8447), a
	cp	#0x25
	ret	nc
	add	a, #0xD8
	out	(0x10), a
	  AFTER_CONTRAST:
	ld	b, #0
	ld	a, ((((0x85BE +1)+1)+1))
	rra
	ld	a, (((0x85BE +1)+1))
	rla
	ld	c, a
	ld	(((0x85BE +1)+1)), a
	ld	a, b
	rla
	ld	((((0x85BE +1)+1)+1)), a
	and	a, c
	bit	0, a
	ret	nz
	ld	hl, # 0x9872
	bit	0, c
	jr	z, LIGHT_GREY
	ld	hl, # 0x9340
	  LIGHT_GREY:
	ld	c,#0x10
	ld	a, ((((((0x85BE +1)+1)+1)+1)+1))
	ld	e, a
	  WAIT_LOOP_FOR_Y_INC_MODE:
	.db	0xED, 0x70
	jp	m, WAIT_LOOP_FOR_Y_INC_MODE
	CALL	0x000B
	LD	A, #0x07 ; set y inc mode
	OUT	(0x10), A
	ld	a, (((((0x85BE +1)+1)+1)+1))
	  rows:
	.db	0xED, 0x70
	jp	m, rows
	out	(0x10), a
	ld	d, a
	CALL	0x000B
	LD	A, (((((((0x85BE +1)+1)+1)+1)+1)+1)) ; reset col
	OUT	(0x10), A
	ld	a, ((((((((0x85BE +1)+1)+1)+1)+1)+1)+1))
	ld	b, a
	      row:
	ld	a, (hl)
	inc	hl
	       row_waiting:
	.db	0xED, 0x70
	jp	m, row_waiting
	out	(0x11), a
	djnz	row
	ld	a, d
	inc	a
	cp	e
	jp	nz, rows
	ret
;../../lib/greyscale.c:212: }
;../../lib/interupts.c:41: void _________SET_INTERUPTS(){
;	---------------------------------
; Function _________SET_INTERUPTS
; ---------------------------------
__________SET_INTERUPTS::
;../../lib/interupts.c:83: __endasm;
;	disable interrupts and set interrupt mode 2
	di
	im	2
;	save whichever page we are on so that we know where to go
	in	a,(6)
	ld	(0x8584),a
;	set the 0x917F byte of the jumptable to $80
	ld	a,#0x80
	ld	i,a
;	now we copy our interrupt loader to ram, we only have to do this once
	ld	hl,#LoadInterrupt
	ld	de, #0x8E2C
	ld	bc,#EndLoadInterupt-LoadInterrupt
	ldir
;	create the vector table (do this every time before you enable interrupts, be sure to disable interrupts before archiving / unarchiving stuff)
	ld	hl, #0x8000
	ld	de, #0x8001
	ld	(hl), #0x85
	ld	bc,#256
	ldir
;	setting up the jump handler at $8585
	ld	hl,#0x8585
	ld	(hl),#0xc3 ; this is the jp instruction
	ld	de,#0x8E2C ; where it jumps to
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	time to enable interrupts
	ei
;../../lib/interupts.c:84: }
	ret
;../../lib/interupts.c:86: void _____copied_to_position()__naked{
;	---------------------------------
; Function _____copied_to_position
; ---------------------------------
______copied_to_position::
;../../lib/interupts.c:104: __endasm;
	  LoadInterrupt:
	di
	exx
	.db	#0x08
	xor	a, a
	out	(3),a
	in	a,(6)
	push	af
	ld	a,(0x8584)
	out	(6),a
;../../lib/interupts.c:106: DURING_INTERUPT();
	call	_grey_interupt
;../../lib/interupts.c:134: __endasm;
	pop	af
	out	(6),a
	xor	a, #0b00001011
	out	(3),a
	.db	#0x08
	exx
	ei
	ret
	  ON_EXIT:
	di
	im	1
	ld	a, # 0b00001011
	out	(3), a
	ei
	ret
	  EndLoadInterupt:
;../../lib/interupts.c:135: }
;../../lib/greyscale.c:221: void clearGreyScaleBuffer(){
;	---------------------------------
; Function clearGreyScaleBuffer
; ---------------------------------
_clearGreyScaleBuffer::
;../../lib/greyscale.c:250: __endasm;
	DI
	LD	(0x980C), SP
	LD	SP, #0x9340 + 768 ; 768 byte area
	ld	c, #0xFF
	            WIPE_LOC:
	LD	HL, #0x0000
	LD	B, #48 ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
	         Loop:
	PUSH	HL ; Do multiple PUSHes in the loop to save cycles
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	DJNZ	Loop
	LD	SP, #0x9872 + 768 ; 768 byte area
	inc	c
	jp	z, WIPE_LOC
	             ENDOFWIPE:
	LD	SP, (0x980C)
	EI
;../../lib/greyscale.c:251: }
	ret
;main.c:13: void make_gradient(){
;	---------------------------------
; Function make_gradient
; ---------------------------------
_make_gradient::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;main.c:16: for (char b = YMAX-8; b !=0; b--){
	ld	hl, #0x9340
	ex	(sp), hl
	ld	-2 (ix), #0x72
	ld	-1 (ix), #0x98
	ld	c, #0x38
00103$:
	ld	a, c
	or	a, a
	jr	Z, 00105$
;main.c:17: *((char*)light) = 0xFF;
	pop	de
	push	de
	ld	a, #0xff
	ld	(de), a
;main.c:18: *((char*)light+1) = 0xFF;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0xff
;main.c:19: *((char*)dark) = 0xFF;
	ld	a, -2 (ix)
	ld	b, -1 (ix)
	ld	l, a
	ld	h, b
	ld	(hl), #0xff
;main.c:20: *((char*)dark+1) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	ld	(hl), #0xff
;main.c:21: *((char*)dark+2) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0xff
;main.c:22: *((char*)dark+3) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0xff
;main.c:23: *((char*)light+4) = 0xFF;
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0xff
;main.c:24: *((char*)light+5) = 0xFF;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0xff
;main.c:25: light+=6;
	ld	a, -4 (ix)
	add	a, #0x06
	ld	-4 (ix), a
	jr	NC, 00118$
	inc	-3 (ix)
00118$:
;main.c:26: dark+=6;
	ld	a, -2 (ix)
	add	a, #0x06
	ld	-2 (ix), a
	jr	NC, 00119$
	inc	-1 (ix)
00119$:
;main.c:16: for (char b = YMAX-8; b !=0; b--){
	dec	c
	jr	00103$
00105$:
;main.c:28: }
	ld	sp, ix
	pop	ix
	ret
;main.c:31: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:32: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:33: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;main.c:34: INIT_GREYSCALE();
	ld	hl, #0x85c0
	ld	(hl), #0x6d
	ld	l, #0xbf
	ld	(hl), #0x15
	ld	hl, #0x8447
	ld	(hl), #0x00
	ld	hl, #0x85be
	ld	(hl), #0x9f
	ld	l, #0xc1
	ld	(hl), #0x01
	ld	l, #0xc2
	ld	(hl), #0x80
	ld	l, #0xc4
	ld	(hl), #0x20
	ld	l, #0xc3
	ld	(hl), #0xbf
	ld	l, #0xc5
	ld	(hl), #0x0c
	ld de, # (ON_EXIT-LoadInterrupt+0x8E2C) 
	push de 
	call	__________SET_INTERUPTS
	ld ix,# 0 
	add ix,sp 
	ld a, # 0x40 
	out (0x33), a ;10922 Hz 
	ld a, # 2 
	out (0x34), a 
	ld a, (0x85BE) 
	out (0x35), a 
;main.c:35: *((char*)START_ROW)=ROW_CONST+8;
	ld	hl, #0x85c2
	ld	(hl), #0x88
;main.c:36: *((char*)MAX_COL)=6;
	ld	l, #0xc5
	ld	(hl), #0x06
;main.c:41: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:42: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:43: make_gradient();
	call	_make_gradient
;main.c:45: while (1){
00116$:
;main.c:46: wait(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_wait
	inc	sp
;main.c:48: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:49: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	cp	a, #0x0f
	jr	Z, 00117$
;main.c:51: else if (skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00110$
;main.c:52: *(char*)WAIT_LOC -=1;
	ld	a, (#0x85be)
	dec	a
	ld	(#0x85be),a
	jr	00114$
00110$:
;main.c:54: else if (skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00107$
;main.c:55: *(char*)WAIT_LOC +=1;
	ld	a, (#0x85be)
	inc	a
	ld	(#0x85be),a
	jr	00114$
00107$:
;main.c:57: else if (skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00104$
;main.c:58: *(char*)CONTRAST_LOC +=1;
	ld	a, (#0x85bf)
	inc	a
	ld	(#0x85bf),a
	jr	00114$
00104$:
;main.c:60: else if (skDown == lastPressedKey()){
	dec	a
	jr	NZ, 00114$
;main.c:61: *(char*)CONTRAST_LOC -=1;
	ld	a, (#0x85bf)
	dec	a
	ld	(#0x85bf),a
00114$:
;main.c:66: resetPen();
	call	_resetPen
;main.c:67: hexdump(*(char*)WAIT_LOC);
	ld	a, (#0x85be)
	push	af
	inc	sp
	call	_hexdump
	inc	sp
;main.c:68: hexdump(*(char*)CONTRAST_LOC);
	ld	a, (#0x85bf)
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	jr	00116$
00117$:
;main.c:74: setCpuSpeed(0);
	xor	a, a
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:76: }	
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
