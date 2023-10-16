#pragma once

// [or, xor, and], because they are valid z80 opcodes
#ifndef COPY_MODE
#define COPY_MODE xor 
#endif

#ifndef X_LINE
#define X_LINE 12  // XMAX / 8
#endif

#ifndef Y_MULT // asm to multiply hl by X_LINE
#define Y_MULT 		add	hl,de \ \
				   	add	hl,de \ \
				   	add	hl,hl \ \
				   	add	hl,hl 
#endif


#ifdef GREYSCALE_SPRITES
#define USE_APPBACKUP_ION
#endif

/**
* @brief Only can render 8 wide sprites, <b>DO NOT CALL FROM C </b>
* 
* IonPutSprite:
* Draw a sprite to the graph buffer (XOR).
* Inputs: 
* b=sprite height
* a=x coordinate
* l=y coordinate
* ix->sprite
* 
* Output: 
* Sprite is XORed to the graph buffer.
* ix->next sprite
* Destroys: af bc de hl ix
* 
* <b> NEVER CALL FROM C </b>
*/
void ionPutSprite()__naked{    
	#asm
		
		putSprite:
		   	ld	e,l
		   	ld	h,00
		   	ld	d,h
		   	
		   	// hl, de = 16 bit y. Must mult by X_LINE
		   	Y_MULT            ;Find the Y displacement offset 


		   	ld	e,a
		   	and	07               ;Find the bit number
		   	ld	c,a
		   	srl	e
		   	srl	e
		   	srl	e
		   	add	hl,de             ;Find the X displacement offset
		   	ld	de,plotSScreen
		   	add	hl,de
		   putSpriteLoop1:
		   sl1:	ld	d,(ix)             ;loads image byte into D
		   	ld	e,00
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
		   	ld	de,X_LINE-1
		   	add	hl,de
		   	inc	ix                   ;Set for next byte of image
		   	djnz	putSpriteLoop1 

		   	ret

	#endasm
}
#ifdef USE_APPBACKUP_ION
void appBackupIonPutSprite()__naked{      ///////// 4 5 6 (7, 8)
	#asm
		
		_putSprite:
		   	ld	e,l
		   	ld	h,00
		   	ld	d,h

		   	// hl, de = 16 bit y. Must mult by X_LINE
		   	Y_MULT            ;Find the Y displacement offset 


		   	ld	e,a
		   	and	07               ;Find the bit number
		   	ld	c,a
		   	srl	e
		   	srl	e
		   	srl	e
		   	add	hl,de             ;Find the X displacement offset
		   	ld	de,appBackUpScreen
		   	add	hl,de
		   _putSpriteLoop1:
		   _sl1:	ld	d,(ix)             ;loads image byte into D
		   	ld	e,00
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
		   	ld	de,X_LINE-1
		   	add	hl,de
		   	inc	ix                   ;Set for next byte of image
		   	djnz	_putSpriteLoop1 

		   	ret

	#endasm
}
#endif

/** @brief Render a sprite
 * 	@param[x] X coord to be drawn
 *  @param[y] Y coord to be drawn
 *  @param[width] Amount of 8-bit long segments to draw (2 for 8 pixels wide)
 *  @param[height] Height of image to be drawn (in pixels)
 * 	@param[sprite] Location to be drawn
 * 
 * Not too slow, images must be encoded with png2sprite.py in the root of the TiConstructor git folder. 
 * `python png2sprite.py IMAGE.png mono`
 */ 
void fullPutSprite(char x, char y, char width, char height, char* sprite) __z88dk_sdccdecl __z88dk_callee __naked{  //4, 5, 6, 7 (8, 9)
	#asm

		di
		ld d, ixh
		ld e, ixl

		pop af
		pop hl  ; y, x
		pop bc  ; height, width
		pop ix ; char* sprite
		push af

		ld a, l
		ld l, h
		push de


		SPRITE_LOOP:
			push af
			push bc
			push hl
			call _ionPutSprite
			pop hl
			pop bc
			pop af

			add a, 8
			dec c
			jp nz, SPRITE_LOOP



		pop ix


		ei
		ret


	#endasm
}

#ifdef GREYSCALE_SPRITES
/** @brief Render a sprite for greyscale
 * 	@param[x] X coord to be drawn
 *  @param[y] Y coord to be drawn
 *  @param[width] Amount of 8-bit long segments to draw (2 for 8 pixels wide)
 *  @param[height] Height of image to be drawn (in pixels)
 * 	@param[sprite] Location to be drawn
 * 
 * Not too slow, images must be encoded with png2sprite.py in the root of the TiConstructor git folder. 
 * `python png2sprite.py IMAGE.png grey`
 */ 
void greyPutSprite(char x, char y, char width, char height, char* sprite) __z88dk_sdccdecl __z88dk_callee __naked{  \
//4, 5, 6, 7 (8, 9) (10, 11)
		#asm
		di
		ld d, ixh
		ld e, ixl

		pop af
		pop hl  ; y, x
		pop bc  ; height, width
		pop ix ; char* sprite
		push af

		ld a, l
		ld l, h
		push de



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

			add a, 8
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

			add a, 8
			dec c
			jp nz, __Xa_DRAW_LOOP


		pop ix
		ret


	

	#endasm
}

#endif