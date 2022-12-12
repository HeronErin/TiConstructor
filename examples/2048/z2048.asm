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
	.globl _real_main
	.globl _calibration_menu
	.globl _make_gradient
	.globl _clearGreyScaleBuffer
	.globl ______copied_to_position
	.globl __________SET_INTERUPTS
	.globl _grey_interupt
	.globl _delete
	.globl _archive
	.globl _getOrCreateVar
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
;../../lib/variables.c:37: char* getOrCreateVar(char* name, int size)__naked{
;	---------------------------------
; Function getOrCreateVar
; ---------------------------------
_getOrCreateVar::
;../../lib/variables.c:84: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20
	rst	40 
	.dw 0x42F1
	jr	c,notfound
	ex	de,hl
	xor	a
	cp	b
	jr	z,unarchived
	di
	exx
	push	ix
	rst	40 
	.dw 0x4FD8
	pop	ix
	exx
	ei
	jp	_getOrCreateVar
	  unarchived:
	ret
	  notfound:
	pop	de
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	de
	rst	40 
	.dw 0x4E6A
	jp	_getOrCreateVar
;../../lib/variables.c:85: }
;../../lib/variables.c:89: void archive(char* name)__naked{
;	---------------------------------
; Function archive
; ---------------------------------
_archive::
;../../lib/variables.c:108: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20 ; Mov9ToOP1
	di
	exx
	push	ix
	rst	40 
	.dw 0x4FD8
	pop	ix
	exx
	ei
	ret
;../../lib/variables.c:110: }
;../../lib/variables.c:111: void delete(char* name)__naked{
;	---------------------------------
; Function delete
; ---------------------------------
_delete::
;../../lib/variables.c:122: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20 ; Mov9ToOP1
	rst	40 
	.dw 0x42F1
	rst	40 
	.dw 0x4351
	ret
;../../lib/variables.c:123: }
;../../lib/greyscale.c:113: void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
;	---------------------------------
; Function grey_interupt
; ---------------------------------
_grey_interupt::
;../../lib/greyscale.c:115: scanKeys();
	rst	40 
	.dw 0x4015 
;../../lib/greyscale.c:229: __endasm;
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
;../../lib/greyscale.c:230: }
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
;../../lib/interupts.c:133: __endasm;
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
;../../lib/interupts.c:134: ADDED_ON_EXIT();
	ld a, (0x9D88) 
	ld (0x8447), a 
	add a, # 0xD8 
	out (0x10), a 
	ret 
;../../lib/interupts.c:143: __endasm;
	ei
	ret
	  EndLoadInterupt:
;../../lib/interupts.c:144: }
;../../lib/greyscale.c:239: void clearGreyScaleBuffer(){
;	---------------------------------
; Function clearGreyScaleBuffer
; ---------------------------------
_clearGreyScaleBuffer::
;../../lib/greyscale.c:268: __endasm;
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
;../../lib/greyscale.c:269: }
	ret
;calibrate.c:3: void make_gradient(){
;	---------------------------------
; Function make_gradient
; ---------------------------------
_make_gradient::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;calibrate.c:6: for (char b = YMAX-8; b !=0; b--){
	ld	hl, #0x9340
	ex	(sp), hl
	ld	-2 (ix), #0x72
	ld	-1 (ix), #0x98
	ld	c, #0x38
00103$:
	ld	a, c
	or	a, a
	jr	Z, 00105$
;calibrate.c:7: *((char*)light) = 0xFF;
	pop	de
	push	de
	ld	a, #0xff
	ld	(de), a
;calibrate.c:8: *((char*)light+1) = 0xFF;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0xff
;calibrate.c:9: *((char*)dark) = 0xFF;
	ld	a, -2 (ix)
	ld	b, -1 (ix)
	ld	l, a
	ld	h, b
	ld	(hl), #0xff
;calibrate.c:10: *((char*)dark+1) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	ld	(hl), #0xff
;calibrate.c:11: *((char*)dark+2) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0xff
;calibrate.c:12: *((char*)dark+3) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0xff
;calibrate.c:13: *((char*)light+4) = 0xFF;
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0xff
;calibrate.c:14: *((char*)light+5) = 0xFF;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0xff
;calibrate.c:15: light+=6;
	ld	a, -4 (ix)
	add	a, #0x06
	ld	-4 (ix), a
	jr	NC, 00118$
	inc	-3 (ix)
00118$:
;calibrate.c:16: dark+=6;
	ld	a, -2 (ix)
	add	a, #0x06
	ld	-2 (ix), a
	jr	NC, 00119$
	inc	-1 (ix)
00119$:
;calibrate.c:6: for (char b = YMAX-8; b !=0; b--){
	dec	c
	jr	00103$
00105$:
;calibrate.c:18: }
	ld	sp, ix
	pop	ix
	ret
;calibrate.c:21: void calibration_menu(char* settings_var){
;	---------------------------------
; Function calibration_menu
; ---------------------------------
_calibration_menu::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;calibrate.c:22: *(char*)WAIT_LOC     = *(settings_var+1);
	ld	a, 4 (ix)
	add	a, #0x01
	ld	-2 (ix), a
	ld	a, 5 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	pop	hl
	push	hl
	ld	a, (hl)
	ld	hl, #0x85be
	ld	(hl), a
;calibrate.c:23: *(char*)CONTRAST_LOC = *(settings_var+2);
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	inc	de
	inc	de
	ld	a, (de)
	ld	l, #0xbf
	ld	(hl), a
;calibrate.c:24: clearGreyScaleBuffer();
	push	de
	call	_clearGreyScaleBuffer
	call	_make_gradient
	pop	de
;calibrate.c:27: *((char*)START_ROW)=ROW_CONST+8;
	ld	hl, #0x85c2
	ld	(hl), #0x88
;calibrate.c:28: *((char*)START_COL) = COL_START_CONST;
	ld	l, #0xc4
	ld	(hl), #0x20
;calibrate.c:30: *((char*)END_ROW) = ROW_END_CONST;
	ld	l, #0xc3
	ld	(hl), #0xbf
;calibrate.c:31: *((char*)MAX_COL)=6;
	ld	l, #0xc5
	ld	(hl), #0x06
;calibrate.c:35: while (1){
00116$:
;calibrate.c:36: wait(4);
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_wait
	inc	sp
	pop	de
;calibrate.c:38: scanKeys();
	rst	40 
	.dw 0x4015 
;calibrate.c:39: if (skClear == lastPressedKey())
	ld	hl, #0x843f
	ld	a, (hl)
	cp	a, #0x0f
	jr	Z, 00118$
;calibrate.c:41: else if (skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00110$
;calibrate.c:42: *(char*)WAIT_LOC -=1;
	ld	a, (#0x85be)
	dec	a
	ld	hl, #0x85be
	ld	(hl), a
;calibrate.c:43: *(settings_var+1) = *(char*)WAIT_LOC     ;
	ld	l, #0xbe
	ld	a, (hl)
	pop	hl
	push	hl
	ld	(hl), a
	jr	00114$
00110$:
;calibrate.c:45: else if (skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00107$
;calibrate.c:46: *(char*)WAIT_LOC +=1;
	ld	a, (#0x85be)
	inc	a
	ld	hl, #0x85be
	ld	(hl), a
;calibrate.c:47: *(settings_var+1) = *(char*)WAIT_LOC     ;
	ld	l, #0xbe
	ld	a, (hl)
	pop	hl
	push	hl
	ld	(hl), a
	jr	00114$
00107$:
;calibrate.c:49: else if (skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00104$
;calibrate.c:50: *(char*)CONTRAST_LOC +=1;
	ld	a, (#0x85bf)
	inc	a
	ld	hl, #0x85bf
	ld	(hl), a
;calibrate.c:51: *(settings_var+2) = *(char*)CONTRAST_LOC ;
	ld	l, #0xbf
	ld	a, (hl)
	ld	(de), a
	jr	00114$
00104$:
;calibrate.c:53: else if (skDown == lastPressedKey()){
	dec	a
	jr	NZ, 00114$
;calibrate.c:54: *(char*)CONTRAST_LOC -=1;
	ld	a, (#0x85bf)
	dec	a
	ld	hl, #0x85bf
	ld	(hl), a
;calibrate.c:55: *(settings_var+2) = *(char*)CONTRAST_LOC ;
	ld	l, #0xbf
	ld	a, (hl)
	ld	(de), a
00114$:
;calibrate.c:58: resetPen();
	push	de
	call	_resetPen
	pop	de
;calibrate.c:59: hexdump( *(settings_var+1));
	pop	hl
	push	hl
	ld	a, (hl)
	push	de
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	pop	de
;calibrate.c:60: hexdump( *(settings_var+2));
	ld	a, (de)
	push	de
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	pop	de
	jr	00116$
00118$:
;calibrate.c:66: }
	ld	sp, ix
	pop	ix
	ret
;main.c:17: void real_main(){
;	---------------------------------
; Function real_main
; ---------------------------------
_real_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;main.c:18: volatile char* dataLoc=getOrCreateVar(dataName, 10)+2;
	ld	hl, #0x000a
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	ex	de, hl
	inc	de
	inc	de
;main.c:19: INIT_GREYSCALE();
	ld	hl, #0x85c0
	ld	(hl), #0x6d
	ld	l, #0xbf
	ld	(hl), #0x15
	ld	a, (#0x8447)
	ld	(#0x9d88),a
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
	push	de
	call	__________SET_INTERUPTS
	pop	de
	ld ix,# 0 
	add ix,sp 
	ld a, # 0x40 
	out (0x33), a ;10922 Hz 
	ld a, # 2 
	out (0x34), a 
	ld a, (0x85BE) 
	out (0x35), a 
;main.c:20: if (!( *dataLoc == 0x69     &&     *(dataLoc+3) == 0x69      )){
	ld	a, (de)
	ld	l, a
	ld	a, e
	add	a, #0x03
	ld	-4 (ix), a
	ld	a, d
	adc	a, #0x00
	ld	-3 (ix), a
;main.c:24: *(dataLoc+1) = 0x9f;   // wait
	ld	c, e
	ld	b, d
	inc	bc
;main.c:25: *(dataLoc+2) = 0x14;   // contrast
	ld	a, e
	add	a, #0x02
	ld	-2 (ix), a
	ld	a, d
	adc	a, #0x00
	ld	-1 (ix), a
;main.c:20: if (!( *dataLoc == 0x69     &&     *(dataLoc+3) == 0x69      )){
	ld	a, l
	sub	a, #0x69
	jr	NZ, 00101$
	pop	hl
	push	hl
	ld	a, (hl)
	sub	a, #0x69
	jr	Z, 00102$
00101$:
;main.c:22: *dataLoc     = 0x69;   // check integrity 
	ld	a, #0x69
	ld	(de), a
;main.c:24: *(dataLoc+1) = 0x9f;   // wait
	ld	a, #0x9f
	ld	(bc), a
;main.c:25: *(dataLoc+2) = 0x14;   // contrast
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), #0x14
;main.c:27: *(dataLoc+3) = 0x69;   // check integrity
	pop	hl
	push	hl
	ld	(hl), #0x69
;main.c:28: *(char*)WAIT_LOC     = 0x9f;
	ld	hl, #0x85be
	ld	(hl), #0x9f
;main.c:29: *(char*)CONTRAST_LOC = 0x14;
	ld	l, #0xbf
	ld	(hl), #0x14
;main.c:30: calibration_menu(dataLoc);
	push	bc
	push	de
	push	de
	call	_calibration_menu
	pop	af
	pop	de
	pop	bc
00102$:
;main.c:32: *(char*)WAIT_LOC     = *(dataLoc+1);
	ld	a, (bc)
	ld	(#0x85be),a
;main.c:33: *(char*)CONTRAST_LOC = *(dataLoc+2);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	(#0x85bf),a
;main.c:35: while (1){
00110$:
;main.c:36: wait(4);
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_wait
	inc	sp
	pop	de
;main.c:38: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:39: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	cp	a, #0x0f
	jr	Z, 00111$
;main.c:41: else if (skMode == lastPressedKey()){
	sub	a, #0x37
	jr	NZ, 00110$
;main.c:42: calibration_menu(dataLoc);
	push	de
	push	de
	call	_calibration_menu
	pop	af
	pop	de
	jr	00110$
00111$:
;main.c:50: archive(dataName); 
	ld	hl, #___str_0
	push	hl
	call	_archive
;main.c:55: }
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.db 0x15
	.ascii "greycfg"
	.db 0x00
;main.c:58: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:60: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:61: resetPen();
	call	_resetPen
;main.c:64: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;main.c:67: real_main(); // sdcc for some reason dose things with ix and sp that mean you need to use another func after INIT_GREYSCALE, 
;main.c:71: }
	jp	_real_main
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
