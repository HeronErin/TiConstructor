#pragma once
/** @file essentials.c
 *  
 * @brief This should be #included in all files.
 * 
 * This file #defines all required constants, and loads in "ti83plus.h" for other constantss that are needed. Only defines stuff at compile time, no real function, no extra bytes.
 */

#ifndef SHOW_WARNINGS
#pragma disable_warning 59 // disable no return warning
#pragma disable_warning 85 // disable parameter not used warning
#endif



#include "ti83plus.h"




/** @{ \name Global omni-present constants
 */

/** @brief ex af, af'
 * 
 * Machine code to swap af and shadow af and only takes 4 t-states, <b>only use in asm</b>  */
#define aSaveA .db #0x08

/**  @brief Stack pointer temp
 * 
 * Used to store the stack pointer in several functions, if you are writing some assembly, feel free to use this.
 * But not for long-term storage as it is writen to by multiple functions.
*/
#define SP_STORE 0x980C


/** @brief Also used for storing the stack pointer */
#define spriteTemp 0x84F3

/** @} */


/** @{ \name function macros */


/** @brief Clears the screen */
#define clearScreen() bcall(_ClrLCDFull)



/** @brief Call System routine
 * 
 *  Preforms a [bcall](https://wikiti.brandonw.net/index.php?title=83Plus:OS:How_BCALLs_work) 
 *  while in C. <b> And keep in mind that a bcall might modify registers, meaning that any bcall can corrupt any C variable </b>
 *  For most bcall values click [here](https://wikiti.brandonw.net/index.php?title=Category:83Plus:BCALLs:By_Name),
 *  or see [TI's system routines document](https://ia600606.us.archive.org/16/items/83psdk/83psysroutines.pdf)*/
#define bcall(__LABEL__) \
    __asm rst 40 \
    .dw __LABEL__ __endasm


/** @brief Junp to System routine
 * 
 * Like a bcall() but jumps instead of calls
 */
#define bjump(__LABEL__) \
    __asm call 0x50 \
    .dw __LABEL__ __endasm



/** @brief The asm for a bcall
 */
#define abcall(__LABEL__) \
    rst 40 \
    .dw __LABEL__


/** @brief Get last pressed key 
 *  
 * Rrequires scanKeys() with custom interupts */
#define lastPressedKey() (*(char*)(kbdScanCode))

/** @brief Scan for pressed keys
 * 
 *  Manually scan for pressed key, only needed with custom interupts */
#define scanKeys() bcall(_kdbScan)


/* @} */


/** @{ \name Safe Memory Areas */


/** @brief 768 bytes (APDRAM)*/
#define saferam1   0x9872
/** @brief 531 bytes (statRAM)*/
#define saferam2   0x8A3A
/** @brief 128 bytes (textMem)*/
#define saferam3   0x8508
/** @brief 66 bytes (Op registers, use with caution)*/
#define saferam4   0x8478
/** @brief 8 bytes (bootTemp)*/
#define saferam5   0x8251



/* @} */
















// switch stuff


// makes sure if you use something you have what is depends on, like number if you are using fixed_print

// fixed point stuff
    #ifdef USE_FIXED_TAN
    #define USE_FIXED_COS
    #endif
    #ifdef USE_FIXED_COS
    #define USE_FIXED_SIN
    #endif
    
    #ifdef USE_FIXED_PRINT
    #define USE_NUMBER
    #endif

