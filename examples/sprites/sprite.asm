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
	.globl _fullPutSprite
	.globl _ionPutSprite
	.globl _wait
	.globl _vertical_dotted_line
	.globl _vertical_line
	.globl _swap
	.globl _clearBuffer
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _cross_DATA
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
;../../lib/graphics.c:86: void clearBuffer(){
;	---------------------------------
; Function clearBuffer
; ---------------------------------
_clearBuffer::
;../../lib/graphics.c:107: __endasm;
	DI
	LD	(0x980C), SP
	LD	SP, #0x9340 + 768 ; 768 byte area
	LD	HL, #0x0000
	LD	B, #48 ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
	        CLEAR_LOOP:
	PUSH	HL ; Do multiple PUSHes in the loop to save cycles
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	PUSH	HL
	DJNZ	CLEAR_LOOP
	LD	SP, (0x980C)
	EI
;../../lib/graphics.c:108: }
	ret
;../../lib/graphics.c:114: void swap(){
;	---------------------------------
; Function swap
; ---------------------------------
_swap::
;../../lib/graphics.c:155: __endasm;
	di
	ld	hl, #0x9340
	CALL	0x000B
	LD	A, #0x07 ; set y inc moce
	OUT	(0x10), A
	LD	c, #0x80
	 YLOOPR__:
	CALL	0x000B ; set row
	LD	A, c
	OUT	(0x10), A
	CALL	0x000B
	LD	A, #0x20 ; reset col
	OUT	(0x10), A
	ld	b, #12
	 XLOOPR__:
	CALL	0x000B
	ld	a, (hl)
	out	(0x11), a
	inc	hl
	djnz	XLOOPR__
	inc	c
	ld	a, c
	cp	#0xBF
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
	ld	hl,#0x9340
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
	ld	hl,#0x9340
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
	add	hl,de 
	add hl,de 
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
	xor	d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	xor	e
	ld	(hl),a ;copy to buffer using XOR logic
	ld	de,#12 -1
	add	hl,de
	inc	ix ;Set for next byte of image
	djnz	putSpriteLoop1
	ret
;../../lib/spritemanager.c:84: }
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
;main.c:18: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:20: clearScreen(); // prepare screen
	rst	40 
	.dw 0x4540 
;main.c:21: signed char x = 20, y = 20;
	ld	bc, #0x1414
;main.c:22: while (1){
00120$:
;main.c:24: clearBuffer(); // clear drawing buffer
	push	bc
	call	_clearBuffer
	pop	bc
;main.c:25: fullPutSprite(x, y, cross_WIDTH, cross_HEIGHT, cross_DATA);
	push	bc
	ld	hl, #_cross_DATA
	push	hl
	ld	de, #0x2004
	push	de
	push	bc
	call	_fullPutSprite
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	call	_swap
	pop	bc
;main.c:27: if (skClear == lastPressedKey()){
	ld	hl, #0x843f
	ld	a, (hl)
	cp	a, #0x0f
	jr	Z, 00121$
;main.c:30: else if(skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00114$
;main.c:31: x-=1;
	dec	c
	jr	00120$
00114$:
;main.c:33: else if(skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00111$
;main.c:34: x+=1;
	inc	c
	jr	00120$
00111$:
;main.c:36: else if(skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00108$
;main.c:37: y-=1;
	dec	b
;main.c:38: if (y < 0)
	bit	7, b
	jr	Z, 00120$
;main.c:39: y =0;
	ld	b, #0x00
	jr	00120$
00108$:
;main.c:42: else if(skDown == lastPressedKey()){
	dec	a
	jr	NZ, 00120$
;main.c:43: y+=1;
	inc	b
;main.c:44: if (y > YMAX-cross_HEIGHT)
	ld	a, #0x20
	sub	a, b
	jp	PO, 00173$
	xor	a, #0x80
00173$:
	jp	P, 00120$
;main.c:45: y = YMAX-cross_HEIGHT;
	ld	b, #0x20
	jr	00120$
00121$:
;main.c:52: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:54: }
	ret
_cross_DATA:
	.db #0xc0	; 192
	.db #0x41	; 65	'A'
	.db #0x21	; 33
	.db #0x13	; 19
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0x23	; 35
	.db #0x13	; 19
	.db #0x0b	; 11
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x84	; 132
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xc8	; 200
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x01	; 1
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
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
