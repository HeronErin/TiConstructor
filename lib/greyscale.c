#pragma once
#define _LCD_BUSY_QUICK 0x000B


// Warnings: This _may_ take up 90% of the cpu time and should be used with cpu turbo (setCpuSpeed(3))
// Look at the example in examples/greyScale
// Usage:

// you might want to know that there is an emergency killswitch built in, if you press the on button it will stop the grey scale,
// but you can disable the killswitch with #define DISABLE_ON_BUTTON_KILL before you include this file



// Greyscale uses interupts so no need for a swap (don't even try to use swap)
// First put your image in LIGHT_GREY_LOC and DARK_GREY_LOC, since there is 4 different color options (off, light grey, dark grey, and black)
// you need need 2 bits per pixel (one in LIGHT_GREY_LOC and the other in DARK_GREY_LOC), both bits are set for black and both are zero for off
// Use clearGreyScaleBuffer to clear these two buffers quickly

// Your first instruction should be clearGreyScaleBuffer() followed by INIT_GREYSCALE()

// Next you may to set your drawing settings (since default values are set in INIT_GREYSCALE)
// this can be done in C as follows:
//						 *((char*)START_ROW) = ROW_CONST;
//						 *((char*)START_COL) = COL_START_CONST;
//						 
//						 *((char*)END_ROW) = ROW_END_CONST;
//						 *((char*)MAX_COL) = DEFAULT_MAX_COL; // you must change your XMAX (or equivalent) along with your DEFAULT_MAX_COL, otherwise things tend to break
//
//
// It is recommended to add/subtrace to/from the default values due to some of them being offseted values (the setting for row 0 is 0x80 and column 0 is 0x20)

// Ps. The emulator dosn't work with greyscale well

// Also if you use an appvar for greyscale settings use the name "greycfg" and use this structor [0x69, WAIT_TIME, CONTRAST, 0x69] 
// 0x69 is for integrity checking (Im not immature at all lol)                        see the 2048 in examples/



#define __hs #

#define WAIT_LOC 0x85BE
#define CONTRAST_LOC (WAIT_LOC+1)
#define GRAY_CYCLE (CONTRAST_LOC+1) // 0 - 0x25
#define GRAY_CYCLE_CARRY (GRAY_CYCLE+1)

#define START_ROW (GRAY_CYCLE_CARRY+1)
#define END_ROW (START_ROW+1)



// IF YOU CHANGE COL, YOU MUST CHANGE THE XMAX, OTHERWISE THE IMAGE IS MESSED UP
// #define XMAX (endcol - startcol)*8
#define START_COL (END_ROW+1)
#define MAX_COL (START_COL+1)


#define SAVE_CONTRAST 0x9D88

#define DEFAULT_MAX_COL 12




#define COL_START_CONST 0x20
#define ROW_CONST 0x80
#define ROW_END_CONST 0xBF


#define LIGHT_GREY_LOC plotSScreen
#define DARK_GREY_LOC appBackUpScreen
// #define LIGHT_GREY_LOC plotSScreen
// #define DARK_GREY_LOC plotSScreen


#define XMAX 96
#define YMAX 64



// Don't change anything here, change it after, for example change WAIT_LOC right after INIT_GREYSCALE is called
#define INIT_GREYSCALE() *((char*)GRAY_CYCLE) = 0b01101101 ;\
						 *((char*)CONTRAST_LOC) = 0x15;\
						 *((char*)SAVE_CONTRAST) = *((char*)contrast);\
						 *((char*)contrast) = 0;\
						 *(char*)WAIT_LOC = 0x9F;\
						 *((char*)GRAY_CYCLE_CARRY) = 1;\
						 \
						 \
						 *((char*)START_ROW) = ROW_CONST;\
						 *((char*)START_COL) = COL_START_CONST;\
						 \
	 					 *((char*)END_ROW) = ROW_END_CONST;\
						 *((char*)MAX_COL) = DEFAULT_MAX_COL;\
						 SET_INTERUPTS(); __asm\
						 \
							ld	a, __hs 0x40 \
							out	(0x33), a	;10922 Hz \
							ld	a, __hs 2 \
							out	(0x34), 	a \
							ld	a, (WAIT_LOC) \
							out	(0x35), a \
							__endasm

// Keeps normal contrast setting
#define ADDED_ON_EXIT() 	__asm\
		ld a, (SAVE_CONTRAST)\
		ld (contrast), a\
		add a, __hs 0xD8\
		out (0x10), a\
		ret\
	__endasm

// called during interupts
void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
  						 // and the z80 only has ome core
	scanKeys();
	__asm

		#ifndef DISABLE_ON_BUTTON_KILL
		in a, (4) // port 4 bit 3 tests if on button is pressed
		bit 3, a
		jp nz, NO_EXIT
		im 1
		ret
		#endif

		NO_EXIT:
		// test if time is up
		in a, (4)
		bit 6, a
		ret z

		// reset timer
		ld	a, #0x40
		out	(0x33), a	;10922 Hz
		ld	a, #2
		out	(0x34), 	a
		ld	a, (WAIT_LOC)
		out	(0x35), a

		// handle constrast
		ld a, (contrast)
		ld b, a
		ld a, (CONTRAST_LOC)
		cp b
		jp z, AFTER_CONTRAST
		ld (contrast), a

		cp #0x25
		ret nc
		add a, #0xD8

		out (0x10), a
		AFTER_CONTRAST:


		// rotate grey cycle byte
		ld b, #0
		ld a, (GRAY_CYCLE_CARRY)
		rra
		ld a, (GRAY_CYCLE)
		rla
		ld c, a
		
		ld (GRAY_CYCLE), a
		ld a, b
		rla
		ld (GRAY_CYCLE_CARRY), a
		
		// Don't need to update display the same image twice in a row
		and a, c
		bit 0, a
		ret nz



		ld hl, # DARK_GREY_LOC
		bit 0, c
		jr z, LIGHT_GREY
		ld hl, # LIGHT_GREY_LOC
		LIGHT_GREY:




		ld c,#0x10
		ld a, (END_ROW)
		ld e, a

		#ifndef NO_MICRO_WAIT
	    in a, (0x20)
	    push af
	   	xor a, a
	   	out (0x20), a
	   	#endif

		// CALL   _LCD_BUSY_QUICK
	    LD     A, #0x07           ; set y inc mode
	    OUT    (0x10), A

	    #ifndef NO_MICRO_WAIT
		push bc // waste time
		pop bc
		#endif



		ld a, (START_ROW)
		rows:
			#ifndef NO_MICRO_WAIT
			push ix // waste time
			pop ix
			nop
			nop
			#endif


			out (0x10), a
			ld d, a

			#ifndef NO_MICRO_WAIT
			push ix // waste time
			pop ix
			push bc
			pop bc
			#endif

		    LD     A, (START_COL)          ; reset col
		    OUT    (0x10), A

		    ld a, (MAX_COL)
		    ld b, a
		    row:
		    	ld a, (hl)
		    	inc hl
		    	// CALL   _LCD_BUSY_QUICK
		    	#ifndef NO_MICRO_WAIT
				push ix // waste time
				pop ix
				push bc
				pop bc
				push bc
				pop bc
				#endif

		    	out (0x11), a
		    	djnz row




		    ld a, d
		    inc a
			cp e
			jp nz, rows

		#ifndef NO_MICRO_WAIT
		pop af
		out (0x20), a
		#endif
		__endasm;


		#ifdef ON_GREY_RENDER
		ON_GREY_RENDER();
		#endif


	__asm;
		ret
	__endasm;
}


#define OVERIDE_INTERUPTS
#define DURING_INTERUPT() grey_interupt() 

#include "interupts.c"


void clearGreyScaleBuffer(){
    __asm
            DI
            LD    (SP_STORE), SP
            LD    SP, #LIGHT_GREY_LOC + 768    ; 768 byte area
            ld c, #0xFF
           	WIPE_LOC:
	            LD    HL, #0x0000
	            LD    B, #48        ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
	        Loop:
	            PUSH  HL          ; Do multiple PUSHes in the loop to save cycles
	            PUSH  HL
	            PUSH  HL
	            PUSH  HL
	            PUSH  HL
	            PUSH  HL
	            PUSH  HL
	            PUSH  HL
	            DJNZ  Loop

	            LD    SP, #DARK_GREY_LOC + 768    ; 768 byte area
	            inc c
	            jp z, WIPE_LOC


	           	ENDOFWIPE:
	            LD    SP, (SP_STORE)
	            EI

    __endasm;
}




