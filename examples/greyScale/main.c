#define USE_WAIT8
#define USE_CPU_SPEED
#define USE_HEXDUMP
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/misc.c"


#define USER_INTERUPT _x_test
#define _LCD_BUSY_QUICK 0x000B


#include "../../lib/interupt_loader.c"


#define GREY_REGION_X1 0
#define GREY_REGION_Y1 8

#define GREY_REGION_X2 16
#define GREY_REGION_Y2 64

#define COL_START_CONST 0x20



#define START_ROW (GREY_REGION_X1/8)
#define MAX_ROW ((GREY_REGION_X2-GREY_REGION_X1)/8)

#define XMAX ((MAX_COL)*8)

#define START_COL GREY_REGION_Y1
#define MAX_COL GREY_REGION_Y2

#define YMAX (MAX_COL-START_COL)




// 9f16 // wait contrast


#define GREY_CYCLE 0x8395
#define GREY_CYCLE_CARRY (GREY_CYCLE+1)

#define WAIT_TIME  (GREY_CYCLE_CARRY+1)
#define CONTRAST_PTR  (WAIT_TIME+1)



void x_test()__naked{
	scanKeys();
	#asm

		// Reset timer
		ld	a, 0x40
		out	(0x33), a	;10922 Hz
		ld	a, 2
		out	(0x34), 	a
		ld	a, 0x9f
		out	(0x35), a



		// // handle constrast
		// ld a, (contrast)
		// ld b, a
		// ld a, (CONTRAST_LOC)
		// cp b
		// jp z, AFTER_CONTRAST
		// ld (contrast), a

		// cp 0x25
		// jp c, AJHSDJIHAIDH
		// CI_RET
		// AJHSDJIHAIDH:
		// add a, 0xD8

		// AFTER_CONTRAST:




	    LD     A, 0x05         
	    OUT    (0x10), A
	    
	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, 0x80
	    OUT    (0x10), A

	    CALL   _LCD_BUSY_QUICK
	    LD     A, 0xBF          ; reset col
	    OUT    (0x10), A


	    ld b, 0
		ld a, (GREY_CYCLE_CARRY)
		rra
		ld a, (GREY_CYCLE)
		rla
		ld c, a
		
		ld (GREY_CYCLE), a
		ld a, b
		rla
		ld (GREY_CYCLE_CARRY), a

		xor a, a
		bit 0, c
		jp z, NO_DEC
		dec a
		NO_DEC:



		ld b, 20
LPPP:    
		CALL   _LCD_BUSY_QUICK
		out (0x11), a

		djnz LPPP
		

EXIT_INTERUPT:
		ld a, interrupt_acknowledge
		out (3), a // Tell the calc we handled the interupt
		CI_RET
	#endasm
}




// void make_gradient(){
// 	int light = LIGHT_GREY_LOC;
// 	int dark = DARK_GREY_LOC;
// 	for (char b = YMAX-8; b !=0; b--){
// 		*((char*)light) = 0xFF;
// 		*((char*)light+1) = 0xFF;
// 		*((char*)dark) = 0xFF;
// 		*((char*)dark+1) = 0xFF;
// 		*((char*)dark+2) = 0xFF;
// 		*((char*)dark+3) = 0xFF;
// 		*((char*)light+4) = 0xFF;
// 		*((char*)light+5) = 0xFF;
// 		light+=6;
// 		dark+=6;
// 	}
// }


void main() {
	
	*((char*)GREY_CYCLE) = 0b01101101;
	*((char*)GREY_CYCLE_CARRY) = 1;

	*((unsigned char*)WAIT_TIME) = 0x9f;
	*((unsigned char*)CONTRAST_PTR) = 0x16;



	clearScreen();
	patch_ram();
	#asm
		di
		call _LCD_BUSY_QUICK
		ld a, 0x16
		add a, 0xD8
		out (0x10), a

		ei


		ld	a, 0x40
		out	(0x33), a	;10922 Hz
		ld	a, 2
		out	(0x34), 	a
		ld	a, 0x9f
		out	(0x35), a
	#endasm
	char is_changed = 1;
	while (1){
		
		wait(2);
		unsigned char key = lastPressedKey();
		if (skClear == key)
			return;
		else if (skDown == key){
			(*((unsigned char*)WAIT_TIME))--;
			is_changed = 1;
		}else if (skUp == key){
			(*((unsigned char*)WAIT_TIME))++;
			is_changed = 1;
		}else if (skLeft == key){
			(*((unsigned char*)CONTRAST_PTR))--;
			is_changed = 1;
		}else if (skRight == key){
			(*((unsigned char*)CONTRAST_PTR))++;
			is_changed = 1;
		}
		if (is_changed){
			resetPen();
			hexdump(*((unsigned char*)WAIT_TIME));
			hexdump(*((unsigned char*)CONTRAST_PTR));
			is_changed = 0;
		}
	}



	// setCpuSpeed(3);
	// clearGreyScaleBuffer();
	// INIT_GREYSCALE();


	// *((char*)START_ROW)=ROW_CONST+8;
	// *((char*)MAX_COL)=6;


	// clearScreen();
	// setCpuSpeed(3);
	// make_gradient();

	// while (1){
	// 	wait(4);

		
	// 	scanKeys();
	// 	if (skClear == lastPressedKey())
	// 		break;
	// 	else if (skLeft == lastPressedKey()){
	// 		*(char*)WAIT_LOC -=1;
	// 	}
	// 	else if (skRight == lastPressedKey()){
	// 		*(char*)WAIT_LOC +=1;
	// 	}
	// 	else if (skUp == lastPressedKey()){
	// 		*(char*)CONTRAST_LOC +=1;
	// 	}
	// 	else if (skDown == lastPressedKey()){
	// 		*(char*)CONTRAST_LOC -=1;
	// 	}

	// 	resetPen();
	// 	hexdump(*(char*)WAIT_LOC);
	// 	hexdump(*(char*)CONTRAST_LOC);

		
	// }

	// setCpuSpeed(0);

}	
