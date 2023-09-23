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
	.globl _downwards
	.globl _upwards
	.globl _toTheLeft
	.globl _toTheRight
	.globl _moveAlong
	.globl _random_spawn
	.globl _set
	.globl _renderBoard
	.globl _animate_board
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
	.globl _vertical_dotted_line
	.globl _vertical_line
	.globl _swap
	.globl _delete
	.globl _archive
	.globl _getOrCreateVar
	.globl _wait
	.globl _setCpuSpeed
	.globl _getCpuSpeed
	.globl _hexdump
	.globl _number
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _NUM_DATA
	.globl _scoreboard_DATA
	.globl _b8192_DATA
	.globl _b4096_DATA
	.globl _b2048_DATA
	.globl _b1024_DATA
	.globl _b512_DATA
	.globl _b256_DATA
	.globl _b128_DATA
	.globl _b64_DATA
	.globl _b32_DATA
	.globl _b16_DATA
	.globl _b8_DATA
	.globl _b4_DATA
	.globl _b2_DATA
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
_NUM_DATA::
	.ds 28
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
;../../lib/textio.c:20: void setPenRow(char row) __naked{
;	---------------------------------
; Function setPenRow
; ---------------------------------
_setPenRow::
;../../lib/textio.c:32: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:33: }
;../../lib/textio.c:38: void setPenCol(char col) __naked{
;	---------------------------------
; Function setPenCol
; ---------------------------------
_setPenCol::
;../../lib/textio.c:50: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:51: }
;../../lib/textio.c:54: void resetPen() __naked{
;	---------------------------------
; Function resetPen
; ---------------------------------
_resetPen::
;../../lib/textio.c:61: __endasm;
	xor	a, a
	ld	(#0x86D7), a
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:62: }
;../../lib/textio.c:67: void fputs(char* loc) __naked {
;	---------------------------------
; Function fputs
; ---------------------------------
_fputs::
;../../lib/textio.c:84: __endasm;
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
;../../lib/textio.c:85: }
;../../lib/textio.c:90: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:91: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:100: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:101: }
	pop	ix
	ret
;../../lib/textio.c:104: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:114: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:115: }
;../../lib/textio.c:119: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:131: __endasm;
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
;../../lib/textio.c:132: }
;../../lib/textio.c:141: void number(int x){
;	---------------------------------
; Function number
; ---------------------------------
_number::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-29
	add	hl, sp
	ld	sp, hl
;../../lib/textio.c:143: if (x<0){
	bit	7, 5 (ix)
	jr	Z, 00113$
;../../lib/textio.c:144: x=0-x;
	xor	a, a
	sub	a, 4 (ix)
	ld	4 (ix), a
	ld	a, #0x00
	sbc	a, 5 (ix)
	ld	5 (ix), a
;../../lib/textio.c:145: printc('-');
	ld	a, #0x2d
	push	af
	inc	sp
	call	_printc
	inc	sp
;../../lib/textio.c:148: do {
00113$:
	ld	hl, #0
	add	hl, sp
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	bc, #0x0000
00103$:
;../../lib/textio.c:149: out[i]=x % 10 + '0';
	ld	a, -4 (ix)
	add	a, c
	ld	e, a
	ld	a, -3 (ix)
	adc	a, b
	ld	d, a
	push	bc
	push	de
	ld	hl, #0x000a
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__modsint
	pop	af
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	pop	de
	pop	bc
	ld	a, -2 (ix)
	add	a, #0x30
	ld	(de), a
;../../lib/textio.c:150: i+=1;
	inc	bc
;../../lib/textio.c:151: } while((x /= 10) > 0);
	push	bc
	ld	hl, #0x000a
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	4 (ix), e
	ld	5 (ix), d
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00139$
	xor	a, #0x80
00139$:
	jp	M, 00103$
;../../lib/textio.c:152: i--;
	dec	bc
00108$:
;../../lib/textio.c:153: for(;i>=0; i--){
	bit	7, b
	jr	NZ, 00110$
;../../lib/textio.c:164: __endasm;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	add	hl, bc
	ld	a, (hl)
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
;../../lib/textio.c:153: for(;i>=0; i--){
	dec	bc
	jr	00108$
00110$:
;../../lib/textio.c:168: }
	ld	sp, ix
	pop	ix
	ret
;../../lib/textio.c:182: void hexdump(char v)__naked{
;	---------------------------------
; Function hexdump
; ---------------------------------
_hexdump::
;../../lib/textio.c:218: __endasm;
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
;../../lib/textio.c:219: }
;../../lib/misc.c:28: char getCpuSpeed() __naked{
;	---------------------------------
; Function getCpuSpeed
; ---------------------------------
_getCpuSpeed::
;../../lib/misc.c:33: __endasm;
	in	a, (0x20)
	ld	l, a
	ret
;../../lib/misc.c:34: }
;../../lib/misc.c:41: void setCpuSpeed(char speed){
;	---------------------------------
; Function setCpuSpeed
; ---------------------------------
_setCpuSpeed::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:45: __endasm;
	ld	a, 4 (ix)
	out	(0x20), a
;../../lib/misc.c:46: }
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
;../../lib/misc.c:70: void wait(unsigned char x){
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:87: __endasm;
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
;../../lib/misc.c:88: }
	pop	ix
	ret
;../../lib/variables.c:46: char* getOrCreateVar(char* name, int size)__naked{
;	---------------------------------
; Function getOrCreateVar
; ---------------------------------
_getOrCreateVar::
;../../lib/variables.c:93: __endasm;
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
;../../lib/variables.c:94: }
;../../lib/variables.c:105: void archive(char* name)__naked{
;	---------------------------------
; Function archive
; ---------------------------------
_archive::
;../../lib/variables.c:124: __endasm;
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
;../../lib/variables.c:126: }
;../../lib/variables.c:133: void delete(char* name)__naked{
;	---------------------------------
; Function delete
; ---------------------------------
_delete::
;../../lib/variables.c:144: __endasm;
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
;../../lib/variables.c:145: }
;../../lib/graphics.c:114: void swap(){
;	---------------------------------
; Function swap
; ---------------------------------
_swap::
;../../lib/graphics.c:155: __endasm;
	di
	ld	hl, #_scoreboard_DATA
	CALL	0x000B
	LD	A, #0x07 ; set y inc moce
	OUT	(0x10), A
	LD	c, #0x80
	 YLOOPR__:
	CALL	0x000B ; set row
	LD	A, c
	OUT	(0x10), A
	CALL	0x000B
	LD	A, #0x20 + 12 - 4 ; reset col
	OUT	(0x10), A
	ld	b, #32/8
	 XLOOPR__:
	CALL	0x000B
	ld	a, (hl)
	out	(0x11), a
	inc	hl
	djnz	XLOOPR__
	inc	c
	ld	a, c
	cp	#0x80 + 64
	jp	nz, YLOOPR__
	ei
;../../lib/graphics.c:157: }
	ret
;../../lib/graphics.c:312: void vertical_line(char x, char start, char height, char not_used)__naked{
;	---------------------------------
; Function vertical_line
; ---------------------------------
_vertical_line::
;../../lib/graphics.c:382: __endasm;
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	ld	h, l
	push	hl
	ld	b, #0
	ld	c, d
	ld	h, b
	ld	l, c
	add	hl, bc
	ld	b, h
	ld	c, l
	add	hl, bc
	ld	b, h
	ld	c, l
	add	hl, bc
	add	hl, bc
	ld	b, h
	ld	c, l
	ld	a, e
	ld	hl,#_scoreboard_DATA
	add	hl, bc
	ld	d,#0
	ld	e,a
	srl	e
	srl	e
	srl	e
	add	hl,de
	and	a, #0x07
	ld	b,a
	inc	b
	ld	a,#1
	  vertloop1:
	rrca
	djnz	vertloop1
	ld	c,a
	pop	af
	ld	b,a
	ld	e,#12
	  vertloop2:
	ld	a,c
	or	(hl)
	ld	(hl),a
	add	hl,de
	djnz	vertloop2
	ret
;../../lib/graphics.c:383: }
;../../lib/graphics.c:395: void vertical_dotted_line(char x, char start, char height, char not_used)__naked{
;	---------------------------------
; Function vertical_dotted_line
; ---------------------------------
_vertical_dotted_line::
;../../lib/graphics.c:468: __endasm;
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	ld	h, l
	push	hl
	ld	b, #0
	ld	c, d
	ld	h, b
	ld	l, c
	add	hl, bc
	ld	b, h
	ld	c, l
	add	hl, bc
	ld	b, h
	ld	c, l
	add	hl, bc
	add	hl, bc
	ld	b, h
	ld	c, l
	ld	a, e
	ld	hl,#_scoreboard_DATA
	add	hl, bc
	ld	d,#0
	ld	e,a
	srl	e
	srl	e
	srl	e
	add	hl,de
	and	a, #0x07
	ld	b,a
	inc	b
	ld	a,#1
	  _vertloop1:
	rrca
	djnz	_vertloop1
	ld	c,a
	pop	af
	rra
	ld	b,a
	ld	e,#12
	  _vertloop2:
	ld	a,c
	or	(hl)
	ld	(hl),a
	add	hl,de
	add	hl,de
	djnz	_vertloop2
	ret
;../../lib/graphics.c:469: }
;../../lib/greyscale.c:141: void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
;	---------------------------------
; Function grey_interupt
; ---------------------------------
_grey_interupt::
;../../lib/greyscale.c:143: scanKeys();
	rst	40 
	.dw 0x4015 
;../../lib/greyscale.c:288: __endasm;
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
	in	a, (0x20)
	push	af
	xor	a, a
	out	(0x20), a
	LD	A, #0x07 ; set y inc mode
	OUT	(0x10), A
	push	bc
	pop	bc
	ld	a, (((((0x85BE +1)+1)+1)+1))
	  rows:
	push	ix
	pop	ix
	nop
	nop
	out	(0x10), a
	ld	d, a
	push	ix
	pop	ix
	push	bc
	pop	bc
	LD	A, (((((((0x85BE +1)+1)+1)+1)+1)+1)) ; reset col
	OUT	(0x10), A
	ld	a, ((((((((0x85BE +1)+1)+1)+1)+1)+1)+1))
	ld	b, a
	      row:
	ld	a, (hl)
	inc	hl
	push	ix
	pop	ix
	push	bc
	pop	bc
	push	bc
	pop	bc
	out	(0x11), a
	djnz	row
	ld	a, d
	inc	a
	cp	e
	jp	nz, rows
	pop	af
	out	(0x20), a
;../../lib/greyscale.c:292: ON_GREY_RENDER();
	call	_animate_board 
;../../lib/greyscale.c:298: __endasm;
;
	ret
;../../lib/greyscale.c:299: }
;../../lib/interupts.c:56: void _________SET_INTERUPTS(){
;	---------------------------------
; Function _________SET_INTERUPTS
; ---------------------------------
__________SET_INTERUPTS::
;../../lib/interupts.c:98: __endasm;
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
;../../lib/interupts.c:99: }
	ret
;../../lib/interupts.c:102: void _____copied_to_position()__naked{
;	---------------------------------
; Function _____copied_to_position
; ---------------------------------
______copied_to_position::
;../../lib/interupts.c:120: __endasm;
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
;../../lib/interupts.c:122: DURING_INTERUPT();
	call	_grey_interupt
;../../lib/interupts.c:149: __endasm;
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
;../../lib/interupts.c:150: ADDED_ON_EXIT();
	ld a, (0x9D88) 
	ld (0x8447), a 
	add a, # 0xD8 
	out (0x10), a 
	ret 
;../../lib/interupts.c:159: __endasm;
	ei
	ret
	  EndLoadInterupt:
;../../lib/interupts.c:160: }
;../../lib/greyscale.c:308: void clearGreyScaleBuffer(){
;	---------------------------------
; Function clearGreyScaleBuffer
; ---------------------------------
_clearGreyScaleBuffer::
;../../lib/greyscale.c:337: __endasm;
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
;../../lib/greyscale.c:338: }
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
	add hl,hl 
	add hl,hl ;Find the Y displacement offset
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
	or	d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	or	e
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
	add hl,hl 
	add hl,hl ;Find the Y displacement offset
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
	or	d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	or	e
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
;main.c:120: void animate_board()__naked{
;	---------------------------------
; Function animate_board
; ---------------------------------
_animate_board::
;main.c:171: __endasm;
	in	a, (4)
	bit	7, a
	ret	z
	ld	a, #0x46
	out	(0x36), a ;128 Hz
	ld	a, #0
	out	(0x37), a
	ld	a, #5
	out	(0x38), a
	ld	hl, #0x983C
	ld	b, #4*4*2
	ld	c, #0
	ld	e, #1
	  ANIM_LOOP:
	ld	a, (hl)
	cp	c
	jp	z, END_OF_ANIM_LOOP
	ld	e, #2
	jp	p, SUB_ANIM
	add	a, #3
	cp	#3
	jp	nc, AFTER_ZERO
	xor	a, a
	jp	AFTER_ZERO
	   SUB_ANIM:
	sub	a, #3
	jp	nc, AFTER_ZERO
	xor	a, a
	   AFTER_ZERO:
	ld	(hl), a
	   END_OF_ANIM_LOOP:
	inc	hl
	djnz	ANIM_LOOP
	dec	e
	ret	z
	ld	(( 0x983C + (4*4*2) +1 )+1), ix
	call	_renderBoard
	ld	ix, (( 0x983C + (4*4*2) +1 )+1)
	ret
;main.c:172: }
;main.c:174: void renderBoard(){
;	---------------------------------
; Function renderBoard
; ---------------------------------
_renderBoard::
;main.c:261: __endasm;
	ld	hl, #0x983C
	push	hl
	pop	ix
	call	_clearGreyScaleBuffer
	ld	hl, #0x84F3
	ld	d, #0
	  X_BOARD_LOOP:
	ld	e, #0
	   Y_BOARD_LOOP:
	ld	b, #0
	ld	c, (hl)
	xor	a, a
	cp	c
	jp	z, AFTER_DRAW
	push	hl
	ld	hl, #__xinit__NUM_DATA
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl, #0x0f02
	push	hl
	xor	a, a
	ld	(0x8478), de
	ld	a, (ix)
	add	d
	cp	#64-15
	jp	nc, AFTER_X_SET_ANIMATION
	ld	d, a
	    AFTER_X_SET_ANIMATION:
	inc	ix
	ld	a, (ix)
	add	e
	cp	#96-15
	jp	nc, AFTER_Y_SET_ANIMATION
	ld	e, a
	    AFTER_Y_SET_ANIMATION:
	inc	ix
	push	de
	call	_greyPutSprite
	ld	de, (0x8478)
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	hl
	    AFTER_DRAW:
	inc	hl
	ld	a, e
	add	a, #14
	ld	e, a
	cp	a, #14*4
	jp	nz, Y_BOARD_LOOP
	ld	a, d
	add	a, #14
	ld	d, a
	cp	a, #14*4
	jp	nz, X_BOARD_LOOP
;main.c:263: }
	ret
_b2_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xc2	; 194
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xc2	; 194
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b4_DATA:
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0xc2	; 194
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0xc2	; 194
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b8_DATA:
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
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b16_DATA:
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
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x9c	; 156
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x62	; 98	'b'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0xe2	; 226
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0xe2	; 226
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b32_DATA:
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xfb	; 251
	.db #0xf7	; 247
	.db #0xfb	; 251
	.db #0xfd	; 253
	.db #0xdd	; 221
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x8e	; 142
	.db #0x76	; 118	'v'
	.db #0xee	; 238
	.db #0xde	; 222
	.db #0xbe	; 190
	.db #0x7e	; 126
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
_b64_DATA:
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xef	; 239
	.db #0xdf	; 223
	.db #0xc3	; 195
	.db #0xdd	; 221
	.db #0xdd	; 221
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xee	; 238
	.db #0xce	; 206
	.db #0xae	; 174
	.db #0x6e	; 110	'n'
	.db #0x06	; 6
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
_b128_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x93	; 147
	.db #0xb0	; 176
	.db #0x91	; 145
	.db #0x92	; 146
	.db #0xbb	; 187
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x3a	; 58
	.db #0xaa	; 170
	.db #0x3a	; 58
	.db #0x2a	; 42
	.db #0xba	; 186
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x93	; 147
	.db #0xb0	; 176
	.db #0x91	; 145
	.db #0x92	; 146
	.db #0xbb	; 187
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x3a	; 58
	.db #0xaa	; 170
	.db #0x3a	; 58
	.db #0x2a	; 42
	.db #0xba	; 186
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b256_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb3	; 179
	.db #0x8a	; 138
	.db #0x93	; 147
	.db #0xa0	; 160
	.db #0xbb	; 187
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x9a	; 154
	.db #0x22	; 34
	.db #0x3a	; 58
	.db #0xaa	; 170
	.db #0x3a	; 58
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb3	; 179
	.db #0x8a	; 138
	.db #0x93	; 147
	.db #0xa0	; 160
	.db #0xbb	; 187
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x9a	; 154
	.db #0x22	; 34
	.db #0x3a	; 58
	.db #0xaa	; 170
	.db #0x3a	; 58
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b512_DATA:
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
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb9	; 185
	.db #0xa3	; 163
	.db #0xb1	; 177
	.db #0x89	; 137
	.db #0xb3	; 179
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x32	; 50	'2'
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x22	; 34
	.db #0xba	; 186
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b1024_DATA:
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
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xa4	; 164
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xf4	; 244
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xd2	; 210
	.db #0x36	; 54	'6'
	.db #0x5e	; 94
	.db #0x86	; 134
	.db #0xe6	; 230
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_b2048_DATA:
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9a	; 154
	.db #0xe4	; 228
	.db #0xd4	; 212
	.db #0xb5	; 181
	.db #0x8b	; 139
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xe2	; 226
	.db #0xaa	; 170
	.db #0x22	; 34
	.db #0xaa	; 170
	.db #0xa2	; 162
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
_b4096_DATA:
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
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xa5	; 165
	.db #0x85	; 133
	.db #0xe5	; 229
	.db #0xeb	; 235
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x12	; 18
	.db #0x4e	; 78	'N'
	.db #0x02	; 2
	.db #0xca	; 202
	.db #0x22	; 34
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
_b8192_DATA:
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf4	; 244
	.db #0xdc	; 220
	.db #0xf4	; 244
	.db #0xd4	; 212
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfa	; 250
	.db #0xa6	; 166
	.db #0xea	; 234
	.db #0x32	; 50	'2'
	.db #0xde	; 222
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf4	; 244
	.db #0xdc	; 220
	.db #0xf4	; 244
	.db #0xd4	; 212
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfa	; 250
	.db #0xa6	; 166
	.db #0xea	; 234
	.db #0x32	; 50	'2'
	.db #0xde	; 222
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xfe	; 254
_scoreboard_DATA:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x9e	; 158
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x71	; 113	'q'
	.db #0x91	; 145
	.db #0x22	; 34
	.db #0x18	; 24
	.db #0x89	; 137
	.db #0x81	; 129
	.db #0x22	; 34
	.db #0x18	; 24
	.db #0x89	; 137
	.db #0x81	; 129
	.db #0x22	; 34
	.db #0x28	; 40
	.db #0x89	; 137
	.db #0x82	; 130
	.db #0x22	; 34
	.db #0x48	; 72	'H'
	.db #0x71	; 113	'q'
	.db #0x84	; 132
	.db #0x22	; 34
	.db #0x48	; 72	'H'
	.db #0x89	; 137
	.db #0x88	; 136
	.db #0x22	; 34
	.db #0xfe	; 254
	.db #0x89	; 137
	.db #0x90	; 144
	.db #0x22	; 34
	.db #0x08	; 8
	.db #0x89	; 137
	.db #0x9f	; 159
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0xf1	; 241
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xa2	; 162
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xa2	; 162
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xb9	; 185
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xa9	; 169
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xb9	; 185
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xb9	; 185
	.db #0x0e	; 14
	.db #0x94	; 148
	.db #0x71	; 113	'q'
	.db #0xa8	; 168
	.db #0x10	; 16
	.db #0xa4	; 164
	.db #0x41	; 65	'A'
	.db #0xa9	; 169
	.db #0x20	; 32
	.db #0xc4	; 196
	.db #0x41	; 65	'A'
	.db #0xa9	; 169
	.db #0x20	; 32
	.db #0xc4	; 196
	.db #0x71	; 113	'q'
	.db #0xb9	; 185
	.db #0x20	; 32
	.db #0xa4	; 164
	.db #0x41	; 65	'A'
	.db #0xa1	; 161
	.db #0x10	; 16
	.db #0xa4	; 164
	.db #0x41	; 65	'A'
	.db #0xa1	; 161
	.db #0x0e	; 14
	.db #0x97	; 151
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
;main.c:265: void set(){
;	---------------------------------
; Function set
; ---------------------------------
_set::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;main.c:274: __endasm;
	ld	a, #0
	ld	hl, #0x983C
	ld	(hl), a
	ld	de, #0x983C +1
	ld	bc, #32
	ldir
;main.c:275: char* dataLoc=getOrCreateVar(dataName, 20)+2; 
	ld	hl, #0x0014
	push	hl
	ld	hl, #___str_1
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	inc	hl
	inc	hl
;main.c:277: if (!(dataLoc[0] == 0x69 && dataLoc[3] == 0x69)){
	ld	a, (hl)
	ld	-3 (ix), a
	ld	e, l
	ld	d, h
	inc	de
	inc	de
	inc	de
;main.c:279: dataLoc[1] = 0x9F;
	ld	c, l
	ld	b, h
	inc	bc
;main.c:280: dataLoc[2] = 0x15;
	ld	a, l
	add	a, #0x02
	ld	-2 (ix), a
	ld	a, h
	adc	a, #0x00
	ld	-1 (ix), a
;main.c:277: if (!(dataLoc[0] == 0x69 && dataLoc[3] == 0x69)){
	ld	a, -3 (ix)
	sub	a, #0x69
	jr	NZ, 00101$
	ld	a, (de)
	sub	a, #0x69
	jr	Z, 00102$
00101$:
;main.c:278: dataLoc[0] = 0x69;
	ld	(hl), #0x69
;main.c:279: dataLoc[1] = 0x9F;
	ld	a, #0x9f
	ld	(bc), a
;main.c:280: dataLoc[2] = 0x15;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), #0x15
;main.c:281: dataLoc[3] = 0x69;
	ld	a, #0x69
	ld	(de), a
00102$:
;main.c:283: *(char*)(0x85A6) = dataLoc[1];
	ld	a, (bc)
	ld	(#0x85a6),a
;main.c:284: *(char*)(0x85A6+1) = dataLoc[2];
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	(#0x85a7),a
;main.c:290: getOrCreateVar(gameName, 20); 
	ld	hl, #0x0014
	push	hl
	ld	hl, #___str_2
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
;main.c:313: __endasm;
	inc	hl
	inc	hl
	ld	a, (hl)
	cp	#0x69
	jp	nz, NOT_RIGHT
	ld	de, #0x84F3
	ld	bc, #20
	ldir
	ld	sp, ix
	pop	ix
	ret
	  NOT_RIGHT:
	xor	a, a
	ld	hl, #0x84F3
	ld	(hl), a
	ld	de, #0x84F3 +1
	ld	bc, #19
	ldir
;main.c:315: }
	ld	sp, ix
	pop	ix
	ret
___str_1:
	.db 0x15
	.ascii "gryCfg"
	.db 0x00
___str_2:
	.db 0x15
	.ascii "v2048s"
	.db 0x00
;main.c:317: void random_spawn(){
;	---------------------------------
; Function random_spawn
; ---------------------------------
_random_spawn::
;main.c:376: __endasm;
	ld	a, r
	ld	b, #2
	and	a, #3
	jp	z, AFTER_SET
	dec	b
	  AFTER_SET:
	ld	e, #18
	  RAND_TILE_SPAWN_LOOP:
	push	bc
	   AFTER_PUSH_IN_RAND_TILE_SPAWN_LOOP:
	dec	e
	jp	z, END_OF_RAND
	ld	b, #0
	ld	a, r
	and	a, #0x0F
	ld	c, a
	ld	hl, #0x84F3
	add	hl, bc
	ld	a, (hl)
	inc	a
	dec	a
	jp	nz, AFTER_PUSH_IN_RAND_TILE_SPAWN_LOOP
	ld	a, r
	rrca
	rrca
	rrca
	ld	b, #1
	and	a, #0b00000111
	jp	nz, ON_SET_STUFF
	inc	b
	   ON_SET_STUFF:
	ld	(hl), b
	pop	bc
	djnz	RAND_TILE_SPAWN_LOOP
	push	bc
	   END_OF_RAND:
	pop	bc
;main.c:377: }
	ret
;main.c:381: void moveAlong(char* (*direction)(char,char), char aoff, char aoff2)
;	---------------------------------
; Function moveAlong
; ---------------------------------
_moveAlong::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;main.c:383: for (char slice = 0; slice != 4; ++slice) {
	ld	-2 (ix), #0
00125$:
	ld	a, -2 (ix)
	sub	a, #0x04
	jp	Z,00126$
;main.c:384: char redoFlag = 0;
	ld	-5 (ix), #0
;main.c:386: for (char j = 1; j != 4; j++){
00133$:
	ld	-1 (ix), #0x01
00119$:
	ld	a, -1 (ix)
	sub	a, #0x04
	jr	Z, 00106$
;main.c:387: char* v = direction(slice, j);
	ld	h, -1 (ix)
	ld	l, -2 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	call	___sdcc_call_hl
	pop	af
	ex	de, hl
;main.c:388: char* v2 = direction(slice, j-1);
	ld	a, -1 (ix)
	dec	a
	push	de
	push	af
	inc	sp
	ld	a, -2 (ix)
	push	af
	inc	sp
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	call	___sdcc_call_hl
	pop	af
	ld	c, l
	ld	b, h
	pop	de
;main.c:389: if (*v2 == 0){
	ld	-4 (ix), c
	ld	-3 (ix), b
	ld	l, c
	ld	h, b
	ld	a, (hl)
	or	a, a
	jr	NZ, 00120$
;main.c:390: if (*v != 0){
	ld	a, (de)
	or	a, a
	jr	Z, 00120$
;main.c:395: *v2 = *v;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
;main.c:396: *v = 0;
	xor	a, a
	ld	(de), a
;main.c:398: moved_flag = 1;
	ld	hl, #0x9861
	ld	(hl), #0x01
;main.c:399: goto TOP;
	jr	00133$
00120$:
;main.c:386: for (char j = 1; j != 4; j++){
	inc	-1 (ix)
	jr	00119$
00106$:
;main.c:404: if (redoFlag == 2) continue ; 
	ld	a, -5 (ix)
	sub	a, #0x02
	jr	Z, 00116$
;main.c:405: for (char j = 1; j != 4; j++){
	ld	b, #0x01
00122$:
	ld	a, b
	sub	a, #0x04
	jr	Z, 00113$
;main.c:406: char* v = direction(slice, j);
	push	bc
	push	bc
	inc	sp
	ld	a, -2 (ix)
	push	af
	inc	sp
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	call	___sdcc_call_hl
	pop	af
	ex	de, hl
	pop	bc
	ld	-4 (ix), e
	ld	-3 (ix), d
;main.c:407: char* v2 = direction(slice, j-1);
	ld	a, b
	dec	a
	push	bc
	push	af
	inc	sp
	ld	a, -2 (ix)
	push	af
	inc	sp
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	call	___sdcc_call_hl
	pop	af
	ex	de, hl
	pop	bc
;main.c:408: if (*v2 != 0){
	ld	a, (de)
	or	a, a
	jr	Z, 00123$
;main.c:409: if (*v == *v2){
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	cp	a, c
	jr	NZ, 00123$
;main.c:410: *v2 +=1;
	inc	a
	ld	(de), a
;main.c:411: *v = 0;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), #0x00
;main.c:412: redoFlag = 1;
	ld	-5 (ix), #0x01
;main.c:413: moved_flag = 1;
	ld	hl, #0x9861
	ld	(hl), #0x01
00123$:
;main.c:405: for (char j = 1; j != 4; j++){
	inc	b
	jr	00122$
00113$:
;main.c:418: if (redoFlag == 1){
	ld	a, -5 (ix)
	dec	a
	jr	NZ, 00116$
;main.c:419: redoFlag = 2;
	ld	-5 (ix), #0x02
;main.c:420: goto TOP;
	jp	00133$
00116$:
;main.c:383: for (char slice = 0; slice != 4; ++slice) {
	inc	-2 (ix)
	jp	00125$
00126$:
;main.c:428: }
	ld	sp, ix
	pop	ix
	ret
;main.c:429: char* toTheRight(char slice, char element)
;	---------------------------------
; Function toTheRight
; ---------------------------------
_toTheRight::
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:431: slice+=slice;
	sla	4 (ix)
;main.c:432: slice+=slice;
	sla	4 (ix)
;main.c:433: return gameData + slice+element;
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	hl, #0x84f3
	add	hl, bc
	ex	de, hl
	ld	l, 5 (ix)
	ld	h, #0x00
	add	hl, de
;main.c:434: }
	pop	ix
	ret
;main.c:436: char*  toTheLeft(char slice, char element)
;	---------------------------------
; Function toTheLeft
; ---------------------------------
_toTheLeft::
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:438: return toTheRight(slice, 4-1-element);
	ld	c, 5 (ix)
	ld	a, #0x03
	sub	a, c
	push	af
	inc	sp
	ld	a, 4 (ix)
	push	af
	inc	sp
	call	_toTheRight
	pop	af
;main.c:439: }
	pop	ix
	ret
;main.c:441: char*  upwards(char slice, char element)
;	---------------------------------
; Function upwards
; ---------------------------------
_upwards::
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:443: return toTheRight(4 - 1 - element, slice);
	ld	c, 5 (ix)
	ld	a, #0x03
	sub	a, c
	ld	h, 4 (ix)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_toTheRight
	pop	af
;main.c:445: }
	pop	ix
	ret
;main.c:447: char*  downwards(char slice, char element)
;	---------------------------------
; Function downwards
; ---------------------------------
_downwards::
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:449: return toTheRight(element, slice);
	ld	h, 4 (ix)
	ld	l, 5 (ix)
	push	hl
	call	_toTheRight
	pop	af
;main.c:450: }
	pop	ix
	ret
;main.c:453: void real_main(){
;	---------------------------------
; Function real_main
; ---------------------------------
_real_main::
;main.c:454: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:455: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:461: set();
	call	_set
;main.c:462: random_spawn();
	call	_random_spawn
;main.c:464: renderBoard();
	call	_renderBoard
;main.c:468: INIT_GREYSCALE();
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
;main.c:476: __endasm;
	ld	a, #0x46
	out	(0x36), a ;128 Hz
	ld	a, #0
	out	(0x37), a
	ld	a, #13
	out	(0x38), a
;main.c:478: *(char*)WAIT_LOC = *(char*)(0x85A6);
	ld	a, (#0x85a6)
	ld	hl, #0x85be
	ld	(hl), a
;main.c:479: *(char*)CONTRAST_LOC = *(char*)(0x85A6+1);
	ld	l, #0xa7
	ld	a, (hl)
	ld	(#0x85bf),a
;main.c:481: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:484: *((char*)MAX_COL)=8;
	ld	hl, #0x85c5
	ld	(hl), #0x08
;main.c:486: *((char*)START_ROW) = ROW_CONST+3;
	ld	l, #0xc2
	ld	(hl), #0x83
;main.c:487: *((char*)END_ROW) = ROW_END_CONST-3;
	ld	l, #0xc3
	ld	(hl), #0xbc
;main.c:488: score_changed = 1;
	ld	hl, #0x985d
	ld	(hl), #0x01
;main.c:489: while (1){
00126$:
;main.c:490: wait(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_wait
	inc	sp
;main.c:495: if (score_changed != 0){
	ld	hl, #0x985d
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;main.c:496: __asm di __endasm;
	di	
;main.c:497: swap(); 
	call	_swap
;main.c:499: __asm ei __endasm;
	ei	
;main.c:507: __endasm;
	ld	a, #15
	ld	(#0x86D8), a
	ld	a, #67
	ld	(#0x86D7), a
	push	ix
;main.c:508: fputs("Score:");
	ld	hl, #___str_3
	push	hl
	call	_fputs
	pop	af
;main.c:514: __endasm;
	ld	a, #15+8
	ld	(#0x86D8), a
	ld	a, #67
	ld	(#0x86D7), a
;main.c:515: number(1234);
	ld	hl, #0x04d2
	push	hl
	call	_number
	pop	af
;main.c:521: __endasm;
	ld	a, #15+8+8
	ld	(#0x86D8), a
	ld	a, #67
	ld	(#0x86D7), a
;main.c:523: fputs("Time:");
	ld	hl, #___str_4
	push	hl
	call	_fputs
	pop	af
;main.c:530: __endasm;
	ld	a, #15+8+8+8
	ld	(#0x86D8), a
	ld	a, #67
	ld	(#0x86D7), a
;main.c:531: number(1234);
	ld	hl, #0x04d2
	push	hl
	call	_number
	pop	af
;main.c:536: __endasm;
	pop	ix
;main.c:537: score_changed = 1;
	ld	hl, #0x985d
	ld	(hl), #0x01
00102$:
;main.c:541: moved_flag = 0;
	ld	hl, #0x9861
	ld	(hl), #0x00
;main.c:542: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:543: if (skClear == lastPressedKey())
	ld	hl, #0x843f
	ld	a, (hl)
	cp	a, #0x0f
	jp	Z,00127$
;main.c:545: else if (skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00118$
;main.c:546: moveAlong(&toTheRight, 1, 14);
	ld	de, #0x0e01
	push	de
	ld	hl, #_toTheRight
	push	hl
	call	_moveAlong
	pop	af
	pop	af
	jr	00122$
00118$:
;main.c:549: else if (skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00115$
;main.c:550: moveAlong(&toTheLeft, 1, -14);
	ld	de, #0xf201
	push	de
	ld	hl, #_toTheLeft
	push	hl
	call	_moveAlong
	pop	af
	pop	af
	jr	00122$
00115$:
;main.c:553: else if (skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00112$
;main.c:554: moveAlong(&downwards, 0, 14);
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_downwards
	push	hl
	call	_moveAlong
	pop	af
	pop	af
	jr	00122$
00112$:
;main.c:557: else if (skDown == lastPressedKey()){
	cp	a, #0x01
	jr	NZ, 00109$
;main.c:558: moveAlong(&upwards, 0, -14);
	ld	a, #0xf2
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_upwards
	push	hl
	call	_moveAlong
	pop	af
	pop	af
	jr	00122$
00109$:
;main.c:561: else if (sk1 == lastPressedKey()){
	cp	a, #0x22
	jr	NZ, 00106$
;main.c:569: __endasm;
	ld	a, #-15
	ld	hl, #0x983C
	ld	(hl), a
	ld	de, #0x983C +1
	ld	bc, #32
	ldir
	jr	00122$
00106$:
;main.c:572: else if (skMode == lastPressedKey()){
	sub	a, #0x37
	jr	NZ, 00122$
;main.c:573: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:574: calibration_loop();
	call	_calibration_loop
;main.c:575: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:576: clearGreyScaleBuffer();
	call	_clearGreyScaleBuffer
00122$:
;main.c:580: if (moved_flag == 1){
	ld	a, (#0x9861)
	dec	a
	jp	NZ,00126$
;main.c:581: random_spawn();
	call	_random_spawn
;main.c:584: __endasm;
	push	ix
;main.c:585: renderBoard();
	call	_renderBoard
;main.c:588: __endasm;
	pop	ix
	jp	00126$
00127$:
;main.c:593: archive(dataName);
	ld	hl, #___str_5
	push	hl
	call	_archive
	pop	af
;main.c:596: }
	ret
___str_3:
	.ascii "Score:"
	.db 0x00
___str_4:
	.ascii "Time:"
	.db 0x00
___str_5:
	.db 0x15
	.ascii "gryCfg"
	.db 0x00
;main.c:598: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:599: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:600: resetPen();
	call	_resetPen
;main.c:603: real_main();
;main.c:609: }
	jp	_real_main
	.area _CODE
	.area _INITIALIZER
__xinit__NUM_DATA:
	.dw #0x0000
	.dw _b2_DATA
	.dw _b4_DATA
	.dw _b8_DATA
	.dw _b16_DATA
	.dw _b32_DATA
	.dw _b64_DATA
	.dw _b128_DATA
	.dw _b256_DATA
	.dw _b512_DATA
	.dw _b1024_DATA
	.dw _b2048_DATA
	.dw _b4096_DATA
	.dw _b8192_DATA
	.area _CABS (ABS)
