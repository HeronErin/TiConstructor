#pragma once
// this is for printing c string, it is not fast, but shouldn't be too large. Feel free not to use it if you need more space, although don't expect to use any other io type stuff.

#define clearScreen() bcall(0x4540)

void setPenRow(char row) __naked{
	row;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value
		ld a, c

		ld (#0x86D8), a

		ret
	__endasm;
}
void setPenCol(char col) __naked{
	col;
	__asm
		pop hl      ; Get input
		pop bc      ; and perserve
		push bc
		push hl     ; ret value
		ld a, c

		ld (#0x86D7), a

		ret
	__endasm;
}
void resetPen() __naked{
	__asm
		ld a, #0x00

		ld (#0x86D7), a
		ld (#0x86D8), a
		ret
	__endasm;
}
// just prints chars to screen
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
		abcall(0x455E)
		inc bc
		jr the_char_loop_i_need_more_good_names_for_labels

	__endasm;
}
// prints to screen while also quickly setting cursor stuff. 
void println(char* loc){
	fputs(loc);
	__asm
		ld a, (#0x86D8)
		ld b, #6
		add b
		ld (#0x86D8), a

		xor a, a
		ld (#0x86D7), a
	__endasm;
}
void newline() __naked{
	__asm
		ld a, (#0x86D8)
		ld b, #6
		add b
		ld (#0x86D8), a

		xor a, a
		ld (#0x86D7), a
		ret
	__endasm;
}
void printc(char ch) __naked{
	ch;
	__asm
		pop hl      ; Get input
		pop bc
		push bc
		push hl 
		ld a, c
		push ix
		abcall(0x455E)
		pop ix
		ret
	__endasm;
}
#ifdef USE_NUMBER
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
			abcall(0x455E)
			pop ix
			
    	__endasm;

    }

}
#endif
#ifdef USE_HEXDUMP
const char hexTab[16] = {'0', '1', '2', '3', '4', '5', '6', '7', 
    '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', };
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
		abcall(0x455E)

		ld a, c
		ld	hl, #_hexTab
		and a, #0x0F
		ld e, a
		ld d, #0
		add hl, de
		ld a, (hl)
		abcall(0x455E)
		

		pop ix
		ret
	__endasm;
}
#endif