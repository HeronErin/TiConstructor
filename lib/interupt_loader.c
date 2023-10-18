#pragma once


// Location of line 45 at:
// https://github.com/z88dk/z88dk/blob/master/lib/target/ti83p/classic/intwrap83p.asm
//

#define interrupt_rst38 24 + 0x8A8A

#define basepage 0x8AFF
// Only have 69 bytes to work with
#define loader_point 48 + 0x8A8A

#define interrupt_mask  0b00001011
#define interrupt_acknowledge 0b00001000


// Effectivly "ret" but to +3 of normal value, and acknowledges that interupt ran
#define CI_RET pop de \ ld hl, 7 \ add hl, de \\
		 ld a, interrupt_mask \ out (3), a \
		 \ jp (hl) 


// Restore old opcodes to the interupt ram
void unpatch_ram() __naked{
	#asm
	di
#ifdef FLASH_APP
	ld hl, interrupt_rst38-2
#else
	ld hl, 0x8A8A+1
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, 24-2 // Calculate where location based on the jp instruction 
	add hl, de  // created by the interupt loader	
#endif
	ld (hl), $D9 // Exx
	inc hl
	ld (hl), $08 // ex af, af
	inc hl
	ld (hl), $FF // rst 38h
	inc hl
	ld (hl), $F3 // di
	inc hl
	ld (hl), $F3 // di
	inc hl
	ld (hl), $08 // ex af, af
	inc hl
	ld (hl), $D9 // Exx
	

	ret


	#endasm
}

void patch_ram() __naked{
	#asm
	di

#ifdef FLASH_APP
	in a,(6)
	ld (basepage), a

	ld hl, interrupt_rst38-2
	
#else
	ld hl, 0x8A8A+1
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, 24-2 // Calculate where location based on the jp instruction 
	add hl, de  // created by the interupt loader
	
#endif
	ld a, 0xF3
	ld (hl), a // Replace "exx" with "di"
	inc hl
	xor a, a
	ld (hl), a // Replace "ex af,af" with "nop"
	inc hl



	// replace calling the default system interupts with calling the interupt loader
	ld (hl), 0xCd // "Call" opcode
	inc hl
	#ifdef FLASH_APP
	ld (hl), (loader_point) &0xFF
	inc hl
	ld (hl), (loader_point) >> 8
	#else
	ld (hl), (USER_INTERUPT_LOADER) &0xFF
	inc hl
	ld (hl), (USER_INTERUPT_LOADER) >> 8
	#endif
	xor a, a
	inc hl
	ld (hl), a // Replace "ex af,af" with "nop"
	inc hl
	ld (hl), a // Replace "exx" with "nop"

	#ifdef FLASH_APP
	ld hl, USER_INTERUPT_LOADER
	ld de, loader_point
	ld bc, END_OF_USER_INTERUPT_LOADER-USER_INTERUPT_LOADER

	ldir
	#endif
	ei
	ret
	#endasm




	#asm
USER_INTERUPT_LOADER:
#ifdef FLASH_APP

	in a,(6)
	push af
	ld a,(basepage)
	out (6),a
#endif
	call USER_INTERUPT

	exx
	ex af, af

	rst	$38			;
	di				; 'BIG' HOLE HERE... (TIOS does ei...)
	di
	exx
	ex af, af

	// Effectivly rets here on CI_RET by adding to the return value

#ifdef FLASH_APP
	pop af
	out (6),a
#endif
	ret
END_OF_USER_INTERUPT_LOADER:
	#endasm




}