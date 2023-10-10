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
	.globl ___drawCircleSegment
	.globl _setPix
	.globl ____GetPixel
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
;../../lib/textio.c:86: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc ; ret value
	push	hl
	 the_char_loop_i_need_more_good_names_for_labels:
	ld	a, (bc)
	or	a, a
	ret	z
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	inc	bc
	jr	the_char_loop_i_need_more_good_names_for_labels
;../../lib/textio.c:87: }
;../../lib/textio.c:92: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:93: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:102: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:103: }
	pop	ix
	ret
;../../lib/textio.c:106: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:116: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:117: }
;../../lib/textio.c:121: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:133: __endasm;
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
;../../lib/textio.c:134: }
;../../lib/graphics.c:88: void clearBuffer(){
;	---------------------------------
; Function clearBuffer
; ---------------------------------
_clearBuffer::
;../../lib/graphics.c:109: __endasm;
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
;../../lib/graphics.c:110: }
	ret
;../../lib/graphics.c:116: void swap(){
;	---------------------------------
; Function swap
; ---------------------------------
_swap::
;../../lib/graphics.c:157: __endasm;
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
;../../lib/graphics.c:159: }
	ret
;../../lib/graphics.c:178: void line(char x, char y, char x2, char y2) __naked{
;	---------------------------------
; Function line
; ---------------------------------
_line::
;../../lib/graphics.c:309: __endasm;
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	ld	a, d
	ld	d, e
	ld	e, a
	ld	a, h
	ld	h, l
	ld	l, a
	push	ix
	ld	ix, #0x9340
	call	DrawLineCompact
	pop	ix
	ret
;	Line drawer
;	Small and quite fast
;	by Patai Gergely, thanks
	  DrawLineCompact:
; This routine draws an unclipped line on an IX-pointed screen from (d,e) to (h,l)
	ld	a,h ; Calculating delta X and swapping points if negative
	sub	d ; (Lines are always drawn from left to right)
	jp	nc,DL_okaydx
	ex	de,hl
	neg
	  DL_okaydx:
	push	af ; Saving DX (it will be popped into DE below)
	ld	b,#0 ; Calculating the position of the first pixel to be drawn
	ld	c,d ; IX+=D/8+E*12 (actually E*4+E*4+E*4)
	srl	c
	srl	c
	srl	c
	add	ix,bc
	ld	c,e
	sla	c
	sla	c
	add	ix,bc
	add	ix,bc
	add	ix,bc
	ld	a,d ; Calculating the starting pixel mask
	ld	c,#0x80
	and	a, #7
	jp	z,DL_okaymask
	  DL_calcmask:
	srl	c
	dec	a
	jp	nz,DL_calcmask
	  DL_okaymask:
	ld	a,l ; Calculating delta Y and negating the Y increment if necessary
	sub	e ; This is the last instruction for which we need the original data
	ld	hl,#12
	jp	nc,DL_okaydy
	ld	hl,#-12
	neg
	  DL_okaydy:
	pop	de ; Recalling DX
	ld	e,a ; D=DX, E=DY
	cp	d
	jp	c,#DL_horizontal ; Line is rather horizontal than vertical
	ld	(0x980C),hl ; Modifying y increment
	push	ix ;
	pop	hl
	ld	b,e ; Pixel counter
	inc	b
	srl	a ; Setting up gradient counter (A=E/2)
	ld	(0x84F3),sp ; Backing up SP to a safe place
	di	; Interrupts are undesirable when we play around with SP :)
	  DL_VLinc:
	ld	sp, (0x980C) ; This value is replaced by +/- 12
	  DL_Vloop:
	.db	0x08
	ld	a,(hl)
	or	c ; Writing pixel to current position
	ld	(hl),a
	.db	0x08
	add	hl,sp
	sub	d ; Handling gradient
	jp	nc,DL_VnoSideStep
	rrc	c ; Rotating mask
	jp	nc,DL_VnoByte ; Handling byte boundary
	inc	hl
	  DL_VnoByte:
	add	a,e
	  DL_VnoSideStep:
	djnz	DL_Vloop
	ld	sp,(0x84F3)
	ret
	  DL_horizontal:
	ld	(0x84F3),hl ; Modifying y increment
	push	ix ;
	pop	hl
	ld	b,d ; Pixel counter
	inc	b
	ld	a,d ; Setting up gradient counter
	srl	a
	ld	(0x980C),sp ; Backing up SP to a safe place
	di	; Interrupts again...
	  DL_HLinc:
	ld	sp,(0x84F3) ; This value is replaced by +/- 12
	  DL_Hloop:
	.db	0x08
	ld	a,(hl)
	or	c ; Writing pixel to current position
	ld	(hl),a
	.db	0x08
	rrc	c ; Rotating mask
	jp	nc,DL_HnoByte ; Handling byte boundary
	inc	hl
	  DL_HnoByte:
	sub	e ; Handling gradient
	jp	nc,DL_HnoSideStep
	add	hl,sp
	add	a,d
	  DL_HnoSideStep:
	djnz	DL_Hloop
	ld	sp,(0x980C)
	ret
;../../lib/graphics.c:310: }
;../../lib/graphics.c:502: void ___GetPixel() __naked{
;	---------------------------------
; Function ___GetPixel
; ---------------------------------
____GetPixel::
;../../lib/graphics.c:535: __endasm;
	LD	H, #0
	LD	D, H
	LD	E, L
	ADD	HL, HL
	ADD	HL, DE
	ADD	HL, HL
	ADD	HL, HL
	LD	E, A
	SRL	E
	SRL	E
	SRL	E
	ADD	HL, DE
	LD	DE, #0x9340
	ADD	HL, DE
	and	a, #7
	LD	B, A
	LD	A, #0x80
	RET	Z
	or	a, a
	 Get_Pix_Loop:
	RRCA
	DJNZ	Get_Pix_Loop
	RET
;../../lib/graphics.c:536: }
;../../lib/graphics.c:552: void setPix(char x, char y)__naked{
;	---------------------------------
; Function setPix
; ---------------------------------
_setPix::
;../../lib/graphics.c:567: __endasm;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a, l
	ld	l, h
	call	____GetPixel
	or	(hl)
	ld	(hl), a
	ret
;../../lib/graphics.c:568: }
;../../lib/graphics.c:583: void __drawCircleSegment(char xc, char yc, char x, char y)
;	---------------------------------
; Function __drawCircleSegment
; ---------------------------------
___drawCircleSegment::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/graphics.c:585: setPix(xc+x, yc+y);
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
;../../lib/graphics.c:586: setPix(xc-x, yc+y);
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
;../../lib/graphics.c:587: setPix(xc+x, yc-y);
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
;../../lib/graphics.c:589: setPix(xc+y, yc+x);
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
;../../lib/graphics.c:590: setPix(xc-y, yc+x);
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
;../../lib/graphics.c:591: setPix(xc+y, yc-x);
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
;../../lib/graphics.c:593: }
	pop	ix
	ret
;../../lib/graphics.c:604: void circle(char xc, char yc, char r)
;	---------------------------------
; Function circle
; ---------------------------------
_circle::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../../lib/graphics.c:606: char x = 0, y = r;
	ld	b, 6 (ix)
;../../lib/graphics.c:607: __drawCircleSegment(xc, yc, x, y);
	push	bc
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	h, 5 (ix)
	ld	l, 4 (ix)
	push	hl
	call	___drawCircleSegment
	pop	af
	pop	af
	pop	bc
;../../lib/graphics.c:608: int d = 3 - 2 * r;
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	ld	a, #0x03
	sub	a, l
	ld	c, a
	ld	a, #0x00
	sbc	a, h
	ld	d, a
;../../lib/graphics.c:609: while (y >= x)
	ld	e, #0x00
00104$:
	ld	a, b
	sub	a, e
	jr	C, 00107$
;../../lib/graphics.c:614: x++;
	inc	e
;../../lib/graphics.c:622: d = d + 4 * (x - y) + 10;
	ld	-2 (ix), e
	ld	-1 (ix), #0
;../../lib/graphics.c:619: if (d > 0)
	xor	a, a
	cp	a, c
	sbc	a, d
	jp	PO, 00125$
	xor	a, #0x80
00125$:
	jp	P, 00102$
;../../lib/graphics.c:621: y--;
	dec	b
;../../lib/graphics.c:622: d = d + 4 * (x - y) + 10;
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
;../../lib/graphics.c:625: d = d + 4 * x + 6;
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
;../../lib/graphics.c:626: __drawCircleSegment(xc, yc, x, y);
	push	bc
	push	de
	ld	c, e
	push	bc
	ld	h, 5 (ix)
	ld	l, 4 (ix)
	push	hl
	call	___drawCircleSegment
	pop	af
	pop	af
	pop	de
	pop	bc
	jr	00104$
00107$:
;../../lib/graphics.c:628: }
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
;main.c:20: line(10, 5, 10, 20); // Using vertical_line() would be faster...
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
	ld	de, #0x1930
	push	de
	ld	de, #0x191b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:31: line(X1, Y2, X2, Y2);
	ld	de, #0x2f30
	push	de
	ld	de, #0x2f1b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:32: line(X1, Y1, X1, Y2);
	ld	de, #0x2f1b
	push	de
	ld	de, #0x191b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:33: line(X2, Y1, X2, Y2);
	ld	de, #0x2f30
	push	de
	ld	de, #0x1930
	push	de
	call	_line
	pop	af
	pop	af
;main.c:35: line(X1+OF, Y1+OF, X2+OF, Y1+OF);
	ld	de, #0x263d
	push	de
	ld	de, #0x2628
	push	de
	call	_line
	pop	af
	pop	af
;main.c:36: line(X1+OF, Y2+OF, X2+OF, Y2+OF);
	ld	de, #0x3c3d
	push	de
	ld	de, #0x3c28
	push	de
	call	_line
	pop	af
	pop	af
;main.c:37: line(X1+OF, Y1+OF, X1+OF, Y2+OF);
	ld	de, #0x3c28
	push	de
	ld	de, #0x2628
	push	de
	call	_line
	pop	af
	pop	af
;main.c:38: line(X2+OF, Y1+OF, X2+OF, Y2+OF);
	ld	de, #0x3c3d
	push	de
	ld	de, #0x263d
	push	de
	call	_line
	pop	af
	pop	af
;main.c:40: line(X1, Y1, X1+OF, Y1+OF);
	ld	de, #0x2628
	push	de
	ld	de, #0x191b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:41: line(X1, Y2, X1+OF, Y2+OF);
	ld	de, #0x3c28
	push	de
	ld	de, #0x2f1b
	push	de
	call	_line
	pop	af
	pop	af
;main.c:42: line(X2, Y1, X2+OF, Y1+OF);
	ld	de, #0x263d
	push	de
	ld	de, #0x1930
	push	de
	call	_line
	pop	af
	pop	af
;main.c:43: line(X2, Y2, X2+OF, Y2+OF);
	ld	de, #0x3c3d
	push	de
	ld	de, #0x2f30
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
;main.c:65: __endasm;
	ld	a, #10
	ld	l, #1
	call	____GetPixel
	ld	(hl), a
;main.c:68: swap();
	call	_swap
;main.c:74: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:76: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
