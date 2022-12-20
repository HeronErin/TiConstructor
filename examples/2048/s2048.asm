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
	.globl _set
	.globl _calibration_loop
	.globl _make_gradient
	.globl _greyPutSprite
	.globl _fullPutSprite
	.globl _appBackupIonPutSprite
	.globl _ionPutSprite
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
	.globl _sixtyfour_DATA
	.globl _thirtytwo_DATA
	.globl _sixteen_DATA
	.globl _eight_DATA
	.globl _four_DATA
	.globl _two_DATA
	.globl _ONE_DATA
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
;../../lib/greyscale.c:114: void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
;	---------------------------------
; Function grey_interupt
; ---------------------------------
_grey_interupt::
;../../lib/greyscale.c:116: scanKeys();
	rst	40 
	.dw 0x4015 
;../../lib/greyscale.c:224: __endasm;
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
	LD	A, #0x07 ; set y inc mode
	OUT	(0x10), A
	ld	a, (((((0x85BE +1)+1)+1)+1))
	  rows:
	out	(0x10), a
	ld	d, a
	LD	A, (((((((0x85BE +1)+1)+1)+1)+1)+1)) ; reset col
	OUT	(0x10), A
	ld	a, ((((((((0x85BE +1)+1)+1)+1)+1)+1)+1))
	ld	b, a
	      row:
	ld	a, (hl)
	inc	hl
	out	(0x11), a
	djnz	row
	ld	a, d
	inc	a
	cp	e
	jp	nz, rows
	ret
;../../lib/greyscale.c:225: }
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
;../../lib/greyscale.c:234: void clearGreyScaleBuffer(){
;	---------------------------------
; Function clearGreyScaleBuffer
; ---------------------------------
_clearGreyScaleBuffer::
;../../lib/greyscale.c:263: __endasm;
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
;../../lib/greyscale.c:264: }
	ret
;../../lib/spritemanager.c:36: void ionPutSprite()__naked{    
;	---------------------------------
; Function ionPutSprite
; ---------------------------------
_ionPutSprite::
;../../lib/spritemanager.c:83: __endasm;
	  putSprite:
	ld	e,l
	ld	h,#00
	ld	d,h
	add	hl,hl 
	ld e, l 
	add hl,hl 
	add hl,de 
	add hl,de ;Find the Y displacement offset
	ld	e,a
	and	#07 ;Find the bit number
	ld	c,a
	srl	e
	srl	e
	srl	e
	add	hl,de ;Find the X displacement offset
	ld	de,#0x9340
	add	hl,de
	     putSpriteLoop1:
	     sl1:
	ld d,(ix) ;loads image byte into D
	ld	e,#00
	ld	a,c
	or	a
	jr	z,putSpriteSkip1
	     putSpriteLoop2:
	srl	d ;rotate to give out smooth moving
	rr	e
	dec	a
	jr	nz,putSpriteLoop2
	     putSpriteSkip1:
	ld	a,(hl)
	xor	d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	xor	e
	ld	(hl),a ;copy to buffer using XOR logic
	ld	de,#8 -1
	add	hl,de
	inc	ix ;Set for next byte of image
	djnz	putSpriteLoop1
	ret
;../../lib/spritemanager.c:84: }
;../../lib/spritemanager.c:86: void appBackupIonPutSprite()__naked{      ///////// 4 5 6 (7, 8)
;	---------------------------------
; Function appBackupIonPutSprite
; ---------------------------------
_appBackupIonPutSprite::
;../../lib/spritemanager.c:133: __endasm;
	  _putSprite:
	ld	e,l
	ld	h,#00
	ld	d,h
	add	hl,hl 
	ld e, l 
	add hl,hl 
	add hl,de 
	add hl,de ;Find the Y displacement offset
	ld	e,a
	and	#07 ;Find the bit number
	ld	c,a
	srl	e
	srl	e
	srl	e
	add	hl,de ;Find the X displacement offset
	ld	de,#0x9872
	add	hl,de
	     _putSpriteLoop1:
	     _sl1:
	ld d,(ix) ;loads image byte into D
	ld	e,#00
	ld	a,c
	or	a
	jr	z,_putSpriteSkip1
	     _putSpriteLoop2:
	srl	d ;rotate to give out smooth moving
	rr	e
	dec	a
	jr	nz,_putSpriteLoop2
	     _putSpriteSkip1:
	ld	a,(hl)
	xor	d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	xor	e
	ld	(hl),a ;copy to buffer using XOR logic
	ld	de,#8 -1
	add	hl,de
	inc	ix ;Set for next byte of image
	djnz	_putSpriteLoop1
	ret
;../../lib/spritemanager.c:134: }
;../../lib/spritemanager.c:138: void fullPutSprite(char x, char y, char width, char height, char* sprite){  //4, 5, 6, 7 (8, 9)
;	---------------------------------
; Function fullPutSprite
; ---------------------------------
_fullPutSprite::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/spritemanager.c:164: __endasm;
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	a, 4(ix)
	ld	l, 5(ix)
	ld	b, 7(ix)
	ld	c, 6(ix)
	pop	ix
	  X_DRAW_LOOP:
	push	af
	push	hl
	push	bc
	call	_ionPutSprite
	pop	bc
	pop	hl
	pop	af
	add	a, #8
	dec	c
	jp	nz, X_DRAW_LOOP
;../../lib/spritemanager.c:165: }
	pop	ix
	ret
;../../lib/spritemanager.c:168: void greyPutSprite(char x, char y, char width, char height, char* sprite){  //4, 5, 6, 7 (8, 9) (10, 11)
;	---------------------------------
; Function greyPutSprite
; ---------------------------------
_greyPutSprite::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/spritemanager.c:228: __endasm;
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	a, 4(ix)
	ld	l, 5(ix)
	ld	h, 6(ix)
	ld	b, 7(ix)
	ld	c, 6(ix)
	pop	ix
	push	af
	push	hl
	push	bc
	  __X_DRAW_LOOP:
	push	af
	push	hl
	push	bc
	call	_ionPutSprite
	pop	bc
	pop	hl
	pop	af
	add	a, #8
	dec	c
	jp	nz, __X_DRAW_LOOP
	pop	bc
	pop	hl
	pop	af
	  __Xa_DRAW_LOOP:
	push	af
	push	hl
	push	bc
	call	_appBackupIonPutSprite
	pop	bc
	pop	hl
	pop	af
	add	a, #8
	dec	c
	jp	nz, __Xa_DRAW_LOOP
;../../lib/spritemanager.c:229: }
	pop	ix
	ret
;calibration.c:4: void make_gradient(){
;	---------------------------------
; Function make_gradient
; ---------------------------------
_make_gradient::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;calibration.c:7: for (char b = YMAX-8; b !=0; b--){
	ld	hl, #0x9340
	ex	(sp), hl
	ld	-2 (ix), #0x72
	ld	-1 (ix), #0x98
	ld	c, #0x38
00103$:
	ld	a, c
	or	a, a
	jr	Z, 00105$
;calibration.c:8: *((char*)light) = 0xFF;
	pop	de
	push	de
	ld	a, #0xff
	ld	(de), a
;calibration.c:9: *((char*)light+1) = 0xFF;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0xff
;calibration.c:10: *((char*)dark) = 0xFF;
	ld	a, -2 (ix)
	ld	b, -1 (ix)
	ld	l, a
	ld	h, b
	ld	(hl), #0xff
;calibration.c:11: *((char*)dark+1) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	ld	(hl), #0xff
;calibration.c:12: *((char*)dark+2) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0xff
;calibration.c:13: *((char*)dark+3) = 0xFF;
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0xff
;calibration.c:14: *((char*)light+4) = 0xFF;
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0xff
;calibration.c:15: *((char*)light+5) = 0xFF;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0xff
;calibration.c:16: light+=6;
	ld	a, -4 (ix)
	add	a, #0x06
	ld	-4 (ix), a
	jr	NC, 00118$
	inc	-3 (ix)
00118$:
;calibration.c:17: dark+=6;
	ld	a, -2 (ix)
	add	a, #0x06
	ld	-2 (ix), a
	jr	NC, 00119$
	inc	-1 (ix)
00119$:
;calibration.c:7: for (char b = YMAX-8; b !=0; b--){
	dec	c
	jr	00103$
00105$:
;calibration.c:19: }
	ld	sp, ix
	pop	ix
	ret
;calibration.c:21: void calibration_loop(){
;	---------------------------------
; Function calibration_loop
; ---------------------------------
_calibration_loop::
;calibration.c:22: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;calibration.c:23: make_gradient();
	call	_make_gradient
;calibration.c:36: __endasm;
	ld	a, (((((0x85BE +1)+1)+1)+1))
	ld	b, a
	ld	a, (((((((0x85BE +1)+1)+1)+1)+1)+1))
	ld	c, a
	push	bc
	ld	a, ((((((0x85BE +1)+1)+1)+1)+1))
	ld	b, a
	ld	a, ((((((((0x85BE +1)+1)+1)+1)+1)+1)+1))
	ld	c, a
	push	bc
;calibration.c:38: *((char*)START_ROW) = ROW_CONST+8;
	ld	hl, #0x85c2
	ld	(hl), #0x88
;calibration.c:39: *((char*)START_COL) = COL_START_CONST;
	ld	l, #0xc4
	ld	(hl), #0x20
;calibration.c:41: *((char*)END_ROW) = ROW_END_CONST;
	ld	l, #0xc3
	ld	(hl), #0xbf
;calibration.c:42: *((char*)MAX_COL) = 6;
	ld	l, #0xc5
	ld	(hl), #0x06
;calibration.c:44: while (1){
00119$:
;calibration.c:45: wait(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_wait
	inc	sp
;calibration.c:47: scanKeys();
	rst	40 
	.dw 0x4015 
;calibration.c:48: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	cp	a, #0x0f
	jr	Z, 00120$
;calibration.c:50: else if (skMode == lastPressedKey())
	cp	a, #0x37
	jr	Z, 00120$
;calibration.c:52: else if (skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00110$
;calibration.c:53: *(char*)WAIT_LOC -=1;
	ld	a, (#0x85be)
	dec	a
	ld	(#0x85be),a
	jr	00117$
00110$:
;calibration.c:55: else if (skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00107$
;calibration.c:56: *(char*)WAIT_LOC +=1;
	ld	a, (#0x85be)
	inc	a
	ld	(#0x85be),a
	jr	00117$
00107$:
;calibration.c:58: else if (skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00104$
;calibration.c:59: *(char*)CONTRAST_LOC +=1;
	ld	a, (#0x85bf)
	inc	a
	ld	(#0x85bf),a
	jr	00117$
00104$:
;calibration.c:61: else if (skDown == lastPressedKey()){
	dec	a
	jr	NZ, 00117$
;calibration.c:62: *(char*)CONTRAST_LOC -=1;
	ld	a, (#0x85bf)
	dec	a
	ld	(#0x85bf),a
00117$:
;calibration.c:65: resetPen();
	call	_resetPen
;calibration.c:66: hexdump(*(char*)WAIT_LOC);
	ld	a, (#0x85be)
	push	af
	inc	sp
	call	_hexdump
	inc	sp
;calibration.c:67: hexdump(*(char*)CONTRAST_LOC);
	ld	a, (#0x85bf)
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	jr	00119$
00120$:
;calibration.c:71: char* dataLoc=getOrCreateVar(dataName, 20)+2;
	ld	hl, #0x0014
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	ex	de, hl
	inc	de
	inc	de
;calibration.c:72: dataLoc[1] = *(char*)WAIT_LOC ;
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (#0x85be)
	ld	(bc), a
;calibration.c:73: dataLoc[2] = *(char*)CONTRAST_LOC ;
	inc	de
	inc	de
	ld	a, (#0x85bf)
	ld	(de), a
;calibration.c:74: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;calibration.c:87: __endasm;
	pop	bc
	ld	a, b
	ld	((((((0x85BE +1)+1)+1)+1)+1)), a
	ld	a, c
	ld	((((((((0x85BE +1)+1)+1)+1)+1)+1)+1)), a
	pop	bc
	ld	a, b
	ld	(((((0x85BE +1)+1)+1)+1)), a
	ld	a, c
	ld	(((((((0x85BE +1)+1)+1)+1)+1)+1)), a
;calibration.c:88: }
	ret
___str_0:
	.db 0x15
	.ascii "gryCfg"
	.db 0x00
;main.c:62: void set(){
;	---------------------------------
; Function set
; ---------------------------------
_set::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;main.c:63: char* dataLoc=getOrCreateVar(dataName, 20)+2; 
	ld	hl, #0x0014
	push	hl
	ld	hl, #___str_1
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	inc	hl
	inc	hl
;main.c:65: if (!(dataLoc[0] == 0x69 && dataLoc[3] == 0x69)){
	ld	a, (hl)
	ld	-3 (ix), a
	ld	c, l
	ld	b, h
	inc	bc
	inc	bc
	inc	bc
;main.c:67: dataLoc[1] = 0x9F;
	ld	e, l
	ld	d, h
	inc	de
;main.c:68: dataLoc[2] = 0x15;
	ld	a, l
	add	a, #0x02
	ld	-2 (ix), a
	ld	a, h
	adc	a, #0x00
	ld	-1 (ix), a
;main.c:65: if (!(dataLoc[0] == 0x69 && dataLoc[3] == 0x69)){
	ld	a, -3 (ix)
	sub	a, #0x69
	jr	NZ, 00101$
	ld	a, (bc)
	sub	a, #0x69
	jr	Z, 00102$
00101$:
;main.c:66: dataLoc[0] = 0x69;
	ld	(hl), #0x69
;main.c:67: dataLoc[1] = 0x9F;
	ld	a, #0x9f
	ld	(de), a
;main.c:68: dataLoc[2] = 0x15;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), #0x15
;main.c:69: dataLoc[3] = 0x69;
	ld	a, #0x69
	ld	(bc), a
00102$:
;main.c:71: *(char*)(0x85A6) = dataLoc[1];
	ld	a, (de)
	ld	(#0x85a6),a
;main.c:72: *(char*)(0x85A6+1) = dataLoc[2];
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	hl, #0x85a7
	ld	(hl), a
;main.c:73: }
	ld	sp, ix
	pop	ix
	ret
_ONE_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
_two_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
_four_DATA:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x41	; 65	'A'
	.db #0xc1	; 193
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0xc1	; 193
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
_eight_DATA:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
_sixteen_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xe7	; 231
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
_thirtytwo_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xdd	; 221
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xe3	; 227
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xf7	; 247
	.db #0xef	; 239
	.db #0xdf	; 223
	.db #0xbf	; 191
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
_sixtyfour_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x9c	; 156
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xb8	; 184
	.db #0xa4	; 164
	.db #0xa5	; 165
	.db #0xa4	; 164
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x31	; 49	'1'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x91	; 145
	.db #0xf9	; 249
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xb8	; 184
	.db #0xa4	; 164
	.db #0xa4	; 164
	.db #0xa4	; 164
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x31	; 49	'1'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x91	; 145
	.db #0xf9	; 249
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
___str_1:
	.db 0x15
	.ascii "gryCfg"
	.db 0x00
;main.c:75: void real_main(){
;	---------------------------------
; Function real_main
; ---------------------------------
_real_main::
;main.c:76: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:77: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:78: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;main.c:80: set();
	call	_set
;main.c:83: INIT_GREYSCALE();
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
	call	__________SET_INTERUPTS
	ld ix,# 0 
	add ix,sp 
	ld a, # 0x40 
	out (0x33), a ;10922 Hz 
	ld a, # 2 
	out (0x34), a 
	ld a, (0x85BE) 
	out (0x35), a 
;main.c:85: *(char*)WAIT_LOC = *(char*)(0x85A6);
	ld	a, (#0x85a6)
	ld	hl, #0x85be
	ld	(hl), a
;main.c:86: *(char*)CONTRAST_LOC = *(char*)(0x85A6+1);
	ld	l, #0xa7
	ld	a, (hl)
	ld	(#0x85bf),a
;main.c:88: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:91: *((char*)MAX_COL)=8;
	ld	hl, #0x85c5
	ld	(hl), #0x08
;main.c:92: *((char*)START_COL) = COL_START_CONST+1;
	ld	l, #0xc4
	ld	(hl), #0x21
;main.c:94: *((char*)START_ROW) = ROW_CONST;
	ld	l, #0xc2
	ld	(hl), #0x80
;main.c:95: *((char*)END_ROW) = ROW_END_CONST;
	ld	l, #0xc3
	ld	(hl), #0xbf
;main.c:98: greyPutSprite(0, 0, ONE_WIDTH, ONE_HEIGHT, ONE_DATA);
	ld	hl, #_ONE_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:99: greyPutSprite(16, 0, two_WIDTH, two_HEIGHT, two_DATA);
	ld	hl, #_two_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x10
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:100: greyPutSprite(32, 0, four_WIDTH, four_HEIGHT, four_DATA);
	ld	hl, #_four_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x20
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:101: greyPutSprite(32+16, 0, eight_WIDTH, eight_HEIGHT, eight_DATA);
	ld	hl, #_eight_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x30
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:102: greyPutSprite(0, 16, sixteen_WIDTH, sixteen_HEIGHT, sixteen_DATA);
	ld	hl, #_sixteen_DATA
	push	hl
	ld	de, #0x1002
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:103: greyPutSprite(16, 16, thirtytwo_WIDTH, thirtytwo_HEIGHT, thirtytwo_DATA);
	ld	hl, #_thirtytwo_DATA
	push	hl
	ld	de, #0x1002
	push	de
	ld	de, #0x1010
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:104: greyPutSprite(32, 16, sixtyfour_WIDTH, sixtyfour_HEIGHT, sixtyfour_DATA);
	ld	hl, #_sixtyfour_DATA
	push	hl
	ld	de, #0x1002
	push	de
	ld	de, #0x1020
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:106: greyPutSprite(32+16, 32+16, ONE_WIDTH, ONE_HEIGHT, ONE_DATA);
	ld	hl, #_ONE_DATA
	push	hl
	ld	de, #0x1002
	push	de
	ld	de, #0x3030
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:108: while (1){
00107$:
;main.c:109: wait(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_wait
	inc	sp
;main.c:111: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:112: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	cp	a, #0x0f
	jr	Z, 00108$
;main.c:114: else if (skMode == lastPressedKey()){
	sub	a, #0x37
	jr	NZ, 00107$
;main.c:115: calibration_loop();
	call	_calibration_loop
;main.c:116: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:117: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
;main.c:119: greyPutSprite(0, 0, ONE_WIDTH, ONE_HEIGHT, ONE_DATA);
	ld	hl, #_ONE_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:120: greyPutSprite(16, 0, two_WIDTH, two_HEIGHT, two_DATA);
	ld	hl, #_two_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x10
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;main.c:121: greyPutSprite(32, 0, four_WIDTH, four_HEIGHT, four_DATA);
	ld	hl, #_four_DATA
	push	hl
	ld	de, #0x1002
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x20
	push	de
	call	_greyPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	jr	00107$
00108$:
;main.c:129: archive(dataName);
	ld	hl, #___str_2
	push	hl
	call	_archive
	pop	af
;main.c:132: }
	ret
___str_2:
	.db 0x15
	.ascii "gryCfg"
	.db 0x00
;main.c:134: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:135: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:136: resetPen();
	call	_resetPen
;main.c:139: real_main();
;main.c:145: }
	jp	_real_main
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
