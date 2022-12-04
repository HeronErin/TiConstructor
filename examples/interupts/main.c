#define USE_WAIT8
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"

// Must be "static inline" for flash apps, and in flash apps you can't call any functions in an interupt
static inline void interupt() {
	__asm
		in a, (4) // port 4 bit 3 tests if on button is pressed
		bit 3, a
		jr nz, 00001$ // jr must be used if you are using a "static inline" function 
		
		call #0x000B // wait for lcd to be ready
		
		ld a, #0xFF // draws black line on current screen pos
		out (0x11), a

		00001$:

	__endasm;
}


#define OVERIDE_INTERUPTS
#define DURING_INTERUPT() interupt() // runs every interupt

#include "../../lib/interupts.c"

void main() {
	
	SET_INTERUPTS();


	clearScreen();
	resetPen();

	while (1){
		wait(1);
		scanKeys();
		if (skClear == lastPressedKey())
			break;
	}
	println("v");
	PressAnyKey();

}
