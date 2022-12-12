#define USE_HEXDUMP
#define USE_WAIT8
#define USE_CPU_SPEED
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/misc.c"
#include "../../lib/userinput.c"
#include "../../lib/variables.c"


#include "../../lib/greyscale.c"

#include "calibrate.c"

#define dataName addAppVarObj("greycfg")

void real_main(){
	volatile char* dataLoc=getOrCreateVar(dataName, 10)+2;
	INIT_GREYSCALE();
	if (!( *dataLoc == 0x69     &&     *(dataLoc+3) == 0x69      )){

		*dataLoc     = 0x69;   // check integrity 

		*(dataLoc+1) = 0x9f;   // wait
		*(dataLoc+2) = 0x14;   // contrast

		*(dataLoc+3) = 0x69;   // check integrity
		*(char*)WAIT_LOC     = 0x9f;
		*(char*)CONTRAST_LOC = 0x14;
		calibration_menu(dataLoc);
	}
	*(char*)WAIT_LOC     = *(dataLoc+1);
	*(char*)CONTRAST_LOC = *(dataLoc+2);
	
	while (1){
		wait(4);
		
		scanKeys();
		if (skClear == lastPressedKey())
			break;
		else if (skMode == lastPressedKey()){
			calibration_menu(dataLoc);
		}
		

		
	}


	archive(dataName); 




}


void main() {

	clearScreen();
	resetPen();


	clearGreyScaleBuffer();
	

	real_main(); // sdcc for some reason dose things with ix and sp that mean you need to use another func after INIT_GREYSCALE, 
	             // its a bug, but not a bad bug. Im not going to rewrite sdcc because of this


}