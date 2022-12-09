#pragma once


#ifndef SHOW_WARNINGS
#pragma disable_warning 59 // disable no return warning
#pragma disable_warning 85 // disable parameter not used warning
#endif



#include "ti83plus.h"

// this should be included in all files, it should be small enough for size constrained programs.


#define aSaveA .db #0x08 // ex af, af' and only takes 4 t-states


#define SP_STORE 0x980C





#define clearScreen() bcall(_ClrLCDFull)
// bcall for c
#define bcall(__LABEL__) \
    __asm rst 40 \
    .dw __LABEL__ __endasm

// bcall for asm
#define abcall(__LABEL__) \
    rst 40 \
    .dw __LABEL__

#define lastPressedKey() (*(char*)(kbdScanCode))
#define scanKeys() bcall(_kdbScan)


#define JpOffset(x) ((x)-INTER_START + 0x9999)




//----> Safe Memory Areas
// saferam1 = 768 bytes (APDRAM)
// saferam2 = 531 bytes (statRAM)
// saferam3 = 128 bytes (textMem)
// saferam4 = 66 bytes (OpXs)
// saferam5 = 10 bytes (iMathPtrs)

#define saferam1   0x9872
#define saferam2   0x8A3A
#define saferam3   0x8508
#define saferam4   0x8478
#define saferamp   0x9872
#define saferamp2   0x8251




















// switch stuff:


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

