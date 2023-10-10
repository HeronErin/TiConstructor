#ifdef SDCC
#define bcall(__LABEL__) rst	40 \
                        .dw __LABEL__
// A bit of trash data so the program runs correctly
void _(){__asm ret
	     .ascii "0000000000" __endasm;}

#else
#pragma string name ad
#define bcall(__LABEL__) rst 40 \ defw __LABEL__

// A bit of trash data so the program runs correctly
void _(){
	#asm
	ret
	defm "0000000000"
	#endasm
}
#endif




void main()
{

	#ifdef SDCC
	__asm
	#else
	#asm
	#endif
		rst 40
		bcall(0x4540 ) ; _ClrLCDFull

		xor	a, a
		ld	(0x86D7), a
		ld	(0x86D8), a

		#ifdef SDCC
		ld a, #'!'
		#else
		ld a, '!'
		#endif

		push	ix
		bcall(0x455E)     ; _VPutMap
		pop	ix


		bcall(0x4972 )    ; _getkey

	#ifdef SDCC
	__endasm;
	#else
	#endasm
	#endif
	


}