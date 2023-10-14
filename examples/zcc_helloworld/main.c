#define bcall(__LABEL__) rst 40 \ defw __LABEL__

void print(char* str) __z88dk_fastcall __naked __preserves_regs(ix, iy, de, bc){
	#asm
	push ix
PRINT:
	ld a, (hl)
	or a
	jp z, RETURN_STUFF

	
	bcall(0x455E)     ; _VPutMap
	inc hl
	jp PRINT
RETURN_STUFF:
	pop ix

	ret
	#endasm
}




int main()
{
	print("Hello World!");

  #asm
  bcall(0x4972 )
  #endasm
  return 0;
}