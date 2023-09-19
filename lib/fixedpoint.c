#pragma once
///////////////////// This file is slow and fast_math.c is better
///////////////////// So I don't think I will be documenting it




typedef int32_t fixedpt;
typedef int64_t fixedptd;

#define fixed_BITS 16


#define fixed_FMASK (((fixedpt)1 << fixed_BITS) - 1)
#define fixed_DMASK ( fixed_FMASK ^ (((fixedpt)1 << ( sizeof(fixedpt)*2  )) - 1) )

#define FXX(R) ((fixedpt)((R) * fixed_ONE + ((R) >= 0 ? 0.5 : -0.5)))
#define fixed_ONE ((fixedpt)((fixedpt)1 << fixed_BITS))
#define fixed_TWO (fixed_ONE + fixed_ONE)
#define fixed_PI  FXX(3.14159265358979323846)
#define fixed_TWO_PI  FXX(2 * 3.14159265358979323846)
#define fixed_HALF_PI FXX(3.14159265358979323846 / 2)
#define fixed_E FXX(2.7182818284590452354)

#define fixed_RAD_TO_DEG (FXX(180/3.14159265358979323846))
#define fixed_DEG_TO_RAD (FXX(3.14159265358979323846/180))


// only use if you are dividing by a constant, about 2x faster then division due to the better multiplication routine
// larger the constant is, the less accuracy
#define cdiv(XXXX, YYYY)  fixed_mult((XXXX), FXX( ((float) 1) /( (float)YYYY) ) )


int fixed_to_int(fixedpt x)__naked{
  __asm
  pop bc
  pop de
  pop hl
  push hl
  push de
  push bc
  ret
  __endasm;
}


#ifdef USE_FIXED_MULT
// Not a horible 32 bit multiplication rountine
// Should be fast enough for a 10-20 fps 2d game with 20 average mults
// More optimal for high numbers, can be improved, my first multiplication routine
// About 26000 t-states on the worst possible or 0.00325 sec or 3.25 ms
// About 19728 t-states on an average case or 0.002466 sec or 2.4659 ms
// About 16592 t-states on a light case or 0.002074 sec or 2.074 ms
void mulr(uint64_t left, uint32_t right, uint64_t* ret){
  __asm di __endasm;
  *ret = 0; // 112 t-states !!!!


    while (right > 0) // 19*4+12 t-states
    {
        if (right & 1) // 12+20 t-states
        {// if Least significant bit exists
          // 68 +(8*(4+7+7+7+4+6+6)) if right

          __asm
        .db 0xDD, 0x54 ; ld d,ixh  8 tstate
        .db 0xDD, 0x5D ; ld e,ixl  8 tstates
        __endasm;
        __asm



          ld  l, 16 (ix) ; 7
          ld  h, 17 (ix) ; 7

          ex de, hl ; 4 states

          ld bc, #4 ; 10 t-states
          add hl, bc ; 11 t-states
          ld b, #8 ; 7 t-states

          __endasm;
        for (char zzz = 0; zzz < 8; zzz++){ // 4, 12 + 7 t states
          __asm
          
  
          aSaveA ; 4 t-states
          ld a, (de) ; 7 t-states
          adc a, (hl) ; 7 t-states
          ld (de), a ; 7 t-states
          aSaveA ; 4 t-states
          inc de ; 6 t-states
          inc hl ; 6 t-states

          __endasm;
        }


        
        }
        right >>= 1; // 23*4 t-states
        left <<= 1; //23*8 + 12 t-states
    }
  __asm ei __endasm;
  
}

// 441 t-states + the time for mulr
// from compiled c code that I optimised
fixedpt fixed_mult(fixedpt a, fixedpt b) __naked{
__asm
  push  ix
  ld  ix,#0
  add ix,sp

; uint64_t r = 0;
  ld hl, #0
  push hl
  push hl
  push hl
  push hl
; mulr(a, b, &r);
  add hl, sp
  ex  de, hl
  ld  c, e
  ld  b, d

  push  de
  push  bc
  ld  l, 10 (ix)
  ld  h, 11 (ix)
  push  hl
  ld  l, 8 (ix)
  ld  h, 9 (ix)
  push  hl
  ld hl, #0
  push  hl
  push  hl
  ld  l, 6 (ix)
  ld  h, 7 (ix)
  push  hl
  ld  l, 4 (ix)
  ld  h, 5 (ix)
  push  hl
  call  _mulr
  ld  hl, #14
  add hl, sp
  ld  sp, hl
  pop de
// return *(uint32_t*)(((char*)&r+2));
  inc de
  inc de
  ld  a, d
  ld  l, e
  ld  h, a
  ld  e, (hl)
  inc hl
  ld  d, (hl)
  inc hl
  ld  c, (hl)
  inc hl
  ld  h, (hl)
  ex  de, hl
  ld  e, c

  ld  sp, ix
  pop ix
  ret

__endasm;

}
#endif



#ifdef USE_FIXED_DIV
// this is a BAD division routine, I stole it from _divulonglong from sdcc, can't do better, all I did is change reste = 0L to alloc with pushes
// minimize the use of this routine, try to use bit shifts and cdiv instead (if you are using constants)
// 798 t-states per loop, and there is 64 of them
// around 51258 t-states per call, all calls are the same
// 0.00640725 secounds per call or 6.407249 ms per call
uint32_t
longdiv (uint64_t x, uint64_t y)__naked{
  __asm
  push  ix ; 15 t-states
  ld  ix,#0 ; 14 t-states
  add ix,sp ; 15 t-states

// ;../../lib/fixedpoint.c:167: unsigned long long reste = 0L;
  xor a, a  ; 4 t-states
  ld de, #0 ; 10 t-states
  push de   ; 11 t-states
  push de   ; 11 t-states
  push de   ; 11 t-states
  push de   ; 11 t-states



// ;../../lib/fixedpoint.c:171: do // 798*64
  ld  c, #0x40
00105$:
// ;../../lib/fixedpoint.c:174: c = MSB_SET(x);
  ld  a, 11 (ix)
  rlca
  and a, #0x01
// ;../../lib/fixedpoint.c:175: x <<= 1;
  sla 4 (ix)
  rl  5 (ix)
  rl  6 (ix)
  rl  7 (ix)
  rl  8 (ix)
  rl  9 (ix)
  rl  10 (ix)
  rl  11 (ix)



// ;../../lib/fixedpoint.c:176: reste <<= 1;
  sla -8 (ix)
  rl  -7 (ix)
  rl  -6 (ix)
  rl  -5 (ix)
  rl  -4 (ix)
  rl  -3 (ix)
  rl  -2 (ix)
  rl  -1 (ix)
// ;../../lib/fixedpoint.c:177: if (c)
  or  a, a
  jr  Z, 00102$
// ;../../lib/fixedpoint.c:178: reste |= 1L;
  ld  a, -8 (ix)
  or  a, #0x01
  ld  -8 (ix), a
00102$:
// ;../../lib/fixedpoint.c:180: if (reste >= y)
  ld  a, -8 (ix)
  sub a, 12 (ix)
  ld  a, -7 (ix)
  sbc a, 13 (ix)
  ld  a, -6 (ix)
  sbc a, 14 (ix)
  ld  a, -5 (ix)
  sbc a, 15 (ix)
  ld  a, -4 (ix)
  sbc a, 16 (ix)
  ld  a, -3 (ix)
  sbc a, 17 (ix)
  ld  a, -2 (ix)
  sbc a, 18 (ix)
  ld  a, -1 (ix)
  sbc a, 19 (ix)
  jr  C, 00106$
// ;../../lib/fixedpoint.c:182: reste -= y;

  ld  a, -8 (ix)
  sub a, 12 (ix)
  ld  -8 (ix), a
  ld  a, -7 (ix)
  sbc a, 13 (ix)
  ld  -7 (ix), a
  ld  a, -6 (ix)
  sbc a, 14 (ix)
  ld  -6 (ix), a
  ld  a, -5 (ix)
  sbc a, 15 (ix)
  ld  -5 (ix), a
  ld  a, -4 (ix)
  sbc a, 16 (ix)
  ld  -4 (ix), a
  ld  a, -3 (ix)
  sbc a, 17 (ix)
  ld  -3 (ix), a
  ld  a, -2 (ix)
  sbc a, 18 (ix)
  ld  -2 (ix), a
  ld  a, -1 (ix)
  sbc a, 19 (ix)
  ld  -1 (ix), a
// ;../../lib/fixedpoint.c:184: x |= 1L;
  ld  a, 4 (ix)
  or  a, #0x01
  ld  4 (ix), a
00106$:
// ;../../lib/fixedpoint.c:187: while (--count);
  dec c
  jp  NZ, 00105$
// ;../../lib/fixedpoint.c:188: return x;
  ld  c, 4 (ix)
  ld  b, 5 (ix)
  ld  e, 6 (ix)
  ld  d, 7 (ix)
  ld  l, c
  ld  h, b
// ;../../lib/fixedpoint.c:189: }
  ld  sp, ix
  pop ix
  ret

  __endasm;
}

// 184 t-states + time for longdiv
fixedpt fixed_div(fixedpt N, fixedpt D) {
  // return N;
  __asm
    ld bc, #0

    ld  l, 8 (ix)
    ld  h, 9 (ix)
    ld  e, 10 (ix)
    ld  d, 11 (ix)

    push bc
    push bc
    push de
    push hl


    ld  l, 4 (ix)
    ld  h, 5 (ix)
    ld  e, 6 (ix)
    ld  d, 7 (ix)


    push bc
    push de
    push hl
    push bc

    call  _longdiv

    ld sp, ix
  __endasm;
  // return longdiv(8, 2);

}
#endif


#ifdef USE_FIXED_PRINT
// not very fast not too slow
void fixed_print(fixedpt i){

  // fixed_div(i, 0);
  __asm
    ld  l, 6 (ix)
    ld  h, 7 (ix)
    push  hl
    call  _number
    xor a, a
    ld  6 (ix), a
    ld  7 (ix), a

    ld a, #'.'
    push ix
    abcall(_VPutMap)
    pop ix
  __endasm;


  __asm
  ld b, #5 // only 5 digets are trusted

  DEC_LOOP:
    push bc
    ld e, #0

    sla 4 (ix)
    rl  5 (ix)
    rl e
    ld l, 4(ix)
    ld h, 5(ix)
    ld a, e


    sla 4 (ix)
    rl  5 (ix)
    rl a
    sla 4 (ix)
    rl  5 (ix)
    rl a

    ld c, 4(ix)
    ld b, 5(ix)
    add hl, bc
    adc a, e
    add a, #'0'
    ld 4(ix), l
    ld 5(ix), h

    push ix
    abcall(_VPutMap)
    pop ix
    



    pop bc
    djnz DEC_LOOP


  __endasm;


  
  __asm
    ei
    ld sp, ix
  __endasm;
}
#endif


#ifdef USE_FIXED_SIN
// takes up about 300 bytes
const fixedpt SINE_LOOKUP[] = {FXX( 0.0), FXX( 0.08715574274765817), FXX( 0.17364817766693033), FXX( 0.25881904510252074), FXX( 0.3420201433256687), FXX( 0.42261826174069944), FXX( 0.49999999999999994), FXX( 0.573576436351046), FXX( 0.6427876096865393), FXX( 0.7071067811865475), FXX( 0.766044443118978), FXX( 0.8191520442889918), FXX( 0.8660254037844386), FXX( 0.9063077870366499), FXX( 0.9396926207859083), FXX( 0.9659258262890683), FXX( 0.984807753012208), FXX( 0.9961946980917455), FXX( 1.0), FXX( 0.9961946980917455), FXX( 0.984807753012208), FXX( 0.9659258262890683), FXX( 0.9396926207859084), FXX( 0.90630778703665), FXX( 0.8660254037844387), FXX( 0.8191520442889917), FXX( 0.766044443118978), FXX( 0.7071067811865476), FXX( 0.6427876096865395), FXX( 0.5735764363510459), FXX( 0.49999999999999994), FXX( 0.4226182617406995), FXX( 0.3420201433256689), FXX( 0.258819045102521), FXX( 0.17364817766693028), FXX( 0.0871557427476582), FXX( 1.2246467991473532e-16), FXX( -0.08715574274765794), FXX( -0.17364817766693047), FXX( -0.2588190451025208), FXX( -0.34202014332566866), FXX( -0.4226182617406993), FXX( -0.5000000000000001), FXX( -0.5735764363510462), FXX( -0.6427876096865393), FXX( -0.7071067811865475), FXX( -0.7660444431189779), FXX( -0.8191520442889916), FXX( -0.8660254037844385), FXX( -0.9063077870366502), FXX( -0.9396926207859084), FXX( -0.9659258262890683), FXX( -0.984807753012208), FXX( -0.9961946980917455), FXX( -1.0), FXX( -0.9961946980917455), FXX( -0.9848077530122081), FXX( -0.9659258262890684), FXX( -0.9396926207859083), FXX( -0.9063077870366498), FXX( -0.8660254037844386), FXX( -0.8191520442889918), FXX( -0.7660444431189781), FXX( -0.7071067811865477), FXX( -0.6427876096865396), FXX( -0.5735764363510465), FXX( -0.5000000000000004), FXX( -0.4226182617406992), FXX( -0.3420201433256686), FXX( -0.2588190451025207), FXX( -0.1736481776669304), FXX( -0.08715574274765832)};

fixedpt fixed_sin(int deg){
  return SINE_LOOKUP[deg%360/5];
}
#endif

#ifdef USE_FIXED_COS
fixedpt fixed_cos(int deg){
  return fixed_sin(deg+90);
}
#endif
#ifdef USE_FIXED_TAN
fixedpt fixed_tan(int deg){
  if (deg != 270) // division by 0 fix
    return fixed_div(fixed_sin(deg), fixed_sin(deg+90) );
  else
    return FXX(99999999999);
}
#endif
#ifdef USE_FIXED_ITAN
fixedpt fixed_itan(int deg){ // same as 1/tan
    if (deg != 360) // division by 0 fix
        return fixed_div(fixed_sin(deg+90), fixed_sin(deg) );
    else
        return FXX(99999999999);

}
#endif