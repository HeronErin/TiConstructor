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
	.globl ______copied_to_position
	.globl __________SET_INTERUPTS
	.globl _interupt
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
;../../lib/textio.c:20: void setPenRow(char row) __naked{
;	---------------------------------
; Function setPenRow
; ---------------------------------
_setPenRow::
;../../lib/textio.c:32: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:33: }
;../../lib/textio.c:38: void setPenCol(char col) __naked{
;	---------------------------------
; Function setPenCol
; ---------------------------------
_setPenCol::
;../../lib/textio.c:50: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl ; ret value
	ld	a, c
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:51: }
;../../lib/textio.c:54: void resetPen() __naked{
;	---------------------------------
; Function resetPen
; ---------------------------------
_resetPen::
;../../lib/textio.c:61: __endasm;
	xor	a, a
	ld	(#0x86D7), a
	ld	(#0x86D8), a
	ret
;../../lib/textio.c:62: }
;../../lib/textio.c:67: void fputs(char* loc) __naked {
;	---------------------------------
; Function fputs
; ---------------------------------
_fputs::
;../../lib/textio.c:84: __endasm;
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
;../../lib/textio.c:85: }
;../../lib/textio.c:90: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:91: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:100: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:101: }
	pop	ix
	ret
;../../lib/textio.c:104: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:114: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:115: }
;../../lib/textio.c:119: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:131: __endasm;
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
;../../lib/textio.c:132: }
;../../lib/misc.c:70: void wait(unsigned char x){
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/misc.c:87: __endasm;
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
;../../lib/misc.c:88: }
	pop	ix
	ret
;main.c:9: void interupt() __naked{ // Keeps this quick as it may be called 100 times per secound (depending on the interupt mask and cpu clock setting) 
;	---------------------------------
; Function interupt
; ---------------------------------
_interupt::
;main.c:11: scanKeys();
	rst	40 
	.dw 0x4015 
;main.c:29: __endasm;
	xor	a, a
	out	(#0x31),a
	in	a, (4)
	bit	3, a
	ret	nz
	call	#0x000B
	ld	a, #0xFF
	out	(0x11), a
	ret
;main.c:30: }
;../../lib/interupts.c:56: void _________SET_INTERUPTS(){
;	---------------------------------
; Function _________SET_INTERUPTS
; ---------------------------------
__________SET_INTERUPTS::
;../../lib/interupts.c:98: __endasm;
;	disable interrupts and set interrupt mode 2
	di
	im	2
;	save whichever page we are on so that we know where to go
	in	a,(6)
	ld	(0x8584),a
;	set the 0x917F byte of the jumptable to $80
	ld	a,#0x80
	ld	i,a
;	now we copy our interrupt loader to ram, we only have to do this once
	ld	hl,#LoadInterrupt
	ld	de, #0x8E2C
	ld	bc,#EndLoadInterupt-LoadInterrupt
	ldir
;	create the vector table (do this every time before you enable interrupts, be sure to disable interrupts before archiving / unarchiving stuff)
	ld	hl, #0x8000
	ld	de, #0x8001
	ld	(hl), #0x85
	ld	bc,#256
	ldir
;	setting up the jump handler at $8585
	ld	hl,#0x8585
	ld	(hl),#0xc3 ; this is the jp instruction
	ld	de,#0x8E2C ; where it jumps to
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;	time to enable interrupts
	ei
;../../lib/interupts.c:99: }
	ret
;../../lib/interupts.c:102: void _____copied_to_position()__naked{
;	---------------------------------
; Function _____copied_to_position
; ---------------------------------
______copied_to_position::
;../../lib/interupts.c:120: __endasm;
	  LoadInterrupt:
	di
	exx
	.db	#0x08
	xor	a, a
	out	(3),a
;../../lib/interupts.c:122: DURING_INTERUPT();
	call	_interupt
;../../lib/interupts.c:159: __endasm;
	xor	a, #0b00001011
	out	(3),a
	.db	#0x08
	exx
	ei
	ret
	  ON_EXIT:
	di
	im	1
	ld	a, # 0b00001011
	out	(3), a
	ei
	ret
	  EndLoadInterupt:
;../../lib/interupts.c:160: }
;main.c:37: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:39: SET_INTERUPTS();
	ld de, # (ON_EXIT-LoadInterrupt+0x8E2C) 
	push de 
	call	__________SET_INTERUPTS
	ld ix,# 0 
	add ix,sp 
;main.c:42: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:44: while (1){
00104$:
;main.c:45: wait(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_wait
	inc	sp
;main.c:47: if (skClear == lastPressedKey())
	ld	hl, #0x843f
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00104$
;main.c:48: break;
;main.c:53: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
