#pragma once
// see https://taricorp.gitlab.io/83pa28d/lesson/day23.html and https://www.cemetech.net/forum/viewtopic.php?t=7696&start=0
// interupts "interupt" your code on run something else

// They must run fast, I recomend you only run asm
// before including this run: #define DURING_INTERUPT() YOUR_CODE_HERE
// I recommend using a static inline function as normal function calls don't work in interupts if you are using a flash app

#ifdef OVERIDE_INTERUPTS


#define __hs #
#define INTRPT_MASK  0b00001011
// use this
#define SET_INTERUPTS() \
	__asm\
		ld hl, __hs __fix_interputs\
		push hl\
		call ______set_interputs\
	__endasm



// not this
void _____set_interputs(){
	__asm
		di
		ld a,#0x9a
		ld i,a
		ld h,a
		ld l,#0
		ld (hl),#0x99
		push hl
		pop de
		inc de
		ld bc,#256
		ldir


		LD     HL, #INTER_START
		LD     DE, #0x9999
		LD     BC, #INTER_END - INTER_START
		ldir

	    ld a, #INTRPT_MASK
	    out (3), a
		im 2
		ei
	__endasm;
}

void _____copied_to_position(){
	
	__asm

	INTER_START:
	exx
	di
	aSaveA
	xor a, a
	out (3),a
	__endasm;

	DURING_INTERUPT();

	__asm
	ld a,#INTRPT_MASK
	out (3),a
	aSaveA
	exx
	ei
	ret
	INTER_END:
	__endasm;
}
void _fix_interputs(){
	__asm
		im	1
		ld	a, #0b00001011	;interrupts
		out	(03), a

	__endasm;
}


#endif