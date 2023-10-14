/**
 * @file textio.c  @brief String I/O type stuff
 * 
 * This is for printing c strings, it is not fast, but shouldn't be too large. Feel free not to use it if you need more space, although don't expect to use any other io type stuff
 * 
 * <h3> Optional #defines </h3>
 *   + <b> USE_NUMBER</b>  - enables number()
 *   + <b> USE_HEXDUMP</b> - enables hexdump()
 */



#pragma once


/** @brief set the row that is currently selectd
 *  @param[row] char to move the pen to
 * See https://wikiti.brandonw.net/index.php?title=83Plus:RAM:86D8
 */
void setPenRow(char row) __naked __z88dk_fastcall __preserves_regs(bc, de){
	#asm
		ld a, l
		ld (penRow), a

		ret
	#endasm
}
/** @brief set the column that is currently selectd
 *  @param[col] char to move the pen to
 * See https://wikiti.brandonw.net/index.php?title=83Plus:RAM:86D7 
 */
void setPenCol(char col) __naked __z88dk_fastcall __preserves_regs(bc, de){
	#asm
		ld a, l

		ld (penCol), a

		ret
	#endasm
}
/** @brief Set the pen back to 0,0
 */
void resetPen() __naked __preserves_regs(bc, de, hl){
	#asm
		xor a, a

		ld (penCol), a
		ld (penRow), a
		ret
	#endasm;
}
/** @brief print a string to the screen
 *  @param[loc] string to be printed
 * Normal text output will not work in apps, this should though by repeatedly printing single chars to the string. 
 */ 
void fputs(char* loc) __naked __z88dk_fastcall{
	#asm
	push ix
	fputs_char_loop:
		ld a, (hl)
		or a
		jp z, fputs_end
		abcall(_VPutMap)
		inc hl
		jp fputs_char_loop

	fputs_end:
		pop ix
		ret
	#endasm
}
/** @brief print a string to the screen, move down a line, and reset the pen col
 *  @param[loc] string to be printed
 * Calls fputs() and moves the pen for you
 */ 
void println(char* loc) __z88dk_fastcall{
	fputs(loc);
	#asm
		ld a, (penRow)
		ld b, 6
		add b
		ld (penRow), a

		xor a, a
		ld (penCol), a
	#endasm;
}
/** @brief Go to the next line go back to the first col
 */
void newline() __naked{
	#asm
		ld a, (penRow)
		ld b, 6
		add b
		ld (penRow), a

		xor a, a
		ld (penCol), a
		ret
	#endasm
}
/** @brief prints a single char
 * @param[ch] single char to be printed
 */
void printc(char ch) __naked __z88dk_fastcall{
	#asm
		ld a, l
		push ix
		abcall(_VPutMap)
		pop ix
		ret
	#endasm
}

#if defined(USE_NUMBER) || defined(DOXYGEN)

/** @brief Print a number to the screen
 * @param[x] number to be printed
 * 
 * Should be quite fast. Ironicly might be faster than hexdump.
 * 
 * <small> Adaped from https://stackoverflow.com/questions/38666119/converting-an-unsigned-16-bit-integer-from-hl-into-text-using-my-own-non-ascii-c</small>
 */


void number(int num) __naked __z88dk_fastcall	{
	#asm

			ld   bc,55536
            call OneDigit_
            ld   bc,64536
            call OneDigit_
            ld   bc,65436
            call OneDigit_
            ld   c,-10
            call OneDigit_
            ld   c,b
OneDigit_:   ld   a,47         ;replace with $16 (for $17-$20)
DivideMe_:   inc  a
            add  hl,bc
            jr   c,DivideMe_
            sbc  hl,bc
            
            cp '0'
            ret z
            push ix
            abcall(_VPutMap)
            pop ix
            ret


	#endasm
}
#endif

#if defined(USE_HEXDUMP) || defined(DOXYGEN)

/** hex lookup table */
const char hexTab[16] = {'0', '1', '2', '3', '4', '5', '6', '7', 
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', };


/** @brief print the hex of a char to the screen
 *  @param[v] Char to be printed
 *  This function is great for debuging but not so good for games. Should be quite fast.
 */ 
void hexdump(char v)__naked { 
	v;
	#asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl
		
		push ix

		ld a, c
		ld	hl, _hexTab
		and a, 0xF0
		SRL a
		SRL a
		SRL a
		SRL a

		ld e, a
		ld d, 0
		add hl, de
		ld a, (hl)
		abcall(_VPutMap)

		ld a, c
		ld	hl, _hexTab
		and a, 0x0F
		ld e, a
		ld d, 0
		add hl, de
		ld a, (hl)
		abcall(_VPutMap)
		

		pop ix
		ret
	#endasm
}
/** @brief Prints a 16-bit int to the screen
 * 	@param[v] Int to be printed
 * 
 *  Basicly just calls hexdump() twice.
 */ 
void doubleHexdump(int v) __naked __z88dk_fastcall{
	#asm

		push hl
		push hl
		inc sp
		call _hexdump
		inc sp
		call _hexdump
		pop hl
		ret
	#endasm
}

#endif
