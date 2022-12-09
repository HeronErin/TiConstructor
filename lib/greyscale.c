#pragma once
#define _LCD_BUSY_QUICK 0x000B

#define __hs #

#define WAIT_LOC 0x85BE
#define CONTRAST_LOC (WAIT_LOC+1)
#define GRAY_CYCLE (CONTRAST_LOC+1)
#define GRAY_CYCLE_CARRY (GRAY_CYCLE+1)

#define START_ROW (GRAY_CYCLE_CARRY+1)
#define END_ROW (START_ROW+1)



// IF YOU CHANGE COL, YOU MUST CHANGE THE XMAX, OTHERWISE THE IMAGE IS MESSED UP
// #define XMAX (endcol - startcol)*8
#define START_COL (WAIT_LOC+5)
#define MAX_COL (WAIT_LOC+6)

#define DEFAULT_MAX_COL 12




#define COL_START_CONST 0x20
#define ROW_CONST 0x80
#define ROW_END_CONST 0xBF


#define LIGHT_GREY_LOC plotSScreen
#define DARK_GREY_LOC plotSScreen



#define XMAX 96
#define YMAX 64

#define INIT_GREYSCALE() *((char*)GRAY_CYCLE) = 0b01101101 ;\
						 *((char*)CONTRAST_LOC) = 0x17;\
						 *(char*)WAIT_LOC = 0xA0;\
						 *((char*)GRAY_CYCLE_CARRY) = 1;\
						 SET_INTERUPTS(); __asm\
						 \
							ld	a, __hs 0x40 \
							out	(0x33), a	;10922 Hz \
							ld	a, __hs 2 \
							out	(0x34), 	a \
							ld	a, (WAIT_LOC) \
							out	(0x35), a \
							__endasm
						



// called during interupts
void grey_interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
  						 // and the z80 only has ome core
	scanKeys();
	__asm
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
		ld a, (CONTRAST_LOC)
		cp #0x25
		ret nc
		add a, #0xD8
		CALL   _LCD_BUSY_QUICK
		out (0x10), a



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
		
		bit 0, c
		jr z, 00002$
		ld c, #0xFF
		jr 00003$
		00002$:
		ld c, #0
		00003$:



	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, #0x89
	    OUT    (0x10), A

	    CALL   _LCD_BUSY_QUICK
	    LD     A, #0x21          ; reset col
	    OUT    (0x10), A

		

		ld a, c
		ld b, #20
		00004$:
		CALL   _LCD_BUSY_QUICK

		out (0x11), a
		dec b
		jp nz, (00004$)






	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, #0x89
	    OUT    (0x10), A
		CALL   _LCD_BUSY_QUICK
		LD     A, #0x22          ; reset col
	    OUT    (0x10), A

	    ld a, c
	    cpl

	    00006$:
	    ld b, #20
		00005$:
		CALL   _LCD_BUSY_QUICK
		out (0x11), a
		dec b
		jp nz, (00005$)


	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, #0x89
	    OUT    (0x10), A
		CALL   _LCD_BUSY_QUICK
		LD     A, #0x20          ; reset col
	    OUT    (0x10), A
		xor a, a
		dec a
	    ld b, #20
		00015$:
		CALL   _LCD_BUSY_QUICK
		out (0x11), a

		dec b
		jp nz, (00015$)



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
