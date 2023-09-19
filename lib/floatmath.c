

/** @file floatmath.c @brief Use the built in calculator floating point math
 * 
 * 
 * This library interfaces with the full normal calc float rutines. This is highly accurate but not very flexible with asm programs
 * Also everything here is realitivly slow compared to intiger or fixed point math. <b> And keep in mind that a bcall might modify registers, meaning that any bcall can corrupt any C variable </b>
 * See: https://taricorp.gitlab.io/83pa28d/lesson/week3/day18/index.html
 */











/** @{ \name floating point stack stuff */
#define FPS 0x9824

/** @{ \name Only odd op push and pops seem to exist */

#define PushOP1()bcall(0x43C9)
#define PushOP5()bcall(0x43C0)
#define PushOP3()bcall(0x43C3)

#define PopOP5()bcall(0x4378)
#define PopOP3()bcall(0x437B)
#define PopOP1()bcall(0x437E)

/** @} */
/** @} */



/** @{ \name Stores op1 to variable */
#define OP1_TO_ANS() bcall(0x4ABF)
#define Store_Theta() bcall(0x4AC2)
#define Store_R() bcall(0x4AC5)
#define Store_Y() bcall(0x4AC8)
#define Store_N() bcall(0x4ACB)
#define Store_T() bcall(0x4ACE)
#define Store_X() bcall(0x4AD1)

/** @} */


/** @{ \name Math operations */

/** @brief op1 = floor(op1) */
#define MATH_FLOOR() bcall(0x405D)
/** @brief op1 = ceil(op1) */
#define MATH_CEIL() bcall(0x489A)
/** @brief 10 ^ (op1) not sure the use of this but its here */
#define TEN_TO_THE_POWER_OF_OP1() bcall(0x40B7)
/** @brief op1 += 1 */
#define INC_OP1() bcall(0x4069)
/** @brief op1 -= 1 */
#define DEC_OP1() bcall(0x406C)
/** @brief op1 = -op1 */
#define NEG_OP1() bcall(0x408D)
/** @brief op1 *= 2 */
#define DOUBLE_OP1() bcall(0x4066)
/** @brief op1 += op2 */
#define FP_ADD() bcall(0x4072)
/** @brief op1 -= op2 */
#define FP_SUB() bcall(0x406F)
/** @brief op1 *= op2 */
#define FP_MULT() bcall(0x4084)
/** @brief op1 /= op2 */
#define FP_DIV()  bcall(0x4099)
/** @brief op1 = op1 * op1 */
#define SQUARE_OP1() bcall(0x4081)
/** @brief op1 = op1 * op1 * op1 */
#define CUBE_OP1() bcall(0x407B)
/** @brief op1 = sqrt( op1 ) */
#define SQ_ROOT_OP1() bcall(0x409C)
/** @brief op1 = 1/op1 */
#define FP_Recip() bcall(0x4096)
/** @brief op1 = Pi/180 * op1 may be bigger than 2pi */
#define DEG_TO_RAD() bcall(0x4075)

/** @{ \name SUPER SLOW !!!! DON'T USE UNLESS NECESSARY 
around 150,000 to 200,000 cycles, the base clock is 8 mhz and turbo is 16  */
/** @brief op1 = tan(op1) */
#define Tan() bcall(0x40C3)
/** @brief op1 = Sin( op1 ) */
#define Sin() bcall(0x40BD)
/** @brief op1 = cos( op1 ) */
#define Cos() bcall(0x40C0)

/** @} */
/** @} */


/** @{ \name op(n) load instructions */

#define OP3ToOP4() bcall(0x4114)
#define OP1ToOP4() bcall(0x4117)
#define OP2ToOP4() bcall(0x411A)
#define OP4ToOP2() bcall(0x411D)
#define OP1ToOP3() bcall(0x4123)
#define OP5ToOP2() bcall(0x4126)
#define OP5ToOP6() bcall(0x4129)
#define OP5ToOP4() bcall(0x412C)
#define OP1ToOP2() bcall(0x412F)
#define OP6ToOP2() bcall(0x4132)
#define OP6ToOP1() bcall(0x4135)
#define OP4ToOP1() bcall(0x4138)
#define OP5ToOP1() bcall(0x413B)
#define OP3ToOP1() bcall(0x413E)
#define OP6ToOP5() bcall(0x4141)
#define OP4ToOP5() bcall(0x4144)
#define OP3ToOP5() bcall(0x4147)
#define OP2ToOP5() bcall(0x414A)
#define OP2ToOP6() bcall(0x414D)
#define OP1ToOP6() bcall(0x4150)
#define OP1ToOP5() bcall(0x4153)
#define OP2ToOP1() bcall(0x4156)
#define OP2ToOP3() bcall(0x416E);
#define OP4ToOP3() bcall(0x4171);
#define OP5ToOP3() bcall(0x4174);
#define OP4ToOP6() bcall(0x4177);

/** @} */

/** @{ \name Easy default values sets and op value to a whole number */

#define OP4Set1() bcall(0x4186)
#define OP3Set1() bcall(0x4189)
#define OP2Set8() bcall(0x418C)
#define OP2Set5() bcall(0x418F)
#define OP2SetA() bcall(0x4192)
#define OP2Set4() bcall(0x4195)
#define OP2Set3() bcall(0x4198)
#define OP1Set1() bcall(0x419B)
#define OP1Set4() bcall(0x419E)
#define OP1Set3() bcall(0x41A1)
#define OP3Set2() bcall(0x41A4)
#define OP1Set2() bcall(0x41A7)
#define OP2Set2() bcall(0x41AA)
#define OP2Set1() bcall(0x41AD)
#define OP5Set0() bcall(0x41B3)
#define OP4Set0() bcall(0x41B6)
#define OP3Set0() bcall(0x41B9)
#define OP2Set0() bcall(0x41BC)
#define OP1Set0() bcall(0x41BF)

/** @} */


int OPT1_TO_INT(){ // if greater than 9999 errors
	bcall(_ConvOP1);
	__asm
		EX DE, HL
	__endasm;
}
void MoveToOp1(int v){
	__asm
		ld	hl, #0 + 4
		add	hl, sp
		ld	e, (hl)
		inc	hl
		ld	d, (hl)

		EX DE, HL
	__endasm;
	bcall(_Mov9ToOP1);
}
void MoveOp1To(unsigned int v){
	unsigned int op =OP1;
	for (char i = 9; i!=0; i--){
		*(char*)v = *(char*)op;
		op++;
		v++;
	}

}

#define PRINT_OP1  __asm \
					ld a, #6 __endasm;\
					bcall(_DispOP1A)


// Taken and moded from Xeda112358
// https://www.cemetech.net/forum/viewtopic.php?t=1449&postdays=0&postorder=asc&start=126
#ifdef USE_CHAR_TO_OP1
void charToOp1(char x){


    __asm
        ld  hl, #0 + 4
        add hl, sp
        ld  a, (hl)

        ld hl,#OP1


        ld bc,#0x0700
        ld (hl),c
        inc hl
        ld (hl),#0x83
        ld d,h
        ld e,l

        inc hl
        ld (hl),c
        $00000:djnz $00000-2


        or a
        jp Z, EOFFF    ;If A is zero, exit early. +227cc

        ld l,a          ;\
        ld h,c          ; |
        add hl,hl       ; |Start converting A to BCD
        add hl,hl       ; |
        add hl,hl       ; |
        add hl,hl       ; |

        ld a,h
        daa
        rl l    ; |Finish converting A to BCD

        adc a,a
        daa
        rl l    ; |Number is in LA
        adc a,a
        daa
        rl l    ; |
        adc a,a
        daa
        rl l    ; |
        adc a,a
        daa
        rl l    ;/ +132cc


        ex de,hl

        $00001:jr nz,$00001+6 
        ld e,a
        xor a
        ld (hl),#0x81    ;+(21+4/85)cc


        inc hl
        ld (hl),e
        inc hl
        ld (hl),a
        ld a,e
        and #0xF0
        jp nz, EOFFF      ;+48cc
        rld         ;\ Rotate up 1 digit
        dec hl      ; |
        rld         ; |
        dec hl      ; |
        dec (hl)    ; |Decrement exponent


        EOFFF:
    __endasm;
}
#endif

#ifdef USE_INT_TO_OP1
void intToOp1(int x){
	__asm
		ld	hl, #0 + 4
		add	hl, sp
		ld	c, (hl)
		inc	hl
		ld	b, (hl)

		push bc


		; loads 128 to op1
		ld	a, #128
		push	af
		inc	sp
		call	_charToOp1
		inc	sp
	__endasm;
		DOUBLE_OP1();

		OP1ToOP2();

		// 256 to op2

		// upper byte to op1

	__asm
		pop bc
		push bc

		ld	a, b
		push	af
		inc	sp
		call	_charToOp1
		inc	sp
	__endasm;
	// op1 now upper byte
	FP_MULT();
	
	OP1ToOP2();


	// add lower byte
	__asm
		pop bc

		ld	a, c
		push	af
		inc	sp
		call	_charToOp1
		inc	sp
	__endasm;

	FP_ADD();
	if (0 > x)
		NEG_OP1();
}
#endif