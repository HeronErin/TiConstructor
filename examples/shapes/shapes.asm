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
	.globl _circle
	.globl _drawCircleSegment
	.globl _setPix
	.globl _line
	.globl _swap
	.globl _clearBuffer
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _getKeyId
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
;../../lib/essentials.c:32: char getKeyId(){
;	---------------------------------
; Function getKeyId
; ---------------------------------
_getKeyId::
;../../lib/essentials.c:33: bcall(_kdbScan);
	rst	40 
	.dw 0x4015 
;../../lib/essentials.c:34: return *(char*)(kbdScanCode);
	ld	hl, #0x843f
	ld	l, (hl)
;../../lib/essentials.c:35: }
	ret
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
	ld	a, #0x00
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
;../../lib/graphics.c:12: void clearBuffer(){
;	---------------------------------
; Function clearBuffer
; ---------------------------------
_clearBuffer::
;../../lib/graphics.c:33: __endasm;
	DI
	LD	(0x9872), SP
	LD	SP, #0x9340 + 768 ; 768 byte area
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
	LD	SP, (0x9872)
	EI
;../../lib/graphics.c:34: }
	ret
;../../lib/graphics.c:37: void swap(){
;	---------------------------------
; Function swap
; ---------------------------------
_swap::
;../../lib/graphics.c:78: __endasm;
	di
	ld	hl, #0x9340
	CALL	0x000B
	LD	A, #0x07 ; set y inc moce
	OUT	(0x10), A
	LD	c, #0x80
	 YLOOPR:
	CALL	0x000B ; set row
	LD	A, c
	OUT	(0x10), A
	CALL	0x000B
	LD	A, #0x20 ; reset col
	OUT	(0x10), A
	ld	b, #12
	 XLOOPR:
	CALL	0x000B
	ld	a, (hl)
	out	(0x11), a
	inc	hl
	djnz	XLOOPR
	inc	c
	ld	a, c
	cp	#0xBF
	jp	nz, YLOOPR
	ei
;../../lib/graphics.c:80: }
	ret
;../../lib/graphics.c:86: void line(char x, char y, char x2, char y2) __naked{
;	---------------------------------
; Function line
; ---------------------------------
_line::
;../../lib/graphics.c:361: __endasm;
;	prep vars
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	ld	c, d
	ld	d, e
	ld	e, c
	ld	c, h
	ld	h, l
	ld	l, c
	di
	ld	(0x9872),sp
	ld	a,h
	cp	d
	jp	nc,noswapx
	ex	de,hl
	  noswapx:
	ld	a,h
	sub	d
	jp	nc,posx
	neg
	  posx:
	ld	b,a
	ld	a,l
	sub	e
	jp	nc,posY
	neg
	  posY:
	ld	c,a
	ld	a,l
	ld	hl,#-12
	cp	e
	jp	c,lineup
	ld	hl,#12
	  lineup:
	ld	ix,#xbit
	ld	a,b
	cp	c
	jp	nc,xline
	ld	b,c
	ld	c,a
	ld	ix,#ybit
	  xline:
	push	hl
	ld	a,d
	ld	d,#0
	ld	h,d
	sla	e
	sla	e
	ld	l,e
	add	hl,de
	add	hl,de
	ld	e,a
	and	#7 ; %00000111
	srl	e
	srl	e
	srl	e
	add	hl,de
	ld	de,#0x9340
	add	hl,de
	add	a,a
	ld	e,a
	ld	d,#0
	add	ix,de
	ld	e,(ix)
	ld	d,1(ix)
	push	de
	pop	ix
	pop	de
	ex	de,hl
	ld	sp,hl
	ex	de,hl
	ld	d,b
	ld	e,c
	ld	a,d
	srl	a
	inc	b
	jp	(ix)
	  lineret:
	ld	sp,(0x9872)
	ret
	  xbit:
	.dw	drawx0,drawx1,drawx2,drawx3
	.dw	drawx4,drawx5,drawx6,drawx7
	  ybit:
	.dw	drawY0,drawY1,drawY2,drawY3
	.dw	drawY4,drawY5,drawy6,drawy7
	  drawx0:
	set	7,(hl)
	add	a,e
	cp	d
	  _89qt23:
	jp c,_89qt23+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx1
	jp	lineret
	  drawx1:
	set	6,(hl)
	add	a,e
	cp	d
	  _7342:
	jp c,_7342+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx2
	jp	lineret
	  drawx2:
	set	5,(hl)
	add	a,e
	cp	d
	  _82934:
	jp c,_82934+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx3
	jp	lineret
	  drawx3:
	set	4,(hl)
	add	a,e
	cp	d
	  _8027523:
	jp c,_8027523+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx4
	jp	lineret
	  drawx4:
	set	3,(hl)
	add	a,e
	cp	d
	  _12489:
	jp c,_12489+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx5
	jp	lineret
	  drawx5:
	set	2,(hl)
	add	a,e
	cp	d
	  _8492348:
	jp c,_8492348+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx6
	jp	lineret
	  drawx6:
	set	1,(hl)
	add	a,e
	cp	d
	  _72834:
	jp c,_72834+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx7
	jp	lineret
	  drawx7:
	set	0,(hl)
	inc	hl
	add	a,e
	cp	d
	  _8294:
	jp c,#_8294+3+1+1
	add	hl,sp
	sub	d
	djnz	drawx0
	jp	lineret
	  drawY0_:
	inc	hl
	sub	d
	dec	b
	jp	z,lineret
	  drawY0:
	set	7,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY1_
	djnz	drawY0
	jp	lineret
	  drawY1_:
	sub	d
	dec	b
	jp	z,lineret
	  drawY1:
	set	6,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY2_
	djnz	drawY1
	jp	lineret
	  drawY2_:
	sub	d
	dec	b
	jp	z,lineret
	  drawY2:
	set	5,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY3_
	djnz	drawY2
	jp	lineret
	  drawY3_:
	sub	d
	dec	b
	jp	z,lineret
	  drawY3:
	set	4,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY4_
	djnz	drawY3
	jp	lineret
	  drawY4_:
	sub	d
	dec	b
	jp	z,lineret
	  drawY4:
	set	3,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY5_
	djnz	drawY4
	jp	lineret
	  drawY5_:
	sub	d
	dec	b
	jp	z,lineret
	  drawY5:
	set	2,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawy6_
	djnz	drawY5
	jp	lineret
	  drawy6_:
	sub	d
	dec	b
	jp	z,lineret
	  drawy6:
	set	1,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawy7_
	djnz	drawy6
	jp	lineret
	  drawy7_:
	sub	d
	dec	b
	jp	z,lineret
	  drawy7:
	set	0,(hl)
	add	hl,sp
	add	a,e
	cp	d
	jp	nc,drawY0_
	djnz	drawy7
	jp	lineret
;../../lib/graphics.c:362: }
;../../lib/graphics.c:374: void setPix(char x, char y){
;	---------------------------------
; Function setPix
; ---------------------------------
_setPix::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;../../lib/graphics.c:375: *(char*)((((int)y)* (XMAX/8) )+(x/8)+SCREEN_BUFFER)|=128>>(x%8);
	ld	c, 5 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	l, c
	ld	a,b
	ld	h,a
	rlca
	and	a,#0x01
	ld	-5 (ix), a
	ld	a, c
	add	a, #0x07
	ld	-4 (ix), a
	ld	a, b
	adc	a, #0x00
	ld	-3 (ix), a
	ld	a, -5 (ix)
	or	a, a
	jr	Z, 00103$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
00103$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	add	hl, de
	ld	a, l
	add	a, #0x40
	ld	l, a
	ld	a, h
	adc	a, #0x93
	ld	-2 (ix), l
	ld	-1 (ix), a
	ld	l, c
	ld	h, b
	ld	a, -5 (ix)
	or	a, a
	jr	Z, 00104$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
00104$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	add	hl, de
	ld	de, #0x9340
	add	hl, de
	ld	e, (hl)
	ld	a, c
	and	a, #0x07
	ld	l, a
	ld	bc, #0x0080
	inc	l
	jr	00116$
00115$:
	sra	b
	rr	c
00116$:
	dec	l
	jr	NZ, 00115$
	ld	a, c
	or	a, e
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), a
;../../lib/graphics.c:376: }
	ld	sp, ix
	pop	ix
	ret
;../../lib/graphics.c:390: void drawCircleSegment(char xc, char yc, char x, char y)
;	---------------------------------
; Function drawCircleSegment
; ---------------------------------
_drawCircleSegment::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/graphics.c:392: setPix(xc+x, yc+y);
	ld	a, 5 (ix)
	add	a, 7 (ix)
	ld	d, a
	ld	a, 4 (ix)
	add	a, 6 (ix)
	ld	e, a
	push	de
	push	de
	call	_setPix
	pop	af
	pop	de
;../../lib/graphics.c:393: setPix(xc-x, yc+y);
	ld	a, 4 (ix)
	sub	a, 6 (ix)
	ld	c, a
	push	bc
	push	de
	ld	e, c
	push	de
	call	_setPix
	pop	af
	pop	de
	pop	bc
;../../lib/graphics.c:394: setPix(xc+x, yc-y);
	ld	a, 5 (ix)
	sub	a, 7 (ix)
	ld	b, a
	push	bc
	ld	c, e
	push	bc
	call	_setPix
	pop	af
	call	_setPix
	pop	af
;../../lib/graphics.c:396: setPix(xc+y, yc+x);
	ld	a, 5 (ix)
	add	a, 6 (ix)
	ld	d, a
	ld	a, 4 (ix)
	add	a, 7 (ix)
	ld	e, a
	push	de
	push	de
	call	_setPix
	pop	af
	pop	de
;../../lib/graphics.c:397: setPix(xc-y, yc+x);
	ld	a, 4 (ix)
	sub	a, 7 (ix)
	ld	c, a
	push	bc
	push	de
	ld	e, c
	push	de
	call	_setPix
	pop	af
	pop	de
	pop	bc
;../../lib/graphics.c:398: setPix(xc+y, yc-x);
	ld	a, 5 (ix)
	sub	a, 6 (ix)
	ld	b, a
	push	bc
	ld	c, e
	push	bc
	call	_setPix
	pop	af
	call	_setPix
	pop	af
;../../lib/graphics.c:400: }
	pop	ix
	ret
;../../lib/graphics.c:404: void circle(char xc, char yc, char r)
;	---------------------------------
; Function circle
; ---------------------------------
_circle::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../../lib/graphics.c:406: char x = 0, y = r;
	ld	b, 6 (ix)
;../../lib/graphics.c:407: drawCircleSegment(xc, yc, x, y);
	push	bc
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	h, 5 (ix)
	ld	l, 4 (ix)
	push	hl
	call	_drawCircleSegment
	pop	af
	pop	af
	pop	bc
;../../lib/graphics.c:408: int d = 3 - 2 * r;
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	ld	a, #0x03
	sub	a, l
	ld	c, a
	ld	a, #0x00
	sbc	a, h
	ld	d, a
;../../lib/graphics.c:409: while (y >= x)
	ld	e, #0x00
00104$:
	ld	a, b
	sub	a, e
	jr	C, 00107$
;../../lib/graphics.c:414: x++;
	inc	e
;../../lib/graphics.c:422: d = d + 4 * (x - y) + 10;
	ld	-2 (ix), e
	ld	-1 (ix), #0
;../../lib/graphics.c:419: if (d > 0)
	xor	a, a
	cp	a, c
	sbc	a, d
	jp	PO, 00125$
	xor	a, #0x80
00125$:
	jp	P, 00102$
;../../lib/graphics.c:421: y--;
	dec	b
;../../lib/graphics.c:422: d = d + 4 * (x - y) + 10;
	ld	l, b
	ld	h, #0x00
	ld	a, -2 (ix)
	sub	a, l
	ld	l, a
	ld	a, -1 (ix)
	sbc	a, h
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, c
	ld	c, a
	ld	a, h
	adc	a, d
	ld	d, a
	ld	a, c
	add	a, #0x0a
	ld	c, a
	jr	NC, 00103$
	inc	d
	jr	00103$
00102$:
;../../lib/graphics.c:425: d = d + 4 * x + 6;
	pop	hl
	push	hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, c
	ld	c, a
	ld	a, h
	adc	a, d
	ld	d, a
	ld	a, c
	add	a, #0x06
	ld	c, a
	jr	NC, 00127$
	inc	d
00127$:
00103$:
;../../lib/graphics.c:426: drawCircleSegment(xc, yc, x, y);
	push	bc
	push	de
	ld	c, e
	push	bc
	ld	h, 5 (ix)
	ld	l, 4 (ix)
	push	hl
	call	_drawCircleSegment
	pop	af
	pop	af
	pop	de
	pop	bc
	jr	00104$
00107$:
;../../lib/graphics.c:428: }
	ld	sp, ix
	pop	ix
	ret
;main.c:8: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:10: clearScreen(); // prepare screen
	rst	40 
	.dw 0x4540 
;main.c:11: clearBuffer(); // clear drawing buffer
	call	_clearBuffer
;main.c:14: line(15, 20, 5, 40);
	ld	de, #0x2805
	push	de
	ld	de, #0x140f
	push	de
	call	_line
	pop	af
	pop	af
;main.c:15: line(15, 20, 25, 40);
	ld	de, #0x2819
	push	de
	ld	de, #0x140f
	push	de
	call	_line
	pop	af
	pop	af
;main.c:16: line(5, 40, 25, 40);
	ld	de, #0x2819
	push	de
	ld	de, #0x2805
	push	de
	call	_line
	pop	af
	pop	af
;main.c:19: line(3, 5, 3, 20);
	ld	de, #0x1403
	push	de
	ld	de, #0x0503
	push	de
	call	_line
	pop	af
	pop	af
;main.c:20: line(10, 5, 10, 20);
	ld	de, #0x140a
	push	de
	ld	de, #0x050a
	push	de
	call	_line
	pop	af
	pop	af
;main.c:21: line(3, 5, 10, 5);
	ld	de, #0x050a
	push	de
	ld	de, #0x0503
	push	de
	call	_line
	pop	af
	pop	af
;main.c:22: line(3, 20, 10, 20);
	ld	de, #0x140a
	push	de
	ld	de, #0x1403
	push	de
	call	_line
	pop	af
	pop	af
;main.c:30: line(X1, Y1, X2, Y1);
	ld	de, #0x1832
	push	de
	ld	de, #0x181e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:31: line(X1, Y2, X2, Y2);
	ld	de, #0x2c32
	push	de
	ld	de, #0x2c1e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:32: line(X1, Y1, X1, Y2);
	ld	de, #0x2c1e
	push	de
	ld	de, #0x181e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:33: line(X2, Y1, X2, Y2);
	ld	de, #0x2c32
	push	de
	ld	de, #0x1832
	push	de
	call	_line
	pop	af
	pop	af
;main.c:35: line(X1+OF, Y1+OF, X2+OF, Y1+OF);
	ld	de, #0x253f
	push	de
	ld	de, #0x252b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:36: line(X1+OF, Y2+OF, X2+OF, Y2+OF);
	ld	de, #0x393f
	push	de
	ld	de, #0x392b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:37: line(X1+OF, Y1+OF, X1+OF, Y2+OF);
	ld	de, #0x392b
	push	de
	ld	de, #0x252b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:38: line(X2+OF, Y1+OF, X2+OF, Y2+OF);
	ld	de, #0x393f
	push	de
	ld	de, #0x253f
	push	de
	call	_line
	pop	af
	pop	af
;main.c:40: line(X1, Y1, X1+OF, Y1+OF);
	ld	de, #0x252b
	push	de
	ld	de, #0x181e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:41: line(X1, Y2, X1+OF, Y2+OF);
	ld	de, #0x392b
	push	de
	ld	de, #0x2c1e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:42: line(X2, Y1, X2+OF, Y1+OF);
	ld	de, #0x253f
	push	de
	ld	de, #0x1832
	push	de
	call	_line
	pop	af
	pop	af
;main.c:43: line(X2, Y2, X2+OF, Y2+OF);
	ld	de, #0x393f
	push	de
	ld	de, #0x2c32
	push	de
	call	_line
	pop	af
	pop	af
;main.c:46: circle(40, 10, 10);
	ld	de, #0x0a0a
	push	de
	ld	a, #0x28
	push	af
	inc	sp
	call	_circle
	pop	af
	inc	sp
;main.c:50: circle(70, 10, 8);
	ld	de, #0x080a
	push	de
	ld	a, #0x46
	push	af
	inc	sp
	call	_circle
	pop	af
	inc	sp
;main.c:51: circle(XMAX-10, 40, 8);
	ld	de, #0x0828
	push	de
	ld	a, #0x56
	push	af
	inc	sp
	call	_circle
	pop	af
	inc	sp
;main.c:52: line(70+8, 10, XMAX-10+9, 40);
	ld	de, #0x285f
	push	de
	ld	de, #0x0a4e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:53: line(70-8, 10, XMAX-10-9, 40);
	ld	de, #0x284d
	push	de
	ld	de, #0x0a3e
	push	de
	call	_line
	pop	af
	pop	af
;main.c:56: swap();
	call	_swap
;main.c:62: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:64: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
