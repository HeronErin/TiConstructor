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
void setPenRow(char row) __naked{
	row;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value
		ld a, c

		ld (#penRow), a

		ret
	__endasm;
}
/** @brief set the column that is currently selectd
 *  @param[col] char to move the pen to
 * See https://wikiti.brandonw.net/index.php?title=83Plus:RAM:86D7 
 */
void setPenCol(char col) __naked{
	col;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value
		ld a, c

		ld (#penCol), a

		ret
	__endasm;
}
/** @brief Set the pen back to 0,0
 */
void resetPen() __naked{
	__asm
		xor a, a

		ld (#penCol), a
		ld (#penRow), a
		ret
	__endasm;
}
/** @brief print a string to the screen
 *  @param[loc] string to be printed
 * Normal text output will not work in apps, this should though by repeatedly printing single chars to the string. 
 */ 
void fputs(char* loc) __naked {
	loc;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc     ; ret value
		push hl     


	the_char_loop_i_need_more_good_names_for_labels:
		ld	a, (bc)
		or a, a
		ret z
		abcall(_VPutMap)
		inc bc
		jr the_char_loop_i_need_more_good_names_for_labels

	__endasm;
}
/** @brief print a string to the screen, move down a line, and reset the pen col
 *  @param[loc] string to be printed
 * Calls fputs() and moves the pen for you
 */ 
void println(char* loc){
	fputs(loc);
	__asm
		ld a, (#penRow)
		ld b, #6
		add b
		ld (#penRow), a

		xor a, a
		ld (#penCol), a
	__endasm;
}
/** @brief Go to the next line go back to the first col
 */
void newline() __naked{
	__asm
		ld a, (#penRow)
		ld b, #6
		add b
		ld (#penRow), a

		xor a, a
		ld (#penCol), a
		ret
	__endasm;
}
/** @brief prints a single char
 * @param[ch] single char to be printed
 */
void printc(char ch) __naked{
	ch;
	__asm
		pop hl      ; Get input
		pop bc
		push bc
		push hl 
		ld a, c
		push ix
		abcall(_VPutMap)
		pop ix
		ret
	__endasm;
}

#if defined(USE_NUMBER) || defined(DOXYGEN)

/** @brief Print a number to the screen
 * @param[x] number to be printed
 * 
 * This function is a bit slow, but it does the job
 */
void number(int x){
    int i = 0;
    if (x<0){
        x=0-x;
        printc('-');
    }
    char out[25];
    do {
        out[i]=x % 10 + '0';
        i+=1;
    } while((x /= 10) > 0);
    i--;
    for(;i>=0; i--){
    	__asm
			ld	l, -4 (ix)
			ld	h, -3 (ix)
			add	hl, bc
			ld	a, (hl)

			push ix
			abcall(_VPutMap)
			pop ix
			
    	__endasm;

    }

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
void hexdump(char v)__naked{
	v;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl
		
		push ix

		ld a, c
		ld	hl, #_hexTab
		and a, #0xF0
		SRL a
		SRL a
		SRL a
		SRL a

		ld e, a
		ld d, #0
		add hl, de
		ld a, (hl)
		abcall(_VPutMap)

		ld a, c
		ld	hl, #_hexTab
		and a, #0x0F
		ld e, a
		ld d, #0
		add hl, de
		ld a, (hl)
		abcall(_VPutMap)
		

		pop ix
		ret
	__endasm;
}
#endif
