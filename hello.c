#pragma string name tes
#define bcall(__LABEL__) rst 40 \ defw __LABEL__

// A bit of trash data so the program runs correctly
void _(){
	#asm
	ret
	defm "0000000000"
	#endasm
}





void main()
{


	#asm

		bcall(0x4540 ) ; _ClrLCDFull

		xor	a, a
		ld	(0x86D7), a
		ld	(0x86D8), a


		ld a, '!'


		push	ix
		bcall(0x455E)     ; _VPutMap
		pop	ix


		bcall(0x4972 )    ; _getkey


	#endasm

	


}