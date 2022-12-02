#pragma once
// this should be included in all files, it should be small enough for size constrained programs.


#define aSaveA .db #0x08 // ex af, af' and only takes 4 t-states

#define clearScreen() bcall(0x4540)
// bcall for c
#define bcall(__LABEL__) \
    __asm rst 40 \
    .dw __LABEL__ __endasm

// bcall for asm
#define abcall(__LABEL__) \
    rst 40 \
    .dw __LABEL__
char getKeyId(){
    bcall(0x4015);
    return *(char*)(0x843F);
}





























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

