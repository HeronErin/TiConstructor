#pragma once
// SCREEN_BUFFER is the temp ram where you draw to 

#ifndef G_SCREEN_BUFFER
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


#define buff (  (char*)G_SCREEN_BUFFER  )
#define _LCD_BUSY_QUICK 0x000B
#define XMAX 96
#define YMAX 64

#ifndef NO_USE_CLEAR
// taken from https://taricorp.gitlab.io/83pa28d/lesson/day10.html
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
// fast enough way to display SCREEN_BUFFER on lcd
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

#ifdef USE_LINE
// taken from https://wikiti.brandonw.net/index.php?title=Z80_Routines:Graphic:LineDraw
// adapted for sdcc, should be quite fast
void line(char x, char y, char x2, char y2) __naked{
	__asm
	// Argument loader
		pop bc
		pop de
		pop hl
		push hl
		push de
		push bc

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



#ifdef USE_CIRCLE
#define USE_SET_PIX
#endif

#ifdef USE_SET_PIX
// It ain't fast, and it ain't pretty, but it works
void setPix(char x, char y){
	*(char*)((((int)y)* (XMAX/8) )+(x/8)+G_SCREEN_BUFFER)|=128>>(x%8);
}
#endif








// this is not fast, nor small
#ifdef USE_CIRCLE
// taken from https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/
// and modified
void drawCircleSegment(char xc, char yc, char x, char y)
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
 
// Function for circle-generation
// using Bresenham's algorithm
void circle(char xc, char yc, char r)
{
    char x = 0, y = r;
    drawCircleSegment(xc, yc, x, y);
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
        drawCircleSegment(xc, yc, x, y);
    }
}
#endif


