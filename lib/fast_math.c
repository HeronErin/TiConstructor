#pragma once

#include "textio.c"
// Faster then fixedpoint.c but more complex and less precise
// Mostly sourced from https://wikiti.brandonw.net/index.php?title=Category:Z80_Routines

// #define FX(rdtfyhjik) ( (rdtfyhjik) * (1<<8))
#define FX(R) (int)((R) > 0 ? (R)*256 :  0xFFFF-((-(R)) *256)  )

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

// Gets the square root of a 16-bit intager to a 8 bit char
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
// About 1800 t-states (+-500)
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

// https://learn.cemetech.net/index.php?title=Z80:Math_Routines#absHL
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



// ;-------------------------------
// ;Square Root
// ;Inputs:
// ;la = number to be square rooted
// ;Outputs:
// ;D  = square root


// ONLY CALL FROM ASM
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

// bc by de and places the result in dehl.
// ONLY CALL FROM ASM
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


// ; IN:	ACIX=dividend, DE=divisor
// ; OUT:	ACIX=quotient, DE=divisor, HL=remainder, B=0
// ONLY CALL FROM ASM
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



// The following routine divides ac by de and places the quotient in ac and the remainder in hl
// ONLY CALL FROM ASM
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



#ifdef FX_TRIG
const int FX_sine_lookup[] =  {4, 13, 22, 31, 40, 48, 57, 66, 74, 83, 91, 100, 108, 116, 124, 131, 139, 146, 154, 161, 167, 174, 181, 187, 193, 198, 204, 209, 214, 219, 223, 228, 232, 235, 238, 242, 244, 247, 249, 251, 252, 254, 255, 255, 255, 255, 255, 255, 254, 252, 251, 249, 247, 244, 242, 238, 235, 232, 228, 223, 219, 214, 209, 204, 198, 193, 187, 181, 174, 167, 161, 154, 146, 139, 131, 124, 116, 108, 100, 91, 83, 74, 66, 57, 48, 40, 31, 22, 13, 4, -4, -13, -22, -31, -40, -48, -57, -66, -74, -83, -91, -100, -108, -116, -124, -131, -139, -146, -154, -161, -167, -174, -181, -187, -193, -198, -204, -209, -214, -219, -223, -228, -232, -235, -238, -242, -244, -247, -249, -251, -252, -254, -255, -255, -255, -255, -255, -255, -254, -252, -251, -249, -247, -244, -242, -238, -235, -232, -228, -223, -219, -214, -209, -204, -198, -193, -187, -181, -174, -167, -161, -154, -146, -139, -131, -124, -116, -108, -100, -91, -83, -74, -66, -57, -48, -40, -31, -22, -13, -4};

int FX_sine(int deg){

	int ret = FX_sine_lookup[(deg%360)/2];

	return ret;
}
int FX_cos(int deg){
  return FX_sine(deg+90);
}
int FX_tan(int deg){
  return FX_div(FX_sine(deg), FX_sine(deg+90));
}
#endif