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
	.globl _delete
	.globl _archive
	.globl _getOrCreateVar
	.globl _wait
	.globl _hexdump
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _hexTab
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
	xor	a, a
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
;../../lib/textio.c:136: void hexdump(char v)__naked{
;	---------------------------------
; Function hexdump
; ---------------------------------
_hexdump::
;../../lib/textio.c:172: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc
	push	hl
	push	ix
	ld	a, c
	ld	hl, #_hexTab
	and	a, #0xF0
	SRL	a
	SRL	a
	SRL	a
	SRL	a
	ld	e, a
	ld	d, #0
	add	hl, de
	ld	a, (hl)
	rst	40 
	.dw 0x455E
	ld	a, c
	ld	hl, #_hexTab
	and	a, #0x0F
	ld	e, a
	ld	d, #0
	add	hl, de
	ld	a, (hl)
	rst	40 
	.dw 0x455E
	pop	ix
	ret
;../../lib/textio.c:173: }
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
_hexTab:
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
;../../lib/variables.c:37: char* getOrCreateVar(char* name, int size)__naked{
;	---------------------------------
; Function getOrCreateVar
; ---------------------------------
_getOrCreateVar::
;../../lib/variables.c:82: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20
	rst	40 
	.dw 0x42F1
	jr	c,notfound
	ex	de,hl
	xor	a
	cp	b
	jr	z,unarchived
	di
	exx
	push	ix
	rst	40 
	.dw 0x4FD8
	pop	ix
	exx
	ei
	jp	_getOrCreateVar
	  unarchived:
	ret
	  notfound:
	pop	de
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	de
	rst	40 
	.dw 0x4E6A
	jp	_getOrCreateVar
;../../lib/variables.c:83: }
;../../lib/variables.c:87: void archive(char* name)__naked{
;	---------------------------------
; Function archive
; ---------------------------------
_archive::
;../../lib/variables.c:104: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20 ; Mov9ToOP1
	di
	exx
	push	ix
	rst	40 
	.dw 0x4FD8
	pop	ix
	exx
	ei
	ret
;../../lib/variables.c:106: }
;../../lib/variables.c:107: void delete(char* name)__naked{
;	---------------------------------
; Function delete
; ---------------------------------
_delete::
;../../lib/variables.c:118: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	rst	0x20 ; Mov9ToOP1
	rst	40 
	.dw 0x42F1
	rst	40 
	.dw 0x4351
	ret
;../../lib/variables.c:119: }
;main.c:15: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:17: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:18: resetPen();
	call	_resetPen
;main.c:22: char* dataLoc=getOrCreateVar(dataName, 20)+2; // 20 bytes long, add 2 to dataLoc because first 2 bytes if appvar is the length
	ld	hl, #0x0014
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	ex	de, hl
	inc	de
	inc	de
	inc	sp
	inc	sp
;main.c:24: while (1){
	ld	c, e
	ld	b, d
	push	bc
	inc	bc
00116$:
;main.c:25: wait(2);
	push	bc
	ld	a, #0x02
	push	af
	inc	sp
	call	_wait
	inc	sp
	pop	bc
;main.c:27: if (skClear == lastPressedKey())
	ld	a, (#0x843f)
	cp	a, #0x0f
	jr	Z, 00117$
;main.c:29: else if (skLeft == lastPressedKey()){
	cp	a, #0x02
	jr	NZ, 00110$
;main.c:30: *dataLoc -=1;
	pop	hl
	push	hl
	ld	a, (hl)
	dec	a
	pop	hl
	push	hl
	ld	(hl), a
	jr	00114$
00110$:
;main.c:32: else if (skRight == lastPressedKey()){
	cp	a, #0x03
	jr	NZ, 00107$
;main.c:33: *dataLoc +=1;
	pop	hl
	push	hl
	ld	a, (hl)
	inc	a
	pop	hl
	push	hl
	ld	(hl), a
	jr	00114$
00107$:
;main.c:35: else if (skUp == lastPressedKey()){
	cp	a, #0x04
	jr	NZ, 00104$
;main.c:36: *(dataLoc+1) +=1;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	jr	00114$
00104$:
;main.c:38: else if (skDown == lastPressedKey()){
	dec	a
	jr	NZ, 00114$
;main.c:39: *(dataLoc+1) -=1;
	ld	a, (bc)
	dec	a
	ld	(bc), a
00114$:
;main.c:42: resetPen();
	push	bc
	call	_resetPen
	pop	bc
;main.c:43: hexdump(*(char*)dataLoc);
	pop	hl
	push	hl
	ld	a, (hl)
	push	bc
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	pop	bc
;main.c:44: hexdump(*(char*)(dataLoc+1));
	ld	a, (bc)
	push	bc
	push	af
	inc	sp
	call	_hexdump
	inc	sp
	pop	bc
	jr	00116$
00117$:
;main.c:47: archive(dataName); // this makes the appVar persist after ram clears (also means corrupt settings data will persist)
	ld	hl, #___str_0
	push	hl
	call	_archive
;main.c:50: }
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.db 0x15
	.ascii "myappdata"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
