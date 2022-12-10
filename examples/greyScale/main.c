#define USE_WAIT8
#define USE_CPU_SPEED
#define USE_HEXDUMP
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"


#include "../../lib/greyscale.c"


void make_gradient(){
	int light = LIGHT_GREY_LOC;
	int dark = DARK_GREY_LOC;
	for (char b = YMAX-8; b !=0; b--){
		*((char*)light) = 0xFF;
		*((char*)light+1) = 0xFF;
		*((char*)dark) = 0xFF;
		*((char*)dark+1) = 0xFF;
		*((char*)dark+2) = 0xFF;
		*((char*)dark+3) = 0xFF;
		*((char*)light+4) = 0xFF;
		*((char*)light+5) = 0xFF;
		light+=6;
		dark+=6;
	}
}


void main() {
	// setCpuSpeed(3);
	clearGreyScaleBuffer();
	INIT_GREYSCALE();
	*((char*)START_ROW)=ROW_CONST+8;
	*((char*)MAX_COL)=6;


	// lastC=0;
	// lastW=0;
	clearScreen();
	setCpuSpeed(3);
	make_gradient();

	while (1){
		wait(4);
		
		scanKeys();
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
		// 	lastC=*(char*)CONTRAST_LOC;
		// 	lastW=*(char*)WAIT_LOC ;
			resetPen();
			hexdump(*(char*)WAIT_LOC);
			hexdump(*(char*)CONTRAST_LOC);
		// 	// drr();
		// }
		
	}

	setCpuSpeed(0);

}	
