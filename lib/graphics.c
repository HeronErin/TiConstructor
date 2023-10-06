#pragma once
/** @file graphics.c @brief some useful graphics functions
 * 
 * <h3> Optional #defines </h3>
 *    <h4>Functions enables </h4>
 * 
 *    + <b> USE_LINE</b> - enables line()
 *    + <b> USE_SET_PIX</b> - enables setPix() 
 *    + <b> USE_CIRCLE</b> - enables circle()
 *    + <b> USE_VERTICAL_LINE</b> - enable vertical_line()
 *    + <b> USE_VERTICAL_LINE_DOTTED</b> - enables vertical_dotted_line()
 * 	 <h4>Functions Disables </h4>
 * 
 *    + <b> NO_USE_CLEAR</b> - Disables clearBuffer()
 *    + <b> NO_USE_SWAP</b>  - Disables swap()
 *   <h4> Variables </h4>
 * 	
 *    + <b> G_SCREEN_BUFFER</b> - allows you to redefine the location of the screen buffer. This is not recommended as the default is plotSScreen
 *    + <b> G_COL_START</b> - allows you to redefine where the screen starts drawing. Not recommended
 *    + <b> G_START_ROW</b> - allows you to redefine where the screen starts drawing. Not recommended
 *    + <b> G_ROW_END</b> - allows you to redefine where the screen stops drawing. Not recommended
 *    + <b> G_MAX_ROW</b> - allows you to redefine where the screen stops drawing. Not recommended
 *    + <b> G_BLOB_END</b> - allows you to redefine how large the screen buffer is. Could be cause errors if you redefine without changing G_CLEAR_BUFFER_CO
 *    + <b> G_CLEAR_BUFFER_CO</b> - allows you to redefine the math behind clearBuffer(). By default is set to 48 beacuse <b>48</b>*8=384 times, @ 2 bytes a PUSH = 768 bytes
 * 	  + <b> XMAX</b> - Max x value. Not recommended. Requires changing a lot of defines
 * 	  + <b> YMAX</b> - Max y value. Not recommended. Requires changing a lot of defines
 */


/** @{ \name Drawing settings */

#ifndef G_SCREEN_BUFFER
/** @brief the temp ram where you draw to */
#define G_SCREEN_BUFFER plotSScreen
#endif

#ifndef G_COL_START
#define G_COL_START 0x20
#endif

#ifndef G_START_ROW
#define G_START_ROW 0x80
#endif

#ifndef G_ROW_END
#define G_ROW_END 0xBF
#endif

#ifndef G_MAX_ROW
#define G_MAX_ROW 12
#endif

#ifndef G_BLOB_END
#define G_BLOB_END 768
#endif

#ifndef G_CLEAR_BUFFER_CO
#define G_CLEAR_BUFFER_CO 48
#endif


/** @brief Use this like a variable for interacting with the screen buffer */
#define buff (  (char*)G_SCREEN_BUFFER  )

/** @brief function to call from <b>ASM</b> to wait required amount of time between screen calls */
#define _LCD_BUSY_QUICK 0x000B

#ifndef XMAX

/** @brief Width of screen in pixels */
#define XMAX 96
#endif

#ifndef YMAX
/** @brief Height of screen in pixels */
#define YMAX 64
#endif


/** @} */

#ifndef NO_USE_CLEAR
/** @brief clears screen buffer as defined by G_SCREEN_BUFFER
 * If you wish to redefine the screen size you muse set multiple #defines before you include this file. You can find an example of this in examples/2048/main.c
 * 
 * <small>Taken from https://taricorp.gitlab.io/83pa28d/lesson/day10.html</small>
 */
void clearBuffer(){
    __asm
            DI
            LD    (SP_STORE), SP
            LD    SP, #G_SCREEN_BUFFER + G_BLOB_END    ; 768 byte area
            LD    HL, #0x0000
            LD    B, #G_CLEAR_BUFFER_CO        ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
        CLEAR_LOOP:
            PUSH  HL          ; Do multiple PUSHes in the loop to save cycles
            PUSH  HL
            PUSH  HL
            PUSH  HL
            PUSH  HL
            PUSH  HL
            PUSH  HL
            PUSH  HL
            DJNZ  CLEAR_LOOP

            LD    SP, (SP_STORE)
            EI

    __endasm;
}
#endif
#ifndef NO_USE_SWAP
/** @brief fast enough way to display SCREEN_BUFFER on lcd 
 * See the scoreboard in examples/2048/main.c for redefining the location of the screen
 */
void swap(){
    __asm
	    di
	    ld hl, #G_SCREEN_BUFFER

	    CALL   _LCD_BUSY_QUICK  
	    LD     A, #0x07           ; set y inc moce
	    OUT    (0x10), A


	    LD     c, #G_START_ROW

	    
	YLOOPR__:
	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, c
	    OUT    (0x10), A

	    CALL   _LCD_BUSY_QUICK
	    LD     A, #G_COL_START          ; reset col
	    OUT    (0x10), A


	    ld b, #G_MAX_ROW


	XLOOPR__:
	    CALL   _LCD_BUSY_QUICK
	    ld a, (hl)
	    out (0x11), a

	    inc hl
	    djnz XLOOPR__



	    inc c
	    ld a, c
	    cp #G_ROW_END
	    jp nz, YLOOPR__
	    ei
    __endasm;
    
}

#endif

#if defined(USE_LINE) || defined(DOXYGEN)

/** @brief Draw a line between any 2 valid points
 *  @param[x] First x coord (between 0-XMAX)
 *  @param[x] First y coord (between 0-YMAX)
 *  @param[x2] Secound x coord (between 0-XMAX)
 *  @param[y2] Secound y coord (between 0-YMAX)
 * 
 * Draws a line onto G_SCREEN_BUFFER between (x, y) and (x2, y2) 
 * 
 * <small>taken from https://wikiti.brandonw.net/index.php?title=Z80_Routines:Graphic:LineDraw and
 *  adapted for sdcc, should be quite fast</small>
 */ 


void line(char x, char y, char x2, char y2) __naked{
	__asm
	// Argument loader
		pop bc
		pop de
		pop hl
		push hl
		push de
		push bc

		ld a, d      // Somehow this routine started to have issues confusting x and y? Fliping it solved that (?????)
		ld d, e
		ld e, a

		ld a, h
		ld h, l
		ld l, a


		push ix
		ld ix, #G_SCREEN_BUFFER
		call DrawLineCompact
		pop ix
		ret





		; Line drawer
		; Small and quite fast
		; by Patai Gergely, thanks
		DrawLineCompact:		; This routine draws an unclipped line on an IX-pointed screen from (d,e) to (h,l)
		 ld a,h			; Calculating delta X and swapping points if negative
		 sub d			; (Lines are always drawn from left to right)
		 jp nc,DL_okaydx
		 ex de,hl
		 neg
		DL_okaydx:
		 push af		; Saving DX (it will be popped into DE below)
		 ld b,#0			; Calculating the position of the first pixel to be drawn
		 ld c,d			; IX+=D/8+E*12 (actually E*4+E*4+E*4)
		 srl c
		 srl c
		 srl c
		 add ix,bc
		 ld c,e
		 sla c
		 sla c
		 add ix,bc
		 add ix,bc
		 add ix,bc
		 ld a,d			; Calculating the starting pixel mask
		 ld c,#0x80
		 and a, #7
		 jp z,DL_okaymask
		DL_calcmask:
		 srl c
		 dec a
		 jp nz,DL_calcmask
		DL_okaymask:
		 ld a,l			; Calculating delta Y and negating the Y increment if necessary
		 sub e			; This is the last instruction for which we need the original data
		 ld hl,#12
		 jp nc,DL_okaydy
		 ld hl,#-12
		 neg
		DL_okaydy:
		 pop de			; Recalling DX
		 ld e,a			; D=DX, E=DY
		 cp d
		 jp c,#DL_horizontal	; Line is rather horizontal than vertical
		 ld (SP_STORE),hl	; Modifying y increment
		 push ix		; //Loading IX to HL for speed; we don't need the old value of HL any more
		 pop hl
		 ld b,e			; Pixel counter
		 inc b
		 srl a			; Setting up gradient counter (A=E/2)
		 ld (spriteTemp),sp	; Backing up SP to a safe place
		 di			; Interrupts are undesirable when we play around with SP :)
		DL_VLinc:
		 ld sp, (SP_STORE)		; This value is replaced by +/- 12
		DL_Vloop:
		 .db 0x08 //ex af,af'		; Saving A to alternative register
		 ld a,(hl)
		 or c			; Writing pixel to current position
		 ld (hl),a
		 .db 0x08 // ex af,af'		; Recalling A (faster than push-pop, and there's no need for SP)
		 add hl,sp
		 sub d			; Handling gradient
		 jp nc,DL_VnoSideStep
		 rrc c			; Rotating mask
		 jp nc,DL_VnoByte	; Handling byte boundary
		 inc hl
		DL_VnoByte:
		 add a,e
		DL_VnoSideStep:
		 djnz DL_Vloop
		 ld sp,(spriteTemp)
		 ret
		DL_horizontal:
		 ld (spriteTemp),hl	; Modifying y increment
		 push ix		; //Loading IX to HL for speed; we don't need the old value of HL any more
		 pop hl
		 ld b,d			; Pixel counter
		 inc b
		 ld a,d			; Setting up gradient counter
		 srl a
		 ld (SP_STORE),sp	; Backing up SP to a safe place
		 di			; Interrupts again...
		DL_HLinc:
		 ld sp,(spriteTemp)		; This value is replaced by +/- 12
		DL_Hloop:
		 .db 0x08 //ex af,af'		; Saving A to alternative register
		 ld a,(hl)
		 or c			; Writing pixel to current position
		 ld (hl),a
		 .db 0x08 // ex af,af'		; Recalling A
		 rrc c			; Rotating mask
		 jp nc,DL_HnoByte	; Handling byte boundary
		 inc hl
		DL_HnoByte:
		 sub e			; Handling gradient
		 jp nc,DL_HnoSideStep
		 add hl,sp
		 add a,d
		DL_HnoSideStep:
		 djnz DL_Hloop
		 ld sp,(SP_STORE)
 ret

	__endasm;
}
#endif



#if defined(USE_VERTICAL_LINE) || defined(DOXYGEN)

/** @brief Quick verticle line drawing routine
 * @param[x] the x value to draw at (0-XMAX)
 * @param[start] the y value to start at (0-YMAX-1)
 * @param[height] How long the line should be (1-YMAX)
 * @param[not_used] Can be anything, this value is just discarded. Odd number byte params require more instructions than Even number params
 * 
 * Quickly draws a verticle line onto G_SCREEN_BUFFER
 */
//                    e        d            l          h	
void vertical_line(char x, char start, char height, char not_used)__naked{
	__asm
		pop bc
		pop de
		pop hl
		push hl
		push de
		push bc

		ld h, l
		push hl



		ld b, #0
		ld c, d

		ld h, b
		ld l, c
		add hl, bc
		ld b, h
		ld c, l
		add hl, bc
		ld b, h
		ld c, l

		add hl, bc
		add hl, bc

		ld b, h
		ld c, l






		ld a, e // X pos
		ld hl,#G_SCREEN_BUFFER
		add hl, bc

		ld d,#0
		ld e,a
		srl e
		srl e
		srl e
		add hl,de
		and a, #0x07
		ld b,a
		inc b
		ld a,#1
		vertloop1:
		rrca
		djnz vertloop1
		ld c,a
		
		pop af
		ld b,a

		ld e,#12
		vertloop2:
		ld a,c
		or (hl)
		ld (hl),a
		add hl,de
		djnz vertloop2
		ret



	__endasm;
}
#endif

#if defined(USE_VERTICAL_LINE_DOTTED) || defined(DOXYGEN)

/** @brief Quick dotted verticle line drawing routine
 * @param[x] the x value to draw at (0-XMAX)
 * @param[start] the y value to start at (0-YMAX-1)
 * @param[height] How long the line should be (1-YMAX)
 * @param[not_used] Can be anything, this value is just discarded. Odd number byte params require more instructions than Even number params
 * 
 * Quickly draws a dotted verticle line onto G_SCREEN_BUFFER
 */

//                           e        d            l          h		
void vertical_dotted_line(char x, char start, char height, char not_used)__naked{
	__asm
		pop bc
		pop de
		pop hl
		push hl
		push de
		push bc

		ld h, l
		push hl



		ld b, #0
		ld c, d

		ld h, b
		ld l, c
		add hl, bc
		ld b, h
		ld c, l
		add hl, bc
		ld b, h
		ld c, l

		add hl, bc
		add hl, bc

		ld b, h
		ld c, l






		ld a, e // X pos

		ld hl,#G_SCREEN_BUFFER
		add hl, bc

		ld d,#0
		ld e,a
		srl e
		srl e
		srl e
		add hl,de
		and a, #0x07
		ld b,a
		inc b
		ld a,#1
		_vertloop1:
		rrca
		djnz _vertloop1
		ld c,a
		
		pop af
		rra
		ld b,a

		ld e,#12
		_vertloop2:
		ld a,c
		or (hl)
		ld (hl),a
		add hl,de
		add hl,de
		djnz _vertloop2
		ret



	__endasm;
}
#endif






/** @brief <b>ASM</b> Routine to get the memory location of a pixel based
 * 	@param[A] The x coord
 * 	@param[L] The y coord
 * 	@return HL = memory location & A = bitmask
 * 
 * Only call this from assembly
 *  <small> Taken from https://taricorp.gitlab.io/83pa28d/lesson/week4/day24/index.html </small>
 */
void ___GetPixel() __naked{
	__asm
		// inc a

	    LD     H, #0
	    LD     D, H
	    LD     E, L
	    ADD    HL, HL
	    ADD    HL, DE
	    ADD    HL, HL
	    ADD    HL, HL

	    LD     E, A
	    SRL    E
	    SRL    E
	    SRL    E
	    ADD    HL, DE

	    LD     DE, #G_SCREEN_BUFFER
	    ADD    HL, DE

	    and a, #7
	    LD     B, A
	    LD     A, #0x80
	    RET    Z
	    
	    
	    or a, a
	Get_Pix_Loop:
	    RRCA
	    DJNZ   Get_Pix_Loop
	    RET
	    
	__endasm;
}



#ifdef USE_CIRCLE
#define USE_SET_PIX
#endif

#if defined(USE_SET_PIX) || defined(DOXYGEN)

/** @brief Set a pixel on the screen
 * @param[x] the x value to draw at (0-XMAX)
 * @param[y] the y value to draw at (0-YMAX)
 * 
 * This is a routine that works, but is overall not the most efficient way to draw on the screen.
 */
void setPix(char x, char y)__naked{
	__asm
		pop bc
		pop hl
		push hl
		push bc

		ld a, l
		ld l, h
		call ____GetPixel
		or (hl)
		ld (hl), a

		ret

	__endasm;
}
#endif








// this is not fast, nor small
#if defined(USE_CIRCLE) || defined(DOXYGEN)


/** @brief Do not call me */
void __drawCircleSegment(char xc, char yc, char x, char y)
{
    setPix(xc+x, yc+y);
    setPix(xc-x, yc+y);
    setPix(xc+x, yc-y);
    setPix(xc-x, yc-y);
    setPix(xc+y, yc+x);
    setPix(xc-y, yc+x);
    setPix(xc+y, yc-x);
    setPix(xc-y, yc-x);
}
 
/** @brief Circle drawing routine
 *  @param[xc] X coord of center of the circle
 *  @param[yc] Y coord of center of the circle
 *  @param[r] Radius of the circle
 * 
 * This code is quite slow as it is entirly written in c and uses the already quite slow setPix()
 * 
 * <small>taken from https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/ and modified </small>
 */ 
void circle(char xc, char yc, char r)
{
    char x = 0, y = r;
    __drawCircleSegment(xc, yc, x, y);
    int d = 3 - 2 * r;
    while (y >= x)
    {
        // for each pixel we will
        // draw all eight pixels
         
        x++;
 
        // check for decision parameter
        // and correspondingly
        // update d, x, y
        if (d > 0)
        {
            y--;
            d = d + 4 * (x - y) + 10;
        }
        else
            d = d + 4 * x + 6;
        __drawCircleSegment(xc, yc, x, y);
    }
}
#endif


