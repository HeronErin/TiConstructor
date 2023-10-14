#pragma once
/** @file misc.c @brief Some random but useful functions
 * 
 * 
 * 
 * <h3> Optional #defines </h3>
 * 
 *   + <b> USE_CPU_SPEED</b> - enables getCpuSpeed(), and setCpuSpeed()
 *   + <b> USE_GET_TIME</b>  - enables getTime()
 *   + <b> USE_WAIT8</b>     - enables wait()
 *   + <b> USE_ISQRT</b>     - enables isqrt()
 * 
 */



/** @{ @name CPU speed settings
 */


#if defined(USE_CPU_SPEED) || defined(DOXYGEN)

/** @brief Get the current cpu speed
 *  @return char of a value 0-3
 * 0 for 8 mhz and 3 for 14.99 mhz
 * for more info: https://wikiti.brandonw.net/index.php?title=83Plus:Ports:20 
 */ 
char getCpuSpeed() __naked __z88dk_sdccdecl{
    #asm
        in a, (0x20)
        ld l, a
        ret
    #endasm
}

/** @brief Set the current cpu speed
 *  @param[speed] char of a value 0-3
 * 0 for 8 mhz and 3 for 14.99 mhz
 * for more info: https://wikiti.brandonw.net/index.php?title=83Plus:Ports:20 
 */ 
void setCpuSpeed(char speed) __naked __z88dk_fastcall{
    #asm
        ld a, l
        out (0x20), a
        ret
    #endasm
}
#endif

/** @brief Get bottom bytes of realtime clock
 *  @return 16-bit unsigned int of the bottom bytes of the real time clock
 * See: https://wikiti.brandonw.net/index.php?title=83Plus:Ports:45 and https://wikiti.brandonw.net/index.php?title=83Plus:Ports:40
 */ 
#if defined(USE_GET_TIME) || defined(DOXYGEN)
unsigned int getTime() __naked __z88dk_sdccdecl{ 
    #asm
        in a, (0x45)
        ld l, a
        in a, (0x46)
        ld h, a
        ret
    #endasm
}
#endif

#if defined(USE_WAIT8)  || defined(DOXYGEN)

/** @brief Wait for amount of time (1/8th of sec)
 *  @param[x] Amount of time to wait in intervals of 1/8th of a secound
 * 
 */
void wait(unsigned char x) __naked __z88dk_fastcall{
    x;
    #asm
       ld a,0x47      ;8 hz
       out (0x30),a
       ld a,0x00        ; no loop, no interrupt
       out (0x31),a
       ld a,l       ;16 ticks / 8 hz equals 2 seconds
       out (0x32),a
    wait:
       in a,(4)
       bit 5,a       ;bit 5 tells if timer 1
       jr z,wait     ;is done
       xor a
       out (0x30),a   ;Turn off the timer.
       out (0x31),a

       ret

   #endasm
}
#endif



#if defined(USE_ISQRT)  || defined(DOXYGEN)
/** @brief <b>DEPRECATED</b> Int square root
 *  @param[val] unsigned int
 *  @return char value of sqrt(val)
 *  
 *  <h3>This function is <b>DEPRECATED</b> and slow! Please use sqrt_rounded() in fast_math.c</h3>
 */
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
