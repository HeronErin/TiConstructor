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
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _getKeyId
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
;../../lib/essentials.c:32: char getKeyId(){
;	---------------------------------
; Function getKeyId
; ---------------------------------
_getKeyId::
;../../lib/essentials.c:33: bcall(_kdbScan);
	rst	40 
	.dw 0x4015 
;../../lib/essentials.c:34: return *(char*)(kbdScanCode);
	ld	hl, #0x843f
	ld	l, (hl)
;../../lib/essentials.c:35: }
	ret
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
;main.c:5: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:7: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:8: resetPen();
	call	_resetPen
;main.c:10: println("Hello 8-bit World!");
	ld	hl, #___str_0
	push	hl
	call	_println
	pop	af
;main.c:12: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:14: }
	ret
___str_0:
	.ascii "Hello 8-bit World!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
