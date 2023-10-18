#pragma once

#define USER_INTERUPT _grey_interupt

#include "interupt_loader.c"




#define _LCD_BUSY_QUICK 0x000B

/** @brief Ram location for wait char */
#define WAIT_LOC 0x8000 

/** @brief Ram location for constast char */
#define CONTRAST_LOC (WAIT_LOC+1) 

/** @brief 0 - 0x25, do not set this yourself */
#define GRAY_CYCLE (CONTRAST_LOC+1) 

/** @brief Used for greyscale math, do not set this yourself */
#define GRAY_CYCLE_CARRY (GRAY_CYCLE+1) 



/** @{ \name Greyscale setting ram locations
 */

/** @brief Ram location whoose value starts at 0x80 and defines what row the greyscale starts at.*/
#define START_ROW (GRAY_CYCLE_CARRY+1) 
/** @brief Ram location whoose value starts at 0xBF and defines what row the greyscale ends at.*/
#define END_ROW (START_ROW+1) 



/**  @{ \name IF YOU CHANGE COL, YOU MUST CHANGE THE XMAX, OTHERWISE THE IMAGE IS MESSED UP: #define XMAX (endcol - startcol)*8 
*/
/** @brief Ram location of what colum the greyscale starts */
#define START_COL (END_ROW+1) 
/** @brief Ram location of how many colums to draw */
#define MAX_COL (START_COL+1)

/** @} */

/** @brief Ram location of where the old contrast of the screen is stored. */
#define SAVE_CONTRAST 0x9D88

/** @brief Only used when setting the initial MAX_COL */
#define DEFAULT_MAX_COL 12



/** @brief Only used when setting the initial START_COL */
#define COL_START_CONST 0x20
/** @brief Only used when setting the initial START_ROW */
#define ROW_CONST 0x80
/** @brief Only used when setting the initial END_ROW */
#define ROW_END_CONST 0xBF

/** @brief @{ \name Grey scale screen buffer locations */

/** @brief Ram location of where light grey pixels are set */
#define LIGHT_GREY_LOC plotSScreen
/** @brief Ram location of where dark grey pixels are set */
#define DARK_GREY_LOC appBackUpScreen

/** @} */

#define XMAX 96
#define YMAX 64



// Don't change anything here, change it after, for example change WAIT_LOC right after INIT_GREYSCALE is called

/** @brief Call this to enable greyscale interupts, <b>change greyscale settings after calling this </b> */
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
						 patch_ram();\
						 \
							__asm__("ld	a, 0x40");\
							__asm__("out	(0x33), a"); // 10922 Hz \
							__asm__("ld	a, 2"); \
							__asm__("out	(0x34), 	a"); \
							__asm__("ld	a, (WAIT_LOC)"); \
							__asm__("out	(0x35), a"); \

// Keeps normal contrast setting
#define ADDED_ON_EXIT()  \
		__asm__("ld a, ("SAVE_CONTRAST")");\
		__asm__("ld ("contrast"), a");\
		__asm__("add a, 0xD8"); \
		__asm__("out (0x10), a")



/** @brief Called during interupts, <b>DO NOT CALL YOURSELF</b> */
void grey_interupt() __naked{
  						 
	scanKeys();
	#asm
		ld a, interrupt_acknowledge
		out (3), a // Tell the calc we handled the interupt



		#ifndef DISABLE_ON_BUTTON_KILL
		in a, (4) // port 4 bit 3 tests if on button is pressed
		bit 3, a
		jp nz, NO_EXIT
	#endasm
	unpatch_ram();  // Restore old interupt
	#asm 
		CI_RET



		#endif

		NO_EXIT:
		// test if time is up
		in a, (4)
		bit 6, a
		jp nz, TIME_IS_UP_FOR_GREY
		CI_RET
		TIME_IS_UP_FOR_GREY:

		// reset timer
		ld	a, 0x40
		out	(0x33), a	;10922 Hz
		ld	a, 2
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

		cp 0x25
		jp c, AJHSDJIHAIDH
		CI_RET
		AJHSDJIHAIDH:
		add a, 0xD8

		out (0x10), a
		AFTER_CONTRAST:


		// rotate grey cycle byte
		ld b, 0
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
		jp z, NO_NEED_FOR_GREY
		CI_RET
		NO_NEED_FOR_GREY:
		



		ld hl,  DARK_GREY_LOC
		bit 0, c
		jr z, LIGHT_GREY
		ld hl,  LIGHT_GREY_LOC
		LIGHT_GREY:




		ld c,0x10
		ld a, (END_ROW)
		ld e, a

		#ifndef NO_MICRO_WAIT
	    in a, (0x20)
	    push af
	   	xor a, a
	   	out (0x20), a
	   	#endif

		// CALL   _LCD_BUSY_QUICK
	    LD     A, 0x07           ; set y inc mode
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
		#endasm


		#ifdef ON_GREY_RENDER
		ON_GREY_RENDER();
		#endif


	#asm
		CI_RET
	#endasm
}



/** @brief Quickly clears both LIGHT_GREY_LOC and DARK_GREY_LOC */
void clearGreyScaleBuffer() __naked{
    #asm
            DI
            LD    (SP_STORE), SP
            LD    SP, LIGHT_GREY_LOC + 768    ; 768 byte area
            ld c, 0xFF
           	WIPE_LOC:
	            LD    HL, 0x0000
	            LD    B, 48        ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
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

	            LD    SP, DARK_GREY_LOC + 768    ; 768 byte area
	            inc c
	            jp z, WIPE_LOC


	           	ENDOFWIPE:
	            LD    SP, (SP_STORE)
	            EI
	            ret

    #endasm
}#