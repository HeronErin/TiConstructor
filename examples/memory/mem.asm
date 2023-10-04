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
	.globl _calloc
	.globl __calloc
	.globl _free
	.globl __free
	.globl _malloc
	.globl __malloc
	.globl _initHeap
	.globl _CustomError
	.globl _delete
	.globl _archive
	.globl _getOrCreateVar
	.globl _doubleHexdump
	.globl _hexdump
	.globl _printc
	.globl _newline
	.globl _println
	.globl _fputs
	.globl _resetPen
	.globl _setPenCol
	.globl _setPenRow
	.globl _HEAP_VAR_NAME
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
;../../lib/textio.c:86: __endasm;
	pop	hl ; Get input
	pop	bc ; and perserve
	push	bc ; ret value
	push	hl
	 the_char_loop_i_need_more_good_names_for_labels:
	ld	a, (bc)
	or	a, a
	ret	z
	push	ix
	rst	40 
	.dw 0x455E
	pop	ix
	inc	bc
	jr	the_char_loop_i_need_more_good_names_for_labels
;../../lib/textio.c:87: }
;../../lib/textio.c:92: void println(char* loc){
;	---------------------------------
; Function println
; ---------------------------------
_println::
	push	ix
	ld	ix,#0
	add	ix,sp
;../../lib/textio.c:93: fputs(loc);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_fputs
	pop	af
;../../lib/textio.c:102: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
;../../lib/textio.c:103: }
	pop	ix
	ret
;../../lib/textio.c:106: void newline() __naked{
;	---------------------------------
; Function newline
; ---------------------------------
_newline::
;../../lib/textio.c:116: __endasm;
	ld	a, (#0x86D8)
	ld	b, #6
	add	b
	ld	(#0x86D8), a
	xor	a, a
	ld	(#0x86D7), a
	ret
;../../lib/textio.c:117: }
;../../lib/textio.c:121: void printc(char ch) __naked{
;	---------------------------------
; Function printc
; ---------------------------------
_printc::
;../../lib/textio.c:133: __endasm;
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
;../../lib/textio.c:134: }
;../../lib/textio.c:184: void hexdump(char v)__naked{
;	---------------------------------
; Function hexdump
; ---------------------------------
_hexdump::
;../../lib/textio.c:220: __endasm;
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
;../../lib/textio.c:221: }
;../../lib/textio.c:227: void doubleHexdump(int v) __naked{
;	---------------------------------
; Function doubleHexdump
; ---------------------------------
_doubleHexdump::
;../../lib/textio.c:242: __endasm;
	pop	hl
	pop	bc
	push	bc
	push	hl
	push	bc
	push	bc
	inc	sp
	call	_hexdump
	inc	sp
	call	_hexdump
	pop	bc
	ret
;../../lib/textio.c:243: }
;../../lib/variables.c:46: char* getOrCreateVar(char* name, int size)__naked{
;	---------------------------------
; Function getOrCreateVar
; ---------------------------------
_getOrCreateVar::
;../../lib/variables.c:94: __endasm;
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
	ld	a, (bc)
	rst	40 
	.dw 0x4E70
	jp	_getOrCreateVar
;../../lib/variables.c:95: }
;../../lib/variables.c:106: void archive(char* name)__naked{
;	---------------------------------
; Function archive
; ---------------------------------
_archive::
;../../lib/variables.c:125: __endasm;
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
;../../lib/variables.c:127: }
;../../lib/variables.c:134: void delete(char* name)__naked{
;	---------------------------------
; Function delete
; ---------------------------------
_delete::
;../../lib/variables.c:145: __endasm;
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
;../../lib/variables.c:146: }
;../../lib/errors.c:11: void CustomError(char* error_text) __naked{
;	---------------------------------
; Function CustomError
; ---------------------------------
_CustomError::
;../../lib/errors.c:24: __endasm;
	pop	de
	pop	hl
	push	hl
	push	de
	ld	de, #0x984D
	ld	bc, #11
	ldir
	rst	40 
	.dw 0x4D41
	ret
;../../lib/errors.c:25: }
;../../lib/memory.c:100: void initHeap(){
;	---------------------------------
; Function initHeap
; ---------------------------------
_initHeap::
;../../lib/memory.c:135: __endasm;
	ld	hl, #0x83E5
	ld	a, #0xFE
	ld	(hl), a
	inc	hl
	ld	a, #0xED
	ld	(hl), a
	ld	hl, #1024
	push	hl
	ld	hl, #_HEAP_VAR_NAME
	push	hl
	call	_getOrCreateVar
	pop	af
	pop	af
	ex	de, hl
	ld	hl, #(( 0x83E5 +1)+1)
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ex	de, hl
	inc	hl
	inc	hl
	ld	(hl), #0xFF
;../../lib/memory.c:136: }
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
_HEAP_VAR_NAME:
	.db 0x15
	.ascii "ConHeap"
	.db 0x00
;../../lib/memory.c:145: void _malloc() __naked{
;	---------------------------------
; Function _malloc
; ---------------------------------
__malloc::
;../../lib/memory.c:155: __endasm; MemoryError(); __asm
	xor	a, a
	ld	hl, #0
	sbc	hl, bc
	ld	hl, #0
	jp	nz, NOT_A_ZERO
	call	0x50 
	.dw 0x44B9 
;../../lib/memory.c:287: __endasm; MemoryError(); __asm
	ret
	 NOT_A_ZERO:
	ld	hl, ((( 0x83E5 +1)+1))
	ex	de, hl
	inc	de
	inc	de
	ex	de, hl
	ld	de, #0
	res	0, 0x21(iy)
	 MALLOC_LOOP:
	ld	a, #0xFF
	cp	(hl)
	jp	z, GROW_HEAP
	bit	0, (hl)
	jp	z, MALLOC_NOT_FREED_ITEM
	bit	0, 0x21(iy)
	jp	nz, AFTER_MALLOC_SET_BIT
	ld	(((( 0x83E5 +1)+1)+2)), hl
	set	0, 0x21(iy)
	  AFTER_MALLOC_SET_BIT:
	inc	hl
	push	hl
	push	bc
	ld	b, (hl)
	inc	hl
	ld	c, (hl)
	ex	de, hl
	add	hl,bc
	pop	de
	push	hl
	dec	hl
	dec	hl
	dec	hl
	or	a
	sbc	hl,de
	pop	hl
	ld	b, d
	ld	c, e
	ex	de, hl
	pop	hl
	jp	c, PREP_NEXT
	ld	hl, (((( 0x83E5 +1)+1)+2))
	jp	GROW_HEAP
	 MALLOC_NOT_FREED_ITEM:
	inc	hl
	ld	de, #0
	res	0, 0x21(iy)
	 PREP_NEXT:
	push	de
	ld	d, (hl)
	inc	hl
	ld	e, (hl)
	dec	hl
	dec	hl
	add	hl, de
	pop	de
	jp	MALLOC_LOOP
	 GROW_HEAP:
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), b
	inc	hl
	ld	(hl), c
	push	hl
	add	hl, bc
	push	hl
	ex	de, hl
	ld	hl, ((( 0x83E5 +1)+1))
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl
	inc	hl
	add	hl, bc
	sbc	hl, de
	jp	nc, MALLOC_SUCCESS
	call	0x50 
	.dw 0x44B9 
;../../lib/memory.c:314: __endasm;
	 MALLOC_SUCCESS:
	pop	hl
	dec	hl
	dec	hl
	dec	a
	ld	(hl), a
	pop	hl
	inc	hl
	ret
;../../lib/memory.c:316: }
;../../lib/memory.c:331: void* malloc(int size)__naked{
;	---------------------------------
; Function malloc
; ---------------------------------
_malloc::
;../../lib/memory.c:339: __endasm;
	pop	hl
	pop	bc
	push	bc
	push	hl
	jp	__malloc
;../../lib/memory.c:340: }
;../../lib/memory.c:349: void _free() __naked{
;	---------------------------------
; Function _free
; ---------------------------------
__free::
;../../lib/memory.c:397: __endasm;
	dec	hl
	dec	hl
	dec	hl
	push	hl
	ex	de, hl
	ld	hl, ((( 0x83E5 +1)+1))
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl
	ex	de, hl
	push	hl
	or	a, a
	sbc	hl, de
	jp	c, FREE_ERROR
	pop	hl
	ex	de, hl
	add	hl, bc
	or	a, a
	ex	de, hl
	sbc	hl, de
	jp	nc, FREE_ERROR
	pop	hl
	set	0, (hl)
	ret
	 FREE_ERROR:
;../../lib/memory.c:399: MemoryError(); 
	call	0x50 
	.dw 0x44B9 
;../../lib/memory.c:404: __endasm;
	pop	af
	ret
;../../lib/memory.c:405: }
;../../lib/memory.c:410: void free(void* ptr)__naked{
;	---------------------------------
; Function free
; ---------------------------------
_free::
;../../lib/memory.c:417: __endasm;
	pop	bc
	pop	hl
	push	hl
	push	bc
	jp	__free
;../../lib/memory.c:418: }
;../../lib/memory.c:425: void _calloc()__naked{
;	---------------------------------
; Function _calloc
; ---------------------------------
__calloc::
;../../lib/memory.c:460: __endasm;
	push	bc
	call	__malloc
	ld	bc, #0
	sbc	hl, bc
	jp	nc, CALLOC_VALID_PTR
	pop	af
	ret
	 CALLOC_VALID_PTR:
	pop	bc
	ex	de, hl
	dec	bc
	ld	hl, #0
	sbc	hl, bc
	ex	de, hl
	jp	nz, CALLOC_NOT_ZERO
	ret
	 CALLOC_NOT_ZERO:
	ld	d, h
	ld	e, l
	ld	(hl), #0x00
	push	hl
	inc	de
	ldir
	pop	hl
	ret
;../../lib/memory.c:461: }
;../../lib/memory.c:468: void* calloc(int size)__naked{
;	---------------------------------
; Function calloc
; ---------------------------------
_calloc::
;../../lib/memory.c:476: __endasm;
	pop	hl
	pop	bc
	push	bc
	push	hl
	jp	__calloc
;../../lib/memory.c:477: }
;main.c:11: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:13: clearScreen();
	rst	40 
	.dw 0x4540 
;main.c:14: resetPen();
	call	_resetPen
;main.c:16: initHeap();             // Create the heap 
	call	_initHeap
;main.c:18: fputs("Here is 50 bytes: ");
	ld	hl, #___str_1
	push	hl
	call	_fputs
;main.c:19: void* temp = malloc(50);
	ld	hl, #0x0032
	ex	(sp),hl
	call	_malloc
	pop	af
	ex	de, hl
	inc	sp
	inc	sp
;main.c:20: doubleHexdump((int)temp);
	ld	c, e
	ld	b, d
	push	bc
	push	bc
	call	_doubleHexdump
	pop	af
;main.c:21: newline();
	call	_newline
;main.c:22: newline();
	call	_newline
;main.c:25: fputs("Here is another 50: ");
	ld	hl, #___str_2
	push	hl
	call	_fputs
;main.c:26: void* temp2 = malloc(50);
	ld	hl, #0x0032
	ex	(sp),hl
	call	_malloc
;main.c:27: doubleHexdump((int)temp2);
	ex	(sp),hl
	call	_doubleHexdump
	pop	af
;main.c:28: newline();
	call	_newline
;main.c:29: newline();
	call	_newline
;main.c:31: println("Lets free the first 50.");
	ld	hl, #___str_3
	push	hl
	call	_println
	pop	af
;main.c:32: newline();
	call	_newline
;main.c:33: free(temp);
	pop	hl
	push	hl
	push	hl
	call	_free
;main.c:35: fputs("Here is 50 more bytes: ");
	ld	hl, #___str_4
	ex	(sp),hl
	call	_fputs
;main.c:36: void* temp3 = malloc(50);
	ld	hl, #0x0032
	ex	(sp),hl
	call	_malloc
;main.c:37: doubleHexdump((int)temp3);
	ex	(sp),hl
	call	_doubleHexdump
	pop	af
;main.c:38: newline();
	call	_newline
;main.c:45: PressAnyKey();
	rst	40 
	.dw 0x4972 
;main.c:46: purge_heap();
	ld	hl, #_HEAP_VAR_NAME
	push	hl
	call	_delete
;main.c:47: }
	ld	sp,ix
	pop	ix
	ret
___str_1:
	.ascii "Here is 50 bytes: "
	.db 0x00
___str_2:
	.ascii "Here is another 50: "
	.db 0x00
___str_3:
	.ascii "Lets free the first 50."
	.db 0x00
___str_4:
	.ascii "Here is 50 more bytes: "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
