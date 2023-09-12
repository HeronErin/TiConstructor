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
;main.c:24: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:26: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:27: resetPen();
	call	_resetPen
;main.c:29: println("Hello 8-bit World!");
	ld	hl, #___str_0
	push	hl
	call	_println
;main.c:31: FX_number(FX(12.34));
	ld	hl, #0x0c57
	ex	(sp),hl
	call	_FX_number
	pop	af
;main.c:33: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:35: }
	ret
___str_0:
	.ascii "Hello 8-bit World!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
