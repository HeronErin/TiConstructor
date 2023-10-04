#pragma once
#include "variables.c"
#include "errors.c"

/** @file memory.c @brief A simple and preforment memory allocator
 * 
 * This file allows for a psuedo-heap, it is a lot like how the heap
 * works in the typical c std. This works by creating a calculator 
 * variable typically called "ConHeap" where the data is stored. 
 * It should be noted that initHeap() uses getOrCreateVar() so
 * if somebody forgets to purge_heap() and you are using a custom
 * HEAP_SIZE you might run into some error. <b>So always call purge_heap()
 * or make use of auto_purge_heap() !</b>
 * 
 * <small> It should be noted that auto_purge_heap() seems not to run correctly in programs </small>
 * 
 * 
 * 
 * <h3> Optional #defines </h3>
 *  + <b> HEAP_SIZE</b>        - A number that is the size of varible to create for the heap.
 *  + <b> CUSTOM_HEAP_NAME</b> - Sets the heap variable to a custom name
 */


#ifndef HEAP_SIZE
/** @brief The size of the calculator variable the heap is stored as. You can set this to a larger (or smaller) value if you want*/
#define HEAP_SIZE 1024
#endif

/** @{ \name Heap memory locations */

/** @brief Memory location of heap related information */
#define HEAP_LOCATION 0x83E5


#define HEAP_CONSTANT  HEAP_LOCATION //< Always should be 0xFE
#define HEAP_CONSTANT2  ( HEAP_CONSTANT+1) //< Always 0xED

#define HEAP_LOCATION_PTR (HEAP_CONSTANT2+1) //< Pointer to heap
#define HEAP_TEMP (HEAP_LOCATION_PTR+2) //< This is used during malloc as a temp memory location

/** @} */




#ifndef CUSTOM_HEAP_NAME
/** @brief allows setting a custom heap variable name */
#define CUSTOM_HEAP_NAME "ConHeap"
#endif

/** @brief Name of heap variable in calculator */
const char HEAP_VAR_NAME[] =  addAppVarObj(CUSTOM_HEAP_NAME); 


/** General structure of the a HeapItem */
struct HeapItem
{
	char HeapItemBitmap;  ///< Bitmap of atributes of heap item. bit 0: isfreed,  OR set to 0xFF if not items exit
	void* HeapItemSize; ///< Size of current heap item including header
	void body; ///< The allocated memory of the size at HeapItemSize
};

/** @brief Cleans up the heap for when the program is closing
 * 
 * Call this before you exit the program if you initialized the heap
 */
#define purge_heap() delete(HEAP_VAR_NAME)

#define __hs #



/** @brief Automaticlly runs purge_heap() for you
 * 
 * This <b>must be called in main</b>, this is because it will
 * automaticlly run purge_heap() when the current function
 * returns. This also must be called <b>before ANY</b>
 * variables are set, it will destroy the hl register.
 * If you call auto_purge_heap() in main before any
 * variables are set, it will automaticlly call purge_heap()
 * for you as main returns. 
 * 
 * 
 * Also doesn't seem to run currectly programs.
 * 
 */
#define auto_purge_heap() __asm                  \
   ld hl, __hs AUTO_CLOSE_HEAP_LOCATION          \
   push hl                                       \
   jp AFTER_AUTO_CLOSE_HEAP                      \
AUTO_CLOSE_HEAP_LOCATION:                        \
   __endasm; purge_heap(); __asm        \
   ret                                           \
  AFTER_AUTO_CLOSE_HEAP: __endasm


/** @brief Create the heap for you
 * 
 *  Call this to create/reset the heap. 
 *  You can call this a secound time to reset the heap for you.
 *  But don't use any pointers you got from malloc/calloc
 *  or you might get undefined outputs.
 */
void initHeap(){
	__asm
	// Fill constants
		ld hl, #HEAP_CONSTANT
		ld a, #0xFE
		ld (hl), a
		inc hl
		ld a, #0xED
		ld (hl), a


	// Get or create heap variable
		ld	hl, #HEAP_SIZE
		push	hl
		ld	hl, #_HEAP_VAR_NAME
		push	hl
		call	_getOrCreateVar
		pop	af
		pop	af
	// set HEAP_LOCATION_PTR 
		ex de, hl
		ld hl, #HEAP_LOCATION_PTR
		ld (hl), e
		inc hl
		ld (hl), d
	// Initialize heap variable memory

		ex de, hl
		// Skip first two bytes are size of appvar
		inc hl
		inc hl

		// Set first byte to 0xFF 
		ld (hl), #0xFF

	__endasm;
}


/** @brief Assembly malloc implementation
 *  @param[bc] Size of memory to be requested 
 * 	@return hl = memory location
 * 
 * 	See malloc() and all error conditions apply. 
 */ 
void _malloc() __naked{
	__asm
		xor a, a
		ld hl, #0
		sbc hl, bc
		ld hl, #0

		jp nz, NOT_A_ZERO

	#ifndef NO_MEMMORY_ERRORS
	__endasm; MemoryError(); __asm
	#endif
	#ifdef NO_MEMMORY_ERRORS
	ret
	#endif


		
		ret


	NOT_A_ZERO:
		ld hl, (HEAP_LOCATION_PTR)

		ex de, hl


		inc de
		inc de

		ex de, hl
		ld de, #0

		res 0, asm_Flag1(iy)
	MALLOC_LOOP:
		ld a, #0xFF
		cp (hl)
		jp z, GROW_HEAP

		bit 0, (hl)
		jp z, MALLOC_NOT_FREED_ITEM

	
		
	// Freed ram
		bit 0, asm_Flag1(iy)		
		jp nz, AFTER_MALLOC_SET_BIT
		ld (HEAP_TEMP), hl
		



		set 0, asm_Flag1(iy)
		AFTER_MALLOC_SET_BIT:
		inc hl
		push hl
		push bc

		ld b, (hl)
		inc hl
		ld c, (hl)

		ex de, hl	
		
		add hl,bc
		pop de

		// Check if there is enough free space for the malloc
		  push hl
		  dec hl
		  dec hl
		  dec hl
		  or a
		  sbc hl,de
		  pop hl


		ld b, d
		ld c, e
		ex de, hl
		pop hl
		jp c, PREP_NEXT

		ld hl, (HEAP_TEMP)
		jp GROW_HEAP


	MALLOC_NOT_FREED_ITEM:
		inc hl
		ld de, #0
		res 0, asm_Flag1(iy)


	PREP_NEXT:
		push de
		ld d, (hl)
		inc hl
		ld e, (hl)
		dec hl
		dec hl
		add hl, de
		pop de

		jp MALLOC_LOOP


	GROW_HEAP:
		inc bc
		inc bc
		inc bc

		xor a, a
		ld (hl), a
		inc hl
		ld (hl), b
		inc hl
		ld (hl), c
		push hl
	
		add hl, bc
		push hl

	// Makes sure there is enough memory in the heap for the memory. Otherwise throws a MemoryError() if NO_MEMMORY_ERRORS is not defined
		ex de, hl
		ld hl, (HEAP_LOCATION_PTR)

		ld c, (hl)
		inc hl
		ld b, (hl)


		inc hl
		inc hl
		
		add hl, bc

		sbc hl, de

		jp nc, MALLOC_SUCCESS


		#ifndef NO_MEMMORY_ERRORS
		__endasm; MemoryError(); __asm
		#endif
		#ifdef NO_MEMMORY_ERRORS
		pop af
		pop af
		ld hl, #0
		ret
		#endif



	MALLOC_SUCCESS:

		pop hl
		dec hl
		dec hl
		

		dec a
		ld (hl), a

		pop hl
		inc hl

		ret


	__endasm;

}

/** @brief Request to allocate an amount of memory from the heap (filled undefined random data)
 *  @param[size] Amount of memory to be allocated
 * 	@return A pointer to free memory
 * 
 *  This should be identical to the normal malloc function. 
 * 	But be warned that if you write to bytes past what you 
 *  have allocated you can cause <b>undefined behavior!</b>
 * 	
 * 	If <b>NO_MEMMORY_ERRORS</b> is defined instead of raising 
 *  an error, malloc will return NULL. 
 * 	Malloc can error for two reasons, if you pass in zero,
 *  or if you allocate too much memory for the heap variable.
 */
void* malloc(int size)__naked{
	__asm
		pop hl
		pop bc
		push bc
		push hl

		jp __malloc
	__endasm;
}



/** @brief Assembly free() implementation
 *  @param[hl] Location of memory to be freed 
 * 	
 *  See free()
 */ 
void _free() __naked{
	__asm
		dec hl // Hl = header of Heap Item (assuming it is valid)
		dec hl
		dec hl
		
		push hl // save hl

		ex de, hl 
		ld hl, (HEAP_LOCATION_PTR) 

		ld c, (hl)
		inc hl
		ld b, (hl) // Bc = size of heap
		inc hl



		ex de, hl // hl = header, de = heap location

		
		push hl
		or a, a
		sbc hl, de

		jp c, FREE_ERROR 
		pop hl
		ex de, hl // hl = location of the heap, de = heap item header, bc = size of heap

		add hl, bc // hl = end of heap
		or a, a

		ex de, hl



		sbc hl, de 
		jp nc, FREE_ERROR   
 
		

		pop hl

		set 0, (hl)
		ret


	FREE_ERROR:
	__endasm;
	#ifndef NO_MEMMORY_ERRORS
	MemoryError(); 
	#endif
	__asm
		pop af
		ret
	__endasm;
}

/** @brief Frees an allocated memory address from the heap
 * 	@param[ptr] Memory to be freed
 */
void free(void* ptr)__naked{
	__asm
		pop bc
		pop hl
		push hl
		push bc
		jp __free
	__endasm;
}

/** @brief Assembly function for calloc()
 *  @param[bc] Size of memory to be requested 
 * 	@return hl = memory location
 * 
 */
void _calloc()__naked{
	__asm
		push bc
		call __malloc
		
		ld bc, #0
		sbc hl, bc
		jp nc, CALLOC_VALID_PTR

		pop af
		ret
	CALLOC_VALID_PTR:
		pop bc
		ex de, hl

		dec bc
		ld hl, #0
		sbc hl, bc
		ex de, hl
		jp nz, CALLOC_NOT_ZERO
		
		ret
	CALLOC_NOT_ZERO:
		ld d, h
		ld e, l
		ld (hl), #0x00
		push hl

		inc de
		
		ldir

		pop hl
		ret

	__endasm;
}
/** @brief Request to allocate an amount of memory from the heap (filled zeros)
 *  @param[size] Amount of memory to be allocated
 * 	@return A pointer to free memory
 * 
 * 	Same as malloc() except fills data buffer with zeros
 */
void* calloc(int size)__naked{
	__asm
		pop hl
		pop bc
		push bc
		push hl

		jp __calloc
	__endasm;
}