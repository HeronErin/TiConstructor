#pragma once

#include "textio.c"


/** @file fast_math.c
 * @brief Fast math operations, and some 16-bit fixed point path
 * 
 * Faster then fixedpoint.c but more complex and less precise. Uses 16 bit (int) for fixed point math (8 for decimal and 8 for fraction).
 * It should be noted that if you are worried about the size of your program, this is quite a large file. 
 * 
 * Mostly sourced from https://wikiti.brandonw.net/index.php?title=Category:Z80_Routines
 * 
 * <h3> Optional #defines </h3>
 * 
 *  + <b>FX_TRIG</b> - Enables FX_sine(), FX_cos(), and FX_tan()
 * 
 */


/**  @brief Inline compile time fixed point number
 * 	 @param[R] Number to be converted
 * 	 @return Fixed point number
 * 		
 * 	 This is used to create a fixed point number at compile time, highly <b><i>NOT</i></b> recommended to use at run time, or with anything other than a literal. 
 */
#define FX(R) (int)((R) > 0 ? (R)*256 :  0xFFFF-((-(R)) *256)  )


/** @brief Fixed point number to char number
 *  @param[f] Number to be converted
 *  @return char
 */
char FX_floor_int(int f)__naked{
	__asm
		pop hl      ; Get input
		pop af      ; and perserve
		push af
		push hl     ; ret value
		ld l, a
		ret
	__endasm;
}
/** @brief Round fixed point number
 *  @param[f] Number to be rounded
 *  @return Another fixed point number
 */
int FX_floor(int f)__naked{
	__asm
		pop de      ; Get input
		pop hl      ; and perserve
		push hl
		push de     ; ret value

		xor a, a
		ld l, a
		ret
	__endasm;
}
 
/** @brief Gets the square root of a 16-bit intager to a 8 bit char
 *  @param[x] A 16-bit INTEGER (<b>NOT</b> fixed point number) 
 *  @return A rounded char of the sqrt(x) 
 */ 
char sqrt_rounded(int x)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value
		
		ld l, b
		ld a, c
		call ___fast_16_bit_sqrt_asm
		ld l, d
		ret
	__endasm;
}
/** @brief Multiple two 16-bit ints together
 *  @param[x] A 16-bit int (<b>NOT</b> fixed point number) 
 *  @param[y] Another 16-bit int (<b>NOT</b> fixed point number) 
 *  @return A long(32-bit) value of x*y
 */ 
long mul_int(int x, int y)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		pop de
		push de
		push bc
		push hl     ; ret value

		jp ___mult_de_bc ; Jp instead of call saves time due to ___mult_de_bc having the same output as long
	__endasm;
}
/** @brief Divide two 16-bit ints together
 *  @param[x] A 16-bit int (<b>NOT</b> fixed point number) 
 *  @param[y] Another 16-bit int (<b>NOT</b> fixed point number) 
 *  @return A 16-bit int of x/y
 */ 
int div_int(int x, int y)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		pop de
		push de
		push bc
		push hl     ; ret value

		ld a, b
		call ___div_ac_de 

		ld h, a
		ld l, c
		ret
	__endasm;
}

/** @brief Multiple two 16-bit fixed point numbers
 *  @param[x] A 16-bit fixed point number
 *  @param[y] Another 16-bit fixed point number
 *  @return The fixed point result of x*y
 */ 
int FX_mul(int x, int y)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		pop de
		push de
		push bc
		push hl     ; ret value

		#ifdef FORCE_FAST_MATH_CORRECT_SIGN
							res 1, asm_Flag1(iy)
							bit 7,d
							jp z, nxtt
								set 1, asm_Flag1(iy)
								xor a 
								 sub e 
								 ld e,a
								sbc a,a 
								 sub d 
								  ld d,a
							nxtt:
					        bit 7,b
					 			  jp z, aftttt
					        bit 1, asm_Flag1(iy)
					        jp z, Uaid
					        res 1, asm_Flag1(iy)
					        jp hejaka

					Uaid:   set 1, asm_Flag1(iy)
					hejaka:
					        xor a 
					         sub c 
					          ld c,a
					        sbc a,a 
					         sub b 
					          ld b,a

					    aftttt:
		#endif
		call ___mult_de_bc

		ld l, h
		ld h, e

		
		#ifdef FORCE_FAST_MATH_CORRECT_SIGN
				bit 1, asm_Flag1(iy)
				ret z
					xor a 
					 sub l 
					  ld l,a
					sbc a,a 
					 sub h 
					  ld h,a
		#endif
		ret
	__endasm;
}


/** @brief Divide two 16-bit fixed point numbers
 *  @param[x] A 16-bit fixed point number
 *  @param[y] Another 16-bit fixed point number
 *  @return The fixed point result of x/y
 * 
 *  <small>Takes about 1800 t-states (+-500)</small>
 */ 
int FX_div(int x, int y)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		pop de
		push de
		push bc
		push hl     ; ret value

		#ifdef FORCE_FAST_MATH_CORRECT_SIGN
							res 1, asm_Flag1(iy)
							bit 7,d
							jp z, _nxtt
								set 1, asm_Flag1(iy)
								xor a 
								 sub e 
								 ld e,a
								sbc a,a 
								 sub d 
								  ld d,a
							_nxtt:
					        bit 7,b
					 			  jp z, _aftttt
					        bit 1, asm_Flag1(iy)
					        jp z, _Uaid
					        res 1, asm_Flag1(iy)
					        jp _hejaka

					_Uaid:   set 1, asm_Flag1(iy)
					_hejaka:
					        xor a 
					         sub c 
					          ld c,a
					        sbc a,a 
					         sub b 
					          ld b,a

					    _aftttt:
		#endif


		push ix
		ld ix, #0
		.db 0xDD, 0x61 ; ld ixh, c
		ld a, #0
		ld c, b

		// ld de, #0x0700


		call ___div_32_by_16
		push ix
		pop hl


		pop ix
		// ld hl, #123
		#ifdef FORCE_FAST_MATH_CORRECT_SIGN
				bit 1, asm_Flag1(iy)
				ret z
					xor a 
					 sub l 
					  ld l,a
					sbc a,a 
					 sub h 
					  ld h,a
		#endif
		ret
	__endasm;
}

/** @brief Take the sqrt of a fixed point number
 *  @param[x] A 16-bit fixed point number
 *  @return The fixed point result of sqrt(x)
 */ 
int FX_sqrt(int x)__naked{
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value

		ld l, b
		ld a, c
		call ___fast_16_bit_sqrt_asm
		ld h, d
		ld l, #0
		; Bit shift by 4
			srl    h
			rr     l
			srl    h
			rr     l
			srl    h
			rr     l
			srl    h
			rr     l

		ret
	__endasm;
}


/** @brief Take the abs of a fixed point number
 *  @param[x] A 16-bit fixed point number
 *  @return The fixed point result of abs(x)
 * 
 * <small> Taken from https://learn.cemetech.net/index.php?title=Z80:Math_Routines#absHL </small>
 */ 
int FX_abs(int x)__naked{
	__asm
			pop de
			pop hl
			push hl
			push de

      bit 7,h
      ret z
      xor a 
       sub l 
        ld l,a
      sbc a,a 
       sub h 
        ld h,a
			ret
	__endasm;
}

/** @brief Print a fixed point number to the screen
 *  @param[x] A 16-bit fixed point number
 */ 
void FX_number(int x)__naked{
	__asm
		pop de
		pop hl
		
		ld a, h
		or a, a
		
		jp p, LOLLL
		; Handle negative
			cpl
			ld h, a
			ld a, l
			cpl
			ld l, a 

			push hl 
			push de
			push ix
			ld a, #'-'
			abcall(_VPutMap)
			pop ix
			pop de
			pop hl
		LOLLL:
		push hl
		push de

		set 0, asm_Flag1(iy)
		push hl
	_NUM_LOOP_FM:
		ld l, h
		ld h, #0
		push hl
		call	_number
		pop af

		bit 0, asm_Flag1(iy)
		jp z, AFTR_DEC
		ld a, #'.'
		push ix
		abcall(_VPutMap)
		pop ix
	AFTR_DEC:

		pop hl
		ld h, #0


		ld c, l
		; Mul 10
		SLA    l
		rl     h
		ld d, h
		ld e, l
		SLA    e
		rl     d
		SLA    e
		rl     d


		add hl, de

		push hl

		

		res 0, asm_Flag1(iy)
		ld a, c
		or a
		jp nz, _NUM_LOOP_FM

		POP AF	

		ret
	__endasm;
}




/** 
 * @brief <b>Assembly</b> 16-bit Square Root routine
 * 
 * <h2> <b> ONLY CALL FROM ASM </b> </h2>
 * 
 * <b>la</b> is the 16-bit operand and <b>D</b> is the 8-bit result.
 */
void __fast_16_bit_sqrt_asm()__naked{
	__asm

	ld	de, #0x0040	; 40h appends "01" to D
	ld	h, d
	
	ld	b, #7
	
	; need to clear the carry beforehand
	or	a, a
	
_loop:
	sbc	hl, de
jrpt:	jr	nc, #jrpt+3
	add	hl, de
	ccf
	rl	d
	rla
	adc	hl, hl
	rla
	adc	hl, hl
	
	djnz	_loop
	
	sbc	hl, de		; optimised last iteration
	ccf
	rl	d
	
	ret
 
	__endasm;

}


/** 
 * @brief <b>Assembly</b> 16-bit multiplication routine
 * 
 * <h2> <b> ONLY CALL FROM ASM </b> </h2>
 * 
 * <b>bc</b> by <b>de</b> and places the result in <b>dehl.</b>
 */
void __mult_de_bc()__naked{ 
	__asm
		ld	hl, #0

		sla	e		; optimised 1st iteration
		rl	d
gyaq:	jr	nc, #gyaq+4
		ld	h, b
		ld	l, c

		ld	a, #15
	_mlloop:
		add	hl, hl
		rl	e
		rl	d
umgp:	jr	nc, #umgp+6
		add	hl, bc
lrjp:	jr	nc, #lrjp+3
		inc	de

		dec	a
		jr	nz, _mlloop

		ret
	__endasm;
}


/** 
 * @brief <b>Assembly</b> 32-bit by 16-bit division routine
 * 
 * <h2> <b> ONLY CALL FROM ASM </b> </h2>
 * 
 * 
 * IN:	<b>ACIX</b>=dividend, <b>DE</b>=divisor
 * OUT:	<b>ACIX</b>=quotient, <b>DE</b>=divisor, <b>HL</b>=remainder, <b>B</b>=0
 * 
 */
void __div_32_by_16()__naked{
	__asm
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
		inc ix // .db	0xDD,0x2C		; inc ixl, change to inc ix to avoid undocumented
		djnz	Div32By16_Loop
		ret
	__endasm;
}



/** 
 * @brief <b>Assembly</b> 16-bit division routine
 * 
 * <h2> <b> ONLY CALL FROM ASM </b> </h2>
 * 
 * This <b>assembly</b> routine divides <b>ac</b> by <b>de</b> and places the quotient in <b>ac</b> and the remainder in <b>hl</b>
 */
void __div_ac_de()__naked{
	__asm
	ld	hl, #0
	ld	b, #16

	_jqaloop:
		.db 0xCB, 0x31  ; sll	c
		rla
		adc	hl, hl
		sbc	hl, de
ijyq:	jr	nc, #ijyq+4
		add	hl, de
		dec	c

	djnz	_jqaloop

	ret
	__endasm;
}


/** @{ \name Fixed point trig functions (requires #define FX_TRIG)
 */
#if defined(FX_TRIG) || defined(DOXYGEN)

/** @brief Fixed point sine lookup table. Takes up 360 bytes  */
const int FX_sine_lookup[] =  {4, 13, 22, 31, 40, 48, 57, 66, 74, 83, 91, 100, 108, 116, 124, 131, 139, 146, 154, 161, 167, 174, 181, 187, 193, 198, 204, 209, 214, 219, 223, 228, 232, 235, 238, 242, 244, 247, 249, 251, 252, 254, 255, 255, 255, 255, 255, 255, 254, 252, 251, 249, 247, 244, 242, 238, 235, 232, 228, 223, 219, 214, 209, 204, 198, 193, 187, 181, 174, 167, 161, 154, 146, 139, 131, 124, 116, 108, 100, 91, 83, 74, 66, 57, 48, 40, 31, 22, 13, 4, -4, -13, -22, -31, -40, -48, -57, -66, -74, -83, -91, -100, -108, -116, -124, -131, -139, -146, -154, -161, -167, -174, -181, -187, -193, -198, -204, -209, -214, -219, -223, -228, -232, -235, -238, -242, -244, -247, -249, -251, -252, -254, -255, -255, -255, -255, -255, -255, -254, -252, -251, -249, -247, -244, -242, -238, -235, -232, -228, -223, -219, -214, -209, -204, -198, -193, -187, -181, -174, -167, -161, -154, -146, -139, -131, -124, -116, -108, -100, -91, -83, -74, -66, -57, -48, -40, -31, -22, -13, -4};

/** @brief Fixed point sine operation
 *  @param[deg] A degree as an INTEGER 
 *  @return The fixed point sine value
 */
int FX_sine(int deg){

	int ret = FX_sine_lookup[(deg%360)/2];

	return ret;
}
/** @brief Fixed point cosine operation
 *  @param[deg] A degree as an INTEGER 
 *  @return The fixed point cosine value
 */
int FX_cos(int deg){
  return FX_sine(deg+90);
}
/** @brief Fixed point tangent operation
 *  @param[deg] A degree as an INTEGER 
 *  @return The fixed point tangent value
 */
int FX_tan(int deg){
  return FX_div(FX_sine(deg), FX_sine(deg+90));
}

#endif


/** @} */

