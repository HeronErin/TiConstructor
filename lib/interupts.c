#pragma once
// Taken from https://www.omnimaga.org/asm-language/interrupt-routine-not-returning/msg404756/#msg404756
// With interupts im not quite sure what im doing but this interupt system work



// See https://taricorp.gitlab.io/83pa28d/lesson/day23.html and https://wikiti.brandonw.net/index.php?title=83Plus:Ports:03
// interupts "interupt" your code on run something else

// They must run fast, I recomend you only run asm
// The absolute max is 54545 t-states, just remember an interupt is ran
// more then 100 times per secound and the z80 only has 1 core



// before including this file, run: #define DURING_INTERUPT() YOUR_CODE_HERE
// Never run anything here except SET_INTERUPTS, in this project assume if something starts with ten underscores, don't try to run it



#define __hs # // bypass rule against using # in macros
#define INTRPT_MASK  0b00001011 // Use all interupts
#define basepage 0x8584




#define SET_INTERUPTS() 	__asm\
		ld de, __hs  (ON_EXIT-LoadInterrupt+0x8E2C) \
		push de \
	__endasm; _________SET_INTERUPTS(); __asm\
		ld	ix,__hs 0\
		add	ix,sp\
	__endasm;
	




// Start the stuff i took
void _________SET_INTERUPTS(){
	__asm
		 ; disable interrupts and set interrupt mode 2
		 di
		 im 2
		 
		 ; save whichever page we are on so that we know where to go
		 in a,(6)
		 ld (basepage),a
		 
		 ; set the upper byte of the jumptable to $80
		 ld a,#0x80
		 ld i,a
		 
		 ; now we copy our interrupt loader to ram, we only have to do this once
		 ld hl,#LoadInterrupt

		 // A better place to store the rom loader code
		 ld de, #0x8E2C 
		 ld bc,#EndLoadInterupt-LoadInterrupt
		 ldir
		 
		 ; create the vector table (do this every time before you enable interrupts, be sure to disable interrupts before archiving / unarchiving stuff)
		 ld hl, #0x8000
		 ld de, #0x8001
		 ld (hl), #0x85
		 ld bc,#256
		 ldir
		 
		 ; setting up the jump handler at $8585
		 ld hl,#0x8585
		 ld (hl),#0xc3 ; this is the jp instruction
		 ld de,#0x8E2C ; where it jumps to
		 inc hl
		 ld (hl),e
		 inc hl
		 ld (hl),d
		
		 ; time to enable interrupts
		 ei


	__endasm;
}

void _____copied_to_position()__naked{
	
	__asm
		LoadInterrupt:
		 di
		 exx
		 aSaveA
		xor a, a
		out (3),a


		#ifdef FLASH_APP
		/////////// flash apps require switching current rom page for interupts
		 in a,(6)
		 push af
		  ld a,(basepage)
		  out (6),a
	    #endif
		  __endasm;

		  DURING_INTERUPT();

		  __asm
	  	
	  	#ifdef FLASH_APP
		 	pop af
		 	out (6),a
	 	#endif
		 
		xor a, #INTRPT_MASK
		out (3),a

			
		aSaveA
		exx
		ei


		ret
		ON_EXIT:  
			di
			im 1 
			ld a, __hs INTRPT_MASK 
			out (3), a

			// useful for greyscale
			#ifdef ADDED_ON_EXIT
			__endasm;
			ADDED_ON_EXIT();
			__asm
			#endif


			ei 
			ret 
		
		EndLoadInterupt:
	__endasm;
}
