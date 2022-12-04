;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl __fix_interputs
	.globl ______copied_to_position
	.globl ______set_interputs
	.globl _wait
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../../lib/textio.c:5: void setPenRow(char row) __naked{
;	---------------------------------
; Function setPenRow
; ---------------------------------
_setPenRow::
;../../lib/textio.c:17: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:18: }
;../../lib/textio.c:19: void setPenCol(char col) __naked{
;	---------------------------------
; Function setPenCol
; ---------------------------------
_setPenCol::
;../../lib/textio.c:31: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:32: }
;../../lib/textio.c:33: void resetPen() __naked{
;	---------------------------------
; Function resetPen
; ---------------------------------
_resetPen::
;../../lib/textio.c:40: __endasm;
	ld	a, #0x00
	ld	(#0x86D7), a
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:41: }
;../../lib/textio.c:43: void fputs(char* loc) __naked {
;	---------------------------------
; Function fputs
; ---------------------------------
_fputs::
;../../lib/textio.c:60: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc ; ret value
	push	hl
	 the_char_loop_i_need_more_good_names_for_labels:
	ld	a, (bc)
	or	a, a
	ret	z
	rst	40 
	.dw 0x455E
	inc	bc
	jr	the_char_loop_i_need_more_good_names_for_labels
;../../lib/textio.c:61: }
;../../lib/textio.c:63: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:64: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:73: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:74: }
	pop	ix
	ret
;../../lib/textio.c:75: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:85: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:86: }
;../../lib/textio.c:87: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:99: __endasm;
	pop	hl ; Get input
	pop	bc
	push	bc
	push	hl
	ld	a, c
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	ret
;../../lib/textio.c:100: }
;../../lib/misc.c:36: void wait(unsigned char x){ // Wait for amount of time (1/8th of sec)
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:53: __endasm;
	ld	a,#0x47 ;8 hz
	out	(#0x30),a
	ld	a,#0x00 ; no loop, no interrupt
	out	(#0x31),a
	ld	a,4(ix) ;16 ticks / 8 hz equals 2 seconds
	out	(#0x32),a
	    wait:
	in	a,(4)
	bit	5,a ;bit 5 tells if timer 1
	jr	z,wait ;is done
	xor	a
	out	(#0x30),a ;Turn off the timer.
	out	(#0x31),a
;../../lib/misc.c:54: }
	pop	ix
	ret
;main.c:8: static inline void interupt() {
;	---------------------------------
; Function interupt
; ---------------------------------
_interupt:
;main.c:21: __endasm;
	in	a, (4)
	bit	3, a
	jr	nz, 00001$
	call	#0x000B
	ld	a, #0xFF
	out	(0x11), a
	  00001$:
;main.c:22: }
	ret
;../../lib/interupts.c:21: void _____set_interputs(){
;	---------------------------------
; Function _____set_interputs
; ---------------------------------
______set_interputs::
;../../lib/interupts.c:45: __endasm;
	di
	ld	a,#0x9a
	ld	i,a
	ld	h,a
	ld	l,#0
	ld	(hl),#0x99
	push	hl
	pop	de
	inc	de
	ld	bc,#256
	ldir
	LD	HL, #INTER_START
	LD	DE, #0x9999
	LD	BC, #INTER_END - INTER_START
	ldir
	ld	a, #0b00001011
	out	(3), a
	im	2
	ei
;../../lib/interupts.c:46: }
	ret
;../../lib/interupts.c:48: void _____copied_to_position(){
;	---------------------------------
; Function _____copied_to_position
; ---------------------------------
______copied_to_position::
;../../lib/interupts.c:58: __endasm;
	 INTER_START:
	exx
	di
	.db	#0x08
	xor	a, a
	out	(3),a
;main.c:21: __endasm;
	in	a, (4)
	bit	3, a
	jr	nz, 00001$
	call	#0x000B
	ld	a, #0xFF
	out	(0x11), a
	  00001$:
;../../lib/interupts.c:70: __endasm;
	ld	a,#0b00001011
	out	(3),a
	.db	#0x08
	exx
	ei
	ret
	 INTER_END:
;../../lib/interupts.c:71: }
	ret
;../../lib/interupts.c:72: void _fix_interputs(){
;	---------------------------------
; Function _fix_interputs
; ---------------------------------
__fix_interputs::
;../../lib/interupts.c:78: __endasm;
	im	1
	ld	a, #0b00001011 ;interrupts
	out	(03), a
;../../lib/interupts.c:79: }
	ret
;main.c:29: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:31: SET_INTERUPTS();
	ld hl, # __fix_interputs 
	push hl 
	call ______set_interputs 
;main.c:34: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:35: resetPen();
	call	_resetPen
;main.c:37: while (1){
00104$:
;main.c:38: wait(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_wait
	inc	sp
;main.c:39: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:40: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	sub	a, #0x0f
	jr	NZ, 00104$
;main.c:43: println("v");
	ld	hl, #___str_0
	push	hl
	call	_println
	pop	af
;main.c:44: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:46: }
	ret
___str_0:
	.ascii "v"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
