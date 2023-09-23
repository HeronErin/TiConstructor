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
	.globl _fixed_sin
	.globl _fixed_print
	.globl _fixed_div
	.globl _longdiv
	.globl _fixed_mult
	.globl _mulr
	.globl _fixed_to_int
	.globl _setPix
	.globl _vertical_dotted_line
	.globl _vertical_line
	.globl _swap
	.globl _clearBuffer
	.globl _number
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _SINE_LOOKUP
	.globl _cool_sine_asm
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
;../../lib/graphics.c:486: void setPix(char x, char y){
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
;../../lib/graphics.c:487: *(char*)((((int)y)* (XMAX/8) )+(x/8)+G_SCREEN_BUFFER)|=128>>(x%8);
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
;../../lib/graphics.c:488: }
	ld	sp, ix
	pop	ix
	ret
;../../lib/fixedpoint.c:34: int fixed_to_int(fixedpt x)__naked{
;	---------------------------------
; Function fixed_to_int
; ---------------------------------
_fixed_to_int::
;../../lib/fixedpoint.c:43: __endasm;
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	ret
;../../lib/fixedpoint.c:44: }
;../../lib/fixedpoint.c:54: void mulr(uint64_t left, uint32_t right, uint64_t* ret){
;	---------------------------------
; Function mulr
; ---------------------------------
_mulr::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fixedpoint.c:55: __asm di __endasm;
	di	
;../../lib/fixedpoint.c:56: *ret = 0; // 112 t-states !!!!
	ld	c, 16 (ix)
	ld	b, 17 (ix)
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
	inc	bc
	ld	(bc), a
;../../lib/fixedpoint.c:59: while (right > 0) // 19*4+12 t-states
00104$:
	ld	a, 15 (ix)
	or	a, 14 (ix)
	or	a, 13 (ix)
	or	a, 12 (ix)
	jr	Z, 00106$
;../../lib/fixedpoint.c:61: if (right & 1) // 12+20 t-states
	bit	0, 12 (ix)
	jr	Z, 00103$
;../../lib/fixedpoint.c:68: __endasm;
	.db	0xDD, 0x54 ; ld d,ixh 8 tstate
	.db	0xDD, 0x5D ; ld e,ixl 8 tstates
;../../lib/fixedpoint.c:82: __endasm;
	ld	l, 16 (ix) ; 7
	ld	h, 17 (ix) ; 7
	ex	de, hl ; 4 states
	ld	bc, #4 ; 10 t-states
	add	hl, bc ; 11 t-states
	ld	b, #8 ; 7 t-states
;../../lib/fixedpoint.c:83: for (char zzz = 0; zzz < 8; zzz++){ // 4, 12 + 7 t states
	xor	a, a
00108$:
	cp	a, #0x08
	jr	NC, 00103$
;../../lib/fixedpoint.c:95: __endasm;
	.db	#0x08 ; 4 t-states
	ld	a, (de) ; 7 t-states
	adc	a, (hl) ; 7 t-states
	ld	(de), a ; 7 t-states
	.db	#0x08 ; 4 t-states
	inc	de ; 6 t-states
	inc	hl ; 6 t-states
;../../lib/fixedpoint.c:83: for (char zzz = 0; zzz < 8; zzz++){ // 4, 12 + 7 t states
	inc	a
	jr	00108$
00103$:
;../../lib/fixedpoint.c:101: right >>= 1; // 23*4 t-states
	srl	15 (ix)
	rr	14 (ix)
	rr	13 (ix)
	rr	12 (ix)
;../../lib/fixedpoint.c:102: left <<= 1; //23*8 + 12 t-states
	sla	4 (ix)
	rl	5 (ix)
	rl	6 (ix)
	rl	7 (ix)
	rl	8 (ix)
	rl	9 (ix)
	rl	10 (ix)
	rl	11 (ix)
	jr	00104$
00106$:
;../../lib/fixedpoint.c:104: __asm ei __endasm;
	ei	
;../../lib/fixedpoint.c:106: }
	pop	ix
	ret
;../../lib/fixedpoint.c:110: fixedpt fixed_mult(fixedpt a, fixedpt b) __naked{
;	---------------------------------
; Function fixed_mult
; ---------------------------------
_fixed_mult::
;../../lib/fixedpoint.c:170: __endasm;
	push	ix
	ld	ix,#0
	add	ix,sp
;	uint64_t r = 0;
	ld	hl, #0
	push	hl
	push	hl
	push	hl
	push	hl
;	mulr(a, b, &r);
	add	hl, sp
	ex	de, hl
	ld	c, e
	ld	b, d
	push	de
	push	bc
	ld	l, 10 (ix)
	ld	h, 11 (ix)
	push	hl
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	hl, #0
	push	hl
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_mulr
	ld	hl, #14
	add	hl, sp
	ld	sp, hl
	pop	de
	inc	de
	inc	de
	ld	a, d
	ld	l, e
	ld	h, a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ex	de, hl
	ld	e, c
	ld	sp, ix
	pop	ix
	ret
;../../lib/fixedpoint.c:172: }
;../../lib/fixedpoint.c:184: longdiv (uint64_t x, uint64_t y)__naked{
;	---------------------------------
; Function longdiv
; ---------------------------------
_longdiv::
;../../lib/fixedpoint.c:300: __endasm;
	push	ix ; 15 t-states
	ld	ix,#0 ; 14 t-states
	add	ix,sp ; 15 t-states
	xor	a, a ; 4 t-states
	ld	de, #0 ; 10 t-states
	push	de ; 11 t-states
	push	de ; 11 t-states
	push	de ; 11 t-states
	push	de ; 11 t-states
	ld	c, #0x40
	00105$:
	ld	a, 11 (ix)
	rlca
	and	a, #0x01
	sla	4 (ix)
	rl	5 (ix)
	rl	6 (ix)
	rl	7 (ix)
	rl	8 (ix)
	rl	9 (ix)
	rl	10 (ix)
	rl	11 (ix)
	sla	-8 (ix)
	rl	-7 (ix)
	rl	-6 (ix)
	rl	-5 (ix)
	rl	-4 (ix)
	rl	-3 (ix)
	rl	-2 (ix)
	rl	-1 (ix)
	or	a, a
	jr	Z, 00102$
	ld	a, -8 (ix)
	or	a, #0x01
	ld	-8 (ix), a
	00102$:
	ld	a, -8 (ix)
	sub	a, 12 (ix)
	ld	a, -7 (ix)
	sbc	a, 13 (ix)
	ld	a, -6 (ix)
	sbc	a, 14 (ix)
	ld	a, -5 (ix)
	sbc	a, 15 (ix)
	ld	a, -4 (ix)
	sbc	a, 16 (ix)
	ld	a, -3 (ix)
	sbc	a, 17 (ix)
	ld	a, -2 (ix)
	sbc	a, 18 (ix)
	ld	a, -1 (ix)
	sbc	a, 19 (ix)
	jr	C, 00106$
	ld	a, -8 (ix)
	sub	a, 12 (ix)
	ld	-8 (ix), a
	ld	a, -7 (ix)
	sbc	a, 13 (ix)
	ld	-7 (ix), a
	ld	a, -6 (ix)
	sbc	a, 14 (ix)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	sbc	a, 15 (ix)
	ld	-5 (ix), a
	ld	a, -4 (ix)
	sbc	a, 16 (ix)
	ld	-4 (ix), a
	ld	a, -3 (ix)
	sbc	a, 17 (ix)
	ld	-3 (ix), a
	ld	a, -2 (ix)
	sbc	a, 18 (ix)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	sbc	a, 19 (ix)
	ld	-1 (ix), a
	ld	a, 4 (ix)
	or	a, #0x01
	ld	4 (ix), a
	00106$:
	dec	c
	jp	NZ, 00105$
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	ld	l, c
	ld	h, b
	ld	sp, ix
	pop	ix
	ret
;../../lib/fixedpoint.c:301: }
;../../lib/fixedpoint.c:304: fixedpt fixed_div(fixedpt N, fixedpt D) {
;	---------------------------------
; Function fixed_div
; ---------------------------------
_fixed_div::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fixedpoint.c:334: __endasm;
	ld	bc, #0
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	ld	e, 10 (ix)
	ld	d, 11 (ix)
	push	bc
	push	bc
	push	de
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	push	bc
	push	de
	push	hl
	push	bc
	call	_longdiv
	ld	sp, ix
;../../lib/fixedpoint.c:337: }
	pop	ix
	ret
;../../lib/fixedpoint.c:343: void fixed_print(fixedpt i){
;	---------------------------------
; Function fixed_print
; ---------------------------------
_fixed_print::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fixedpoint.c:359: __endasm;
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	call	_number
	xor	a, a
	ld	6 (ix), a
	ld	7 (ix), a
	ld	a, #'.'
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
;../../lib/fixedpoint.c:403: __endasm;
	ld	b, #5
	  DEC_LOOP:
	push	bc
	ld	e, #0
	sla	4 (ix)
	rl	5 (ix)
	rl	e
	ld	l, 4(ix)
	ld	h, 5(ix)
	ld	a, e
	sla	4 (ix)
	rl	5 (ix)
	rl	a
	sla	4 (ix)
	rl	5 (ix)
	rl	a
	ld	c, 4(ix)
	ld	b, 5(ix)
	add	hl, bc
	adc	a, e
	add	a, #'0'
	ld	4(ix), l
	ld	5(ix), h
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	pop	bc
	djnz	DEC_LOOP
;../../lib/fixedpoint.c:410: __endasm;
	ei
	ld	sp, ix
;../../lib/fixedpoint.c:411: }
	pop	ix
	ret
;../../lib/fixedpoint.c:419: fixedpt fixed_sin(int deg){
;	---------------------------------
; Function fixed_sin
; ---------------------------------
_fixed_sin::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fixedpoint.c:420: return SINE_LOOKUP[deg%360/5];
	ld	hl, #0x0168
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__modsint
	pop	af
	pop	af
	ex	de, hl
	ld	hl, #0x0005
	push	hl
	push	de
	call	__divsint
	pop	af
	pop	af
	add	hl, hl
	add	hl, hl
	ld	de, #_SINE_LOOKUP
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ex	de, hl
	ld	e, c
;../../lib/fixedpoint.c:421: }
	pop	ix
	ret
_SINE_LOOKUP:
	.byte #0x00, #0x00, #0x00, #0x00	;  0
	.byte #0x50, #0x16, #0x00, #0x00	;  5712
	.byte #0x74, #0x2c, #0x00, #0x00	;  11380
	.byte #0x42, #0x42, #0x00, #0x00	;  16962
	.byte #0x8f, #0x57, #0x00, #0x00	;  22415
	.byte #0x31, #0x6c, #0x00, #0x00	;  27697
	.byte #0x00, #0x80, #0x00, #0x00	;  32768
	.byte #0xd6, #0x92, #0x00, #0x00	;  37590
	.byte #0x8e, #0xa4, #0x00, #0x00	;  42126
	.byte #0x05, #0xb5, #0x00, #0x00	;  46341
	.byte #0x1b, #0xc4, #0x00, #0x00	;  50203
	.byte #0xb4, #0xd1, #0x00, #0x00	;  53684
	.byte #0xb4, #0xdd, #0x00, #0x00	;  56756
	.byte #0x04, #0xe8, #0x00, #0x00	;  59396
	.byte #0x90, #0xf0, #0x00, #0x00	;  61584
	.byte #0x47, #0xf7, #0x00, #0x00	;  63303
	.byte #0x1c, #0xfc, #0x00, #0x00	;  64540
	.byte #0x07, #0xff, #0x00, #0x00	;  65287
	.byte #0x00, #0x00, #0x01, #0x00	;  65536
	.byte #0x07, #0xff, #0x00, #0x00	;  65287
	.byte #0x1c, #0xfc, #0x00, #0x00	;  64540
	.byte #0x47, #0xf7, #0x00, #0x00	;  63303
	.byte #0x90, #0xf0, #0x00, #0x00	;  61584
	.byte #0x04, #0xe8, #0x00, #0x00	;  59396
	.byte #0xb4, #0xdd, #0x00, #0x00	;  56756
	.byte #0xb4, #0xd1, #0x00, #0x00	;  53684
	.byte #0x1b, #0xc4, #0x00, #0x00	;  50203
	.byte #0x05, #0xb5, #0x00, #0x00	;  46341
	.byte #0x8e, #0xa4, #0x00, #0x00	;  42126
	.byte #0xd6, #0x92, #0x00, #0x00	;  37590
	.byte #0x00, #0x80, #0x00, #0x00	;  32768
	.byte #0x31, #0x6c, #0x00, #0x00	;  27697
	.byte #0x8f, #0x57, #0x00, #0x00	;  22415
	.byte #0x42, #0x42, #0x00, #0x00	;  16962
	.byte #0x74, #0x2c, #0x00, #0x00	;  11380
	.byte #0x50, #0x16, #0x00, #0x00	;  5712
	.byte #0x00, #0x00, #0x00, #0x00	;  0
	.byte #0xb0, #0xe9, #0xff, #0xff	; -5712
	.byte #0x8c, #0xd3, #0xff, #0xff	; -11380
	.byte #0xbe, #0xbd, #0xff, #0xff	; -16962
	.byte #0x71, #0xa8, #0xff, #0xff	; -22415
	.byte #0xcf, #0x93, #0xff, #0xff	; -27697
	.byte #0x00, #0x80, #0xff, #0xff	; -32768
	.byte #0x2a, #0x6d, #0xff, #0xff	; -37590
	.byte #0x72, #0x5b, #0xff, #0xff	; -42126
	.byte #0xfb, #0x4a, #0xff, #0xff	; -46341
	.byte #0xe5, #0x3b, #0xff, #0xff	; -50203
	.byte #0x4c, #0x2e, #0xff, #0xff	; -53684
	.byte #0x4c, #0x22, #0xff, #0xff	; -56756
	.byte #0xfc, #0x17, #0xff, #0xff	; -59396
	.byte #0x70, #0x0f, #0xff, #0xff	; -61584
	.byte #0xb9, #0x08, #0xff, #0xff	; -63303
	.byte #0xe4, #0x03, #0xff, #0xff	; -64540
	.byte #0xf9, #0x00, #0xff, #0xff	; -65287
	.byte #0x00, #0x00, #0xff, #0xff	; -65536
	.byte #0xf9, #0x00, #0xff, #0xff	; -65287
	.byte #0xe4, #0x03, #0xff, #0xff	; -64540
	.byte #0xb9, #0x08, #0xff, #0xff	; -63303
	.byte #0x70, #0x0f, #0xff, #0xff	; -61584
	.byte #0xfc, #0x17, #0xff, #0xff	; -59396
	.byte #0x4c, #0x22, #0xff, #0xff	; -56756
	.byte #0x4c, #0x2e, #0xff, #0xff	; -53684
	.byte #0xe5, #0x3b, #0xff, #0xff	; -50203
	.byte #0xfb, #0x4a, #0xff, #0xff	; -46341
	.byte #0x72, #0x5b, #0xff, #0xff	; -42126
	.byte #0x2a, #0x6d, #0xff, #0xff	; -37590
	.byte #0x00, #0x80, #0xff, #0xff	; -32768
	.byte #0xcf, #0x93, #0xff, #0xff	; -27697
	.byte #0x71, #0xa8, #0xff, #0xff	; -22415
	.byte #0xbe, #0xbd, #0xff, #0xff	; -16962
	.byte #0x8c, #0xd3, #0xff, #0xff	; -11380
	.byte #0xb0, #0xe9, #0xff, #0xff	; -5712
;main.c:21: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:22: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:23: resetPen();
	call	_resetPen
;main.c:24: clearBuffer();
	call	_clearBuffer
;main.c:26: cool_sine_asm();
	call	_cool_sine_asm
;main.c:30: fputs("2 * \xC4 * 40.512 = ");
	ld	hl, #___str_0
	push	hl
	call	_fputs
;main.c:33: x = fixed_mult(x, fixed_PI);
	ld	hl, #0x0003
	ex	(sp),hl
	ld	hl, #0x243f
	push	hl
	ld	hl, #0x0051
	push	hl
	ld	hl, #0x0624
	push	hl
	call	_fixed_mult
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;main.c:34: fixed_print(x);
	push	de
	push	bc
	call	_fixed_print
	pop	af
	pop	af
;main.c:35: newline();
	call	_newline
;main.c:36: newline();
	call	_newline
;main.c:39: fputs("\xC4 * 52.673^2 = ");
	ld	hl, #___str_1
	push	hl
	call	_fputs
;main.c:41: x = fixed_mult(x, x);
	ld	hl, #0x0034
	ex	(sp),hl
	ld	hl, #0xac4a
	push	hl
	ld	hl, #0x0034
	push	hl
	ld	hl, #0xac4a
	push	hl
	call	_fixed_mult
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;main.c:42: x = fixed_mult(x, fixed_PI);
	ld	hl, #0x0003
	push	hl
	ld	hl, #0x243f
	push	hl
	push	de
	push	bc
	call	_fixed_mult
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;main.c:43: fixed_print(x);
	push	de
	push	bc
	call	_fixed_print
	pop	af
	pop	af
;main.c:44: newline();
	call	_newline
;main.c:45: newline();
	call	_newline
;main.c:47: fputs("\xC4 \xD1 E * 180 \xD1 \xC4 = ");
	ld	hl, #___str_2
	push	hl
	call	_fputs
;main.c:48: x = fixed_div(fixed_PI, fixed_E);
	ld	hl, #0x0002
	ex	(sp),hl
	ld	hl, #0xb7e1
	push	hl
	ld	hl, #0x0003
	push	hl
	ld	hl, #0x243f
	push	hl
	call	_fixed_div
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;main.c:49: fixed_print(fixed_div(  fixed_mult(x, FXX(180)), fixed_PI) );
	ld	hl, #0x00b4
	push	hl
	ld	hl, #0x0000
	push	hl
	push	de
	push	bc
	call	_fixed_mult
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x0003
	push	hl
	ld	hl, #0x243f
	push	hl
	push	de
	push	bc
	call	_fixed_div
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	push	de
	push	bc
	call	_fixed_print
	pop	af
	pop	af
;main.c:52: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:54: }
	ret
___str_0:
	.ascii "2 * "
	.db 0xc4
	.ascii " * 40.512 = "
	.db 0x00
___str_1:
	.db 0xc4
	.ascii " * 52.673^2 = "
	.db 0x00
___str_2:
	.db 0xc4
	.ascii " "
	.db 0xd1
	.ascii " E * 180 "
	.db 0xd1
	.ascii " "
	.db 0xc4
	.ascii " = "
	.db 0x00
;main.c:57: void cool_sine_asm(){
;	---------------------------------
; Function cool_sine_asm
; ---------------------------------
_cool_sine_asm::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;main.c:58: for (char b = XMAX/4; b!=0; b--){
	ld	-1 (ix), #0x18
00103$:
	ld	a, -1 (ix)
	or	a, a
	jr	Z, 00101$
;main.c:59: char c = (b-1)*4;
	ld	l, -1 (ix)
	dec	l
	add	hl, hl
	add	hl, hl
;main.c:60: fixedpt sn = fixed_mult(fixed_sin(c<<3), FXX(5));
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	call	_fixed_sin
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x0005
	push	hl
	ld	hl, #0x0000
	push	hl
	push	de
	push	bc
	call	_fixed_mult
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;main.c:63: fixed_to_int(sn); // c functions return ints in the hl register
	push	de
	push	bc
	call	_fixed_to_int
	pop	af
	pop	af
;main.c:95: __endasm;
	ld	a, l
	add	a, #64 -10
	ld	h, a
	ld	a, -1 (ix)
	add	a, a
	add	a, a
	ld	l, a
	push	hl
	call	_setPix
	pop	hl
	inc	hl
	push	hl
	call	_setPix
	pop	hl
	inc	hl
	push	hl
	call	_setPix
	pop	hl
	inc	hl
	push	hl
	call	_setPix
	pop	hl
;main.c:58: for (char b = XMAX/4; b!=0; b--){
	dec	-1 (ix)
	jr	00103$
00101$:
;main.c:98: swap();
	call	_swap
;main.c:99: }
	inc	sp
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
