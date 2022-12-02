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