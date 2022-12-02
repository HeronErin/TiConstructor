#define USE_FIXED_PRINT
#define USE_FIXED_MULT
#define USE_FIXED_DIV
#define USE_SET_PIX
#define USE_FIXED_SIN
#include <stdint.h>


#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"
#include "../../lib/graphics.c"

#include "../../lib/fixedpoint.c"

void cool_sine_asm();


// void aa(uint64_t a){}
void main() {
	clearScreen();
	resetPen();
	clearBuffer();

	cool_sine_asm();
	

	// 2 * PI * r = c
	fputs("2 * \xC4 * 40.512 = ");
	fixedpt x = FXX(40.512);
	x = x <<1; // bitshift 1 is the same as *2, but faster
	x = fixed_mult(x, fixed_PI);
	fixed_print(x);
	newline();
	newline();

	// PI * r^2 = c
	fputs("\xC4 * 52.673^2 = ");
	x = FXX(52.673);
	x = fixed_mult(x, x);
	x = fixed_mult(x, fixed_PI);
	fixed_print(x);
	newline();
	newline();

	fputs("\xC4 \xD1 E * 180 \xD1 \xC4 = ");
	x = fixed_div(fixed_PI, fixed_E);
	fixed_print(fixed_div(  fixed_mult(x, FXX(180)), fixed_PI) );
	

	PressAnyKey();

}

// this is a bit more advanced
void cool_sine_asm(){
		for (char b = XMAX/4; b!=0; b--){
		char c = (b-1)*4;
		fixedpt sn = fixed_mult(fixed_sin(c<<3), FXX(5));


		fixed_to_int(sn); // c functions return ints in the hl register

		// use assembly to bypass sdcc issues
		__asm  // just mults b by 4 and uses the int from fixed_to_int for the height
			ld a, l     
			add a, #YMAX-10 // adds YMAX-10 to the number from fixed_to_int
			ld h, a


			ld	a, -1 (ix) // b *4
			add a, a
			add a, a 
			ld l, a

			// call setPix 4 times with x++ each time
			
			push hl  // push hl (Y, X) onto the stack
			call _setPix 
			pop hl // retrive hl (Y, X) from the stack
			inc hl // add one to hl, effectivly adds one to X
			
			push hl // repeate 3 more times
			call _setPix
			pop hl
			inc hl
			push hl
			call _setPix
			pop hl
			inc hl
			push hl
			call _setPix
			pop hl
		__endasm;
	}

	swap();
}