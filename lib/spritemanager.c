#pragma once

// [or, xor, and], because they are valid z80 opcodes
#ifndef COPY_MODE
#define COPY_MODE xor 
#endif

#ifndef X_LINE
#define X_LINE 12  // XMAX / 8
#endif

#ifndef Y_MULT // asm to multiply hl by X_LINE
#define Y_MULT 		add	hl,de \
				   	add	hl,de \
				   	add	hl,hl \
				   	add	hl,hl 
#endif


#ifdef GREYSCALE_SPRITES
#define USE_APPBACKUP_ION
#endif

// only can render 8 wide sprites, DO NOT CALL FROM C 

// ionPutSprite:
// Draw a sprite to the graph buffer (XOR).
// Input: b=sprite height
// a=x coordinate
// l=y coordinate
// ix->sprite
// Output: Sprite is XORed to the graph buffer.
// ix->next sprite
// Destroys: af bc de hl ix


// NEVER CALL FROM C 
void ionPutSprite()__naked{    
	__asm
		
		putSprite:
		   	ld	e,l
		   	ld	h,#00
		   	ld	d,h
		   	
		   	// hl, de = 16 bit y. Must mult by X_LINE
		   	Y_MULT            ;Find the Y displacement offset 


		   	ld	e,a
		   	and	#07               ;Find the bit number
		   	ld	c,a
		   	srl	e
		   	srl	e
		   	srl	e
		   	add	hl,de             ;Find the X displacement offset
		   	ld	de,#plotSScreen
		   	add	hl,de
		   putSpriteLoop1:
		   sl1:	ld	d,(ix)             ;loads image byte into D
		   	ld	e,#00
		   	ld	a,c
		   	or	a
		   	jr	z,putSpriteSkip1
		   putSpriteLoop2:
		   	srl	d                  ;rotate to give out smooth moving
		   	rr	e
		   	dec	a
		   	jr	nz,putSpriteLoop2
		   putSpriteSkip1:
		   	ld	a,(hl)
		   	COPY_MODE	d
		   	ld	(hl),a
		   	inc	hl
		   	ld	a,(hl)
		   	COPY_MODE	e
		   	ld	(hl),a              ;copy to buffer using XOR logic
		   	ld	de,#X_LINE-1
		   	add	hl,de
		   	inc	ix                   ;Set for next byte of image
		   	djnz	putSpriteLoop1 

		   	ret

	__endasm;
}
#ifdef USE_APPBACKUP_ION
void appBackupIonPutSprite()__naked{      ///////// 4 5 6 (7, 8)
	__asm
		
		_putSprite:
		   	ld	e,l
		   	ld	h,#00
		   	ld	d,h

		   	// hl, de = 16 bit y. Must mult by X_LINE
		   	Y_MULT            ;Find the Y displacement offset 


		   	ld	e,a
		   	and	#07               ;Find the bit number
		   	ld	c,a
		   	srl	e
		   	srl	e
		   	srl	e
		   	add	hl,de             ;Find the X displacement offset
		   	ld	de,#appBackUpScreen
		   	add	hl,de
		   _putSpriteLoop1:
		   _sl1:	ld	d,(ix)             ;loads image byte into D
		   	ld	e,#00
		   	ld	a,c
		   	or	a
		   	jr	z,_putSpriteSkip1
		   _putSpriteLoop2:
		   	srl	d                  ;rotate to give out smooth moving
		   	rr	e
		   	dec	a
		   	jr	nz,_putSpriteLoop2
		   _putSpriteSkip1:
		   	ld	a,(hl)
		   	COPY_MODE	d
		   	ld	(hl),a
		   	inc	hl
		   	ld	a,(hl)
		   	COPY_MODE	e
		   	ld	(hl),a              ;copy to buffer using XOR logic
		   	ld	de,#X_LINE-1
		   	add	hl,de
		   	inc	ix                   ;Set for next byte of image
		   	djnz	_putSpriteLoop1 

		   	ret

	__endasm;
}
#endif

// Not too slow, images must be encoded a special way
void fullPutSprite(char x, char y, char width, char height, char* sprite){  //4, 5, 6, 7 (8, 9)
	__asm
		ld	l, 8 (ix)
		ld	h, 9 (ix)
		push hl
		

		ld a,  4(ix)
		ld l, 5(ix)
		ld b, 7(ix)

		ld c, 6(ix)

		pop ix
		X_DRAW_LOOP: // 101 t-states
			push af
			push hl
			push bc
			call _ionPutSprite
			pop bc
			pop hl
			pop af

			add a, #8
			dec c
			jp nz, X_DRAW_LOOP
	__endasm;
}

#ifdef GREYSCALE_SPRITES
void greyPutSprite(char x, char y, char width, char height, char* sprite){  //4, 5, 6, 7 (8, 9) (10, 11)
		__asm
		ld	l, 8 (ix)
		ld	h, 9 (ix)
		push hl

		// add hl, de
		// ex de, hl
		// pop hl
		// push de
		// push hl


		ld a,  4(ix)
		ld l, 5(ix)

		ld h, 6(ix)

		ld b, 7(ix)

		ld c, 6(ix)

		pop ix

		push af
		push hl
		push bc

		__X_DRAW_LOOP: // 101 t-states
			push af
			push hl
			push bc
			call _ionPutSprite
			pop bc
			pop hl
			pop af

			add a, #8
			dec c
			jp nz, __X_DRAW_LOOP

		pop bc
		pop hl
		pop af

		__Xa_DRAW_LOOP: // 101 t-states
			push af
			push hl
			push bc
			call _appBackupIonPutSprite
			pop bc
			pop hl
			pop af

			add a, #8
			dec c
			jp nz, __Xa_DRAW_LOOP

	

	__endasm;
}

#endif