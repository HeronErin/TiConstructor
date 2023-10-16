#define USE_WAIT8

#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"


// Called from inside interupt after page is swapped back (in apps)
#define USER_INTERUPT _my_interupt

#include "../../lib/interupt_loader.c"


#define safepoint 0xFFFF // 0xFFFF is a free byte apparently

void my_interupt()__naked{
	#asm
		in a, (4) // port 4 bit 3 tests if on button is pressed
		bit 3, a

		ret nz // Return if on button is not pressed
	
	#endasm 
		scanKeys(); // Scan for pressed keys since we are not using system interupts
	#asm

		inc (iy+asm_Flag3) // Only happen every 256 interupts
		jp z, AFTER_RET_OF_INTERUPT
		
		CI_RET
		AFTER_RET_OF_INTERUPT:

		ld a, (safepoint) // Pattern byte
		rrca // Rotate right
		ld (safepoint), a // Save back
		out (0x11), a // Output to screen


		CI_RET // Custom return that overides system interupts
	#endasm
}


void main() {
	bcall((0x4570)); // Disable the annoying "busy" indicator so it won't interfear with the drawing.
	*(unsigned char*)(safepoint) = 0b11001100;
	patch_ram();
	#asm
	xor a, a
	ld (iy+asm_Flag3), a
	#endasm
	
	clearScreen();

	while (1){
		wait(2);
		
		if (skClear == lastPressedKey())
			return;
	}



}
