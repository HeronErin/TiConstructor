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
	.globl _setCpuSpeed
	.globl _getCpuSpeed
	.globl _vertical_dotted_line
	.globl _vertical_line
	.globl _line
	.globl _swap
	.globl _clearBuffer
	.globl _FX_tan
	.globl _FX_cos
	.globl _FX_sine
	.globl ___div_ac_de
	.globl ___div_32_by_16
	.globl ___mult_de_bc
	.globl ___fast_16_bit_sqrt_asm
	.globl _FX_number
	.globl _FX_abs
	.globl _FX_sqrt
	.globl _FX_div
	.globl _FX_mul
	.globl _div_int
	.globl _mul_int
	.globl _sqrt_rounded
	.globl _FX_floor
	.globl _FX_floor_int
	.globl _number
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _worldMap
	.globl _FX_sine_lookup
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
;../../lib/textio.c:102: void number(int x){
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
;../../lib/textio.c:104: if (x<0){
	bit	7, 5 (ix)
	jr	Z, 00113$
;../../lib/textio.c:105: x=0-x;
	xor	a, a
	sub	a, 4 (ix)
	ld	4 (ix), a
	ld	a, #0x00
	sbc	a, 5 (ix)
	ld	5 (ix), a
;../../lib/textio.c:106: printc('-');
	ld	a, #0x2d
	push	af
	inc	sp
	call	_printc
	inc	sp
;../../lib/textio.c:109: do {
00113$:
	ld	hl, #0
	add	hl, sp
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	bc, #0x0000
00103$:
;../../lib/textio.c:110: out[i]=x % 10 + '0';
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
;../../lib/textio.c:111: i+=1;
	inc	bc
;../../lib/textio.c:112: } while((x /= 10) > 0);
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
;../../lib/textio.c:113: i--;
	dec	bc
00108$:
;../../lib/textio.c:114: for(;i>=0; i--){
	bit	7, b
	jr	NZ, 00110$
;../../lib/textio.c:125: __endasm;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	add	hl, bc
	ld	a, (hl)
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
;../../lib/textio.c:114: for(;i>=0; i--){
	dec	bc
	jr	00108$
00110$:
;../../lib/textio.c:129: }
	ld	sp, ix
	pop	ix
	ret
;../../lib/fast_math.c:10: char FX_floor_int(int f)__naked{
;	---------------------------------
; Function FX_floor_int
; ---------------------------------
_FX_floor_int::
;../../lib/fast_math.c:18: __endasm;
	pop	hl ; Get input
	pop	af ; and perserve
	push	af
	push	hl ; ret value
	ld	l, a
	ret
;../../lib/fast_math.c:19: }
;../../lib/fast_math.c:20: int FX_floor(int f)__naked{
;	---------------------------------
; Function FX_floor
; ---------------------------------
_FX_floor::
;../../lib/fast_math.c:30: __endasm;
	pop	de ; Get input
	pop	hl ; and perserve
	push	hl
	push	de ; ret value
	xor	a, a
	ld	l, a
	ret
;../../lib/fast_math.c:31: }
;../../lib/fast_math.c:34: char sqrt_rounded(int x)__naked{
;	---------------------------------
; Function sqrt_rounded
; ---------------------------------
_sqrt_rounded::
;../../lib/fast_math.c:46: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	l, b
	ld	a, c
	call	___fast_16_bit_sqrt_asm
	ld	l, d
	ret
;../../lib/fast_math.c:47: }
;../../lib/fast_math.c:48: long mul_int(int x, int y)__naked{
;	---------------------------------
; Function mul_int
; ---------------------------------
_mul_int::
;../../lib/fast_math.c:58: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	pop	de
	push	de
	push	bc
	push	hl ; ret value
	jp	___mult_de_bc ; Jp instead of call saves time due to ___mult_de_bc having the same output as long
;../../lib/fast_math.c:59: }
;../../lib/fast_math.c:60: int div_int(int x, int y)__naked{
;	---------------------------------
; Function div_int
; ---------------------------------
_div_int::
;../../lib/fast_math.c:75: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	pop	de
	push	de
	push	bc
	push	hl ; ret value
	ld	a, b
	call	___div_ac_de
	ld	h, a
	ld	l, c
	ret
;../../lib/fast_math.c:76: }
;../../lib/fast_math.c:79: int FX_mul(int x, int y)__naked{
;	---------------------------------
; Function FX_mul
; ---------------------------------
_FX_mul::
;../../lib/fast_math.c:135: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	pop	de
	push	de
	push	bc
	push	hl ; ret value
	res	1, 0x21(iy)
	bit	7,d
	jp	z, nxtt
	set	1, 0x21(iy)
	xor	a
	sub	e
	ld	e,a
	sbc	a,a
	sub	d
	ld	d,a
	       nxtt:
	bit	7,b
	jp	z, aftttt
	bit	1, 0x21(iy)
	jp	z, Uaid
	res	1, 0x21(iy)
	jp	hejaka
	     Uaid:
	set 1, 0x21(iy)
	     hejaka:
	xor	a
	sub	c
	ld	c,a
	sbc	a,a
	sub	b
	ld	b,a
	         aftttt:
	call	___mult_de_bc
	ld	l, h
	ld	h, e
	bit	1, 0x21(iy)
	ret	z
	xor	a
	sub	l
	ld	l,a
	sbc	a,a
	sub	h
	ld	h,a
	ret
;../../lib/fast_math.c:136: }
;../../lib/fast_math.c:138: int FX_div(int x, int y)__naked{
;	---------------------------------
; Function FX_div
; ---------------------------------
_FX_div::
;../../lib/fast_math.c:206: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	pop	de
	push	de
	push	bc
	push	hl ; ret value
	res	1, 0x21(iy)
	bit	7,d
	jp	z, _nxtt
	set	1, 0x21(iy)
	xor	a
	sub	e
	ld	e,a
	sbc	a,a
	sub	d
	ld	d,a
	       _nxtt:
	bit	7,b
	jp	z, _aftttt
	bit	1, 0x21(iy)
	jp	z, _Uaid
	res	1, 0x21(iy)
	jp	_hejaka
	     _Uaid:
	set 1, 0x21(iy)
	     _hejaka:
	xor	a
	sub	c
	ld	c,a
	sbc	a,a
	sub	b
	ld	b,a
	         _aftttt:
	push	ix
	ld	ix, #0
	.db	0xDD, 0x61 ; ld ixh, c
	ld	a, #0
	ld	c, b
	call	___div_32_by_16
	push	ix
	pop	hl
	pop	ix
	bit	1, 0x21(iy)
	ret	z
	xor	a
	sub	l
	ld	l,a
	sbc	a,a
	sub	h
	ld	h,a
	ret
;../../lib/fast_math.c:207: }
;../../lib/fast_math.c:208: int FX_sqrt(int x)__naked{
;	---------------------------------
; Function FX_sqrt
; ---------------------------------
_FX_sqrt::
;../../lib/fast_math.c:231: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	l, b
	ld	a, c
	call	___fast_16_bit_sqrt_asm
	ld	h, d
	ld	l, #0
;	Bit shift by 4
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ret
;../../lib/fast_math.c:232: }
;../../lib/fast_math.c:235: int FX_abs(int x)__naked{
;	---------------------------------
; Function FX_abs
; ---------------------------------
_FX_abs::
;../../lib/fast_math.c:251: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	bit	7,h
	ret	z
	xor	a
	sub	l
	ld	l,a
	sbc	a,a
	sub	h
	ld	h,a
	ret
;../../lib/fast_math.c:252: }
;../../lib/fast_math.c:253: void FX_number(int x)__naked{
;	---------------------------------
; Function FX_number
; ---------------------------------
_FX_number::
;../../lib/fast_math.c:328: __endasm;
	pop	de
	pop	hl
	ld	a, h
	or	a, a
	jp	p, LOLLL
;	Handle negative
	cpl
	ld	h, a
	ld	a, l
	cpl
	ld	l, a
	push	hl
	push	de
	push	ix
	ld	a, #'-'
	rst	40 
	.dw 0x455E
	pop	ix
	pop	de
	pop	hl
	  LOLLL:
	push	hl
	push	de
	set	0, 0x21(iy)
	push	hl
	 _NUM_LOOP_FM:
	ld	l, h
	ld	h, #0
	push	hl
	call	_number
	pop	af
	bit	0, 0x21(iy)
	jp	z, AFTR_DEC
	ld	a, #'.'
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	 AFTR_DEC:
	pop	hl
	ld	h, #0
	ld	c, l
;	Mul 10
	SLA	l
	rl	h
	ld	d, h
	ld	e, l
	SLA	e
	rl	d
	SLA	e
	rl	d
	add	hl, de
	push	hl
	res	0, 0x21(iy)
	ld	a, c
	or	a
	jp	nz, _NUM_LOOP_FM
	POP	AF
	ret
;../../lib/fast_math.c:329: }
;../../lib/fast_math.c:342: void __fast_16_bit_sqrt_asm()__naked{
;	---------------------------------
; Function __fast_16_bit_sqrt_asm
; ---------------------------------
___fast_16_bit_sqrt_asm::
;../../lib/fast_math.c:372: __endasm;
	ld	de, #0x0040 ; 40h appends "01" to D
	ld	h, d
	ld	b, #7
;	need to clear the carry beforehand
	or	a, a
	_loop:
	sbc	hl, de
	jrpt:
	jr nc, #jrpt+3
	add	hl, de
	ccf
	rl	d
	rla
	adc	hl, hl
	rla
	adc	hl, hl
	djnz	_loop
	sbc	hl, de ; optimised last iteration
	ccf
	rl	d
	ret
;../../lib/fast_math.c:374: }
;../../lib/fast_math.c:378: void __mult_de_bc()__naked{ 
;	---------------------------------
; Function __mult_de_bc
; ---------------------------------
___mult_de_bc::
;../../lib/fast_math.c:402: __endasm;
	ld	hl, #0
	sla	e ; optimised 1st iteration
	rl	d
	gyaq:
	jr nc, #gyaq+4
	ld	h, b
	ld	l, c
	ld	a, #15
	 _mlloop:
	add	hl, hl
	rl	e
	rl	d
	umgp:
	jr nc, #umgp+6
	add	hl, bc
	lrjp:
	jr nc, #lrjp+3
	inc	de
	dec	a
	jr	nz, _mlloop
	ret
;../../lib/fast_math.c:403: }
;../../lib/fast_math.c:409: void __div_32_by_16()__naked{
;	---------------------------------
; Function __div_32_by_16
; ---------------------------------
___div_32_by_16::
;../../lib/fast_math.c:431: __endasm;
	ld	hl,#0
	ld	b,#32
	 Div32By16_Loop:
	add	ix,ix
	rl	c
	rla
	adc	hl,hl
	jr	c,Div32By16_Overflow
	sbc	hl,de
	jr	nc,Div32By16_SetBit
	add	hl,de
	djnz	Div32By16_Loop
	ret
	 Div32By16_Overflow:
	or	a
	sbc	hl,de
	 Div32By16_SetBit:
	inc	ix
	djnz	Div32By16_Loop
	ret
;../../lib/fast_math.c:432: }
;../../lib/fast_math.c:438: void __div_ac_de()__naked{
;	---------------------------------
; Function __div_ac_de
; ---------------------------------
___div_ac_de::
;../../lib/fast_math.c:455: __endasm;
	ld	hl, #0
	ld	b, #16
	 _jqaloop:
	.db	0xCB, 0x31 ; sll c
	rla
	adc	hl, hl
	sbc	hl, de
	ijyq:
	jr nc, #ijyq+4
	add	hl, de
	dec	c
	djnz	_jqaloop
	ret
;../../lib/fast_math.c:456: }
;../../lib/fast_math.c:463: int FX_sine(int deg){
;	---------------------------------
; Function FX_sine
; ---------------------------------
_FX_sine::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fast_math.c:465: int ret = FX_sine_lookup[(deg%360)/2];
	ld	hl, #0x0168
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__modsint
	pop	af
	pop	af
	ld	e, l
	ld	d, h
	bit	7, d
	jr	Z, 00103$
	ex	de,hl
	inc	hl
00103$:
	sra	h
	rr	l
	add	hl, hl
	ld	de, #_FX_sine_lookup
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;../../lib/fast_math.c:467: return ret;
	ex	de, hl
;../../lib/fast_math.c:468: }
	pop	ix
	ret
_FX_sine_lookup:
	.dw #0x0004
	.dw #0x000d
	.dw #0x0016
	.dw #0x001f
	.dw #0x0028
	.dw #0x0030
	.dw #0x0039
	.dw #0x0042
	.dw #0x004a
	.dw #0x0053
	.dw #0x005b
	.dw #0x0064
	.dw #0x006c
	.dw #0x0074
	.dw #0x007c
	.dw #0x0083
	.dw #0x008b
	.dw #0x0092
	.dw #0x009a
	.dw #0x00a1
	.dw #0x00a7
	.dw #0x00ae
	.dw #0x00b5
	.dw #0x00bb
	.dw #0x00c1
	.dw #0x00c6
	.dw #0x00cc
	.dw #0x00d1
	.dw #0x00d6
	.dw #0x00db
	.dw #0x00df
	.dw #0x00e4
	.dw #0x00e8
	.dw #0x00eb
	.dw #0x00ee
	.dw #0x00f2
	.dw #0x00f4
	.dw #0x00f7
	.dw #0x00f9
	.dw #0x00fb
	.dw #0x00fc
	.dw #0x00fe
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00fe
	.dw #0x00fc
	.dw #0x00fb
	.dw #0x00f9
	.dw #0x00f7
	.dw #0x00f4
	.dw #0x00f2
	.dw #0x00ee
	.dw #0x00eb
	.dw #0x00e8
	.dw #0x00e4
	.dw #0x00df
	.dw #0x00db
	.dw #0x00d6
	.dw #0x00d1
	.dw #0x00cc
	.dw #0x00c6
	.dw #0x00c1
	.dw #0x00bb
	.dw #0x00b5
	.dw #0x00ae
	.dw #0x00a7
	.dw #0x00a1
	.dw #0x009a
	.dw #0x0092
	.dw #0x008b
	.dw #0x0083
	.dw #0x007c
	.dw #0x0074
	.dw #0x006c
	.dw #0x0064
	.dw #0x005b
	.dw #0x0053
	.dw #0x004a
	.dw #0x0042
	.dw #0x0039
	.dw #0x0030
	.dw #0x0028
	.dw #0x001f
	.dw #0x0016
	.dw #0x000d
	.dw #0x0004
	.dw #0xfffc
	.dw #0xfff3
	.dw #0xffea
	.dw #0xffe1
	.dw #0xffd8
	.dw #0xffd0
	.dw #0xffc7
	.dw #0xffbe
	.dw #0xffb6
	.dw #0xffad
	.dw #0xffa5
	.dw #0xff9c
	.dw #0xff94
	.dw #0xff8c
	.dw #0xff84
	.dw #0xff7d
	.dw #0xff75
	.dw #0xff6e
	.dw #0xff66
	.dw #0xff5f
	.dw #0xff59
	.dw #0xff52
	.dw #0xff4b
	.dw #0xff45
	.dw #0xff3f
	.dw #0xff3a
	.dw #0xff34
	.dw #0xff2f
	.dw #0xff2a
	.dw #0xff25
	.dw #0xff21
	.dw #0xff1c
	.dw #0xff18
	.dw #0xff15
	.dw #0xff12
	.dw #0xff0e
	.dw #0xff0c
	.dw #0xff09
	.dw #0xff07
	.dw #0xff05
	.dw #0xff04
	.dw #0xff02
	.dw #0xff01
	.dw #0xff01
	.dw #0xff01
	.dw #0xff01
	.dw #0xff01
	.dw #0xff01
	.dw #0xff02
	.dw #0xff04
	.dw #0xff05
	.dw #0xff07
	.dw #0xff09
	.dw #0xff0c
	.dw #0xff0e
	.dw #0xff12
	.dw #0xff15
	.dw #0xff18
	.dw #0xff1c
	.dw #0xff21
	.dw #0xff25
	.dw #0xff2a
	.dw #0xff2f
	.dw #0xff34
	.dw #0xff3a
	.dw #0xff3f
	.dw #0xff45
	.dw #0xff4b
	.dw #0xff52
	.dw #0xff59
	.dw #0xff5f
	.dw #0xff66
	.dw #0xff6e
	.dw #0xff75
	.dw #0xff7d
	.dw #0xff84
	.dw #0xff8c
	.dw #0xff94
	.dw #0xff9c
	.dw #0xffa5
	.dw #0xffad
	.dw #0xffb6
	.dw #0xffbe
	.dw #0xffc7
	.dw #0xffd0
	.dw #0xffd8
	.dw #0xffe1
	.dw #0xffea
	.dw #0xfff3
	.dw #0xfffc
;../../lib/fast_math.c:469: int FX_cos(int deg){
;	---------------------------------
; Function FX_cos
; ---------------------------------
_FX_cos::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fast_math.c:470: return FX_sine(deg+90);
	ld	a, 4 (ix)
	add	a, #0x5a
	ld	c, a
	ld	a, 5 (ix)
	adc	a, #0x00
	ld	b, a
	push	bc
	call	_FX_sine
	pop	af
;../../lib/fast_math.c:471: }
	pop	ix
	ret
;../../lib/fast_math.c:472: int FX_tan(int deg){
;	---------------------------------
; Function FX_tan
; ---------------------------------
_FX_tan::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/fast_math.c:473: return FX_div(FX_sine(deg), FX_sine(deg+90));
	ld	a, 4 (ix)
	add	a, #0x5a
	ld	c, a
	ld	a, 5 (ix)
	adc	a, #0x00
	ld	b, a
	push	bc
	call	_FX_sine
	ex	(sp),hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_FX_sine
	ex	(sp),hl
	call	_FX_div
	pop	af
	pop	af
;../../lib/fast_math.c:474: }
	pop	ix
	ret
;../../lib/graphics.c:40: void clearBuffer(){
;	---------------------------------
; Function clearBuffer
; ---------------------------------
_clearBuffer::
;../../lib/graphics.c:61: __endasm;
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
;../../lib/graphics.c:62: }
	ret
;../../lib/graphics.c:66: void swap(){
;	---------------------------------
; Function swap
; ---------------------------------
_swap::
;../../lib/graphics.c:107: __endasm;
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
;../../lib/graphics.c:109: }
	ret
;../../lib/graphics.c:116: void line(char x, char y, char x2, char y2) __naked{
;	---------------------------------
; Function line
; ---------------------------------
_line::
;../../lib/graphics.c:238: __endasm;
	pop	bc
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
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
;../../lib/graphics.c:239: }
;../../lib/graphics.c:245: void vertical_line(char x, char start, char height, char not_used)__naked{
;	---------------------------------
; Function vertical_line
; ---------------------------------
_vertical_line::
;../../lib/graphics.c:315: __endasm;
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
;../../lib/graphics.c:316: }
;../../lib/graphics.c:318: void vertical_dotted_line(char x, char start, char height, char not_used)__naked{
;	---------------------------------
; Function vertical_dotted_line
; ---------------------------------
_vertical_dotted_line::
;../../lib/graphics.c:391: __endasm;
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
;../../lib/graphics.c:392: }
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
;main.c:79: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:88: setCpuSpeed(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_setCpuSpeed
	inc	sp
;main.c:89: posX = FX(6); posY = FX(6);  //x and y start position
	ld	hl, #0x0600
	ld	(0x8a3a), hl
	ld	l, #0x00
	ld	(0x8a3e), hl
;main.c:90: dirX = FX(-1); dirY = 0; //initial direction vector
	ld	hl, #0xfeff
	ld	(0x8a42), hl
	ld	hl, #0x0000
	ld	(0x8a46), hl
;main.c:91: planeX = 0; planeY = FX(0.66); //the 2d raycaster version of camera plane
	ld	l, h
	ld	(0x8a4a), hl
	ld	l, #0xa8
	ld	(0x8a4e), hl
;main.c:92: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:93: resetPen();
	call	_resetPen
;main.c:95: clearBuffer();
	call	_clearBuffer
;main.c:96: while (1){
00163$:
;main.c:97: swap();
	call	_swap
;main.c:98: clearBuffer();
	call	_clearBuffer
;main.c:100: for (x_temp = 0; x_temp!=(w*256); x_temp+=(256*SPEED_CO)){
	ld	hl, #0x0000
	ld	(0x8a82), hl
00169$:
	ld	hl, #0x8a82
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, c
	or	a, a
	jr	NZ, 00335$
	ld	a, b
	sub	a, #0x60
	jp	Z,00139$
00335$:
;main.c:102: cameraX = 2 *FX_div(x_temp, w*256)-256; //x-coordinate in camera space
	ld	hl, #0x6000
	push	hl
	push	bc
	call	_FX_div
	pop	af
	pop	af
	ex	de, hl
	ld	a, e
	add	a, a
	rl	d
	ld	c,a
	ld	a,d
	add	a,#0xff
	ld	b, a
	ld	(0x8a56), bc
;main.c:103: rayDirX = dirX+FX_mul(planeX, cameraX);
	ld	hl, #0x8a42
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a4a
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	bc
	push	de
	push	hl
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a5a), bc
;main.c:104: rayDirY = dirY+FX_mul(planeY, cameraX);
	ld	hl, #0x8a46
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a56
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a4e
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	bc
	push	de
	push	hl
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a5e), bc
;main.c:106: mapX = FX_floor(posX);
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor
	pop	af
	ex	de, hl
	ld	(0x8a72), de
;main.c:107: mapY = FX_floor(posY);
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor
	pop	af
	ex	de, hl
	ld	(0x8a76), de
;main.c:122: if (rayDirX == 0) continue;
	ld	hl, #0x8a5a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jp	Z, 00138$
;main.c:123: if (rayDirY == 0) continue;
	ld	hl, #0x8a5e
	ld	a, (hl)
	inc	hl
	or	a, (hl)
	jp	Z, 00138$
;main.c:124: deltaDistX = FX_div(FX(1) , FX_abs(rayDirX) );
	push	bc
	call	_FX_abs
	ex	(sp),hl
	ld	hl, #0x0100
	push	hl
	call	_FX_div
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a6a), de
;main.c:125: deltaDistY = FX_div(FX(1) , FX_abs(rayDirY) );
	ld	hl, #0x8a5e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_abs
	ex	(sp),hl
	ld	hl, #0x0100
	push	hl
	call	_FX_div
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a6e), de
;main.c:134: hit = 0; //was there a wall hit?
	ld	hl, #0x8a7e
	ld	(hl), #0x00
;main.c:138: if(rayDirX < 0)
	ld	l, #0x5a
	inc	hl
	bit	7, (hl)
	jr	Z, 00106$
;main.c:140: stepX = -1;
	ld	hl, #0x8a7a
	ld	(hl), #0xff
;main.c:141: sideDistX = FX_mul((posX - mapX), deltaDistX);
	ld	l, #0x6a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a72
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	de
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a62), de
	jr	00107$
00106$:
;main.c:145: stepX = 1;
	ld	hl, #0x8a7a
	ld	(hl), #0x01
;main.c:146: sideDistX = FX_mul((mapX + 256 - posX) , deltaDistX);
	ld	l, #0x6a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a72
	ld	c, (hl)
	inc	hl
	ld	a, (hl)
	inc	a
	ld	b, a
	ld	hl, #0x8a3a
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	de
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a62), de
00107$:
;main.c:148: if(rayDirY < 0)
	ld	hl, #0x8a5e
	inc	hl
	bit	7, (hl)
	jr	Z, 00109$
;main.c:150: stepY = -1;
	ld	hl, #0x8a7c
	ld	(hl), #0xff
;main.c:151: sideDistY = FX_mul((posY - mapY) , deltaDistY);
	ld	l, #0x6e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a76
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	de
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a66), de
	jr	00110$
00109$:
;main.c:155: stepY = 1;
	ld	hl, #0x8a7c
	ld	(hl), #0x01
;main.c:156: sideDistY = FX_mul((mapY + 256 - posY) , deltaDistY);
	ld	l, #0x6e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a76
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0100
	add	hl, de
	ex	de, hl
	ld	hl, #0x8a3e
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	d, a
	push	bc
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	ld	(0x8a66), de
00110$:
;main.c:159: mapX_temp = FX_floor_int(mapX);
	ld	hl, #0x8a72
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	ld	hl, #0x8a86
	ld	(hl), a
;main.c:160: mapY_temp = FX_floor_int(mapY);
	ld	l, #0x76
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	ld	hl, #0x8a87
	ld	(hl), a
;main.c:162: char mapX_temp_temp2 = mapX_temp;
	ld	l, #0x86
	ld	c, (hl)
;main.c:165: char didhit = 0;
	ld	b, #0x00
;main.c:166: while(didhit == 0)
00116$:
	ld	a, b
	or	a, a
	jr	NZ, 00118$
;main.c:169: if(sideDistX < sideDistY)
	ld	hl, #0x8a62
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x8a66
	ld	a, (hl)
	ld	-2 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-1 (ix), a
	ld	a, e
	sub	a, -2 (ix)
	ld	a, d
	sbc	a, -1 (ix)
	jp	PO, 00337$
	xor	a, #0x80
00337$:
	jp	P, 00112$
;main.c:171: sideDistX += deltaDistX;
	ld	hl, #0x8a6a
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ex	de, hl
	ld	(0x8a62), de
;main.c:172: mapX_temp_temp2 += stepX;
	ld	a, (#0x8a7a)
	add	a, c
	ld	c, a
;main.c:173: side = 0;
	ld	hl, #0x8a7f
	ld	(hl), #0x00
	jr	00113$
00112$:
;main.c:177: sideDistY += deltaDistY;
	ld	hl, #0x8a6e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, -2 (ix)
	add	a, e
	ld	e, a
	ld	a, -1 (ix)
	adc	a, d
	ld	d, a
	ld	(0x8a66), de
;main.c:178: mapY_temp += stepY;
	ld	hl, #0x8a87
	ld	e, (hl)
	ld	a, (#0x8a7c)
	add	a, e
	ld	hl, #0x8a87
	ld	(hl), a
;main.c:179: side = 1;
	ld	l, #0x7f
	ld	(hl), #0x01
00113$:
;main.c:182: if(worldMap[mapX_temp_temp2][mapY_temp] > 0) didhit = 1;
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl, #_worldMap
	add	hl, de
	ex	de, hl
	ld	hl, #0x8a87
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
	ld	b, #0x01
	jp	00116$
00118$:
;main.c:213: if(side == 0) perpWallDist = (sideDistX - deltaDistX);
	ld	a, (#0x8a7f)
	or	a, a
	jr	NZ, 00120$
	ld	hl, #0x8a62
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a6a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	jr	00121$
00120$:
;main.c:214: else          perpWallDist = (sideDistY - deltaDistY);
	ld	hl, #0x8a66
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a6e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
00121$:
;main.c:217: char lineHeight = FX_floor_int( FX_div(FX(h) , perpWallDist));
	push	bc
	ld	hl, #0x4000
	push	hl
	call	_FX_div
	pop	af
	ex	(sp),hl
	call	_FX_floor_int
	pop	af
	ld	a, l
;main.c:220: drawStart = -lineHeight / 2 + h / 2;
	ld	e, a
	ld	d, #0x00
	ld	hl, #0x0000
	cp	a, a
	sbc	hl, de
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00172$
	inc	hl
	ld	c, l
	ld	b, h
00172$:
	sra	b
	rr	c
	ld	a, c
	add	a, #0x20
	ld	hl, #0x8a80
	ld	(hl), a
;main.c:221: if(drawStart < 0) drawStart = 0;
	ld	l, #0x80
	bit	7, (hl)
	jr	Z, 00123$
	ld	hl, #0x8a80
	ld	(hl), #0x00
00123$:
;main.c:222: drawEnd = lineHeight / 2 + h / 2;
	ld	c, e
	ld	b, d
	bit	7, d
	jr	Z, 00173$
	ld	c, e
	ld	b, d
	inc	bc
00173$:
	sra	b
	rr	c
	ld	a, c
	add	a, #0x20
	ld	hl, #0x8a81
	ld	(hl), a
;main.c:223: if(drawEnd >= h) drawEnd = h - 1;
	ld	l, #0x81
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0xc0
	jr	C, 00125$
	ld	hl, #0x8a81
	ld	(hl), #0x3f
00125$:
;main.c:225: if (drawStart < 0) drawStart = 0;
	ld	hl, #0x8a80
	bit	7, (hl)
	jr	Z, 00127$
	ld	hl, #0x8a80
	ld	(hl), #0x00
00127$:
;main.c:226: if (drawEnd < 0) drawEnd = 0;
	ld	hl, #0x8a81
	bit	7, (hl)
	jr	Z, 00129$
	ld	hl, #0x8a81
	ld	(hl), #0x00
00129$:
;main.c:223: if(drawEnd >= h) drawEnd = h - 1;
	ld	hl, #0x8a81
	ld	c, (hl)
;main.c:228: if (drawEnd > YMAX) continue;
	ld	a, #0x40
	sub	a, c
	jp	PO, 00338$
	xor	a, #0x80
00338$:
	jp	M, 00138$
;main.c:229: if (drawStart > drawEnd) drawStart = drawEnd;
	ld	hl, #0x8a80
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jp	PO, 00339$
	xor	a, #0x80
00339$:
	jp	P, 00133$
	ld	hl, #0x8a80
	ld	(hl), c
00133$:
;main.c:242: char rlx = FX_floor_int(x_temp);
	ld	hl, #0x8a82
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor_int
	pop	af
	ld	c, l
;main.c:244: for (char Q = 0; Q != SPEED_CO; Q++){
	ld	b, #0x00
00166$:
	ld	a, b
	dec	a
	jr	Z, 00138$
;main.c:245: if (side == 1)
	ld	hl, #0x8a7f
	ld	e, (hl)
;main.c:221: if(drawStart < 0) drawStart = 0;
	ld	hl, #0x8a80
	ld	d, (hl)
;main.c:223: if(drawEnd >= h) drawEnd = h - 1;
	ld	a, (#0x8a81)
;main.c:246: vertical_line(rlx, drawStart, drawEnd-drawStart, 0);
	sub	a, d
	ld	h, a
;main.c:245: if (side == 1)
	dec	e
	jr	NZ, 00135$
;main.c:246: vertical_line(rlx, drawStart, drawEnd-drawStart, 0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	l, d
	push	hl
	ld	a, c
	push	af
	inc	sp
	call	_vertical_line
	pop	af
	pop	af
	pop	bc
	jr	00136$
00135$:
;main.c:248: vertical_dotted_line(rlx, drawStart, drawEnd-drawStart, 0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	l, d
	push	hl
	ld	a, c
	push	af
	inc	sp
	call	_vertical_dotted_line
	pop	af
	pop	af
	pop	bc
00136$:
;main.c:249: rlx+=1;
	inc	c
;main.c:244: for (char Q = 0; Q != SPEED_CO; Q++){
	inc	b
	jr	00166$
00138$:
;main.c:100: for (x_temp = 0; x_temp!=(w*256); x_temp+=(256*SPEED_CO)){
	ld	hl, #0x8a82
	ld	c, (hl)
	inc	hl
	ld	a, (hl)
	inc	a
	ld	b, a
	ld	(0x8a82), bc
	jp	00169$
00139$:
;main.c:255: if (skClear == lastPressedKey())
	ld	hl, #0x843f
	ld	a, (hl)
	ld	-1 (ix), a
	sub	a, #0x0f
	jp	Z,00170$
;main.c:257: else if (skLeft == lastPressedKey()){
	ld	a, -1 (ix)
	sub	a, #0x02
	jp	NZ,00157$
;main.c:103: rayDirX = dirX+FX_mul(planeX, cameraX);
	ld	hl, #0x8a42
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;main.c:260: int oldDirX = dirX;
;main.c:261: dirX = FX_mul(dirX , crot) - FX_mul(dirY , srot);
	push	de
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	pop	bc
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x002b
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, -2 (ix)
	sub	a, e
	ld	e, a
	ld	a, -1 (ix)
	sbc	a, d
	ld	d, a
	ld	(0x8a42), de
;main.c:262: dirY = FX_mul(oldDirX , srot) + FX_mul(dirY , crot);
	ld	hl, #0x002b
	push	hl
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a46), bc
;main.c:103: rayDirX = dirX+FX_mul(planeX, cameraX);
	ld	hl, #0x8a4a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;main.c:263: int oldP__laneX = planeX;
;main.c:264: planeX = FX_mul(planeX , crot) - FX_mul(planeY , srot);
	push	de
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	pop	bc
	ld	hl, #0x8a4e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x002b
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, -2 (ix)
	sub	a, e
	ld	e, a
	ld	a, -1 (ix)
	sbc	a, d
	ld	d, a
	ld	(0x8a4a), de
;main.c:265: planeY = FX_mul(oldP__laneX , srot) + FX_mul(planeY , crot);
	ld	hl, #0x002b
	push	hl
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x8a4e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a4e), bc
	jp	00163$
00157$:
;main.c:267: else if (skRight == lastPressedKey()){
	ld	a, -1 (ix)
	sub	a, #0x03
	jp	NZ,00154$
;main.c:103: rayDirX = dirX+FX_mul(planeX, cameraX);
	ld	hl, #0x8a42
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;main.c:270: int oldDirX = dirX;
;main.c:271: dirX = FX_mul(dirX , crot) - FX_mul(dirY , srot);
	push	de
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	pop	bc
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0xffd3
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, -2 (ix)
	sub	a, e
	ld	e, a
	ld	a, -1 (ix)
	sbc	a, d
	ld	d, a
	ld	(0x8a42), de
;main.c:272: dirY = FX_mul(oldDirX , srot) + FX_mul(dirY , crot);
	ld	hl, #0xffd3
	push	hl
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a46), bc
;main.c:103: rayDirX = dirX+FX_mul(planeX, cameraX);
	ld	hl, #0x8a4a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;main.c:273: int oldP__laneX = planeX;
;main.c:274: planeX = FX_mul(planeX , crot) - FX_mul(planeY , srot);
	push	de
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	pop	bc
	ld	hl, #0x8a4e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0xffd3
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, -2 (ix)
	sub	a, e
	ld	e, a
	ld	a, -1 (ix)
	sbc	a, d
	ld	d, a
	ld	(0x8a4a), de
;main.c:275: planeY = FX_mul(oldP__laneX , srot) + FX_mul(planeY , crot);
	ld	hl, #0xffd3
	push	hl
	push	bc
	call	_FX_mul
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	hl, #0x8a4e
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #0x00fa
	push	hl
	push	de
	call	_FX_mul
	pop	af
	pop	af
	ex	de, hl
	pop	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	(0x8a4e), bc
	jp	00163$
00154$:
;main.c:278: else if (skUp == lastPressedKey()){
	ld	a, -1 (ix)
	sub	a, #0x04
	jp	NZ,00151$
;main.c:279: if(worldMap[FX_floor_int(posX + dirX )][FX_floor_int(posY)] == 0) posX += dirX>>1;
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a42
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	add	hl, bc
	push	hl
	call	_FX_floor_int
	pop	af
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#_worldMap
	add	hl,bc
	ex	de, hl
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	de
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	pop	de
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00141$
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a42
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	sra	h
	rr	l
	add	hl, bc
	ex	de, hl
	ld	(0x8a3a), de
00141$:
;main.c:280: if(worldMap[FX_floor_int(posX)][FX_floor_int(posY + dirY )] == 0) posY += dirY>>1;
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor_int
	pop	af
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#_worldMap
	add	hl,bc
	ex	de, hl
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a46
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	de
	push	hl
	call	_FX_floor_int
	pop	af
	ld	a, l
	pop	de
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	NZ, 00163$
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	sra	h
	rr	l
	add	hl, bc
	ex	de, hl
	ld	(0x8a3e), de
	jp	00163$
00151$:
;main.c:283: else if (skDown == lastPressedKey()){
	ld	a, -1 (ix)
	dec	a
	jp	NZ,00163$
;main.c:284: if(worldMap[FX_floor_int(posX - dirX )][FX_floor_int(posY)] == 0) posX -= dirX>>1;
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a42
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl, #_worldMap
	add	hl, de
	ex	de, hl
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	de
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	pop	de
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a42
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	sra	d
	rr	e
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	(0x8a3a), bc
00145$:
;main.c:285: if(worldMap[FX_floor_int(posX)][FX_floor_int(posY - dirY )] == 0) posY -= dirY>>1;
	ld	hl, #0x8a3a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl, #_worldMap
	add	hl, de
	ex	de, hl
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a46
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	de
	push	bc
	call	_FX_floor_int
	pop	af
	ld	a, l
	pop	de
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	NZ, 00163$
	ld	hl, #0x8a3e
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x8a46
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	sra	d
	rr	e
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	(0x8a3e), bc
	jp	00163$
00170$:
;main.c:291: }
	ld	sp, ix
	pop	ix
	ret
_worldMap:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
