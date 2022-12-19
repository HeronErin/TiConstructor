#pragma once


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

void calibration_loop(){
	clearGreyScaleBuffer();
	make_gradient();
	__asm
		ld a, (START_ROW)
		ld b, a
		ld a, (START_COL)
		ld c, a
		push bc

		ld a, (END_ROW)
		ld b, a
		ld a, (MAX_COL)
		ld c, a
		push bc
	__endasm;

	*((char*)START_ROW) = ROW_CONST+8;
	*((char*)START_COL) = COL_START_CONST;

	*((char*)END_ROW) = ROW_END_CONST;
	*((char*)MAX_COL) = 6;

	while (1){
		wait(4);
		
		scanKeys();
		if (skClear == lastPressedKey())
			break;
		else if (skMode == lastPressedKey())
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

		resetPen();
		hexdump(*(char*)WAIT_LOC);
		hexdump(*(char*)CONTRAST_LOC);

		
	}
	char* dataLoc=getOrCreateVar(dataName, 20)+2;
	dataLoc[1] = *(char*)WAIT_LOC ;
	dataLoc[2] = *(char*)CONTRAST_LOC ;
	clearGreyScaleBuffer();
	__asm
		pop bc
		ld a, b
		ld (END_ROW), a
		ld a, c
		ld (MAX_COL), a

		pop bc
		ld a, b
		ld (START_ROW), a
		ld a, c
		ld (START_COL), a
	__endasm;
}