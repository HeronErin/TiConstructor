#define USE_WAIT8

#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"

// called during interupts
void interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
  						 // and the z80 only has ome core
	scanKeys();
	__asm
		xor a, a
		out (#0x31),a


		in a, (4) // port 4 bit 3 tests if on button is pressed
		bit 3, a

		ret nz
		
		call #0x000B // wait for lcd to be ready
		
		ld a, #0xFF // draws black line on current screen pos
		out (0x11), a

		ret

	__endasm;
}


#define DURING_INTERUPT() interupt() // runs every interupt

#include "../../lib/interupts.c"

void main() {

	SET_INTERUPTS();


	clearScreen();

	while (1){
		wait(1);
		
		if (skClear == lastPressedKey())
			break;
	}



}
