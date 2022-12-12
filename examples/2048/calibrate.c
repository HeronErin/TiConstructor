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


void calibration_menu(char* settings_var){
	*(char*)WAIT_LOC     = *(settings_var+1);
	*(char*)CONTRAST_LOC = *(settings_var+2);
	clearGreyScaleBuffer();
	make_gradient();

	*((char*)START_ROW)=ROW_CONST+8;
	*((char*)START_COL) = COL_START_CONST;

	*((char*)END_ROW) = ROW_END_CONST;
	*((char*)MAX_COL)=6;

	

	while (1){
		wait(4);
		
		scanKeys();
		if (skClear == lastPressedKey())
			break;
		else if (skLeft == lastPressedKey()){
			*(char*)WAIT_LOC -=1;
			*(settings_var+1) = *(char*)WAIT_LOC     ;
		}
		else if (skRight == lastPressedKey()){
			*(char*)WAIT_LOC +=1;
			*(settings_var+1) = *(char*)WAIT_LOC     ;
		}
		else if (skUp == lastPressedKey()){
			*(char*)CONTRAST_LOC +=1;
			*(settings_var+2) = *(char*)CONTRAST_LOC ;
		}
		else if (skDown == lastPressedKey()){
			*(char*)CONTRAST_LOC -=1;
			*(settings_var+2) = *(char*)CONTRAST_LOC ;
		}

		resetPen();
		hexdump( *(settings_var+1) );
		hexdump( *(settings_var+2) );
		
	}
	
	

}