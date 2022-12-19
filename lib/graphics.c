#pragma once
// SCREEN_BUFFER is the temp ram where you draw to 

#define SCREEN_BUFFER plotSScreen
#define buff (  (char*)SCREEN_BUFFER  )
#define _LCD_BUSY_QUICK 0x000B
#define XMAX 96
#define YMAX 64

#ifndef NO_USE_CLEAR
// taken from https://taricorp.gitlab.io/83pa28d/lesson/day10.html
void clearBuffer(){
    __asm
            DI
            LD    (SP_STORE), SP
            LD    SP, #plotSScreen + 768    ; 768 byte area
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
	    ld hl, #SCREEN_BUFFER

	    CALL   _LCD_BUSY_QUICK  
	    LD     A, #0x07           ; set y inc moce
	    OUT    (0x10), A


	    LD     c, #0x80

	    
	YLOOPR:
	    CALL   _LCD_BUSY_QUICK   ; set row
	    LD     A, c
	    OUT    (0x10), A

	    CALL   _LCD_BUSY_QUICK
	    LD     A, #0x20          ; reset col
	    OUT    (0x10), A


	    ld b, #12


	XLOOPR:
	    CALL   _LCD_BUSY_QUICK
	    ld a, (hl)
	    out (0x11), a

	    inc hl
	    djnz XLOOPR



	    inc c
	    ld a, c
	    cp #0xBF
	    jp nz, YLOOPR
	    ei
    __endasm;
    
}
#endif

#ifdef USE_LINE
// taken from https://www.ticalc.org/pub/83plus/asm/source/routines/dline.zip
// adapted for sdcc, should be quite fast
void line(char x, char y, char x2, char y2) __naked{
	x;y;x2;y2;
	__asm
		; prep vars
			pop bc
			pop de
			pop hl
			push hl
			push de
			push bc
			
			ld c, d
			ld d, e
			ld e, c

			ld c, h
			ld h, l
			ld l, c


			di
			ld (SP_STORE),sp
			ld a,h
			cp d
			jp nc,noswapx
			ex de,hl
		noswapx:
			ld a,h
			sub d
			jp nc,posx
			neg
		posx:
			ld b,a
			ld a,l
			sub e
			jp nc,posY
			neg
		posY:
			ld c,a
			ld a,l
			ld hl,#-12
			cp e
			jp c,lineup
			ld hl,#12
		lineup:
			ld ix,#xbit
			ld a,b
			cp c
			jp nc,xline
			ld b,c
			ld c,a
			ld ix,#ybit
		xline:
			push hl
			ld a,d
			ld d,#0
			ld h,d
			sla e
			sla e
			ld l,e
			add hl,de
			add hl,de
			ld e,a
			and #7 ; %00000111
			srl e
			srl e
			srl e
			add hl,de
			ld de,#SCREEN_BUFFER
			add hl,de
			add a,a
			ld e,a
			ld d,#0
			add ix,de
			ld e,(ix)
			ld d,1(ix)
			push de
			pop ix
			pop de
			ex de,hl
			ld sp,hl
			ex de,hl
			ld d,b
			ld e,c
			ld a,d
			srl a
			inc b
			jp (ix)
		lineret:


			ld sp,(SP_STORE)


			ret

		xbit:
		 .dw drawx0,drawx1,drawx2,drawx3
		 .dw drawx4,drawx5,drawx6,drawx7
		ybit:
		 .dw drawY0,drawY1,drawY2,drawY3
		 .dw drawY4,drawY5,drawy6,drawy7
			
		drawx0:
			set 7,(hl)
			add a,e
			cp d
		_89qt23:	jp c,_89qt23+3+1+1
			add hl,sp
			sub d
			djnz drawx1
			jp lineret
		drawx1:
			set 6,(hl)
			add a,e
			cp d
		_7342:	jp c,_7342+3+1+1
			add hl,sp
			sub d
			djnz drawx2
			jp lineret
		drawx2:
			set 5,(hl)
			add a,e
			cp d
		_82934:	jp c,_82934+3+1+1
			add hl,sp
			sub d
			djnz drawx3
			jp lineret
		drawx3:
			set 4,(hl)
			add a,e
			cp d
		_8027523:	jp c,_8027523+3+1+1
			add hl,sp
			sub d
			djnz drawx4
			jp lineret
		drawx4:
			set 3,(hl)
			add a,e
			cp d
		_12489:	jp c,_12489+3+1+1
			add hl,sp
			sub d
			djnz drawx5
			jp lineret
		drawx5:
			set 2,(hl)
			add a,e
			cp d
		_8492348:	jp c,_8492348+3+1+1
			add hl,sp
			sub d
			djnz drawx6
			jp lineret
		drawx6:
			set 1,(hl)
			add a,e
			cp d
		_72834:	jp c,_72834+3+1+1
			add hl,sp
			sub d
			djnz drawx7
			jp lineret
		drawx7:
			set 0,(hl)
			inc hl
			add a,e
			cp d
		_8294:	jp c,#_8294+3+1+1
			add hl,sp
			sub d
			djnz drawx0
			jp lineret

		drawY0_:
			inc hl
			sub d
			dec b
			jp z,lineret
		drawY0:
			set 7,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY1_
			djnz drawY0
			jp lineret
		drawY1_:
			sub d
			dec b
			jp z,lineret
		drawY1:
			set 6,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY2_
			djnz drawY1
			jp lineret
		drawY2_:
			sub d
			dec b
			jp z,lineret
		drawY2:
			set 5,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY3_
			djnz drawY2
			jp lineret
		drawY3_:
			sub d
			dec b
			jp z,lineret
		drawY3:
			set 4,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY4_
			djnz drawY3
			jp lineret
		drawY4_:
			sub d
			dec b
			jp z,lineret
		drawY4:
			set 3,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY5_
			djnz drawY4
			jp lineret
		drawY5_:
			sub d
			dec b
			jp z,lineret
		drawY5:
			set 2,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawy6_
			djnz drawY5
			jp lineret
		drawy6_:
			sub d
			dec b
			jp z,lineret
		drawy6:
			set 1,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawy7_
			djnz drawy6
			jp lineret
		drawy7_:
			sub d
			dec b
			jp z,lineret
		drawy7:
			set 0,(hl)
			add hl,sp
			add a,e
			cp d
			jp nc,drawY0_
			djnz drawy7
			jp lineret

			__endasm;
}
#endif




#ifdef USE_CIRCLE
#define USE_SET_PIX
#endif

#ifdef USE_SET_PIX
// It ain't fast, and it ain't pretty, but it works
void setPix(char x, char y){
	*(char*)((((int)y)* (XMAX/8) )+(x/8)+SCREEN_BUFFER)|=128>>(x%8);
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


