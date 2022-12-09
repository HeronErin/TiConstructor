#define USE_WAIT8
#define USE_CPU_SPEED
#define USE_HEXDUMP
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"


#include "../../lib/greyscale.c"




void main() {
	INIT_GREYSCALE();
	setCpuSpeed(3);

	

	clearScreen();

	while (1){
		wait(4);
		
		if (skClear == lastPressedKey())
			break;
		else if (skLeft == lastPressedKey()){
			*(char*)WAIT_LOC -=1;
		}
		else if (skRight == lastPressedKey()){
			*(char*)WAIT_LOC +=1;
		}
		else if (skUp == lastPressedKey()){
			*(char*)CONTRAST_LOC +=1;
		}
		else if (skDown == lastPressedKey()){
			*(char*)CONTRAST_LOC -=1;
		}
		// if (( *(char*)WAIT_LOC != lastW ) | ( *(char*)CONTRAST_LOC != lastC ) ){
			// lastC=;
			// lastW= ;
			resetPen();
			hexdump(*(char*)WAIT_LOC);
			hexdump(*(char*)CONTRAST_LOC);

		
	}

	setCpuSpeed(0);

}	
