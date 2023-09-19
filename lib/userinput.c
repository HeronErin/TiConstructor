#pragma once

/** @file userinput.c @brief 2 useful functions for getting user input
 * 
 * You don't actually need getKey() unless custom interupts (like greyscale.c) are used.
 * 
 * <h3> Optional #defines </h3>
 * 
 *   + <b> USE_GETKEY</b>  - enables getKey()
 * 
 */


/** @brief Wait for a key to be pressed and return it in the "A" assembly register
 *  This is mostly used at the end of a program, bewarned that this(like any bcall) my mess with C vars, see https://wikiti.brandonw.net/index.php?title=83Plus:BCALLs:4972
 */
#define PressAnyKey() bcall(0x4972)


#if defined(USE_GETKEY) || defined(DOXYGEN)


/** @brief <b>DEPRECATED</b> Scan for keypresses and returns the currently pressed key
 *  @return char of the currently pressed key (see: https://wikiti.brandonw.net/index.php?title=83Plus:RAM:843F)
 * 
 * <h3><b>DEPRECATED</b> You probably do not need this, but if interupts are disable/customized or greyscale is active, this will work for you.</h3>
 */
char getKey(){
    bcall(0x4015);
    return *((char*)(0x843F));
}
#endif

