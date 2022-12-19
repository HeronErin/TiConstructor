#pragma once



// 0 for 8 mhz and 3 for 14.99 mhz
// for more info: https://wikiti.brandonw.net/index.php?title=83Plus:Ports:20 
#ifdef USE_CPU_SPEED
char getCpuSpeed() __naked{
    __asm
        in a, (0x20)
        ld l, a
        ret
    __endasm;
}
void setCpuSpeed(char speed){
    __asm
        ld a, 4 (ix)
        out (0x20), a
    __endasm;
}
#endif

// get bottom bytes of realtime clock
#ifdef USE_GET_TIME
unsigned int getTime(){ 
    __asm
        in a, (0x45)
        ld l, a
        in a, (0x46)
        ld h, a
    __endasm;
}
#endif

#ifdef USE_WAIT8
void wait(unsigned char x){ // Wait for amount of time (1/8th of sec)
    x;
    __asm
       ld a,#0x47      ;8 hz
       out (#0x30),a
       ld a,#0x00        ; no loop, no interrupt
       out (#0x31),a
       ld a,4(ix)       ;16 ticks / 8 hz equals 2 seconds
       out (#0x32),a
    wait:
       in a,(4)
       bit 5,a       ;bit 5 tells if timer 1
       jr z,wait     ;is done
       xor a
       out (#0x30),a   ;Turn off the timer.
       out (#0x31),a

   __endasm;
}
#endif



#ifdef USE_ISQRT
// int square root
char isqrt(unsigned int val) {
    unsigned int temp;
    unsigned char bshft = 7, b = 0x80, g=0;
    do {
        if (val >= (temp = (((g << 1) + b)<<bshft--))) {
           g += b;
           val -= temp;
        }
    } while (b >>= 1);
    return g;
}
#endif
