;	Stub for the TI 83+ calculator for building as an app
;
;	Stefano Bodrato - Dec 2000
;			Feb 2000 - Speeded up the cpygraph
;
;	$Id: ti83p_crt0_app.asm,v 1.33 2016-07-11 05:58:34 stefano Exp $
;------------------------------------------------
; Some general PUBLICs and EXTERNs needed by the assembler
;-----------------------------------------------------

	MODULE  Ti83plus_App_crt0

	DEFINE TI83PLUSAPP	;Used by grayscale interrupt and the such


	EXTERN	_main		; No matter what set up we have, main is
				;  always, always external to this file.
	


	PUBLIC	cleanup		; used by exit()
	PUBLIC	l_dcal		; used by calculated calls = "call (hl)"


	PUBLIC	cpygraph	; TI calc specific stuff
	PUBLIC	tidi		;
	PUBLIC	tiei		;
	defc intcount = $8A8D

;-------------------------
; Begin of (shell) headers
;-------------------------

	INCLUDE "Ti83p.def"	; ROM / RAM adresses on Ti83+[SE]
        defc    crt0 = 1
	INCLUDE	"zcc_opt.def"	; Receive all compiler-defines

	defc	CONSOLE_ROWS = 8
        defc    TAR__clib_exit_stack_size = 3
        defc    TAR__register_sp = -1
	defc	__CPU_CLOCK = 6000000
        INCLUDE "crt/classic/crt_rules.inc"
	


; Header data
	DEFINE ASM
	DEFINE NOT_DEFAULT_SHELL

	org $4000

	DEFB $80,$0F		;Field: Program length
	DEFB $00,$00,$00,$00	;Length=0 (N/A for unsigned apps)

	DEFB $80,$12		;Field: Program type
	DEFB $01,$04		;Type = Freeware, 0104

	DEFB $80,$21		;Field: App ID
	DEFB $01		;Id = 1

	DEFB $80,$31		;Field: App Build
	DEFB $01		;Build = 1


	DEFB $80,$48		;Field: App Name


	DEFm "TI83+APP"		;App Name (Needs to be 8 bytes)



	DEFB $80,$81		;Field: App Pages
	DEFB $01		;App Pages = 1

	DEFB $80,$90		;No default splash screen

	DEFB $03,$26,$09,$04	;Field: Date stamp = 
	DEFB $04,$6f,$1b,$80	;5/12/1999

	DEFB $02, $0d, $40	;Dummy encrypted TI date stamp signature
	DEFB $a1, $6b, $99, $f6 
	DEFB $59, $bc, $67, $f5
	DEFB $85, $9c, $09, $6c
	DEFB $0f, $b4, $03, $9b
	DEFB $c9, $03, $32, $2c
	DEFB $e0, $03, $20, $e3
	DEFB $2c, $f4, $2d, $73
	DEFB $b4, $27, $c4, $a0
	DEFB $72, $54, $b9, $ea
	DEFB $7c, $3b, $aa, $16
	DEFB $f6, $77, $83, $7a
	DEFB $ee, $1a, $d4, $42
	DEFB $4c, $6b, $8b, $13
	DEFB $1f, $bb, $93, $8b
	DEFB $fc, $19, $1c, $3c
	DEFB $ec, $4d, $e5, $75

	DEFB $80,$7F		;Field: Program Image length
	DEFB 0,0,0,0		;Length=0, N/A
	DEFB 0,0,0,0		;Reserved
	DEFB 0,0,0,0		;Reserved
	DEFB 0,0,0,0		;Reserved
	DEFB 0,0,0,0		;Reserved





;-------------------------------------
; End of header, begin of startup part
;-------------------------------------
start:
IF DEFINED_GimmeSpeed
	ld	a,1		; switch to 15MHz (extra fast)
	rst	28		; bcall(SetExSpeed)
	defw	SetExSpeed	;
ENDIF				;
	ld	(__restore_sp_onexit+1),sp	;
        INCLUDE "crt/classic/crt_init_sp.asm"
        INCLUDE "crt/classic/crt_init_atexit.asm"
        call    crt0_init_bss
        ld      (exitsp),sp

IF DEFINED_USING_amalloc
	INCLUDE "crt/classic/crt_init_amalloc.asm"
ENDIF


	EXTERN	fputc_cons
	ld	hl,12
	push	hl
	call	fputc_cons
	pop	hl

IF DEFINED_GRAYlib
 IF DEFINED_GimmeSpeed
	INCLUDE "target/ti83p/classic/gray83pSE.asm"	; 15MHz grayscale interrupt
 ELSE
	INCLUDE	"target/ti83p/classic/gray83p.asm"		;  6MHz grayscale interrupt
 ENDIF
ELSE
	INCLUDE	"target/ti83p/classic/intwrap83p.asm"	; Interrupt Wrapper
ENDIF

	im	2		; enable IM2 interrupt
	call	_main		; call main()
cleanup:			; exit() jumps to this point
	ld	iy,_IY_TABLE	; Restore flag pointer
	im	1		;
IF DEFINED_GimmeSpeed		;
	xor	a		; Switch to 6MHz (normal speed)
	rst	28		; bcall(SetExSpeed)
	defw	SetExSpeed	;
ENDIF				;
__restore_sp_onexit:
    ld	sp,0		; Restore SP
IF TSE				; TSE Kernel
	call	_tseForceYield	; Task-switch back to shell (can return...)
	jp	start		; begin again if needed...
ENDIF				;
tiei:	ei			;
IF DEFINED_GRAYlib		;
cpygraph:
ENDIF				;
	call	$50		; B_JUMP(_jforcecmdnochar)
	DEFW      4027h;
tidi:	ret			;

;----------------------------------------
; End of startup part, routines following
;----------------------------------------
l_dcal:
	jp	(hl)		; used as "call (hl)"






IF !DEFINED_GRAYlib
 IF DEFINED_GimmeSpeed
cpygraph:
	call	$50		; bjump(GrBufCpy)
	defw	GrBufCpy	; FastCopy is far too fast at 15MHz...
 ELSE
  IF Ion
	defc	cpygraph = $966E+80+15	; Ion FastCopy call
  ENDIF
  IF MirageOS
	defc	cpygraph = $4092	; MirageOS FastCopy call
  ENDIF
  IF TSE
	defc	cpygraph = $8A3A+18	; TSE FastCopy call
  ENDIF
  IF ASM
cpygraph:
;(ion)FastCopy from Joe Wingbermuehle
	di
	ld	a,$80				; 7
	out	($10),a				; 11
	ld	hl,plotSScreen-12-(-(12*64)+1)		; 10
	ld	a,$20				; 7
	ld	c,a				; 4
	inc	hl				; 6 waste
	dec	hl				; 6 waste
fastCopyAgain:
	ld	b,64				; 7
	inc	c				; 4
	ld	de,-(12*64)+1			; 10
	out	($10),a				; 11
	add	hl,de				; 11
	ld	de,10				; 10
fastCopyLoop:
	add	hl,de				; 11
	inc	hl				; 6 waste
	inc	hl				; 6 waste
	inc	de				; 6
	ld	a,(hl)				; 7
	out	($11),a				; 11
	dec	de				; 6
	djnz	fastCopyLoop			; 13/8
	ld	a,c				; 4
	cp	$2B+1				; 7
	jr	nz,fastCopyAgain		; 10/1
	ret					; 10
  ENDIF
 ENDIF
ENDIF

		defc ansipixels = 96
		IF !DEFINED_ansicolumns
			 defc DEFINED_ansicolumns = 1
			 defc ansicolumns = 32
		ENDIF
		
        INCLUDE "crt/classic/crt_runtime_selection.asm"
	INCLUDE	"crt/classic/crt_section.asm"

	SECTION	code_crt_init
	ld	hl,plotSScreen
	ld	(base_graphics),hl






