#pragma once
/** @file  ti83plus.h
 *  @brief TI-83 Plus Include File
 * 
 * This is created from the ti83plus.inc which used by many assembly programs and includes essential equates used by the operating system. 
 * This version is more complete than what TI provides, due to years of research from various programmers throughout the decades.
 * 
 * And converted into a .h file from https://wikiti.brandonw.net/index.php?title=83Plus:OS:ti83plus.inc
 * should be C compatible now, if you see any mistakes a PR is welcome.
 * 
 * 
 * 
 * 
 */


/** @snippet ti83plus.h bulk
 */


#ifndef DOXYGEN

//! [bulk]


//System Variable Equates
//------------------------------
#define XSCLt                2  
#define YSCLt                3  
#define XMINt              0x0A 
#define XMAXt              0x0B 
#define YMINt              0x0C 
#define YMAXt              0x0D 
#define TMINt              0x0E 
#define TMAXt              0x0F 
#define THETMINt         0x10 
#define THETMAXt         0x11 
#define TBLMINt              0x1A 
#define PLOTSTARTt         0x1B 
#define NMAXt              0x1D 
#define NMINt              0x1F 
#define TBLSTEPt         0x21 
#define TSTEPt              0x22 
#define THETSTEPt         0x23 
#define DELTAXt              0x26 
#define DELTAYt              0x27 
#define XFACTt              0x28 
#define YFACTt              0x29 
#define FINNt              0x2B 
#define FINIt              0x2C 
#define FINPVt              0x2D 
#define FINPMTt              0x2E 
#define FINFVt              0x2F 
#define FINPYt              0x30 
#define FINCYt              0x31 
#define PLOTSTEPt         0x34 
#define XRESt              0x36 

//Run indicators
//------------------------------------
#define busyPause         0b10101010 
#define busyNormal         0b11110000 

//Banked Call Equates/Macros
//-----------------------------------------------
#define rBR_CALL         0x28 
#define BRT_JUMP0         0x50 
// OMITED LINE: #define bcall(xxxx) rst 28h \ .dw xxxx
// OMITED LINE: #define bjump(xxxx) call 50h \ .dw xxxx

//Common Restart Routines
//------------------------------
#define rOP1TOOP2         0x08 
#define rFINDSYM         0x10 
#define rPUSHREALO1         0x18 
#define rMOV9TOOP1         0x20 
#define rFPADD              0x30 

//Error Handler Equates/Macros
//-------------------------------------------
#define APP_PUSH_ERRORH         0x59 
#define APP_POP_ERRORH         0x5C 
// OMITED LINE: #define AppOnErr(xxxx) ld hl,xxxx \ call 59h
// OMITED LINE: #define AppOffErr call 5Ch

//Page 1Bh ROM Calls
//--------------------------------
#define _JErrorNo         0x4000 
#define _FontHook         0x4003 
#define _call_character_hook    0x4006  //calls character(localize) hook
#define _ldHLind         0x4009  //l=a=(hl),h=(hl+1)
#define _CpHLDE              0x400C 
#define _DivHLBy10         0x400F 
#define _DivHLByA         0x4012 
#define _kdbScan         0x4015 
#define _GetCSC              0x4018  //key board scan codes
#define _coorMon         0x401B  //
#define _Mon              0x401E  //system monitor, customized through the context vectors
#define _monForceKey         0x4021  //
#define _sendKPress         0x4024 
#define _JForceCmdNoChar    0x4027 
#define _JForceCmd         0x402A  //
#define _sysErrHandler         0x402D  //loads error context? sp=(onSP)
#define _newContext         0x4030  //(kbdKey)=0, loads context, restores page in 4000h-7fffh
#define _newContext0         0x4033  //loads context
#define _cxPutAway         0x4036  //
#define _cxPutAway2         0x4039  //same but also does a B_CALL CanAlphIns
#define _cxPPutAway         0x403C 
#define _cxSizeWind         0x403F 
#define _cxErrEP         0x4042 
#define _cxMain              0x4045 
#define _monErrHand         0x4048  //installs errorhandler to start of ROM call, loads error context, jumps to mon
#define _AppInit         0x404B  //loads vector data at hl to cxMain and the rest of the vectors
#define _resetRam         0x404E 
#define _lcd_busy         0x4051  //wait till bit 1 of port 2 is set
#define _Min              0x4054  //op1 = lowest number between op1 and op2
#define _Max              0x4057  //op1 = highest number between op1 and op2 
#define _Trunc              0x4060 
#define _InvSub              0x4063 
#define _Times2              0x4066 
#define _Plus1              0x4069  //op1=op1+1
#define _Minus1              0x406C 
#define _FPSub              0x406F 
#define _FPAdd              0x4072 
#define _DToR              0x4075 
#define _RToD              0x4078 
#define _Cube              0x407B 
#define _TimesPt5         0x407E 
#define _FPSquare         0x4081 
#define _FPMult              0x4084  //op1=op1*op2
#define _LJRND              0x4087  //adjusts op1 if 0s precede the actual number... rounding? when
#define _InvOP1SC         0x408A 
#define _InvOP1S         0x408D 
#define _InvOP2S         0x4090 
#define _frac              0x4093 
#define _fprecip         0x4096 
#define _fpdiv              0x4099 
#define _SqRoot              0x409C 
#define _RndGuard         0x409F 
#define _RnFx              0x40A2 
#define _int              0x40A5 
#define _Round              0x40A8 
#define _LnX              0x40AB 
#define _LogX              0x40AE 
#define _LJNORND         0x40B1  //like _LJRND but no rounding
#define _EToX              0x40B4 
#define _TenX              0x40B7 
#define _SinCosRad         0x40BA 
#define _Sin              0x40BD 
#define _cos              0x40C0 
#define _Tan              0x40C3 
#define _SinHCosH         0x40C6 
#define _TanH              0x40C9 
#define _cosh              0x40CC 
#define _SinH              0x40CF 
#define _ACosRad         0x40D2 
#define _ATanRad         0x40D5 
#define _ATan2Rad         0x40D8 
#define _ASinRad         0x40DB 
#define _ACos              0x40DE 
#define _ATan              0x40E1 
#define _ASin              0x40E4 
#define _ATan2              0x40E7 
#define _ATanH              0x40EA 
#define _ASinH              0x40ED 
#define _ACosH              0x40F0 
#define _PtoR              0x40F3 
#define _RToP              0x40F6 
#define _HLTimes9         0x40F9 
#define _CkOP1Cplx         0x40FC 
#define _CkOP1Real         0x40FF 
#define _Angle              0x4102 
#define _COP1Set0         0x4105 
#define _CpOP4OP3         0x4108 
#define _Mov9OP2Cp         0x410B 
#define _AbsO1O2Cp         0x410E 
#define _cpop1op2         0x4111 
#define _OP3ToOP4         0x4114 
#define _OP1ToOP4         0x4117 
#define _OP2ToOP4         0x411A 
#define _OP4ToOP2         0x411D 
#define _OP1ToOP3         0x4123 
#define _OP5ToOP2         0x4126 
#define _OP5ToOP6         0x4129 
#define _OP5ToOP4         0x412C 
#define _OP1ToOP2         0x412F 
#define _OP6ToOP2         0x4132 
#define _OP6ToOP1         0x4135 
#define _OP4ToOP1         0x4138 
#define _OP5ToOP1         0x413B 
#define _OP3ToOP1         0x413E 
#define _OP6ToOP5         0x4141 
#define _OP4ToOP5         0x4144 
#define _OP3ToOP5         0x4147 
#define _OP2ToOP5         0x414A 
#define _OP2ToOP6         0x414D 
#define _OP1ToOP6         0x4150 
#define _OP1ToOP5         0x4153 
#define _OP2ToOP1         0x4156 
#define _Mov11B              0x4159 
#define _Mov10B              0x415C 
#define _Mov9B              0x415F 
#define _mov9B2              0x4162  //points to _mov9B
#define _Mov8B              0x4165 
#define _Mov7B              0x4168 
#define _Mov7B2              0x416B  //same pointer as _Mov7B
#define _OP2ToOP3         0x416E 
#define _OP4ToOP3         0x4171 
#define _OP5ToOP3         0x4174 
#define _OP4ToOP6         0x4177 
#define _Mov9ToOP1         0x417A 
#define _Mov9OP1OP2         0x417D 
#define _Mov9ToOP2         0x4180 
#define _MovFrOP1         0x4183 
#define _OP4Set1         0x4186 
#define _OP3Set1         0x4189 
#define _OP2Set8         0x418C 
#define _OP2Set5         0x418F 
#define _OP2SetA         0x4192 
#define _OP2Set4         0x4195 
#define _OP2Set3         0x4198 
#define _OP1Set1         0x419B 
#define _OP1Set4         0x419E 
#define _OP1Set3         0x41A1 
#define _OP3Set2         0x41A4 
#define _OP1Set2         0x41A7 
#define _OP2Set2         0x41AA 
#define _OP2Set1         0x41AD 
#define _Zero16D         0x41B0 
#define _OP5Set0         0x41B3 
#define _OP4Set0         0x41B6 
#define _OP3Set0         0x41B9 
#define _OP2Set0         0x41BC 
#define _OP1Set0         0x41BF 
#define _OPSet0              0x41C2  //hl = location to write floating point 0
#define _ZeroOP1         0x41C5 
#define _ZeroOP2         0x41C8 
#define _ZeroOP3         0x41CB 
#define _ZeroOP              0x41CE 
#define _ClrLp              0x41D1 
#define _ShRAcc              0x41D4  //move high nibble in a to low nibble
#define _ShLAcc              0x41D7  //move low nibble in a to high nibble
#define _ShR18              0x41DA  //insert a 0 nibble at high nibble of (hl), shift 9 bytes 1 nibble to right
#define _SHR18A              0x41DD  //insert low nibble in a at high nibble of (hl), shift 9 bytes 1 nibble to right
#define _SHR16              0x41E0  //insert a 0 nibble at highnibble of (hl), shift 8 bytes 1 nibble to right
#define _SHR14              0x41E3  //insert low nibble in a at high nibble of (hl), shift 7 bytes 1 nibble to right
#define _SHL16              0x41E6  //insert nibble of 0 in low nibble of (hl), shift 8 bytes (before and including (hl)) to the left 1 nibble
#define _SHL14              0x41E9  //insert low nibble of a in low nibble of (hl), shift 7 bytes (before and including (hl)) to the left 1 nibble
#define _SRDO1              0x41EC 
#define _SHRDRND         0x41EF 
#define _MANTPA              0x41F2  //adds the value of a to hl which points to the end of the bcd 7 bytes long
#define _ADDPROP         0x41F5  //adds the value of a to hl which points to the end of the bcd (b bytes long)
#define _ADDPROPLP         0x41F8  //adds the value of a and carry to hl which points to the end of the bcd (b bytes long)
#define _ADD16D          0x41FB  //adds the bcd numbers at (hl-7) and (de-7)
#define _ADD14D              0x41FE  //adds the bcd numbers at (hl-6) and (de-6)
#define _SUB16D              0x4201  //subtracts bcd numbers at (hl-7) and (de-7)
#define _SUB14D              0x4204  //subtracts bcd numbers at (hl-6) and (de-6)
#define _OP2ExOP6         0x4207 
#define _OP5ExOP6         0x420A 
#define _OP1ExOP5         0x420D 
#define _OP1ExOP6         0x4210 
#define _OP2ExOP4         0x4213 
#define _OP2ExOP5         0x4216 
#define _OP1ExOP3         0x4219 
#define _OP1ExOP4         0x421C 
#define _OP1ExOP2         0x421F 
#define _ExLp              0x4222 
#define _CkOP1C0         0x4225 
#define _CkOP1FP0         0x4228 
#define _CkOP2FP0         0x422B 
#define _PosNo0Int         0x422E 
#define _CKPosInt         0x4231 
#define _CKInt              0x4234 
#define _CKOdd              0x4237 
#define _CKOP1M              0x423A 
#define _GETCONOP1         0x423D  //a=0 opX=57.29577951308232 (1 radian in degrees)
#define _GETCONOP2         0x4240  //a=1 opX=1.570796326794897 (90 deg = pi/2)
//a=2 opX=.7853981633974483 (45 deg = pi/4)
//a=3 opX=.4342944819032518 (log e)
//a=4 opX=3.141592653589800 (pi)
//a=5 opX=.0174532925199433 (pi/180 = 1 degree in radians)
//a=6 opX=2.302585092994046 (ln 10)
#define _PIDIV2              0x4243  //not code, but a pointer to:     .db 80h,15h,70h,79h,63h,26h,79h,48h,97h
#define _PIDIV4              0x4246  //                    .db 7fh,78h,53h,98h,16h,33h,97h,44h,83h
#define _PItimes2         0x4249  //not code, but a pointer to a 2*pi in non-OP format (no exponent byte)
#define _PI              0x424C  //not code, but a pointer to a pi in non-OP format (no exponent byte)
#define _ExpToHex         0x424F 
#define _OP1ExpToDec         0x4252 
#define _ckop2pos         0x4255 
#define _CkOP1Pos         0x4258 
#define _ClrOP2S         0x425B 
#define _ClrOP1S         0x425E 
#define _FDIV100         0x4261  //op1=op1/100
#define _FDIV10              0x4264  //op1=op1/10
#define _DecO1Exp         0x4267  //decrease exponent by 1, this can go from 0 to FF
#define _INCO1EXP         0x426A  //op1=op1*10
#define _INCEXP              0x426D  //hl points to the floating point's exponent to be multiplied by 10
#define _CkValidNum         0x4270 
#define _GETEXP              0x4273  //a=OP1's exponent, carry set if negative exponent, Z if e0
#define _HTimesL         0x4276 
#define _EOP1NotReal         0x4279 
#define _ThetaName         0x427C 
#define _RName              0x427F 
#define _REGEQNAME         0x4282 
#define _RECURNNAME         0x4285 
#define _XName              0x4288 
#define _YName              0x428B 
#define _TName              0x428E 
#define _REALNAME         0x4291 
#define _SETesTOfps         0x4294  //moves the word at fps to es
#define _markTableDirty         0x4297  //looks up table variable and marks VAT entry as "dirty" or selected
#define _OP1MOP2EXP         0x429A  //op1's exponent = op1's expoent - op2's exponent
#define _OP1EXPMinusE         0x429D  //a=(op1+1)-e
#define _CHKERRBREAK         0x42A0 
#define _isA2ByteTok         0x42A3 
#define _GETLASTENTRY         0x42A6 
#define _GETLASTENTRYPTR    0x42A9 
#define _REGCLRCHNG         0x42AC 
#define _RESETWINTOP         0x42AF  //takes into account grfsplitoverride and grfsplit flags
#define _SetYUp              0x42B2  //loads 7 to port 10... what does this do?
#define _SetXUp              0x42B5  //loads 5 to port 10...
#define _ISO1NONTLSTorPROG    0x42B8  //checks if op1 contains a list, program, group, or appvar obj name
#define _ISO1NONTEMPLST         0x42BB  //checks if op1 contains a list (why would op1+1 contain 01, or 0d for a var name?)
#define _IS_A_LSTorCLST         0x42BE  //checks if a = 1 or 0Dh
#define _CHK_HL_999         0x42C1  //returns nc if less than 999, throws invalid dim error if greater than or equal to 999
#define _equ_or_newequ         0x42C4 
#define _errd_op1notpos         0x42C7 
#define _ErrD_OP1Not_R         0x42CA 
#define _ErrD_OP1NotPosInt     0x42CD 
#define _ErrD_OP1_LE_0         0x42D0 
#define _ErrD_OP1_0         0x42D3 
#define _FINDSYM_GET_SIZE     0x42D6  //like findsym, but on output hl is the size of the variable
#define _STO_STATVAR         0x42D9 
#define _Rcl_StatVar         0x42DC 
#define _CkOP2Real         0x42DF 
#define _GET_X_INDIRECT         0x42E2  //whatever this is, it uses the imathptrX locations
#define _MemChk              0x42E5 
#define _CMPPRGNAMLEN1         0x42E8  //gets variable name length from HL
#define _CMPPRGNAMLEN         0x42EB  //gets variable name length from OP1
#define _FINDPROGSYM         0x42EE  //find the program whose name is in op1 (see chkfindsym in SDK)
#define _ChkFindSym         0x42F1 
#define _FindSym         0x42F4 
#define _InsertMem         0x42F7 
#define _INSERTMEMA         0x42FA  //not sure how this differs from insertmem
#define _EnoughMem         0x42FD 
#define _CMPMEMNEED         0x4300 
#define _CREATEPVAR4         0x4303 
#define _CREATEPVAR3         0x4306 
#define _CREATEVAR3         0x4309 
#define _CreateCplx         0x430C 
#define _CreateReal         0x430F 
#define _CreateTempRList    0x4312 
#define _CreateRList         0x4315 
#define _CREATETCLIST         0x4318 
#define _CreateCList         0x431B 
#define _CreateTempRMat         0x431E 
#define _CreateRMat         0x4321 
#define _CreateTempString    0x4324 
#define _CreateStrng         0x4327 
#define _Create0Equ         0x432A 
#define _CreateTempEqu         0x432D 
#define _CreateEqu         0x4330 
#define _CreatePict         0x4333 
#define _CreateGDB         0x4336 
#define _CreateProg         0x4339 
#define _CHKDEL              0x433C 
#define _CHKDELA         0x433F 
#define _ADJPARSER         0x4342 
#define _ADJMATH         0x4345 
#define _ADJM7              0x4348 
#define _DELMEMA         0x434B 
#define _GET_FORM_NUM         0x434E 
#define _DelVar              0x4351 
#define _DELVARIO         0x4354 
#define _DelMem              0x4357 
#define _DELVAR3D         0x435A 
#define _DELVAR3C         0x435D 
#define _DELVAR3DC         0x4360  //may be incorrect
#define _IsFixedName         0x4363 
#define _DelVarEntry         0x4366 
#define _DataSizeA         0x4369 
#define _DataSize         0x436C 
#define _POPMCPLXO1         0x436F 
#define _POPMCPLX         0x4372 
#define _MOVCPLX         0x4375 
#define _popOP5              0x4378 
#define _popOP3              0x437B 
#define _popOP1              0x437E 
#define _PopRealO6         0x4381 
#define _PopRealO5         0x4384 
#define _PopRealO4         0x4387 
#define _PopRealO3         0x438A 
#define _PopRealO2         0x438D 
#define _PopRealO1         0x4390 
#define _PopReal         0x4393 
#define _FPOPCPLX         0x4396 
#define _FPOPREAL         0x4399 
#define _FPOPFPS         0x439C 
#define _DeallocFPS         0x439F 
#define _DeallocFPS1         0x43A2 
#define _AllocFPS         0x43A5 
#define _AllocFPS1         0x43A8 
#define _PushRealO6         0x43AB 
#define _PushRealO5         0x43AE 
#define _PushRealO4         0x43B1 
#define _PushRealO3         0x43B4 
#define _PushRealO2         0x43B7 
#define _PushRealO1         0x43BA 
#define _PushReal         0x43BD 
#define _PushOP5         0x43C0 
#define _PushOP3         0x43C3 
#define _PUSHMCPLXO3         0x43C6 
#define _PushOP1         0x43C9 
#define _PUSHMCPLXO1         0x43CC 
#define _PUSHMCPLX         0x43CF 
#define _ExMCplxO1         0x43D2 
#define _Exch9              0x43D5 
#define _CpyTo1FPS11         0x43D8 
#define _CpyTo2FPS5         0x43DB 
#define _CpyTo1FPS5         0x43DE 
#define _CpyTo2FPS6         0x43E1 
#define _CpyTo1FPS6         0x43E4 
#define _CpyTo2FPS7         0x43E7 
#define _CpyTo1FPS7         0x43EA 
#define _CpyTo1FPS8         0x43ED 
#define _CpyTo2FPS8         0x43F0 
#define _CpyTo1FPS10         0x43F3 
#define _CpyTo1FPS9         0x43F6 
#define _CpyTo2FPS4         0x43F9 
#define _CpyTo6FPS3         0x43FC 
#define _CpyTo6FPS2         0x43FF 
#define _CpyTo2FPS3         0x4402 
#define _CPYCTO1FPS3         0x4405 
#define _CpyTo1FPS3         0x4408 
#define _CPYFPS3         0x440B 
#define _CpyTo1FPS4         0x440E 
#define _CpyTo3FPS2         0x4411 
#define _CpyTo5FPST         0x4414 
#define _CpyTo6FPST         0x4417 
#define _CpyTo4FPST         0x441A 
#define _CpyTo3FPST         0x441D 
#define _CpyTo2FPST         0x4420 
#define _CpyTo1FPST         0x4423 
#define _CPYFPST         0x4426 
#define _CpyStack         0x4429 
#define _CpyTo3FPS1         0x442C 
#define _CpyTo2FPS1         0x442F 
#define _CpyTo1FPS1         0x4432 
#define _CPYFPS1         0x4435 
#define _CpyTo2FPS2         0x4438 
#define _CpyTo1FPS2         0x443B 
#define _CPYFPS2         0x443E 
#define _CpyO3ToFPST         0x4441 
#define _CpyO2ToFPST         0x4444 
#define _CpyO6ToFPST         0x4447 
#define _CpyO1ToFPST         0x444A 
#define _CpyToFPST         0x444D 
#define _CpyToStack         0x4450 
#define _CpyO3ToFPS1         0x4453 
#define _CpyO5ToFPS1         0x4456 
#define _CpyO2ToFPS1         0x4459 
#define _CpyO1ToFPS1         0x445C 
#define _CpyToFPS1         0x445F 
#define _CpyO2ToFPS2         0x4462 
#define _CpyO3ToFPS2         0x4465 
#define _CpyO6ToFPS2         0x4468 
#define _CpyO1ToFPS2         0x446B 
#define _CpyToFPS2         0x446E 
#define _CpyO5ToFPS3         0x4471 
#define _CpyO2ToFPS3         0x4474 
#define _CpyO1ToFPS3         0x4477 
#define _CpyToFPS3         0x447A 
#define _CpyO1ToFPS6         0x447D 
#define _CpyO1ToFPS7         0x4480 
#define _CpyO1ToFPS5         0x4483 
#define _CpyO2ToFPS4         0x4486 
#define _CpyO1ToFPS4         0x4489 
#define _ErrNotEnoughMem     0x448C  //only if not HL bytes free
#define _FPSMINUS9         0x448F 
#define _HLMINUS9         0x4492 
#define _ErrOverflow         0x4495 
#define _ErrDivBy0         0x4498 
#define _ErrSingularMat         0x449B 
#define _ErrDomain         0x449E 
#define _ErrIncrement         0x44A1 
#define _ErrNon_Real         0x44A4 
#define _ErrSyntax         0x44A7 
#define _ErrDataType         0x44AA 
#define _ErrArgument         0x44AD 
#define _ErrDimMismatch         0x44B0 
#define _ErrDimension         0x44B3 
#define _ErrUndefined         0x44B6 
#define _ErrMemory         0x44B9 
#define _ErrInvalid         0x44BC 
#define _ErrBreak         0x44BF 
#define _ErrStat         0x44C2 
#define _ErrSignChange         0x44C5 
#define _ErrIterations         0x44C8 
#define _ErrBadGuess         0x44CB 
#define _ErrTolTooSmall         0x44CE 
#define _ErrStatPlot         0x44D1 
#define _ErrLinkXmit         0x44D4 
#define _JError              0x44D7 
#define _noErrorEntry         0x44DA 
#define _pushErrorHandleR    0x44DD 
#define _popErrorHandleR    0x44E0 
#define _strcopy         0x44E3 
#define _strCat              0x44E6 
#define _isInSet         0x44E9 
#define _sDone              0x44EC  //this should actually be called _SetEquToOP1
#define _serrort         0x44EF 
#define _sNameEq         0x44F2 
#define _sUnderScr         0x44F5 
#define _sFAIL              0x44F8 
#define _sName              0x44FB 
#define _sOK              0x44FE 
#define _PutMap              0x4501 
#define _PutC              0x4504 
#define _DispHL              0x4507 
#define _PutS              0x450A 
#define _putpsb              0x450D 
#define _PutPS              0x4510 
#define _wputps              0x4513 
#define _putbuf              0x4516 
#define _putbuf1         0x4519 
#define _wputc              0x451C 
#define _wputs              0x451F 
#define _wputsEOL         0x4522  //displays string in HL in big font, and uses ... if too long
#define _wdispEOL         0x4525 
#define _whomeup         0x4528 
#define _setNumWindow         0x452B  //based on current cursor position, sets winleft and similar (for input prompts)
#define _newline         0x452E 
#define _moveDown         0x4531 
#define _scrollUp         0x4534 
#define _shrinkWindow         0x4537 
#define _moveUp              0x453A 
#define _scrollDown         0x453D 
#define _ClrLCDFull         0x4540 
#define _ClrLCD              0x4543 
#define _ClrScrnFull         0x4546 
#define _ClrScrn         0x4549 
#define _ClrTxtShd         0x454C 
#define _ClrWindow         0x454F 
#define _EraseEOL         0x4552 
#define _EraseEOW         0x4555 
#define _HomeUp              0x4558 
#define _getcurloc         0x455B 
#define _VPutMap         0x455E 
#define _VPutS              0x4561 
#define _VPutSN              0x4564 
#define _vputsnG         0x4567 
#define _vputsnT         0x456A 
#define _RunIndicOn         0x456D 
#define _RunIndicOff         0x4570 
#define _saveCmdShadow         0x4573 
#define _saveShadow         0x4576 
#define _rstrShadow         0x4579 
#define _rstrpartial         0x457C 
#define _rstrCurRow         0x457F 
#define _rstrUnderMenu         0x4582 
#define _rstrbotrow         0x4585 
#define _saveTR              0x4588  //save top right corner of LCD so 2nd arrow can be displayed, indicinuse flag must be set
#define _restoreTR         0x458B  //restore top right corner of LCD destroyed by an arrow. indicinuse flag must be set
#define _GetKeyPress         0x458E 
#define _GetTokLen         0x4591  //input: hl=pointer to token. output: a=lenght of string, hl=pointer to string on page 1
#define _GET_TOK_STRNG         0x4594  //input: hl=pointer to token. output: op3=string of the token, a=length of string
#define _GETTOKSTRING         0x4597  //input: DE=token. output: hl=pointer to the string on page 1
#define _PUTBPATBUF2         0x459A 
#define _PUTBPATBUF         0x459D 
#define _putbPAT         0x45A0 
#define _putcCheckScrolL    0x45A3 
#define _DispEOL         0x45A6 
#define _fdispEOL         0x45A9 
#define _MAKEROWCMD         0x45AC 
#define _TOTOSTRP         0x45AF 
#define _SETVARNAME         0x45B2 
#define _DispDone         0x45B5 
#define _finishoutput         0x45B8 
#define _curBlink         0x45BB 
#define _CursorOff         0x45BE 
#define _hideCursor         0x45C1 
#define _CursorOn         0x45C4 
#define _showCursor         0x45C7 
#define _KeyToString         0x45CA 
#define _PULLDOWNCHK         0x45CD  //something wrong here
#define _MenuCatCommon         0x45D0 
#define _ZIfCatalog         0x45D3 
#define _ZIfMatrixMenu         0x45D6  //_loadCurCat
#define _LoadMenuNum         0x45D9 
#define _LoadMenuNumL         0x45DC 
#define _MenCatRet         0x45DF  //restores display as though a menu were just cleared (restores some flags too)
#define _MenuSwitchContext    0x45E2  //switches to context in A, calls menu hook with A=3, set 5,(iy+16h) for some sort of override to not make switch
#define _MenuEdKey         0x45E5 
#define _BackUpGraphSettings    0x45E8 
#define _notalphnum         0x45EB 
#define _SaveSavedFlags         0x45EE 
#define _SetMenuFlags         0x45F1 
#define _RstrSomeFlags         0x45F4 
#define _RstrOScreen         0x45F7  //restores saveSScreen to the display
#define _SaveOScreen         0x45FA  //stores display in saveSScreen
#define _dispListName         0x45FD  //_SeeIfErrorCx
#define _PrevContext         0x4600 
#define _CompareContext         0x4603 
#define _AdrMRow         0x4606 
#define _AdrMEle         0x4609 
#define _GETMATOP1A         0x460C 
#define _GETM1TOOP1         0x460F 
#define _GETM1TOP1A         0x4612 
#define _GetMToOP1         0x4615 
#define _PUTTOM1A         0x4618 
#define _PUTTOMA1         0x461B 
#define _PutToMat         0x461E 
#define _MAT_EL_DIV         0x4621 
#define _CMATFUN         0x4624 
#define _ROWECH_POLY         0x4627 
#define _ROWECHELON         0x462A 
#define _AdrLEle         0x462D 
#define _GETL1TOOP1         0x4630 
#define _GETL1TOP1A         0x4633 
#define _GetLToOP1         0x4636 
#define _GETL1TOOP2         0x4639 
#define _GETL1TOP2A         0x463C 
#define _GETL2TOP1A         0x463F 
#define _PUTTOLA1         0x4642 
#define _PutToL              0x4645 
#define _MAXMINLST         0x4648 
#define _LLOW              0x464B 
#define _LHIGH              0x464E 
#define _LSUM              0x4651 
#define CUMSUM              0x4654 
#define _ToFrac              0x4657 
#define _SEQSET              0x465A 
#define _SEQSOLVE         0x465D 
#define _CMP_NUM_INIT         0x4660 
#define _BinOPExec         0x4663 
#define _EXMEAN1         0x4666 
#define _SET2MVLPTRS         0x4669 
#define _SETMAT1         0x466C 
#define _CREATETLIST         0x466F 
#define _UnOPExec         0x4672 
#define _ThreeExec         0x4675 
#define _RESTOREERRNO         0x4678 
#define _FourExec         0x467B 
#define _FiveExec         0x467E 
#define _CPYTO2ES1         0x4681 
#define _CPYTO6ES1         0x4684 
#define _CPYTO1ES1         0x4687 
#define _CPYTO3ES1         0x468A 
#define _CPYTO3ES2         0x468D 
#define _CPYTO2ES2         0x4690 
#define _CPYTO1ES2         0x4693 
#define _CPYTO2ES3         0x4696 
#define _CPYTO1ES3         0x4699 
#define _CPYTO3ES4         0x469C 
#define _CPYTO6ES3         0x469F 
#define _CPYTO2ES4         0x46A2 
#define _CPYTO1ES4         0x46A5 
#define _CPYTO2ES5         0x46A8 
#define _CPYTO1ES5         0x46AB 
#define _CPYTO4EST         0x46AE 
#define _CPYTO2EST         0x46B1 
#define _CPYTO1EST         0x46B4 
#define _CPYTO2ES6         0x46B7 
#define _CPYTO1ES6         0x46BA 
#define _CPYTO2ES7         0x46BD 
#define _CPYTO1ES7         0x46C0 
#define _CPYTO2ES8         0x46C3 
#define _CPYTO1ES8         0x46C6 
#define _CPYTO1ES9         0x46C9 
#define _CPYTO2ES9         0x46CC 
#define _CPYTO2ES10         0x46CF 
#define _CPYTO1ES10         0x46D2 
#define _CPYTO2ES11         0x46D5 
#define _CPYTO1ES11         0x46D8 
#define _CPYTO2ES12         0x46DB 
#define _CPYTO1ES12         0x46DE 
#define _CPYTO2ES13         0x46E1 
#define _CPYTO1ES13         0x46E4 
#define _CPYTO1ES14         0x46E7 
#define _CPYTO1ES16         0x46EA 
#define _CPYTO1ES17         0x46ED 
#define _CPYTO1ES18         0x46F0 
#define _CPYTO1ES15         0x46F3 
#define _CPYTO2ES15         0x46F6 
#define _CPYO1TOEST         0x46F9 
#define _CPYO1TOES1         0x46FC 
#define _CPYO6TOES1         0x46FF 
#define _CPYO6TOES3         0x4702 
#define _CPYO1TOES2         0x4705 
#define _CPYO2TOES2         0x4708 
#define _CPYO1TOES3         0x470B 
#define _CPYO1TOES4         0x470E 
#define _CPYO1TOES5         0x4711 
#define _CPYO1TOES6         0x4714 
#define _CPYO1TOES7         0x4717 
#define _CPYO2TOES4         0x471A 
#define _CPYO2TOES5         0x471D 
#define _CPYO2TOES6         0x4720 
#define _CPYO2TOES7         0x4723 
#define _CPYO2TOES8         0x4726 
#define _CPYO2TOES9         0x4729 
#define _CPYO1TOES8         0x472C 
#define _CPYO1TOES9         0x472F 
#define _CPYO1TOES10         0x4732 
#define _CPYO1TOES11         0x4735 
#define _CPYO1TOES12         0x4738 
#define _CPYO1TOES13         0x473B 
#define _CPYO1TOES14         0x473E 
#define _CPYO1TOES15         0x4741 
#define _EVALF3A         0x4744 
#define _GetK              0x4747  //?
#define _setTitle              0x474A 
#define _dispVarVal         0x474D 
#define _RecallEd         0x4750  //_setupBuffer
#define _createNumEditBuf    0x4753 
#define _ProcessBufKeys         0x4756  //may be default key processing like [CLEAR], etc. especially for an edit buffer.
#define _CallCommon         0x4759 
#define _CommonKeys         0x475C 
#define _Leftmore         0x475F 
#define _fDel              0x4762 
#define _fClear              0x4765 
#define _finsDisp         0x4768  //Michael says _FinsDisp02 equ 4768h (something's not right)
#define _FinsDisp02         0x476B  //_setIndicator
#define _closeeditbufnor    0x476E 
#define _releaseBuffer         0x4771 
#define _varnameToOP1hl         0x4774 
#define _nameToOP1         0x4777 
#define _numPPutAway         0x477A 
#define _numRedisp         0x477D 
#define _numError02         0x4780 
#define _Load_SFont         0x4783 
#define _SFont_Len         0x4786 
#define _InitNumVec         0x4789  //inits window settings/table setup/finance solver context (dialog-like)
#define _SetXXOP1         0x478C 
#define _SetXXOP2         0x478F 
#define _SetXXXXOP2         0x4792 
#define _UCLineS         0x4795 
#define _CLine              0x4798 
#define _CLineS              0x479B 
#define _XRootY              0x479E 
#define _YToX              0x47A1 
#define _ZmStats         0x47A4 
#define _POINT_STAT_HLP         0x47A7 
#define _DRAWSPLOT         0x47AA 
#define _INITNEWTRACEP         0x47AD  //A is input here, goes to (8E63h)
#define _SPLOTCOORD         0x47B0 
#define _SPLOTRIGHT         0x47B3 
#define _SPLOTLEFT         0x47B6 
#define _CMPBOXINFO         0x47B9 
#define _NEXTPLOT         0x47BC 
#define _PREVPLOT         0x47BF 
#define _CLRPREVPLOT         0x47C2 
#define _PUT_INDEX_LST         0x47C5 
#define _GET_INDEX_LST         0x47C8 
#define _HEAP_SORT         0x47CB 
#define _StoGDB2         0x47CE 
#define _RclGDB2         0x47D1 
#define _CircCmd         0x47D4 
#define _GrphCirc         0x47D7 
#define _Mov18B              0x47DA 
#define _DarkLine         0x47DD 
#define _ILine              0x47E0 
#define _IPoint              0x47E3 
#define _XYRNDBOTH         0x47E6 
#define _XYRND              0x47E9 
#define _CheckTOP         0x47EC 
#define _CheckXY         0x47EF 
#define _DarkPnt         0x47F2 
#define _CPointS         0x47F5 
#define _WTOV              0x47F8 
#define _VtoWHLDE         0x47FB 
#define _Xitof              0x47FE 
#define _YftoI              0x4801 
#define _XftoI              0x4804 
#define _TraceOff         0x4807 
#define _GrRedisp         0x480A 
#define _GDISPTOKEN         0x480D 
#define _GRDECODA         0x4810 
#define _LABCOOR         0x4813  //draws labels with _GRLABELS and X/Y/whatever coordinates, including stat plot stuff
#define _COORDISP         0x4816  //draws X & Y coordinates (or R and theta if PolarGC)
#define _TMPEQUNOSRC         0x4819 
#define _GRLABELS         0x481C 
#define _YPIXSET         0x481F 
#define _XPIXSET         0x4822 
#define _COPYRNG         0x4825 
#define _VALCUR              0x4828  //just sets/resets three flags, enables graph cursor
#define _GRPUTAWAY         0x482B 
#define _RSTGFLAGS         0x482E 
#define _GRReset         0x4831 
#define _XYCENT              0x4834 
#define _ZOOMXYCMD         0x4837 
#define _CPTDELY         0x483A 
#define _CPTDELX         0x483D 
#define _SetFuncM         0x4840 
#define _SetSeqM         0x4843 
#define _SetPolM         0x4846 
#define _SetParM         0x4849 
#define _ZmInt              0x484C 
#define _ZmDecml         0x484F 
#define _ZmPrev              0x4852 
#define _ZmUsr              0x4855 
#define _SETUZM              0x4858 
#define _ZmFit              0x485B 
#define _ZmSquare         0x485E 
#define _ZmTrig              0x4861 
#define _SetXMinMax         0x4864 
#define _ZooDefault         0x4867 
#define _GrBufCpy         0x486A 
#define _DRAWSPLITLINE         0x486D 
#define _RestoreDisp         0x4870 
#define _FNDDB              0x4873 
#define _AllEq              0x4876 
#define _fndallseleq         0x4879 
#define _NEXTEQ              0x487C 
#define _PREVEQ              0x487F 
#define _BLINKGCUR         0x4882 
#define _NBCURSOR         0x4885 
#define _STATMARK         0x4888 
#define _CHKTEXTCURS         0x488B 
#define _Regraph         0x488E 
#define _DOREFFLAGS02         0x4891  //something wrong here
#define INITNSEQ         0x4894 
#define _YRES              0x4897  //_PLOTPTXY2
#define _Ceiling         0x489A  //ceil(OP1)
#define _PutXY              0x489D  //draws X & Y coordinates (regardless of PolarGC)
#define _PUTEQUNO         0x48A0 
#define _PDspGrph         0x48A3 
#define _HorizCmd         0x48A6 
#define _VertCmd         0x48A9 
#define _LineCmd         0x48AC 
#define _UnLineCmd         0x48AF 
#define _PointCmd         0x48B2 
#define _PixelTest         0x48B5 
#define _PixelCmd           0x48B8 
#define _TanLnF              0x48BB 
#define _DRAWCMD_INIT         0x48BE 
#define _DrawCmd         0x48C1 
#define _SHADECMD         0x48C4 
#define _InvCmd              0x48C7 
#define _STATSHADE         0x48CA 
#define _dspmattable         0x48CD 
#define _dsplsts         0x48D0 
#define _closeEditBuf         0x48D3 
#define _parseEditBuf         0x48D6 
#define _putsm              0x48D9 
#define _DspCurTbl         0x48DC 
#define _DSPGRTBL         0x48DF 
#define _zeroTemplate         0x48E2 
#define _settblrefs         0x48E5 
#define _dispTblBot         0x48E8 
#define _DispTblTop         0x48EB 
#define _dispTblbody         0x48EE 
#define _VPUTBLANK         0x48F1 
#define _TBLTRACE         0x48F4 
#define _dispListNameY         0x48F7 
#define _CurNameLength         0x48FA 
#define _NameToBuf         0x48FD 
#define _jpromptcursor         0x4900 
#define _BufLeft         0x4903 
#define _BufRight         0x4906 
#define _bufInsert         0x4909 
#define _bufQueueChar         0x490C 
#define _BufReplace         0x490F 
#define _BufDelete         0x4912 
#define _BUFPEEK         0x4915 
#define _BUFPEEK1         0x4918 
#define _BUFPEEK2         0x491B 
#define _BUFPEEK3         0x491E 
#define _BufToBtm         0x4921 
#define _setupEditEqu         0x4924 
#define _BufToTop         0x4927 
#define _isEditFull         0x492A 
#define _IsEditEmpty         0x492D 
#define _IsAtTop         0x4930 
#define _IsAtBtm         0x4933 
#define _BufClear         0x4936 
#define _JcursorFirst         0x4939 
#define _JcursorLast         0x493C 
#define _CursorLeft         0x493F 
#define _cursorRight         0x4942 
#define _cursorUp         0x4945 
#define _CursorDown         0x4948 
#define _cursorToOffset         0x494B 
#define _InsDisp         0x494E 
#define _FDISPBOL1         0x4951 
#define _FDISPBOL         0x4954 
#define _DispEOW         0x4957 
#define _DispHead         0x495A 
#define _DispTail         0x495D 
#define _PutTokString         0x4960 
#define _setupEditCmd         0x4963 
#define _setEmptyEditEqu    0x4966 
#define _SetEmptyEditPtr    0x4969 
#define _CloseEditEqu         0x496C 
#define _GetPrevTok         0x496F 
#define _getkey              0x4972 
#define _canIndic         0x4975 
#define _LCD_DRIVERON         0x4978  
#define _DFMIN2              0x497B 
#define _formDisp         0x497E  //this is directly what the OS calls on the homescreen to display a result
#define _formMatrix         0x4981 
#define _wscrollLeft         0x4984 
#define _wscrollUp         0x4987 
#define _wscrollDown         0x498A 
#define _wscrollRight         0x498D 
#define _FormEReal         0x4990 
#define _formERealTOK         0x4993 
#define _FormDCplx         0x4996 
#define _FormReal         0x4999 
#define _formScrollUp         0x499C 
#define _setwinabove         0x499F 
#define _disarmScroll         0x49A2 
#define _OP1toEdit         0x49A5 
#define _MinToEdit         0x49A8 
#define _rclVarToEdit         0x49AB 
#define _rclVarToEditPtR    0x49AE 
#define _RCLENTRYTOEDIT         0x49B1 
#define _rclToQueue         0x49B4  //recalls bytes at OP1 into edit buffer
#define _FORMTOTOK         0x49B7 
#define _DISP_INTERVAL         0x49BA 
#define _DisplstName         0x49BD 
#define _dispSLstNameHL         0x49C0 
#define _EditEqu         0x49C3 
#define _closeEquField         0x49C6 
#define _AutoSelect         0x49C9 
#define _DISPYEOS         0x49CC 
#define _dispNumEOS         0x49CF 
#define _setupdispeq         0x49D2 
#define _DispForward         0x49D5 
#define _DispYPrompt2         0x49D8 
#define _stringwidth         0x49DB 
#define _dispErrorScreen    0x49DE  //displays top row of error screen (error message)
#define _POPCX              0x49E1  //moves 14 bytes at cxPrev to cxMain, 15th byte goes to replace appflags
#define _loadnoeentry         0x49E4 
#define _SaveScreen         0x49E7 
#define _RETSCREEN         0x49EA 
#define _RetScreenErr         0x49ED 
#define _CheckSplitFlag         0x49F0 
#define _SolveRedisp         0x49F3 
#define _SolveDisp         0x49F6 
#define _itemName         0x49F9 
#define _SetNorm_Vals         0x49FC 
#define _SetYOffset         0x49FF  //sets up YOffset and next 4 bytes (possibly specialized for the table editor)
#define _ConvKeyToTok         0x4A02 
#define _ConvFCKeyToTok         0x4A05 
#define _ConvFEKeyToTok         0x4A08 
#define _TokToKey         0x4A0B 
#define _SendSkipExitPacket    0x4A0E 
#define _GETVARCMD         0x4A11 
#define _SendVarCmd         0x4A14 
#define _SendScreenshot         0x4A17 
#define keyscnlnk         0x4A1A 
#define _DeselectAllVars    0x4A1D 
#define _DelRes              0x4A20 
#define _ConvLcToLr         0x4A23 
#define _RedimMat         0x4A26 
#define _IncLstSize         0x4A29 
#define _InsertList         0x4A2C 
#define _dellistel         0x4A2F 
#define _EditProg         0x4A32 
#define _CloseProg         0x4A35 
#define _ClrGraphRef         0x4A38 
#define _FixTempCnt         0x4A3B 
#define _SAVEDATA         0x4A3E 
#define _RESTOREDATA         0x4A41 
#define _FindAlphaUp         0x4A44 
#define _FindAlphaDn         0x4A47 
#define _CmpSyms         0x4A4A 
#define _CREATETEMP         0x4A4D 
#define _CleanAll         0x4A50 
#define _MoveToNextSym         0x4A53  //input: hl=pointer to type byte of VAT entry. output: hl = pointer to next entry's type byte
#define _ConvLrToLc         0x4A56 
#define _TblScreenDn         0x4A59  //something is not right here
#define _TblScreenUp         0x4A5C 
#define _SCREENUP         0x4A5F 
#define _ScreenUpDown         0x4A62 
#define _ZifRclHandler         0x4A65 
#define _zifrclkapp         0x4A68 
#define _rclkeyRtn         0x4A6B 
#define _RCLKEY              0x4A6B 
#define _RCLREGEQ_CALL         0x4A6E 
#define _RCLREGEQ         0x4A71 
#define _initNamePrompt         0x4A74 
#define _NamePrompt2         0x4A77 
#define _CATALOGCHK         0x4A7A 
#define _clrTR              0x4A7D 
#define _QUAD              0x4A80 
#define _GRAPHQUAD         0x4A83 
#define _BC2NOREAL         0x4A86 
#define _ErrNonReal_FPST_FPS1    0x4A89 
#define _ErrNonReal         0x4A8C  //ERR:DATA TYPE if top B numers from FPS are non-real
#define _WRITE_TEXT         0x4A8F 
#define _FORSEQINIT         0x4A92 
#define _GRPHPARS         0x4A95 
#define _PLOTPARS         0x4A98 
#define _ParseInp         0x4A9B 
#define _PARSEOFF         0x4A9E 
#define _PARSESCAN         0x4AA1 
#define _GETPARSE         0x4AA4 
#define _SAVEPARSE         0x4AA7 
#define _InitPFlgs         0x4AAA 
#define _CKENDLINERR         0x4AAD 
#define _OP2Set60         0x4AB0 
#define _GETSTATPTR         0x4AB3 
#define _CMP_STATPTR         0x4AB6 
#define _VARSYSADR         0x4AB9 
#define _StoSysTok         0x4ABC 
#define _StoAns              0x4ABF 
#define _StoTheta         0x4AC2 
#define _StoR              0x4AC5 
#define _StoY              0x4AC8 
#define _StoN              0x4ACB 
#define _StoT              0x4ACE 
#define _StoX              0x4AD1 
#define _StoOther         0x4AD4 
#define _RclAns              0x4AD7 
#define _RclY              0x4ADA 
#define _RclN              0x4ADD 
#define _RclX              0x4AE0 
#define _RclVarSym         0x4AE3 
#define _RclSysTok         0x4AE6 
#define _StMatEl         0x4AE9 
#define _STLSTVECEL         0x4AEC 
#define _ConvOP1         0x4AEF 
#define _Find_Parse_Formula    0x4AF2 
#define _PARSE_FORMULA         0x4AF5 
#define _FetchQuotedString    0x4AF8 
#define _FetchNumLine         0x4AFB 
#define _ParseNameTokens    0x4AFE 
#define _ParseInpGraph         0x4B01  //same as _ParseInp except 3,(iy+1Fh) is graph/split screen override, or something
#define _ParseInpGraphReset    0x4B04  //_ParseInpGraph except zeroes out iy+6/7, resets 3,(iy+1Ah) & 0,(iy+1Fh), fmtFlags->fmtOverride, parse within ParseInp?
#define _ParseInpLastEnt    0x4B07  //ParseInp on program 05h,23h,00h
#define _ErrOnCertainTypes    0x4B0A  //ERR:DATA TYPE if A is one of a couple of values...subroutine in ParseInp, somehow
#define _CreatePair         0x4B0D 
#define _PUSHNUM         0x4B10 
#define _INCCURPCERREND         0x4B13 
#define _ERREND              0x4B16 
#define _COMMAERRF         0x4B19 
#define _COMMAERR         0x4B1C 
#define _STEQARG2         0x4B1F 
#define _STEQARG         0x4B22 
#define _INPARG              0x4B25 
#define _STEQARG3         0x4B28 
#define _NXTFETCH         0x4B2B 
#define _CKFETCHVAR         0x4B2E 
#define _FETCHVARA         0x4B31 
#define _FETCHVAR         0x4B34 
#define _CKENDLIN         0x4B37  //gets parse byte in A and then _CKENDEXP
#define _CKENDEXP         0x4B3A  //checks A for 3Eh or 3Fh
#define _CKPARSEND         0x4B3D 
#define _STOTYPEARG         0x4B40 
#define _ConvDim         0x4B43 
#define _ConvDim00         0x4B46 
#define _AHEADEQUAL         0x4B49 
#define _PARSAHEADS         0x4B4C 
#define _PARSAHEAD             0x4B4F 
#define _AnsName         0x4B52 
#define _STOCMPREALS         0x4B55 
#define _GETDEPTR         0x4B58 
#define _PUSH2BOPER         0x4B5B  //push the value in bc onto the operator stack
#define _POP2BOPER         0x4B5E  //pop 2 bytes on the operator stack to bc
#define _PUSHOPER         0x4B61  //push the value in a onto the operator stack
#define _POPOPER         0x4B64  //pop 1 byte on the operator stack to a
#define _FIND_E_UNDEF         0x4B67 
#define _STTMPEQ         0x4B6A 
#define _FINDEOL         0x4B6D 
#define _BRKINC              0x4B70 
#define _INCFETCH         0x4B73 
#define _CURFETCH         0x4B76 
#define _Random              0x4B79 
#define _StoRand         0x4B7C 
#define _RandInit         0x4B7F 
#define _resetStacks         0x4B82  //(onsp)->(errsp), (fpbase)->(fps), (opbase)->(ops)
#define _Factorial         0x4B85 
#define _YONOFF              0x4B88 
#define _EQSELUNSEL         0x4B8B 
#define _ITSOLVER         0x4B8E 
#define _GRITSOLVER         0x4B91 
#define _ITSOLVERB         0x4B94 
#define _ITSOLVERNB         0x4B97 
#define _ExTest_INT         0x4B9A 
#define _DIST_FUN         0x4BAD 
#define _LogGamma         0x4BA0 
#define _OneVar              0x4BA3 
#define _ONEVARS_0         0x4BA6 
#define _ORDSTAT         0x4BA9 
#define _INITSTATANS2         0x4BAC 
#define _ANOVA_SPEC         0x4BAF 
#define _OutputExpr         0x4BB2 
#define _CentCursor         0x4BB5 
#define _TEXT              0x4BB8 
#define _FINISHSPEC         0x4BBB 
#define _TRCYFUNC         0x4BBE 
#define _RCL_SEQ_X         0x4BC1 
#define _RCLSEQ2         0x4BC4 
#define _GRPPutAway         0x4BC7 
#define _CKVALDELX         0x4BCA 
#define _CKVALDELTA         0x4BCD 
#define _GrBufClr         0x4BD0 
#define _GRBUFCPY_V         0x4BD3 
#define _FNDSELEQ         0x4BD6 
#define _CLRGRAPHXY         0x4BD9 
#define _NEDXT_Y_STYLE         0x4BDC 
#define _PLOTPT              0x4BDF 
#define _NEWINDEP         0x4BE2 
#define _Axes              0x4BE5 
#define _setPenX         0x4BE8 
#define _setPenY         0x4BEB 
#define _setPenT         0x4BEE 
#define _TAN_EQU_DISP         0x4BF1 
#define _PutAns              0x4BF4 
#define _DispOP1A         0x4BF7 
#define _MATHTANLN         0x4BFA 
#define _ENDDRAW         0x4BFD 
#define _SetTblGraphDraw    0x4C00 
#define _StartDialog         0x4C03 
#define _DialogInit         0x4C06 
#define _GetDialogNumOP1    0x4C09 
#define _SetDialogNumOP1    0x4C0C 
#define _GetDialogNumHL         0x4C0F 
#define _ErrArgumentO123    0x4C12  //ERR:ARGUMENT if OP2>OP1 or OP1>OP3
#define _SetDialogKeyOverride    0x4C15 
#define _ResDialogKeyOverride    0x4C18 
#define _ForceDialogKeypress    0x4C1B 
#define _DialogStartGetKey    0x4C1E 
#define _StartDialog_Override    0x4C21 
#define _CallDialogCallback    0x4C24 
#define _SetDialogCallback    0x4C27 
#define _ResDialogCallback    0x4C2A 
#define _CopyDialogNum         0x4C2D 
#define _MemClear         0x4C30 
#define _MemSet              0x4C33 
#define _ReloadAppEntryVecs    0x4C36 
#define _PointOn         0x4C39 
#define _ExecuteNewPrgm         0x4C3C 
#define _StrLength         0x4C3F 
#define _VPutMapRec         0x4C42 
#define _getRomPage         0x4C45 
#define _FindAppUp         0x4C48 
#define _FindAppDn         0x4C4B 
#define _FindApp         0x4C4E 
#define _ExecuteApp         0x4C51 
#define _MonReset         0x4C54 
#define _ClearParseVar         0x4C57 
#define _SetParseVarProg    0x4C5A 
#define _isContextKey         0x4C5D 
#define _IBounds         0x4C60 
#define _IOffset         0x4C63 
#define _DrawCirc2         0x4C66 
#define _CanAlphIns         0x4C69 
#define cxRedisp         0x4C6C 
#define _GetBaseVer         0x4C6F 
#define _OPSet0DE         0x4C72  //loads a floating point 0 to location de 
#define _AppGetCbl         0x4C75 
#define _AppGetCalc         0x4C78 
#define _SaveDisp         0x4C7B 
#define _SetIgnoreKey           0x4C7E  //set 1,(iy+28h) / ret
#define _SetSendThisKeyBack    0x4C81  //set 2,(iy+28h) / ld (kbdKey),a / ret
#define _DisableApd         0x4C84 
#define _EnableApd         0x4C87  //set apdable,(iy+apdflags)
#define _JForceCmdNoChar2    0x4C8A  //2.41 at least
#define _set2IY34         0x4C8D  //set 2,(iy+34) / ret
#define _forcecmd         0x4C90 
#define _ApdSetup         0x4C93 
#define _Get_NumKey         0x4C96 
#define _AppSetup         0x4C99  //or _AppCleanup, or something
#define _HandleLinkKeyActivity    0x4C9C 
#define _JForceCmdNoChar3    0x4C9F  //2.41 at least
#define _ReleaseSedit         0x4CA2 
#define _initsmalleditline    0x4CA5 
#define _startsmalledit         0x4CA8 
//4CABh
#define _SGetTokString         0x4CAE 
#define _LoadPattern          0x4CB1 
#define _SStringLength         0x4CB4 
#define _RestorePenCol         0x4CB7 
//4CBAh
#define _DoNothing         0x4CBD 
#define _ForceSmallEditReturn    0x4CC0 
//4CC3h ;saves context
//4CC6h
//4CC9h
//4CCCh
#define _VEraseEOL         0x4CCF 
//4CD2h
//4CD5h
#define _GoToErr         0x4CD8 
#define _initsmalleditBox    0x4CDB 
//4CDEh
#define _EmptyHook         0x4CE1 
#define _ForceSmallEditReturn2    0x4CE4 
//4CE7h ;same as 4CC3h
//4CEAh
#define _ClearRow         0x4CED 
//4CF0h
//4CF3h
//4CF6h
//4CF9h
//4CFCh
//4CFFh
//4D02h
//4D05h
//4D08h
//4D0Bh
//4D0Eh
//4D11h
//4D14h
//4D17h
//4D1Ah
//4D1Dh
//4D20h
//4D23h
#define _AppScreenUpDown    0x4D26  //shifts screen up/down, A is LCD row, H is number of lines to shift, (OP1)-(OP1+3) are something
#define _AppScreenUpDown1    0x4D29  //shifts screen up/down, but really no clue what the inputs are (all registers and (OP1)-(OP1+3))
//4D2Ch
#define _initsmalleditlinevar    0x4D2F 
#define _initsmalleditlineop1    0x4D32 
#define _initsmalleditboxvar    0x4D35 
#define _initsmalleditboxop1    0x4D38 
//4D3Bh
#define _RestartDialog         0x4D3E 
#define _ErrCustom1         0x4D41 
#define _ErrCustom2         0x4D44 
#define _AppStartMouse         0x4D47 
#define _AppStartMouseNoSetup    0x4D4A 
#define _AppMouseGetKey         0x4D4D 
#define _AppDispMouse         0x4D50 
#define _AppEraseMouse         0x4D53 
#define _AppSetupMouseMem    0x4D56 
#define _GetDispRowOffset    0x4D59  //HL=A*12 (intended for A to be row and HL becomes offset into plotSScreen)
#define _ClearRect         0x4D5C 
#define _InvertRect         0x4D5F 
#define _FillRect         0x4D62 
#define _AppUpdateMouse         0x4D65 
#define _AppDispPrevMouse    0x4D68  //might bring previous keypress's movement to current coordinates with flags to not display
//4D6Bh ;restores some cursor flags and stuff
#define _initcellbox         0x4D6E 
#define _drawcell         0x4D71 
//4D74h
#define _invertcell         0x4D77 
#define _setcelloverride    0x4D7A 
#define _DrawRectBorder         0x4D7D 
#define _ClearCell         0x4D80 
#define _covercell         0x4D83 
#define _EraseRectBorder    0x4D86 
#define _FillRectPattern    0x4D89 
#define _DrawRectBorderClear    0x4D8C 
//4D8Fh ;mouse subroutine
//4D92h
#define _VerticalLine         0x4D95 
#define _IBoundsFull         0x4D98 
#define _DisplayImage         0x4D9B 
//4D9Eh ;does something dumb with ports 10h/11h
//4DA1h ;mouse subroutine
#define _AppUpdateMouseCoords    0x4DA4 
#define _ShiftBitsLeft         0x4DA7  //mouse subroutine, shifts B bits left from DE sprite to HL one
//4DAAh ;mouse subroutine
//4DADh ;mouse subroutine
//4DB0h ;mouse subroutine
//4DB3h ;mouse subroutine
//4DB6h ;mouse subroutine
//4DB9h ;mouse subroutine
//4DBCh ;mouse subroutine
#define _AppUpdateMouseRow    0x4DBF 
#define _AppDrawMouse         0x4DC2  //set 2,(iy+2Ch) for AppEraseMouse, reset for AppDispMouse
#define _AppDrawMouseDirect    0x4DC5  //pretty much _AppDrawMouse, but you pass LCD column in A
#define _CPoint              0x4DC8 
#define _DeleteApp         0x4DCB 
#define _AppUpdateMouseXY    0x4DCE 
#define _setmodecellflag    0x4DD1 
#define _resetmodecellflag    0x4DD4 
#define _ismodecellset         0x4DD7 
#define _getmodecellflag    0x4DDA 
//4DDDh
#define _CellBoxManager         0x4DE0 
#define _startnewcell         0x4DE3 
//4DE6h
#define _CellCursorHandle    0x4DE9 
//4DECh
//4DEFh
#define _ClearCurCell         0x4DF2 
#define _drawcurcell         0x4DF5 
#define _invertcurcell         0x4DF8 
#define _covercurcell         0x4DFB 
#define _BlinkCell         0x4DFE 
#define _BlinkCellNoLookUp    0x4E01 
#define _BlinkCurCell         0x4E04 
#define _BlinkCellToOn         0x4E07 
#define _BlinkCellToOnNoLookUp    0x4E0A 
#define _BlinkCurCellToOn    0x4E0D 
#define _BlinkCellToOff         0x4E10 
#define _BlinkCellToOffNoLookUp0x4E13 
#define _BlinkCurCellToOff    0x4E16 
#define _getcurmodecellflag    0x4E19 
//4E1Ch
#define _startsmalleditreturn    0x4E1F 
//4E22h
//4E25h
#define _CellkHandle         0x4E28 
#define _errchkalphabox         0x4E2B 
//4E2Eh
//4E31h
//4E34h
//4E37h
#define _eraseallcells         0x4E3A 
#define _iscurmodecellset    0x4E3D 
//4E40h
#define _initalphabox         0x4E43 
//4E46h
//4E49h
#define _drawblnkcell         0x4E4C 
#define _ClearBlnkCell         0x4E4F 
#define _invertblnkcell         0x4E52 
#define _AppMouseForceKey    0x4E55 
#define _AppSetupMouseMemCoords    0x4E58  //this is _AppSetupMouseMem except you pass starting coordinates in HL
#define _AppMoveMouse         0x4E5B  //this is _AppMouseForceKey and then updating coordinates
#define _GetStringInput         0x4E5E 
#define _GetStringInput2    0x4E61 
#define _WaitEnterKeyValue    0x4E64 
#define _HorizontalLine         0x4E67 
#define _CreateAppVar         0x4E6A 
#define _CreateProtProg         0x4E6D 
#define _CreateVar         0x4E70 
#define _AsmComp         0x4E73 
#define _GetAsmSize         0x4E76 
#define _SquishPrgm         0x4E79 
#define _ExecutePrgm         0x4E7C 
#define _ChkFindSymAsm         0x4E7F 
#define _ParsePrgmName         0x4E82 
#define _CSub              0x4E85 
#define _CAdd              0x4E88 
#define _CSqaure         0x4E8B 
#define _CMult              0x4E8E 
#define _CRecip              0x4E91 
#define _CDiv              0x4E94 
#define _CAbs              0x4E97 
#define _AddSquares         0x4E9A 
#define _CSqRoot         0x4E9D 
#define _CLN              0x4EA0 
#define _CLog              0x4EA3 
#define _CTenX              0x4EA6 
#define _CEtoX              0x4EA9 
#define _CXrootY         0x4EAC 
//4EAFh
#define _CYtoX              0x4EB2 
#define _InvertNonReal         0x4EB5 
#define _CplxMult         0x4EB8 
#define _CplxDiv         0x4EBB 
#define _CplxTrunc         0x4EBE 
#define _CplxFrac         0x4EC1 
#define _CplxFloor         0x4EC4 
#define _SendHeaderPacket    0x4EC7 
#define _CancelTransmission    0x4ECA 
#define _SendScreenContents    0x4ECD 
#define _SendRAMVarData         0x4ED0 
#define _SendRAMCmd         0x4ED3 
#define _SendPacket         0x4ED6 
#define _ReceiveAck         0x4ED9 
#define _Send4BytePacket    0x4EDC 
#define _SendDataByte         0x4EDF 
#define _Send4Bytes         0x4EE2 
#define _SendAByte         0x4EE5 
#define _SendCByte         0x4EE8 
#define _GetSmallPacket         0x4EEB 
#define _GetDataPacket         0x4EEE 
#define _SendAck         0x4EF1 
#define _Get4Bytes         0x4EF4 
#define _Get3Bytes         0x4EF7 
#define _Rec1stByte         0x4EFA 
#define _Rec1stByteNC         0x4EFD 
#define _ContinueGetByte    0x4F00 
#define _RecAByteIO         0x4F03 
#define _ReceiveVar         0x4F06 
#define _ReceiveVarDataExists    0x4F09 
#define _ReceiveVarData         0x4F0C 
#define _SrchVLstUp         0x4F0F 
#define _SrchVLstDn         0x4F12 
#define _SendVariable         0x4F15 
#define _Get4BytesCursor    0x4F18 
#define _Get4BytesNC         0x4F1B 
#define _Convert85List         0x4F1E 
#define _SendDirectoryContents    0x4F21 
#define _SendReadyPacket    0x4F24 
#define _Convert85Real         0x4F27 
#define _ret_6              0x4F2A 
#define _SendCertificate    0x4F2D  //sends certificate in header/data packets, Flash must be unlocked, used with sending an application in LINK menu
#define _SendApplication    0x4F30 
#define _SendOSHeader         0x4F33 
#define _SendOSPage         0x4F36 
#define _SendOS              0x4F39 
#define _FlashWriteDisable    0x4F3C 
#define _SendCmd         0x4F3F 
#define _SendOSValidationData    0x4F42 
#define _Disp              0x4F45 
#define _SendGetkeyPress    0x4F48 
#define _RejectCommand         0x4F4B 
#define _CheckLinkLines         0x4F4E 
#define _GetHookByte         0x4F51 
#define _GetBytePaged         0x4F54 
#define _cursorhook         0x4F57 
#define _call_library_hook    0x4F5A 
#define _call_rawkey_hook    0x4F5D 
#define _setCursorHook         0x4F60  //enable cursor hook
#define _EnableLibraryHook    0x4F63 
#define _SetGetKeyHook         0x4F66 
#define _ClrCursorHook         0x4F69 
#define _DisableLibraryHook    0x4F6C 
#define _ClrRawKeyHook      0x4F6F 
#define _ResetHookBytes         0x4F72 
#define _AdjustAllHooks         0x4F75 
#define _getkeyhook         0x4F78 
#define _SetGetcscHook         0x4F7B 
#define _ClrGetKeyHook         0x4F7E 
#define _call_linkactivity_hook    0x4F81 
#define _EnableLinkActivityHook    0x4F84 
#define _DisableLinkHook    0x4F87 
#define _GetSmallPacket2    0x4F8A 
#define _EnableCatalog2Hook    0x4F8D 
#define _DisableCatalog2Hook    0x4F90 
#define _EnableLocalizeHook    0x4F93 
#define _DisableLocalizeHook    0x4F96 
#define _SetTokenHook         0x4F99 
#define _ClearTokenHook         0x4F9C 
//4F9Fh ld hl,92c6 / ld a,(92c5) / res 2,a / cp (hl) / ret
//4FA2h hl=11*(92fc)+92c9 / ld a,(hl) / and Fh / cp 2 / ret ; I can almost guarantee this is stat plot related
#define _DispListElementOffLA    0x4FA5 
#define _Bit_VertSplit         0x4FA8 
#define _SetHomescreenHook    0x4FAB 
#define _ClrHomeScreenHook    0x4FAE 
#define _SetWindowHook         0x4FB1 
#define _DisableWindowHook    0x4FB4 
#define _SetGraphModeHook    0x4FB7 
#define _DisableGraphHook    0x4FBA 
#define _ParseAndStoreSysVar    0x4FBD 
#define _DisplayEditSysVar    0x4FC0 
#define _JForceWindowSettings    0x4FC3 
#define _DelVarArc         0x4FC6 
#define _DelVarNoArc         0x4FC9 
#define _SetAllPlots         0x4FCC 
#define _SetYeditHook         0x4FCF 
#define _DisableYEquHook    0x4FD2 
#define _JForceYEqu         0x4FD5 
#define _Arc_Unarc         0x4FD8  //checks for low battery
#define _ArchiveVar         0x4FDB  //set 0,(iy+24h) to check for low battery first
#define _UnarchiveVar         0x4FDE 
#define _DialogKeyHook         0x4FE1  //rawkey hook used by OS for dialog context
#define _SetFontHook         0x4FE4 
#define _ClrFontHook         0x4FE7 
#define _SetRegraphHook         0x4FEA 
#define _DisableRegraphHook    0x4FED 
#define _RunGraphingHook    0x4FF0 
#define _SetTraceHook         0x4FF3 
#define _DisableTraceHook    0x4FF6 
#define _RunTraceHook         0x4FF9 
#define _NDeriv              0x4FFC 
#define _PolarDerivative    0x4FFF 
#define _JForceGraphNoKey    0x5002 
#define _JForceGraphKey         0x5005 
#define _PowerOff         0x5008 
#define _GetKeyRetOff         0x500B  //same as getkey, only returns kOff if 2nd+on is pressed 
#define _FindGroupSym         0x500E 
#define _FillBasePageTable    0x5011 
#define _ArcChk              0x5014 
#define _FlashToRam         0x5017 
#define _LoadDEIndPaged         0x501A 
#define _LoadCIndPaged         0x501D 
#define _SetupPagedPtr         0x5020 
#define _PagedGet         0x5023 
#define _SetParserHook         0x5026 
#define _ClearParserHook    0x5029 
#define _SetAppChangeHook     0x502C 
#define _ClearAppChangeHook    0x502F 
#define _EnableGraphicsHook    0x5032 
#define _DisableGraphicsHook    0x5035 
#define _IPointNoGraphicsHook    0x5038 
#define _ILineNoHook         0x503B 
//503Eh
#define _DeleteTempPrograms    0x5041 
#define _EnableCatalog1Hook    0x5044 
#define _DisableCatalog1Hook    0x5047 
#define _EnableHelpHook         0x504A 
#define _DisableHelpHook    0x504D 
#define _DispCatalogEnd         0x5050 
#define _GetMenuKeypress    0x5053 
#define _GetCatalogItem         0x5056 
#define _RunCatalog2Hook    0x5059 
#define _RunCatalog1Hook    0x505C 
//505Fh
//5062h
#define _dispMenuTitle         0x5065 
//5068h
#define _EnablecxRedispHook    0x506B 
#define _DisablecxRedispHook    0x506E 
#define _BufCpy              0x5071 
#define _BufClr              0x5074 
#define _UnOPExec2         0x5077 
#define _BinOPExec2         0x507A 
#define _LoadMenuB         0x507D  //clears screen and loads menu from B, plus a couple flag changes
#define _DisplayVarInfo         0x5080 
#define _SetMenuHook         0x5083 
#define _ClearMenuHook         0x5086 
#define _getBCOffsetIX         0x5089 
#define _GetBCOffsetIX2         0x508C 
#define _ForceFullScreen    0x508F 
#define _GetVariableData    0x5092 
#define _FindSwapSector         0x5095 
#define _CopyFlashPage         0x5098 
#define _FindAppNumPages    0x509B 
#define _HLMinus5         0x509E 
#define _SendArcPacket         0x50A1 
#define _ForceGraphKeypress    0x50A4 
#define _DoNothing3         0x50A7 
#define _FormBase         0x50AA 
//50ADh
#define _IsFragmented         0x50B0 
#define _Chk_Batt_Low         0x50B3 
#define _Chk_Batt_Low_2         0x50B6 
#define _Arc_Unarc2         0x50B9  //identical to _Arc_Unarc, except you can choose to res 0,(iy+24h) to skip low battery check
#define _GetAppBasePage         0x50BC  //input: a=one of an app's pages. output: a=app's first page
#define _SetExSpeed         0x50BF 
#define _RclExit         0x50C2 
#define _GroupAllVars         0x50C5 
#define _UngroupVar         0x50C8 
#define _WriteToFlash         0x50CB  //ReceiveApplication or something like that on OSes below 2.40
#define _SetSilentLinkHook    0x50CE 
#define _DisableSilentLinkHook    0x50D1 
#define _TwoVarSet         0x50D4 
#define _ExecClassCToken    0x50D7 
#define _ExecClass3Token    0x50DA 
#define _GetSysInfo         0x50DD 
#define _NZIf83Plus         0x50E0 
#define _LinkStatus         0x50E3 
#define _DoNothing2         0x50E6  //originally for TI-Navigator
#define _KeyboardGetKey         0x50E9 
#define _RunAppLib         0x50EC 
#define _FindSpecialAppHeader    0x50EF 
#define _SendUSBData         0x50F2 
#define _AppGetCBLUSB         0x50F5 
#define _AppGetCalcUSB         0x50F8 
#define _GetVarCmdUSB         0x50FB 
//50FEh
#define _TenX2              0x5101 
//5104h
//5107h
#define _GetVarVersion         0x510A 
//510Dh
//5110h
#define _DeleteTempEditEqu    0x5113 
#define _JcursorFirst2         0x5116 
//5119h
#define _PromptMoveBackLeft    0x511C 
#define _wputsEOL2         0x511F  //same except res 0,(iy+0Eh) first
#define _InvertTextInsMode    0x5122 
//5125h
#define _ResetDefaults         0x5128 
#define _ZeroFinanceVars    0x512B 
#define _DispHeader         0x512E 
#define _JForceGroup         0x5131 
//5134h
//5137h
#define _DispCoords         0x513A 
//513Dh
//5140h
#define _chkTmr              0x5143 
//5146h
//5149h
//514Ch
#define _getDate         0x514F 
#define _GetDateString         0x5152 
#define _getDtFmt         0x5155 
#define _getDtStr         0x5158 
#define _getTime         0x515B 
#define _GetTimeString         0x515E 
#define _getTmFmt         0x5161 
#define _getTmStr         0x5164 
#define _SetZeroOne         0x5167 
#define _setDate         0x516A 
#define _IsOneTwoThree         0x516D 
#define _setTime         0x5170 
#define _IsOP112or24         0x5173 
#define _chkTimer0         0x5176 
#define _timeCnv         0x5179 
#define _GetLToOP1Extra         0x517C 
#define _ClrWindowAndFlags    0x517F 
#define _SetMachineID         0x5182 
#define _ResetLists         0x5185 
#define _DispValue         0x5188 
//518Bh
//518Eh
#define _ExecLib         0x5191 
//5194h
#define _CPOP1OP2Rounded    0x5197 
#define _CPOP1OP2Rounded2    0x519A 
#define _OpenLib         0x519D 
//51A0h
//51A3h
#define _ResetIOPrompt         0x51A6 
#define _StrCpyVarData         0x51A9 
#define _SetUpEditor         0x51AC 
#define _SortA              0x51AF 
#define _SortD              0x51B2 
//51B5h
#define _IsOP1ResID         0x51B8 
#define _ListEdNameCxMain    0x51BB 
#define _ListEdEnterNewName    0x51BE 
//51C1h
#define _ForceModeKeypress    0x51C4  //forces a keypress (and calls help hook) on any of several mode-setting contexts
#define _DispAboutScreen    0x51C7 
#define _ChkHelpHookVer         0x51CA 
#define _Disp32              0x51CD 
//51D0h
//51D3h
//51D6h
//51D9h
#define _DrawTableEditor    0x51DC  //draws table editor lines
#define _DisplayListNameEquals    0x51DF 
#define _DisplayListHeader    0x51E2 
#define _DispMatrixDimensions    0x51E5 
#define _HighlightListEdItem    0x51E8 
//51EBh
//51EEh
#define _MatrixName         0x51F1 
//51F4h
//51F7h
//51FAh
//51FDh
//5200h
//5203h
//5206h
//5209h
//520Ch
//520Fh
#define _SetupEmptyEditTempEqu    0x5212 
#define _ExecClass1Token    0x5215 
#define _HandleMathTokenParse    0x5218 
#define _MaybePushMultiplyOp    0x521B 
#define _RestartParseOP1Result    0x521E 
#define _Chk_Batt_Level         0x5221 
//5224h
//5227h
//522Ah
#define _DisplayListEquals    0x522D 
#define _GetCurPlotListOffset    0x5230 
#define _GoToLastRow         0x5233 
#define _RectBorder         0x5236 
//5239h
//523Ch
//523Fh
#define _LoadA5              0x5242 
//5245h
#define _NamedListToOP1         0x5248 
//524Bh
//524Eh
//5251h
#define _InitUSBDeviceCallback    0x5254 
#define _KillUSBDevice         0x5257  //this actually recycles the USB connection and re-inits it (I think)
#define _SetUSBConfiguration    0x525A 
#define _RequestUSBData         0x525D 
#define _StopReceivingUSBData    0x5260 
#define _FindAppHeaderByPage    0x5263 
#define _FindNextHeaderByPage    0x5266 
#define _IsMatchingLaunchApp    0x5269 
#define _InitTimer         0x526C 
#define _KillTimer         0x526F 
#define _StartTimer         0x5272 
#define _RestartTimer         0x5275 
#define _StopTimer         0x5278 
#define _WaitTimer         0x527B 
#define _CheckTimer         0x527E 
#define _CheckTimerRestart    0x5281 
#define _SetVertGraphActive    0x5284 
#define _ClearVertGraphActive    0x5287 
#define _EnableUSBHook         0x528A 
#define _DisableUSBHook         0x528D 
#define _InitUSBDevice         0x5290 
#define _KillUSBPeripheral    0x5293 
#define _GetCurPlotListOffset2    0x5296 
//5299h
#define _GraphLine         0x529C 
//529Fh
//52A2h
//52A5h
//52A8h
//52ABh
//52AEh
#define _ZifTableEditor         0x52B1 
//52B4h
#define _GetCurPlotOffset    0x52B7 
//52BAh
#define _FindAppName         0x52BD 
//52C0h
//52C3h
#define _UpdateStatPlotLists    0x52C6 
#define _GrBufCpyCustom         0x52C9 
//52CCh
//52CFh
//52D2h
#define _VDispRealOP1         0x52D5 
#define _DispXEqualsNum         0x52D8 
#define _ResetGraphSettings    0x52DB 
#define _InitializeVariables    0x52DE 
//52E1h ;bit 4,(9C75h) (this is DEFINITELY returning the status of something when acting as a TI-SmartView Input Pad...this bit is bit 1 of the data byte from a PC HID Set Report request)
#define _DelVarSym         0x52E4 
#define _FindAppUpNoCase    0x52E7 
#define _FindAppDnNoCase    0x52EA 
#define _DeleteInvalidApps    0x52ED 
#define _DeleteApp_Link         0x52F0 
#define _CmpSymsNoCase         0x52F3 
#define _SetAppRestrictions    0x52F6 
#define _RemoveAppRestrictions    0x52F9 
#define _QueryAppRestrictions    0x52FC 
#define _DispAppRestrictions    0x52FF 
#define _SetupHome         0x5302 
#define _GRPUTAWAYFull         0x5305  //same as _GRPUTAWAY except it assumes no split screen
#define _SendSmartPadKeypress    0x5308  //B and A are the inputs
#define _ToggleUSBSmartPadInput    0x530B  //A is input, 0 or 1 to enable/disable
#define _IsUSBDeviceConnected    0x530E  //bit 4,(81h) \ ret, this is just a guess on its purpose but it seems to work
#define _RecycleUSB         0x5311  //identical to 5257h
#define _PolarEquToOP1         0x5314 
#define _ParamXEquToOP1         0x5317 
#define _ParamYEquToOP1         0x531A 
#define _GetRestrictionsOptions    0x531D 
#define _DispResetComplete    0x5320 
#define _PTTReset         0x5323 
#define _FindAppCustom         0x5326 
#define _ClearGraphStyles    0x5329 
//532Ch
//532Fh
//5332h
//5335h
//5338h
//533Bh
//533Eh
//5341h
//5344h
//5347h
//534Ah
//534Dh
//5350h
//5353h
//5356h
//5359h
//535Ch
//535Fh
//5362h
//5365h
//5368h
//536Bh
//536Eh
//5371h
//5374h
//5377h
//537Ah
//537Dh
//5380h
//5383h
//5386h
//5389h
//538Ch
//538Fh
//5392h
//5395h
//5398h
//539Bh
//539Eh
//53A1h
//53A4h
//53A7h
//53AAh
//53ADh
//53B0h
//53B3h
//53B6h
//53B9h
//53BCh
//53BFh
//53C2h
//53C5h
//53C8h
//53CBh
//53CEh
//53D1h
//53D4h
//53D7h
//53DAh
//53DDh
//53E0h
//53E3h
//53E6h
//53E9h
//53ECh
//53EFh
//53F2h
//53F5h
//53F8h
//53FBh
//53FEh
//5401h
//5404h
//5407h
//540Ah
//540Dh
//5410h
//5413h
//5416h
//5419h
//541Ch
//541Fh
//5422h
//5425h
//5428h
//542Bh
//542Eh
//5431h
//5434h
//5437h
//543Ah
//543Dh
//5440h
//5443h
//5446h
//5449h
#define _xorAret              0x5443 
#define _scfRet                   0x5446 
#define _ret                   0x5449 

//Page 1Fh ROM Calls
//--------------------------------
#define bootbtf                   0x8000 
//400Fh may point to version string ("1.02 ",0)
#define _MD5Final              0x8018 
#define _RSAValidate              0x801B 
#define _cmpStr                   0x801E  //BigNumCompare
#define _WriteAByte              0x8021 
#define _EraseFlash              0x8024 
#define _FindFirstCertField         0x8027 
#define _ZeroToCertificate         0x802A 
#define _GetCertificateEnd         0x802D 
#define _FindGroupedField         0x8030 
#define _ret_1                   0x8033 
#define _ret_2                   0x8036 
#define _ret_3                   0x8039 
#define _ret_4                   0x803C 
#define _ret_5                   0x803F 
#define _Mult8By8              0x8042 
#define _Mult16By8              0x8045 
#define _Div16By8              0x8048 
#define _Div16By16              0x804B 
//804Eh ;scary certificate reading and writing, something about calc ID and fields 0A10/0A20
#define _LoadAIndPaged              0x8051 
#define _FlashToRam2              0x8054 
#define _GetCertificateStart         0x8057 
#define _GetFieldSize              0x805A 
#define _FindSubField              0x805D 
#define _EraseCertificateSector         0x8060 
#define _CheckHeaderKey              0x8063 
//8066h ;just returns Z if specified data in field 0310h, subfield 0610h exists, DE points to data of that field you want to find
//8069h ;just returns number of 0810h/0710h fields that exist in certificate or something, in IX
#define _Load_LFontV2              0x806C 
#define _Load_LFontV              0x806F 
#define _ReceiveOS              0x8072 
#define _FindOSHeaderSubField         0x8075 
#define _FindNextCertField         0x8078 
#define _GetByteOrBoot              0x807B 
#define _getSerial              0x807E  //GetCalcSerial
#define _ReceiveCalcID              0x8081  //receives certificate replacement (including calculator ID, fails if already exists) and writes it, requires Flash unlocked
#define _EraseFlashPage              0x8084 
#define _WriteFlashUnsafe         0x8087 
#define _dispBootVer              0x808A 
#define _MD5Init              0x808D 
#define _MD5Update              0x8090 
#define _MarkOSInvalid              0x8093 
#define _FindProgramLicense         0x8096  //copies 8010h field to appID and other insane stuff that makes zero sense
#define _MarkOSValid              0x8099 
#define _CheckOSValidated         0x809C 
#define _SetupAppPubKey              0x809F 
#define _SigModR              0x80A2 
#define _TransformHash              0x80A5 
#define _IsAppFreeware              0x80A8 
#define _FindAppHeaderSubField         0x80AB 
#define _WriteValidationNumber         0x80AE  //generates two-byte validation number from calc ID and stores to certificate
#define _Div32By16              0x80B1 
#define _FindGroup              0x80B4  //searches until field of DE-like group is found (DE=0A00h, it stops when it finds 0Ax0h)
#define _getBootVer              0x80B7 
#define _getHardwareVersion         0x80BA 
#define _xorA                   0x80BD  //xor a
#define _bignumpowermod17         0x80C0 
#define _ProdNrPart1              0x80C3 
#define _WriteAByteSafe              0x80C6 
#define _WriteFlash              0x80C9 
#define _SetupDateStampPubKey         0x80CC 
#define _SetFlashLowerBound         0x80CF 
#define _LowBatteryBoot              0x80D2 
//TI-84 Plus/Silver Edition Only Entry Points
#define _AttemptUSBOSReceive         0x80E4  //Z to wait for USB cable insert & get OS, NZ and A= contents of port 4Dh or 56h, ON to cancel & clear RAM
#define _DisplayBootMessage         0x80E7 
#define _NewLine2              0x80EA 
#define _DisplayBootError10         0x80ED 
#define _Chk_Batt_Low_B              0x80F0 
#define _Chk_Batt_Low_B2         0x80F3 
#define _ReceiveOS_USB              0x80F6 
#define _DisplayOSProgress         0x80F9 
#define _ResetCalc              0x80FC 
#define _SetupOSPubKey              0x80FF 
#define _CheckHeaderKeyHL         0x8102  //same as _CheckHeaderKey, only you pass the address of header in HL, not at appData
#define _USBErrorCleanup         0x8105  //kills some USB stuff (doesn't completely kill periph communication), error handler in boot code
#define _InitUSB              0x8108  //initializes USB hardware as peripheral, sets 5,(iy+1Bh), C set if problems
//810Bh set 1,(81h) and wait (has something to do with USB peripheral kill, but it doesn't actually kill it)
#define _KillUSB              0x810E  //identical to 8105h, except in the middle of the outputs, it sends zero to port 4Ch
#define _DisplayBootError1         0x8111 
#define _DisplayBootError2         0x8114 
#define _DisplayBootError3         0x8117 
#define _DisplayBootError4         0x811A 
#define _DisplayBootError5         0x811D 
#define _DisplayBootError6         0x8120 
#define _DisplayBootError7         0x8123 
#define _DisplayBootError8         0x8126 
#define _DisplayBootError9         0x8129 

//RAM Equates
//--------------------------------
#define ramStart         0x8000 
#define appData              0x8000 
#define ramCode              0x8100 
#define SmallEditColumnLeft    0x8177 
#define SmallEditRow         0x8178 
#define SmallEditColumnRight    0x8179 
//penCol left edge?     equ 817Bh
#define bigInteger1         0x8182 
#define SmallEditCancelParse    0x8194 
#define SmallEditRowCount    0x81B7 
#define bigInteger2         0x81C3 
#define SmallEditPromptString    0x81CC 
#define ramCodeEnd         0x822F 
#define baseAppBrTab         0x8230  //table of base pages for apps on page < 20h (starts with eight zeroes because they're OS pages)
#define clockFlag         0x8230  //bit 2 set for 24-hour mode and don't display "AM/PM"
#define clockIDs         0x8231  //five bytes, numbers 0-4 in memory, that when present, stops displaying clock numbers in time setting context?
#define bootTemp         0x8251 
#define MD5Temp              0x8259 
#define MD5Length         0x8269 
#define MD5Hash              0x8292 
#define appSearchPage         0x82A3 
#define tempSwapArea         0x82A5 
//something          equ 837Bh ;18 bytes, probably indicates something about Flash app pages, start out as 0FFh
#define appID              0x838D 
#define arcPageEnd         0x8392 
#define arcPtrEnd         0x8393 
//839Fh something...field size bytes?
#define MD5Buffer         0x83A5 
#define Abackup              0x83EB 
#define ramReturnData         0x83ED 
#define arcInfo              0x83EE 
#define savedArcInfo         0x8406 
#define appInfo              0x8432 
#define appBank_jump         0x843C 
#define appPage              0x843E 
#define kbdScanCode         0x843F 
#define kbdKey              0x8444 
#define kbdGetKy         0x8445 
#define keyExtend         0x8446 
#define EXTECHO                keyExtend  
#define contrast         0x8447 
#define apdSubTimer         0x8448 
#define apdTimer         0x8449 
#define curTime              0x844A 
#define curRow              0x844B 
#define curCol              0x844C 
#define curOffset         0x844D 
#define curUnder         0x844E 
#define curY              0x844F 
#define curType              0x8450 
#define curXRow              0x8451 
#define prevDData         0x8452 
#define lFont_record         0x845A 
#define sFont_record         0x8462 
#define tokVarPtr         0x846A 
#define tokLen              0x846C 
#define indicMem         0x846E  //eight bytes used by _saveTR and _restoreTR to store image in top right corner
#define indicCounter         0x8476 
#define indicBusy         0x8477 
#define OP1              0x8478 
#define OP1M              0x847A 
#define OP2              0x8483 
#define OP2M              0x8485 
#define OP2EXT              0x848C 
#define OP3              0x848E 
#define OP3M              0x8490 
#define OP4              0x8499 
#define OP4M              0x849B 
#define OP5              0x84A4 
#define OP5M              0x84A6 
#define OP6              0x84AF 
#define OP6M              0x84B1 
#define OP6EXT              0x84B8 
#define progToEdit         0x84BF 
#define nameBuff         0x84C7 
#define equ_edit_save         0x84D2 
#define iMathPtr1         0x84D3 
#define iMathPtr2         0x84D5 
#define iMathPtr3         0x84D7 
#define iMathPtr4         0x84D9 
#define iMathPtr5         0x84DB 
#define chkDelPtr1         0x84DD 
#define chkDelPtr2         0x84DF 
#define insDelPtr         0x84E1 
#define upDownPtr         0x84E3 
#define fOutDat              0x84E5 
#define asm_data_ptr1         0x84EB 
#define asm_data_ptr2         0x84ED 
#define asm_sym_ptr1         0x84EF 
#define asm_sym_ptr2         0x84F1 
#define asm_ram              0x84F3 
#define asm_ind_call         0x8507 
#define textShadow         0x8508 
#define textShadCur         0x8588 
#define textShadTop         0x858A 
#define textShadAlph         0x858B 
#define textShadIns         0x858C 
#define cxMain              0x858D 
#define cxPPutAway         0x858F 
#define cxPutAway         0x8591 
#define cxErrorEP         0x8595 
#define cxSizeWind         0x8597 
#define cxPage              0x8599 
#define cxCurApp         0x859A 
#define cxPrev              0x859B  //12 bytes are shadows of cxMain through cxCurApp and appFlags
#define monQH              0x85AA 
#define monQT              0x85AB 
#define monQueue         0x85AC 
#define onSP              0x85BC 
#define promptRow         0x85C0 
#define promptCol         0x85C1 
#define promptIns         0x85C2 
#define promptShift         0x85C3 
#define promptRet         0x85C4 
#define promptValid         0x85C6 
#define promptTop         0x85C8 
#define promptCursor         0x85CA 
#define promptTail         0x85CC 
#define promptBtm         0x85CE 
#define varType              0x85D0 
#define varCurrent         0x85D1 
#define varClass         0x85D9 
#define CatalogCurrent         0x85DA  //word at this location starting with 6007h corresponds to what is highlighted in catalog
#define menuActive         0x85DC 
#define menuAppDepth         0x85DD 
#define MenuCurrent         0x85DE 
//               equ 85DFh ;holds current submenu index
//               equ 85E0h ;holds currently selected item in current submenu
//               equ 85E1h ;holds number of submenus for this menu
//               equ 85E2h ;holds number of items in this submenu
//               equ 85E3h ;iy+appFlags backup for menu stuff
//               equ 85E4h ;iy+0Ch backup for menu stuff
//               equ 85E5h ;curGStyle backup for menu stuff
//               equ 85E6h ;iy+graphFlags backup for menu stuff
#define ProgCurrent         0x85E8 
//something, OP1 backup?     equ 85F2h ;type and name of topmost variable on menu with names
//something          equ 85FDh
#define userMenuSA         0x85FE 
#define ioPrompt         0x865F 
#define dImageWidth         0x8660 
#define ioFlag              0x8670 
#define sndRecState         0x8672 
#define ioErrState         0x8673 
#define header              0x8674 
#define ioData              0x867D 
#define ioNewData         0x8689 
#define bakHeader         0x868B 
//something          equ 8697h ;app bitmap for selecting stuff from menus
//something          equ 86B7h ;used in 47h and 74h link packets
#define penCol              0x86D7 
#define penRow              0x86D8 
#define rclQueue         0x86D9 
#define rclQueueEnd         0x86DB 
#define errNo              0x86DD 
#define errSP              0x86DE 
#define errOffset         0x86E0 
#define saveSScreen         0x86EC 
#define asm_prgm_size         0x89EC 
#define bstCounter         0x89EE 
#define flags              0x89F0 
#define appFlagsAddr         0x89FD 
//something          equ 8A36h ;stats-related? This gets stored to (varCurrent) for some reason
#define statVars         0x8A3A 
#define anovaf_vars         0x8C17 
#define infVars              0x8C4D 
#define infVar1              0x8C56 
#define infVar2              0x8C5F 
#define infVar3              0x8C68 
#define infVar4              0x8C71 
#define infVar5              0x8C7A 
#define infVar6              0x8C83 
#define infVar7              0x8C8C 
#define infVar8              0x8C95 
#define infVar9              0x8C9E 
#define infVar10         0x8CA7 
#define infVar11         0x8CB0 
#define infVar12         0x8CB9 
#define infVar13         0x8CC2 
#define infVar14         0x8CCB 
#define infVar15         0x8CD4 
#define infVar16         0x8CDD 
#define infVar17         0x8CE6 
#define infVar18         0x8CEF 
#define infVar19         0x8CF8 
#define infVar20         0x8D01 
//something          equ 8D0Bh
//list-related stat vars     equ 8D0Dh
#define curGStyle         0x8D17 
#define curGY              0x8D18 
#define curGX              0x8D19 
#define curGY2              0x8D1A 
#define curGX2              0x8D1B  //currently selected equation while graphing
#define freeSaveY         0x8D1C 
#define freeSaveX         0x8D1D 
//100 bytes          equ 8D2Ah
#define XOffset              0x8DA1 
#define YOffset              0x8DA2 
#define lcdTallP         0x8DA3 
#define pixWideP         0x8DA4 
#define pixWide_m_1         0x8DA5 
#define pixWide_m_2         0x8DA6 
#define lastEntryPTR         0x8DA7  //pointer to the next available byte in the entry stack
#define lastEntryStk         0x8DA9  //the start of entry stack (note last entry is not in the stack, it is in the program '#'.)  This is a stack of strings.  first 2 bytes are length, followed by string. 2nd from last entry is first in this stack.
#define numLastEntries         0x8E29  //number of entries you can back-track through minus one
#define currLastEntry         0x8E2A  //counter used by OS to keep track of which entry was just displayed by pressing 2nd+enter
#define curPlotNumber         0x8E63  //current plot being graphed (1-3), this gets reset back to 0
//something          equ 8E65h
//something          equ 8E66h
#define curInc              0x8E67 
#define uXmin              0x8E7E 
#define uXmax              0x8E87 
#define uXscl              0x8E90 
#define uYmin              0x8E99 
#define uYmax              0x8EA2 
#define uYscl              0x8EAB 
#define uThetMin         0x8EB4 
#define uThetMax         0x8EBD 
#define uThetStep         0x8EC6 
#define uTmin              0x8ECF 
#define uTmax              0x8ED8 
#define uTStep              0x8EE1 
#define uPlotStart         0x8EEA 
#define unMax              0x8EF3 
#define uu0              0x8EFC 
#define uv0              0x8F05 
#define unMin              0x8F0E 
#define uu02              0x8F17 
#define uv02              0x8F20 
#define uw0              0x8F29 
#define uPlotStep         0x8F32 
#define uXres              0x8F3B 
#define uw02              0x8F44 
#define Xmin              0x8F50 
#define Xmax              0x8F59 
#define Xscl              0x8F62 
#define Ymin              0x8F6B 
#define Ymax              0x8F74 
#define Yscl              0x8F7D 
#define ThetaMin         0x8F86 
#define ThetaMax         0x8F8F 
#define ThetaStep         0x8F98 
#define TminPar              0x8FA1 
#define TmaxPar              0x8FAA 
#define Tstep              0x8FB3 
#define PlotStart         0x8FBC 
#define nMax              0x8FC5 
#define u0              0x8FCE 
#define v0              0x8FD7 
#define nMin              0x8FE0 
#define u02              0x8FE9 
#define v02              0x8FF2 
#define w0              0x8FFB 
#define PlotStep         0x9004 
#define XresO              0x900D 
#define w02              0x9016 
#define un1              0x901F 
#define un2              0x9028 
#define vn1              0x9031 
#define vn2              0x903A 
#define wn1              0x9043 
#define wn2              0x904C 
#define fin_N              0x9055 
#define fin_I              0x905E 
#define fin_PV              0x9067 
#define fin_PMT              0x9070 
#define fin_FV              0x9079 
#define fin_PY              0x9082 
#define fin_CY              0x908B 
#define cal_N              0x9094 
#define cal_I              0x909D 
#define cal_PV              0x90A6 
#define cal_PMT              0x90AF 
#define cal_FV              0x90B8 
#define cal_PY              0x90C1 
#define smallEditRAM         0x90D3 
#define XFact              0x913F 
#define YFact              0x9148 
#define Xres_int         0x9151 
#define deltaX              0x9152 
#define deltaY              0x915B 
#define shortX              0x9164 
#define shortY              0x916D 
#define lower              0x9176 
#define upper              0x917F 
#define XOutSym              0x918C 
#define XOutDat              0x918E 
#define YOutSym              0x9190 
#define YOutDat              0x9192 
#define inputSym         0x9194 
#define inputDat         0x9196 
#define prevData         0x9198 
//something          equ 91D9h
//something          equ 91DAh
#define CurTableRow         0x91DC 
#define CurTableCol         0x91DD 
#define TblMin              0x92B3 
#define TblStep              0x92BC 
//something          equ 92C5h
//something          equ 92C6h
//somePlotThing1          equ 92D9h
//somePlotThing2          equ 92EAh
//somePlotThing3          equ 92FBh
#define ES              0x9302  //bottom of the es
#define EST              0x9305  //current height of the es
//something          equ 9311h ;this is the pointer to a table of stuff for a BASIC menu
#define plotSScreen         0x9340 
#define seed1              0x9640 
#define seed2              0x9649 
#define basic_prog         0x9652 
#define basic_start         0x965B 
#define nextParseByte         0x965D  //basic_pc
#define basic_end         0x965F 
#define numArguments         0x9661 
//something          equ 9665h ;parser-related word
//something          equ 966Ch
//something          equ 966Dh
#define cmdShadow         0x966E 
#define cmdShadCur         0x96EE 
#define cmdShadAlph         0x96F0 
#define cmdShadIns         0x96F1 
#define cmdCursor         0x96F2 
#define editTop              0x96F4 
#define editCursor         0x96F6 
#define editTail         0x96F8 
#define editBtm              0x96FA 
//something          equ 96FEh ;word, this is offset into list for currently-highlighted element in list editor
//something          equ 9700h ;table entry pointer used in dialog/menu/edit buffer routines
#define matrixDimensions    0x9702  //dimensions of matrix being edited in matrix editor
#define editSym              0x9706  //pointer to symbol table entry of variable being edited
#define editDat              0x9708  //pointer to data of variable being edited
//something          equ 970Eh ;stats/list editor related, usually 1
//something          equ 970Fh ;stats/list editor related, usually 0 (this is 0-based offset from listName1), pretty sure this is a page offset
//something          equ 9710h ;stats/list editor related, usually 0 (this is 0-based currently-selected list)
#define listName1         0x9711 
#define listName2         0x9716 
#define listName3         0x971B 
#define listName4         0x9720 
#define listName5         0x9725 
#define listName6         0x972A 
#define listName7         0x972F 
#define listName8         0x9734 
#define listName9         0x9739 
#define listName10         0x973E 
#define listName11         0x9743 
#define listName12         0x9748 
#define listName13         0x974D 
#define listName14         0x9752 
#define listName15         0x9757 
#define listName16         0x975C 
#define listName17         0x9761 
#define listName18         0x9766 
#define listName19         0x976B 
#define listName20         0x9770 
//something          equ 9775h
#define y1LineType         0x9776  //these bytes define the line type for functions which are graphed
#define y2LineType         0x9777 
#define y3LineType         0x9778 
#define y4LineType         0x9779 
#define y5LineType         0x977A 
#define y6LineType         0x977B 
#define y7LineType         0x977C 
#define y8LineType         0x977D 
#define y9LineType         0x977E 
#define y0LineType         0x977F 
#define para1LineType         0x9780 
#define para2LineType         0x9781 
#define para3LineType         0x9782 
#define para4LineType         0x9783 
#define para5LineType         0x9784 
#define para6LineType         0x9785 
#define polar1LineType         0x9786 
#define polar2LineType         0x9787 
#define polar3LineType         0x9788 
#define polar4LineType         0x9789 
#define polar5LineType         0x978A 
#define polar6LineType         0x978B 
#define secULineType         0x978C 
#define secVLineType         0x978D 
#define secWLineType         0x978E 
//something          equ 979Fh
//something          equ 97A1h
#define winTop              0x97A5 
#define winBtm              0x97A6 
#define winLeftEdge         0x97A7 
#define winLeft              0x97A8 
#define winAbove         0x97AA 
#define winRow              0x97AC 
#define winCol              0x97AE 
#define fmtDigits         0x97B0 
#define fmtString         0x97B1 
#define fmtConv              0x97F2 
#define fmtLeft              0x9804 
#define fmtIndex         0x9806 
#define fmtMatSym         0x9808 
#define fmtMatMem         0x980A 
#define EQS              0x980C 
//something          equ 980Eh
//something          equ 9810h
#define freeRAM              0x9815  //pretty sure this is the amount of RAM free, valid in Mem Mgmt/Del anyway
//something          equ 9817h
#define tSymPtr1         0x9818 
#define tSymPtr2         0x981A 
#define chkDelPtr3         0x981C 
#define chkDelPtr4         0x981E 
#define tempMem              0x9820 
#define fpBase              0x9822 
#define FPS              0x9824 
#define OPBase              0x9826 
#define OPS              0x9828 
#define pTempCnt         0x982A 
#define cleanTmp         0x982C 
#define pTemp                  0x982E  //end of symbol table
#define progPtr              0x9830 
#define newDataPtr         0x9832 
#define pagedCount         0x9834 
#define pagedPN              0x9835 
#define pagedGetPtr         0x9836 
#define pagedPutPtr         0x9838 
#define pagedBuf         0x983A 
//something          equ 984Ah ;this is the top LCD row for a menu (usually 1)
#define appErr1              0x984D 
#define appErr2              0x985A 
#define flashByte1         0x9867 
#define flashByte2         0x9868 
#define freeArcBlock         0x9869 
#define arcPage              0x986B 
#define arcPtr              0x986C 
#define appRawKeyHandle         0x9870 
#define appBackUpScreen         0x9872 
#define customHeight         0x9B72 
#define localLanguage         0x9B73 
#define hookExecTemp         0x9B75 
#define linkActivityHook    0x9B78 
#define cursorHookPtr         0x9B7C 
#define libraryHookPtr         0x9B80 
#define rawKeyHookPtr         0x9B84 
#define getKeyHookPtr         0x9B88 
#define homescreenHookPtr    0x9B8C 
#define windowHookPtr         0x9B90 
#define graphHookPtr         0x9B94 
#define yEqualsHookPtr         0x9B98 
#define fontHookPtr         0x9B9C 
#define regraphHookPtr         0x9BA0 
#define graphicsHook         0x9BA4 
#define traceHookPtr         0x9BA8 
#define parserHookPtr         0x9BAC 
#define appChangeHookPtr    0x9BB0 
#define catalog1HookPtr         0x9BB4 
#define helpHookPtr         0x9BB8 
#define cxRedispHookPtr         0x9BBC 
#define menuHookPtr         0x9BC0 
#define catalog2HookPtr         0x9BC4 
#define tokenHookPtr         0x9BC8 
#define localizeHookPtr         0x9BCC 
#define silentLinkHookPtr    0x9BD0  //restartClr?
#define USBActivityHookPtr    0x9BD4 
#define baseAppBrTab2         0x9C06  //table of base pages for apps on page >= 20h; first 20h bytes are zeroes.
#define USBcallbackPage         0x9C13 
#define USBcallbackPtr         0x9C14 
#define vendorID         0x9C16 
#define productID         0x9C18 
#define devReleaseNumber    0x9C1A 
#define oldSESpeed         0x9C21 
#define calcPeripheralState    0x9C26 
#define usb_dataWaitingCount    0x9C27 
#define basePageTable2End    0x9C6F  //this is the last page
#define port91hTemp         0x9C79 
#define usb_dataExpectCount    0x9C80 
#define offPageCallPage         0x9C83  //temporarily stores off-page page and address
#define offPageCallAddress    0x9C84 
//something          equ 9C86h ;used with SE link activity, values of 00h, 0FAh, 0FFh probably mean something
//something          equ 9C87h ;zero this to force the APPS menu to recache itself (this is always either 0, 1, or last app page, for some reason)
//something          equ 9C88h ;don't know, but it's 14 bytes and has to do with selecting stuff (if 9C87h is non-zero, this is zeroed out)
//something          equ 9C9Eh ;funky, this actually gets written to the certificate on non-83+ (11 bytes)
#define SEspeed              0x9CAE 
//something, table index     equ 9CAFh
//something          equ 9CB0h
//something          equ 9CB1h ;table
//something          equ 9CCDh
#define localTokStr         0x9D65 
#define keyForStr         0x9D76 
#define keyToStrRam         0x9D77 
#define sedMonSp         0x9D88  //small edit monitor SP
#define bpSave              0x9D8A 
#define userMem              0x9D95 
#define symTable         0x0FE66 

//System Flags
//----------------------------------------------------------------------
#define ioDelFlag         0x0 
#define inDelete           0            //1 = DELETE SCREEN 

#define trigFlags         0x0      //Trigonometry mode settings
#define trigDeg                2            //1=degrees, 0=radians

#define kbdFlags         0x0      //Keyboard scan
#define kbdSCR                3            //1=scan code ready
#define kbdKeyPress           4            //1=key has been pressed

#define doneFlags         0x0      //display "Done"
#define donePrgm           5            //1=display "Done" after prgm
//----------------------------------------------------------------------
#define editFlags         0x1 
#define editOpen           2            //1=edit buffer is open

#define ansFlags           1  
#define AnsScroll           3            //1=answer can scroll, seems must be reset in order to move about edit buffer

#define monFlags         0x1       //monitor flags
#define monAbandon           4            //1=don't start any long process in put away (#715)
//----------------------------------------------------------------------
#define plotFlags         0x2      //plot generation flags
#define plotLoc            1            //0=bkup & display, 1=display only
#define plotDisp           2            //1=plot is in display, 0=text in display, this also indicates whether graph is being shown or not

#define grfModeFlags         0x2      //graph mode settings
#define grfFuncM           4            //1=function graph
#define grfPolarM           5            //1=polar graph
#define grfParamM           6            //1=parametric graph
#define grfRecurM           7            //1=RECURSION graph
//----------------------------------------------------------------------
#define graphFlags         0x3 
#define graphDraw           0            //0=graph is valid, 1=redraw graph(dirty)
#define graphCursor           2  
//----------------------------------------------------------------------
#define grfDBFlags         0x4 
#define grfDot                0            //0=line, 1=dot
#define grfSimul           1            //0=sequential, 1=simultaneous
#define grfGrid            2            //0=no grid, 1=grid
#define grfPolar           3            //0=rectangular, 1=polar coordinates
#define grfNoCoord           4            //0=display coordinates, 1=off
#define grfNoAxis           5            //0=axis, 1=no axis
#define grfLabel           6            //0=off, 1=axis label
//----------------------------------------------------------------------
#define textFlags         0x5      //Text output flags
#define textEraseBelow           1            //1=erase line below small char
#define textScrolled           2            //1=screen scrolled
#define textInverse           3            //1=display inverse bit-map
#define textInsMode           4            //0=overstrike, 1=insert mode
//----------------------------------------------------------------------
#define ParsFlag         0x6      //PARSER flags
//----------------------------------------------------------------------
#define ParsFlag2         0x7      //PARSER flags
#define numOP1                0            //1=RESULT IN OP1, 0=NO RESULT
//----------------------------------------------------------------------
#define newDispF         0x8      //Derivative mode flags
#define preClrForMode           0            //1=HELP BLINK ON MODE SCREEN
#define allowProgTokens           1            //1=allow programming tokens to be parsed in BASIC programs

#define apdFlags         0x8      //Automatic power-down
#define apdAble            2            //1=APD enabled
#define apdRunning           3            //1=APD clock running
#define apdWarmStart           4            //1=calculator is turning on from APD or power loss
//----------------------------------------------------------------------
#define web_err_mask         0x60 
//----------------------------------------------------------------------
#define onFlags          0x9      //on key flags
#define parseInput           1            //1=parse input when done
#define onRunning           3            //1=calculator is running
#define onInterrupt           4            //1=on key interrupt request

#define statFlags         0x9      //statistics flags
//unknown          equ 5          ;unknown
#define statsValid           6            //1=stats are valid
//----------------------------------------------------------------------
#define fmtFlags         0x0A      //numeric format flags
#define fmtExponent           0             //1=show exponent, 0=no exponent
#define fmtEng                1             //1=engineering notion, 0=scientific
#define fmtHex                2             //1=hexadecimal
#define fmtOct                3             //1=octal
#define fmtBin                4             //1=binary

#define numMode              0x0A 
#define fmtReal                5  
#define fmtRect                6  
#define fmtPolar           7  

#define realMode           5  
#define rectMode           6  
#define polarMode           7  
//                         ;if Hex and Oct both = 1
//                         ; then Bin=0 means >Frac
//                         ; Bin=1 means >DMS
#define fmtBaseMask         0b00011100      // mask to base flags
#define fmtBaseShift            2            // offset to base flags
//
//       CHECK IF THESE ARE USED BY NUMFORM,
//
//                    equ  6
//                    equ  7
//----------------------------------------------------------------------
#define fmtOverride         0x0B      //copy of fmtFlags with conversion override
//----------------------------------------------------------------------
#define fmtEditFlags         0x0C      //numeric editing flags
#define fmtEdit                0            //1=format number for editing

#define curFlags         0x0C      //Cursor
#define curAble            2            //1=cursor flash is enabled
#define curOn                3            //1=cursor is showing
#define curLock            4            //1=cursor is locked off

#define cmdFlags         0x0C      //command editor flags
#define cmdVirgin           5            //1=nothing has been typed in cmd bfr
//----------------------------------------------------------------------
#define appFlags         0x0D      //application flags
#define appWantIntrpt           0            //1=want ON key interrupts
#define appTextSave           1            //1=save characters in textShadow
#define appAutoScroll           2            //1=auto-scroll text on last line
#define appMenus           3            //1=process keys that bring up menus, 0=check Lock menu flag
#define appLockMenus           4            //1=ignore menu keys, 0=switch to home screen and bring up menu
#define appCurGraphic           5            //1=graphic cursor
#define appCurWord           6            //1=text cursor covers entire word
#define appExit            7            //1=application handles [EXIT] key itself

#define appWantIntrptF           1<<appWantIntrpt  
#define appTextSaveF           1<<appTextSave  
#define appAutoScrollF           1<<appAutoScroll  
#define appMenusF           1<<appMenus  
#define appLockMenusF           1<<appLockMenus  
#define appCurGraphicF           1<<appCurGraphic  
#define appCurWordF           1<<appCurWord  
#define appExitF           1<<appExit  
//----------------------------------------------------------------------
#define rclFlag              0x0E      //OS recall queue flags
#define enableQueue           7            //1 = enable recall queue
//----------------------------------------------------------------------
#define seqFlags         0x0F      //Sequential Graph flags
#define webMode                0            //0 = NORMAL SEQ MODE, 1 = WEB MODE
#define webVert                1  
#define sequv                2            //U vs V
#define seqvw                3            //V vs W
#define sequw                4            //U vs W
//----------------------------------------------------------------------
#define promptFlags         0x11      //prompt line flags
#define promptEdit           0            //1=editing in prompt buffer
//----------------------------------------------------------------------
#define indicFlags         0x12      //Indicator flags
#define indicRun           0            //1=run indicator ON
#define indicInUse           1            //indicator save area in use=1, free=0 ;resetting will disable 2nd while in _getkey
#define indicOnly           2            //interrupt handler only checks run indicator

#define shiftFlags         0x12      //[2nd] and [ALPHA] flags
#define shift2nd           3            //1=[2nd] has been pressed
#define shiftAlpha           4            //1=[ALPHA] has been pressed
#define shiftLwrAlph           5            //1=lower case, 0=upper case
#define shiftALock           6            //1=alpha lock has been pressed
#define shiftKeepAlph           7            //1=cannot cancel alpha shift
//----------------------------------------------------------------------
#define tblFlags         0x13      //table flags.
#define autoFill           4            //1=prompt, 0=fillAuto
#define autoCalc           5            //1=prompt, 0=CalcAuto
#define reTable                6            //0=table is okay, 1=must recompute table.
//----------------------------------------------------------------------
#define sGrFlags         0x14 
#define grfSplit           0            //1=Split Graph, 0=Normal
#define vertSplit           1            //1=Vertical (left-right) Split
#define grfSChanged           2            //1=Graph just changed Split <-> normal
#define grfSplitOverride      3            //1 = ignore graph split flag if set
#define write_on_graph           4            //1 = TEXT OR EQU WRITING TO GRAPH SCREEN
#define g_style_active           5            //1 = GRAPH STYLES ARE ENABLED, USE THEM
#define cmp_mod_box           6            //1 = DOING MOD BOX PLOT COMPUTATION
#define textWrite           7  
//----------------------------------------------------------------------
#define newIndicFlags         0x15 
#define extraIndic           0  
#define saIndic                1  
//3 has something to do with stat/list editor
//----------------------------------------------------------------------
#define interruptFlags         0x16 
#define secondTimerEnabled      0            //1 = second hardware timer enabled
#define batteryFlags         0x16 
#define batteriesGood           2            //1 = batteries good, I think this being reset will force the calc to shut off, used in USB error handler
//----------------------------------------------------------------------
#define smartFlags         0x17 
#define smarter_mask           3  
#define smarter_test           1  
#define smartGraph           0  
#define smartGraph_inv           1  
//----------------------------------------------------------------------
#define traceFlags         0x18 
#define grfExpr                0            //set to hide expression while tracing
//----------------------------------------------------------------------
//There is a flag 19h.
//----------------------------------------------------------------------
#define statFlags2         0x1A 
#define statDiagnosticsOn      0            //1 = stat diagnostics on
//----------------------------------------------------------------------
#define linkFlags         0x1B 
#define IDis95h                1            //1 = link routines use machine ID 95h (CBL)
#define IDis82h                2            //1 = link routines use machine ID 82h (TI-82)
#define IDis83h                3            //1 = link routines use machine ID 83h (TI-83)
#define IDis03h                4            //1 = link routines use machine ID 03h (PC to TI-83)
#define USBenabled           5            //1 = use USB port first, or at least try to
//----------------------------------------------------------------------
//There is a flag 1Ch (stats-related).
//----------------------------------------------------------------------
//There is a flag 1Dh.
//----------------------------------------------------------------------
//There is a flag 1Eh.
//----------------------------------------------------------------------
#define varTypeMask         0x1F      //is this a flag byte? yes
#define varGraphRef           6  
//----------------------------------------------------------------------
#define graphFlags2         0x1F 
#define splitOverride           3            //0 = force full screen with ParseInp, or something
//----------------------------------------------------------------------
#define asm_Flag1         0x21      //ASM CODING
#define asm_Flag2         0x22      //ASM CODING
#define asm_Flag3         0x23      //ASM CODING
//----------------------------------------------------------------------
#define arcFlag              0x24 
#define checkBatteryLevelFirst      0            //1 = check battery levels in Arc_Unarc first and throw error if low

#define getSendFlg         0x24 
#define comFailed           1            //1 = Get/Send Communication Failed

#define selfTestFlag         0x24 
#define resetOnPowerOn           2            //1 = Force RAM reset when APD disabled on next power on

#define appLwrCaseFlag         0x24 
#define lwrCaseActive           3  
//----------------------------------------------------------------------
#define contextFlags         0x25 
#define nocxPutAway           5            //1 = do not call cxPutAway routine
//----------------------------------------------------------------------
#define groupFlags         0x26  //used temporarily in Arc_Unarc
#define inGroup                1            //1 = IN GROUP CONTEXT
#define noCompletionByte      2            //1 = do not write 0FCh when calling Arc_Unarc, leave as 0FEh
#define noDataWrite           3            //1 = do not write data when calling Arc_Unarc, nor size bytes
#define writeSizeBytesOnly      5            //1 = only write size bytes when calling Arc_Unarc
//----------------------------------------------------------------------
//There is a flag 27h.
//----------------------------------------------------------------------
#define APIFlg              0x28 
#define appAllowContext           0             //App wants context changes to happen
//1 set to ignore a key after returning from rawkeyhook
//2 set to send this key back?
//3
#define appRunning           4            //app is currently running
//5
//6
#define appRetKeyOff           7            //1 = GetKey returns kOff when [2nd]+[ON] pressed
//----------------------------------------------------------------------
#define apiFlg2              0x29 
//----------------------------------------------------------------------
#define apiFlg3              0x2A 
//1 set means using small font?
//----------------------------------------------------------------------
#define apiFlg4              0x2B 
#define cellOverride           1            //use cell override
#define fullScrnDraw           2            //DRAW INTO LAST ROW/COL OF SCREEN
//----------------------------------------------------------------------
#define mouseFlag1         0x2C 
//----------------------------------------------------------------------
#define mouseFlag2         0x2D  //might want to keep this always reset
//----------------------------------------------------------------------
#define xapFlag0         0x2E      //external app flags, do not use 0,(iy+2Eh) (used by mouse routines)
#define xapFlag1         0x2F 
#define xapFlag2         0x30 
#define xapFlag3         0x31 
//----------------------------------------------------------------------
#define fontFlags         0x32 
#define fracDrawLFont           2  
#define fracTallLFont           3  
#define customFont           7  
//----------------------------------------------------------------------
#define hookflags1         0x33  //also scriptFlag, rclFlag2, backGroundLink
#define alt_On                0            //run ONSCRPT at startup
#define alt_Off                1            //run OFFSCRPT at shutdown
#define useRclQueueEnd           2            //1 = external mode
#define ignoreBPLink           3            //1 = override flag for link activity hook
#define bPLinkOn           4            //1 = link activity hook active
#define enableKeyEcho           5            //1 = sends keypresses back to connected calc as remote control packets (with GetCSC vs. GetKey codes...really dumb, TI)
#define noTempDelete           6            //1 = do not delete temporary programs at homescreen
//----------------------------------------------------------------------
#define hookflags2         0x34  //also sysHookFlg
#define getCSCHookActive      0            //1 = GetCSC hook active
#define libraryHookActive      1            //1 = library hook active
//2 This is set in the OS, but never referenced and the code is never executed
#define homescreenHookActive      4            //1 = homescreen hook active
#define rawKeyHookActive      5            //1 = raw key hook active
#define catalog2HookActive      6            //1 = catalog 2 hook active
#define cursorHookActive      7            //1 = cursor hook active
//----------------------------------------------------------------------
#define hookflags3         0x35  //also sysHookFlg1
#define tokenHookActive           0            //1 = token hook active
#define localizeHookActive      1            //1 = localize hook active
#define windowHookActive      2            //1 = window hook active
#define graphHookActive           3            //1 = graph hook active
#define yEquHookActive           4            //1 = Y= hook active
#define fontHookActive           5            //1 = font hook active
#define regraphHookActive      6            //1 = regraph hook active
#define drawingHookActive      7            //1 = drawing hook active
//----------------------------------------------------------------------
#define hookflags4         0x36  //also sysHookFlag2
#define traceHookActive           0            //1 = trace hook active
#define parserHookActive      1            //1 = parser hook active
#define appChangeHookActive      2            //1 = app change hook active
#define catalog1HookActive      3            //1 = catalog 1 hook active
#define helpHookActive           4            //1 = help hook active
#define cxRedispHookActive      5            //1 = cxRedisp hook active
#define menuHookActive           6            //1 = menu hook active
#define silentLinkHookActive      7            //1 = silent link hook active
//----------------------------------------------------------------------
//hookflags2Override     equ 37h          ;set corresponding bit to kill iy+35h hook when executing app
//----------------------------------------------------------------------
//hookflags3Override     equ 38h          ;set corresponding bit to kill iy+36h hook when executing app
//----------------------------------------------------------------------
//hookflags4Override     equ 39h          ;set corresponding bit to kill iy+37h hook when executing app
//----------------------------------------------------------------------
//hookflags5          equ 3Ah
#define usbActivityHookActive      0            //1 = USB activity hook active
//----------------------------------------------------------------------
#define plotFlag3         0x3C   
#define bufferOnly           0  
#define useFastCirc           4  
//----------------------------------------------------------------------
#define dBKeyFlags         0x3D 
#define keyDefaultsF           6            //1 = GetKey returns extended keycodes with TI-Keyboard
//----------------------------------------------------------------------
#define silentLinkFlags         0x3E 
#define silentLinkActive      0            //1 = SE/84+ silent link is active

#define extraHookFlags         0x3E 
#define checkCatalog2HookVer      3            //1 = check catalog 2 hook's version before executing it (and error or take other action if so)
#define openLibActive           4            //1 = OpenLib( was successfully called on a Flash application (ExecLib will error if zero)
//5
//----------------------------------------------------------------------
#define clockFlags         0x3F 
#define notMDYMode           0            //0 = M/D/Y format
#define isYMDMode           1            //1 = Y/M/D format
#define is24Hour           2            //1 = clock in 24 hour mode
#define inAfternoon           3            //1 = current time is in afternoon (PM) (I think)
#define useTokensInString      4            //1 = use tokens instead of characters when displaying clock as string (for getTmStr and getDtStr vs. MODE screen) (keep this reset)
#define displayClock           5            //1 = display clock (this is set every second, reset otherwise)
#define clockOn                6            //1 = clock on
//----------------------------------------------------------------------
#define USBFlag1         0x40 
//1 Reset in I/O receiving code, doesn't seem to be used anywhere else
#define usbReceiveZone1           2            //1 = receive to RAM pages 3/2 ("zone 1")
//----------------------------------------------------------------------
#define USBFlag2         0x41 
//0
//2
#define noUSBHostInit           3            //1 = _InitSpecificUSBDevice must fail
#define usbDataWaiting           5  
//6
//7
//----------------------------------------------------------------------
#define USBFlag3         0x42 
//----------------------------------------------------------------------
#define USBFlag4         0x43 
#define usbTimeoutError           0            //1 = USB timeout error (crystal timer expired)
//----------------------------------------------------------------------

//Character Font Equates  
//-------------------------------
#define LrecurN              0x001 
#define LrecurU              0x002 
#define LrecurV              0x003 
#define LrecurW              0x004 
#define Lconvert         0x005 
#define LsqUp              0x006 
#define LsqDown              0x007 
#define Lintegral         0x008 
#define Lcross              0x009 
#define LboxIcon          0x00A 
#define LcrossIcon          0x00B 
#define LdotIcon          0x00C 
#define LsubT            0x00D  //small capital T for parametric mode.
#define LcubeR           0x00E  //slightly different 3 for cubed root.
#define LhexF              0x00F 
#define Lroot              0x010 
#define Linverse         0x011 
#define Lsquare              0x012 
#define Langle              0x013 
#define Ldegree              0x014 
#define Lradian              0x015 
#define Ltranspose         0x016 
#define LLE              0x017 
#define LNE              0x018 
#define LGE              0x019 
#define Lneg              0x01A 
#define Lexponent         0x01B 
#define Lstore              0x01C 
#define Lten              0x01D 
#define LupArrow         0x01E 
#define LdownArrow         0x01F 
#define Lspace              0x020 
#define Lexclam              0x021 
#define Lquote              0x022 
#define Lpound              0x023 
#define Lfourth              0x024 
#define Lpercent         0x025 
#define Lampersand         0x026 
#define Lapostrophe         0x027 
#define LlParen              0x028 
#define LrParen              0x029 
#define Lasterisk         0x02A 
#define LplusSign         0x02B 
#define Lcomma              0x02C 
#define Ldash              0x02D 
#define Lperiod              0x02E 
#define Lslash              0x02F 
#define L0              0x030 
#define L1              0x031 
#define L2              0x032 
#define L3              0x033 
#define L4              0x034 
#define L5              0x035 
#define L6              0x036 
#define L7              0x037 
#define L8              0x038 
#define L9              0x039 
#define Lcolon              0x03A 
#define Lsemicolon         0x03B 
#define LLT              0x03C 
#define LEQ              0x03D 
#define LGT              0x03E 
#define Lquestion         0x03F 
#define LatSign              0x040 
#define LcapA              0x041 
#define LcapB              0x042 
#define LcapC              0x043 
#define LcapD              0x044 
#define LcapE              0x045 
#define LcapF              0x046 
#define LcapG              0x047 
#define LcapH              0x048 
#define LcapI              0x049 
#define LcapJ              0x04A 
#define LcapK              0x04B 
#define LcapL              0x04C 
#define LcapM              0x04D 
#define LcapN              0x04E 
#define LcapO              0x04F 
#define LcapP              0x050 
#define LcapQ              0x051 
#define LcapR              0x052 
#define LcapS              0x053 
#define LcapT              0x054 
#define LcapU              0x055 
#define LcapV              0x056 
#define LcapW              0x057 
#define LcapX              0x058 
#define LcapY              0x059 
#define LcapZ              0x05A 
#define Ltheta              0x05B 
#define Lbackslash         0x05C 
#define LrBrack              0x05D 
#define Lcaret              0x05E 
#define Lunderscore         0x05F 
#define Lbackquote         0x060 
#define La              0x061 
#define Lb              0x062 
#define Lc              0x063 
#define Ld              0x064 
#define Le              0x065 
#define Lf              0x066 
#define Lg              0x067 
#define Lh              0x068 
#define Li              0x069 
#define Lj              0x06A 
#define Lk              0x06B 
#define Ll              0x06C 
#define Lm              0x06D 
#define Ln              0x06E 
#define Lo              0x06F 
#define Lp              0x070 
#define Lq              0x071 
#define Lr              0x072 
#define Ls              0x073 
#define Lt              0x074 
#define Lu              0x075 
#define Lv              0x076 
#define Lw              0x077 
#define Lx              0x078 
#define Ly              0x079 
#define Lz              0x07A 
#define LlBrace              0x07B 
#define Lbar              0x07C 
#define LrBrace              0x07D 
#define Ltilde              0x07E 
#define LinvEQ              0x07F 
#define Lsub0              0x080 
#define Lsub1              0x081 
#define Lsub2              0x082 
#define Lsub3              0x083 
#define Lsub4              0x084 
#define Lsub5              0x085 
#define Lsub6              0x086 
#define Lsub7              0x087 
#define Lsub8              0x088 
#define Lsub9              0x089 
#define LcapAAcute         0x08A 
#define LcapAGrave         0x08B 
#define LcapACaret         0x08C 
#define LcapADier         0x08D 
#define LaAcute              0x08E 
#define LaGrave              0x08F 
#define LaCaret              0x090 
#define LaDier              0x091 
#define LcapEAcute         0x092 
#define LcapEGrave         0x093 
#define LcapECaret         0x094 
#define LcapEDier         0x095 
#define LeAcute              0x096 
#define LeGrave              0x097 
#define LeCaret              0x098 
#define LeDier              0x099 
#define LcapIAcute         0x09A 
#define LcapIGrave         0x09B 
#define LcapICaret         0x09C 
#define LcapIDier         0x09D 
#define LiAcute              0x09E 
#define LiGrave              0x09F 
#define LiCaret              0x0A0 
#define LiDier              0x0A1 
#define LcapOAcute         0x0A2 
#define LcapOGrave         0x0A3 
#define LcapOCaret         0x0A4 
#define LcapODier         0x0A5 
#define LoAcute              0x0A6 
#define LoGrave              0x0A7 
#define LoCaret              0x0A8 
#define LoDier              0x0A9 
#define LcapUAcute         0x0AA 
#define LcapUGrave         0x0AB 
#define LcapUCaret         0x0AC 
#define LcapUDier         0x0AD 
#define LuAcute              0x0AE 
#define LuGrave              0x0AF 
#define LuCaret              0x0B0 
#define LuDier              0x0B1 
#define LcapCCed         0x0B2 
#define LcCed              0x0B3 
#define LcapNTilde         0x0B4 
#define LnTilde              0x0B5 
#define Laccent              0x0B6 
#define Lgrave              0x0B7 
#define Ldieresis         0x0B8 
#define LquesDown         0x0B9 
#define LexclamDown         0x0BA 
#define Lalpha              0x0BB 
#define Lbeta              0x0BC 
#define Lgamma              0x0BD 
#define LcapDelta         0x0BE 
#define Ldelta              0x0BF 
#define Lepsilon         0x0C0 
#define LlBrack          0x0C1 
#define Llambda              0x0C2 
#define Lmu              0x0C3 
#define Lpi              0x0C4 
#define Lrho              0x0C5 
#define LcapSigma         0x0C6 
#define Lsigma              0x0C7 
#define Ltau              0x0C8 
#define Lphi              0x0C9 
#define LcapOmega         0x0CA 
#define LxMean              0x0CB 
#define LyMean              0x0CC 
#define LsupX              0x0CD 
#define Lellipsis         0x0CE 
#define Lleft              0x0CF 
#define Lblock              0x0D0 
#define Lper              0x0D1 
#define Lhyphen              0x0D2 
#define Larea              0x0D3 
#define Ltemp              0x0D4 
#define Lcube              0x0D5 
#define Lenter              0x0D6 
#define LimagI              0x0D7 
#define Lphat              0x0D8 
#define Lchi              0x0D9 
#define LstatF              0x0DA 
#define Llne              0x0DB 
#define LlistL              0x0DC 
#define LfinanN          0x0DD 
#define L2_r_paren          0x0DE 
#define LblockArrow         0x0DF 
#define LcurO            0x0E0 
#define LcurO2           0x0E1 
#define LcurOcapA           0x0E2 
#define LcurOa           0x0E3 
#define LcurI            0x0E4 
#define LcurI2           0x0E5 
#define LcurIcapA           0x0E6 
#define LcurIa           0x0E7 
#define LGline              0x0E8  // = 0
#define LGthick             0x0E9  // = 1
#define LGabove              0x0EA  // = 2
#define LGbelow              0x0EB  // = 3
#define LGpath              0x0EC  // = 4
#define LGanimate         0x0ED  // = 5
#define LGdot              0x0EE  // = 6
#define LUpBlk              0x0EF  //Up arrow and Block in solver
#define LDnBlk              0x0F0  //Down arrow and Block in solver
#define LcurFull         0x0F1  //note: must be last char (PutMap checks)

//(MenuCurrent) Values
//--------------------------
#define mConfirmation         0x01 
#define mApps              0x02 
#define mProgramHome         0x03 
#define mPrgm_Run         0x00 
#define mPrgm_Edit         0x01 
#define mPrgm_New         0x02 
#define mZoom              0x04 
#define mZoom_Zoom         0x00 
#define mZoom_Memory         0x01 
#define mDraw              0x05 
#define mDraw_Draw         0x00 
#define mDraw_Points         0x01 
#define mDraw_Store         0x02 
#define mStatPlots         0x06 
#define mStat              0x07 
#define mStat_Edit         0x00 
#define mStat_Calc         0x01 
#define mStat_Tests         0x02 
#define mMath              0x08 
#define mMath_Math         0x00 
#define mMath_Number         0x01 
#define mMath_Complex         0x02 
#define mMath_Prob         0x03 
#define mTest              0x09 
#define mTest_Test         0x00 
#define mTest_Logic         0x01 
#define mVars              0x0A 
#define mVars_Vars         0x00 
#define mVars_YVars         0x01 
#define mMemory              0x0C 
#define mMatrix              0x0D 
#define mMatrix_Name         0x00 
#define mMatrix_Math         0x01 
#define mMatrix_Edit         0x02 
#define mDistr              0x0E 
#define mDistr_Distr         0x00 
#define mDistr_Draw         0x01 
#define mAngle              0x0F 
#define mList              0x10 
#define mList_Names         0x00 
#define mList_Ops         0x01 
#define mList_Math         0x02 
#define mCalculate         0x11 
#define mVarsWin         0x14 
#define mVarsWin_XY         0x00 
#define mVarsWin_TTh         0x01 
#define mVarsWin_UVW         0x02 
#define mVarsZoom         0x15 
#define mVarsZoom_ZXY         0x00 
#define mVarsZoom_ZT         0x01 
#define mVarsZoom_UVW         0x02 
#define mVarsGDB         0x16 
#define mVarsPics         0x17 
#define mVarsStrings         0x18 
#define mVarsStat         0x19 
#define mVarsStat_XY         0x00 
#define mVarsStat_Sigma         0x01 
#define mVarsStat_EQ         0x02 
#define mVarsStat_Test         0x03 
#define mVarsStat_Pts         0x04 
#define mVarsTable         0x1A 
#define mVarsYEqu         0x1B 
#define mVarsParametric         0x1C 
#define mVarsPolar         0x1D 
#define mVarsFnOnOff         0x1E 
#define mMemReset         0x1F 
#define mMemReset_RAM         0x00 
#define mMemReset_ROM         0x01 
#define mMemReset_All         0x02 
#define mMemMgmtDel         0x20 
#define mMemResetDefaults    0x21 
#define mMemResetRAMAll         0x23 
#define mMemResetROMVars    0x24 
#define mMemResetROMApps    0x25 
#define mMemResetROMAll         0x26 
#define mMemResetAll         0x27 
#define mGroup              0x28 
#define mGroup_New         0x00 
#define mGroup_Ungroup         0x01 
#define mGroupVars         0x29 
#define mProgramEdit         0x2A 
#define mPrgmEd_Ctrl         0x00 
#define mPrgmEd_IO         0x01 
#define mPrgmEd_Exec         0x02 
#define mPrgmZoom         0x2B 
#define mPrgmZoom_Zoom         0x00 
#define mPrgmZoom_Mem         0x01 
#define mPrgmDraw         0x2C 
#define mPrgmDraw_Draw         0x00 
#define mPrgmDraw_Pt         0x01 
#define mPrgmDraw_Store         0x02 
#define mPrgmStatPlot         0x2D 
#define mPrgmSP_Plots         0x00 
#define mPrgmSP_Type         0x01 
#define mPrgmSP_Mark         0x02 
#define mPrgmStat         0x2E 
#define mPrgmStat_Edit         0x00 
#define mPrgmStat_Calc         0x01 
#define mPrgmStat_Tests         0x02 
#define mPrgmMath         0x2F 
#define mPrgmMath_Math         0x00 
#define mPrgmMath_Num         0x01 
#define mPrgmMath_Cplx         0x02 
#define mPrgmMath_Prob         0x03 
#define mLink              0x30 
#define mLink_Send         0x00 
#define mLink_Recieve         0x01 
#define mLinkTrasmit         0x31 
#define mLinkXmit_Xmit         0x01 
#define mGarbageCollect         0x3F 
#define mSelectGroupVars    0x40 
#define mSelGrpVars_Sel         0x00 
#define mSelGrpVars_Grp         0x01 
#define mDuplicateName         0x42 
#define mCatalog         0x45 
#define mFinance         0x22 
#define mFinance_Calc         0x00 
#define mFinance_Vars         0x01 

//Keypress Equates
//-------------------------------
#define kRight              0x001 
#define kLeft              0x002 
#define kUp              0x003 
#define kDown              0x004 
#define kEnter              0x005 
#define kAlphaEnter         0x006 
#define kAlphaUp         0x007 
#define kAlphaDown         0x008 
#define kClear              0x009 
#define kDel              0x00A 
#define kIns              0x00B 
#define kRecall              0x00C 
#define kLastEnt         0x00D 
#define kBOL              0x00E 
#define kEOL              0x00F 

#define kSelAll              0x010 
#define kUnselAll         0x011 
#define kLtoTI82         0x012 
#define kBackup              0x013 
#define kRecieve         0x014 
#define kLnkQuit         0x015 
#define kTrans              0x016 
#define kRename              0x017 
#define kOverw              0x018 
#define kOmit              0x019 
#define kCont              0x01A 
#define kSendID              0x01B 
#define kSendSW              0x01C 
#define kYes              0x01D 
#define kNoWay              0x01E 
#define kvSendType         0x01F 
#define kOverWAll         0x020 
#define kNo              0x025 
#define kKReset              0x026 
#define kApp              0x027 
#define kDoug              0x028 
#define kListflag         0x029 
#define menuStart         0x02B 
#define kAreYouSure         0x02B 
#define kAppsMenu         0x02C 
#define kPrgm              0x02D 
#define kZoom              0x02E 
#define kDraw              0x02F 
#define kSPlot              0x030 
#define kStat              0x031 
#define kMath              0x032 
#define kTest              0x033 
#define kChar              0x034 
#define kVars              0x035 
#define kMem              0x036 
#define kMatrix              0x037 
#define kDist              0x038 
#define kAngle              0x039 
#define kList              0x03A 
#define kCalc              0x03B 
#define kFin              0x03C 
#define menuEnd                kFin  
#define kCatalog         0x03E 
#define kInputDone         0x03F 
#define kOff                kInputDone  
#define kQuit              0x040 
#define appStart           kQuit  
#define kLinkIO              0x041 
#define kMatrixEd         0x042 
#define kStatEd              0x043 
#define kGraph              0x044 
#define kMode              0x045 
#define kPrgmEd              0x046  //PROGRAM EDIT
#define kPrgmCr              0x047  //PROGRAM CREATE
#define kWindow              0x048  //RANGE EDITOR
#define kYequ              0x049  //EQUATION EDITOR
#define kTable              0x04A  //TABLE EDITOR
#define kTblSet              0x04B  //TABLE SET
#define kChkRAM              0x04C  //CHECK RAM (About screen)
#define kDelMem              0x04D  //DELETE MEM
#define kResetMem         0x04E  //RESET MEM
#define kResetDef         0x04F  //RESET DEFAULT
#define kPrgmInput         0x050  //PROGRAM INPUT
#define kZFactEd         0x051  //ZOOM FACTOR EDITOR
#define kError              0x052  //ERROR
#define kSolveTVM         0x053  //TVM SOLVER
#define kSolveRoot         0x054  //SOLVE EDITOR
#define kStatP              0x055  //stat plot
#define kInfStat         0x056  //Inferential Statistic
#define kFormat              0x057  //FORMAT
#define kExtApps         0x058  //External Applications.     NEW
#define kNewApps         0x059  //New Apps for Cerberus.
#define append                kNewApps  
#define echoStart1         0x05A 
#define kTrace              0x05A 
#define kZFit              0x05B 
#define kZIn              0x05C 
#define kZOut              0x05D 
#define kZPrev              0x05E 
#define kBox              0x05F 
#define kDecml              0x060 
#define kSetZm              0x061 
#define kSquar              0x062 
#define kStd              0x063 
#define kTrig              0x064 
#define kUsrZm              0x065 
#define kZSto              0x066 
#define kZInt              0x067 
#define kZStat              0x068 
#define echoStart2         0x069 
#define kSelect              0x069 
#define kCircl              0x06A 
#define kClDrw              0x06B 
#define kLine              0x06C 
#define kPen              0x06D 
#define kPtChg              0x06E 
#define kPtOff              0x06F 
#define kPtOn              0x070 
#define kVert              0x071 
#define kHoriz              0x072 
#define kText              0x073 
#define kTanLn              0x074 
#define kEval              0x075 
#define kInters              0x076 
#define kDYDX              0x077 
#define kFnIntg              0x078 
#define kRootG              0x079 
#define kDYDT              0x07A 
#define kDXDT              0x07B 
#define kDRDo              0x07C 
#define KGFMin              0x07D 
#define KGFMax              0x07E 
#define EchoStart         0x07F 
#define kListName         0x07F 
#define kAdd              0x080 
#define kSub              0x081 
#define kMul              0x082 
#define kDiv              0x083 
#define kExpon              0x084 
#define kLParen              0x085 
#define kRParen              0x086 
#define kLBrack              0x087 
#define kRBrack              0x088 
#define kShade              0x089 
#define kStore              0x08A 
#define kComma              0x08B 
#define kChs              0x08C 
#define kDecPnt              0x08D 
#define k0              0x08E 
#define k1              0x08F 
#define k2              0x090 
#define k3              0x091 
#define k4              0x092 
#define k5              0x093 
#define k6              0x094 
#define k7              0x095 
#define k8              0x096 
#define k9              0x097 
#define kEE              0x098 
#define kSpace              0x099 
#define kCapA              0x09A 
#define kCapB              0x09B 
#define kCapC              0x09C 
#define kCapD              0x09D 
#define kCapE              0x09E 
#define kCapF              0x09F 
#define kCapG              0x0A0 
#define kCapH              0x0A1 
#define kCapI              0x0A2 
#define kCapJ              0x0A3 
#define kCapK              0x0A4 
#define kCapL              0x0A5 
#define kCapM              0x0A6 
#define kCapN              0x0A7 
#define kCapO              0x0A8 
#define kCapP              0x0A9 
#define kCapQ              0x0AA 
#define kCapR              0x0AB 
#define kCapS              0x0AC 
#define kCapT              0x0AD 
#define kCapU              0x0AE 
#define kCapV              0x0AF 
#define kCapW              0x0B0 
#define kCapX              0x0B1 
#define kCapY              0x0B2 
#define kCapZ              0x0B3 
#define kVarx              0x0B4 
#define kPi              0x0B5 
#define kInv              0x0B6 
#define kSin              0x0B7 
#define kASin              0x0B8 
#define kCos              0x0B9 
#define kACos              0x0BA 
#define kTan              0x0BB 
#define kATan              0x0BC 
#define kSquare              0x0BD 
#define kSqrt              0x0BE 
#define kLn              0x0BF 
#define kExp              0x0C0 
#define kLog              0x0C1 
#define kALog              0x0C2 
#define kToABC              0x0C3 
#define kClrTbl              0x0C4 
#define kAns              0x0C5 
#define kColon              0x0C6 
#define kNDeriv              0x0C7 
#define kFnInt              0x0C8 
#define kRoot              0x0C9 
#define kQuest              0x0CA 
#define kQuote              0x0CB 
#define kTheta              0x0CC 
#define kIf              0x0CD 
#define kThen              0x0CE 
#define kElse              0x0CF 
#define kFor              0x0D0 
#define kWhile              0x0D1 
#define kRepeat              0x0D2 
#define kEnd              0x0D3 
#define kPause              0x0D4 
#define kLbl              0x0D5 
#define kGoto              0x0D6 
#define kISG              0x0D7 
#define kDSL              0x0D8 
#define kMenu              0x0D9 
#define kExec              0x0DA 
#define kReturn              0x0DB 
#define kStop              0x0DC 
#define kInput              0x0DD 
#define kPrompt              0x0DE 
#define kDisp              0x0DF 
#define kDispG              0x0E0 
#define kDispT              0x0E1 
#define kOutput              0x0E2 
#define kGetKey              0x0E3 
#define kClrHome         0x0E4 
#define kPrtScr              0x0E5 
#define kSinH              0x0E6 
#define kCosH              0x0E7 
#define kTanH              0x0E8 
#define kASinH              0x0E9 
#define kACosH              0x0EA 
#define kATanH              0x0EB 
#define kLBrace              0x0EC 
#define kRBrace              0x0ED 
#define kI              0x0EE 
#define kCONSTeA         0x0EF 
#define kPlot3              0x0F0 
#define kFMin              0x0F1 
#define kFMax              0x0F2 
#define kL1A              0x0F3 
#define kL2A              0x0F4 
#define kL3A              0x0F5 
#define kL4A              0x0F6 
#define kL5A              0x0F7 
#define kL6A              0x0F8 
#define kunA              0x0F9 
#define kvnA              0x0FA 
#define kwnA              0x0FB 

//THIS KEY MEANS THAT IT IS A 2 BYTE KEYCODE
//THERE ARE 2 OF THESE KEYS; BE CAREFUL WITH USAGE
//------------------------------------------------
#define kExtendEcho2         0x0FC 

//THIS KEY MEANS THAT THE KEY PRESS IS ONE THAT ECHOS
//INTO A BUFFER, AND IT IS A 2 BYTE KEY CODE, GO LOOK AT
//(EXTECHO) FOR THE KEY VALUE 
//------------------------------------------------------
#define kExtendEcho         0x0FE 

#define kE1BT                0  
#define kDrawInv           kE1BT  
#define kDrawF                kE1BT+1  
#define kPixelOn           kE1BT+2  
#define kPixelOff           kE1BT+3  
#define kPxlTest           kE1BT+4  
#define kRCGDB                kE1BT+5  
#define kRCPic                kE1BT+6  
#define kSTGDB                kE1BT+7  
#define kSTPic                kE1BT+8  
#define kAbs                kE1BT+9  
#define kTEqu                kE1BT+10   //==
#define kTNoteQ                kE1BT+11   //<>
#define kTGT                kE1BT+12   //>
#define kTGTE                kE1BT+13   //>=
#define kTLT                kE1BT+14   //<
#define kTLTE                kE1BT+15   //<=
#define kAnd                kE1BT+16  
#define kOr                kE1BT+17  
#define kXor                kE1BT+18  
#define kNot                kE1BT+19  
#define kLR1                kE1BT+20  
#define kXRoot                kE1BT+21  
#define kCube                kE1BT+22  
#define kCbRt                kE1BT+23   //Cube ROOT
#define kToDec                kE1BT+24  
#define kCubicR                kE1BT+25  
#define kQuartR                kE1BT+26  
#define kPlot1                kE1BT+27  
#define kPlot2                kE1BT+28  
#define kRound                kE1BT+29  
#define kIPart                kE1BT+30  
#define kFPart                kE1BT+31  
#define kInt                kE1BT+32  
#define kRand                kE1BT+33  
#define kNPR                kE1BT+34  
#define kNCR                kE1BT+35  
#define kXFactorial           kE1BT+36  
#define kRad                kE1BT+37  
#define kDegr                kE1BT+38   //DEGREES CONV
#define kAPost                kE1BT+39  
#define kToDMS                kE1BT+40  
#define kRToPo                kE1BT+41   //R
#define kRToPr                kE1BT+42  
#define kPToRx                kE1BT+43  
#define kPToRy                kE1BT+44  
#define kRowSwap           kE1BT+45  
#define kRowPlus           kE1BT+46  
#define kTimRow                kE1BT+47  
#define kTRowP                kE1BT+48  
#define kSortA                kE1BT+49  
#define kSortD                kE1BT+50  
#define kSeq                kE1BT+51  
#define kMin                kE1BT+52  
#define kMax                kE1BT+53  
#define kMean                kE1BT+54  
#define kMedian                kE1BT+55  
#define kSum                kE1BT+56  
#define kProd                kE1BT+57  
#define kDet                kE1BT+58  
#define kTransp                kE1BT+59  
#define kDim                kE1BT+60  
#define kFill                kE1BT+61  
#define kIdent                kE1BT+62  
#define kRandm                kE1BT+63  
#define kAug                kE1BT+64  
#define kOneVar                kE1BT+65  
#define kTwoVar                kE1BT+66  
#define kLR                kE1BT+67  
#define kLRExp                kE1BT+68  
#define kLRLn                kE1BT+69  
#define kLRPwr                kE1BT+70  
#define kMedMed                kE1BT+71  
#define kQuad                kE1BT+72  
#define kClrLst                kE1BT+73  
#define kHist                kE1BT+74  
#define kxyLine                kE1BT+75  
#define kScatter           kE1BT+76  
#define kmRad                kE1BT+77  
#define kmDeg                kE1BT+78  
#define kmNormF                kE1BT+79  
#define kmSci                kE1BT+80  
#define kmEng                kE1BT+81  
#define kmFloat                kE1BT+82  
#define kFix                kE1BT+83  
#define kSplitOn           kE1BT+84  
#define kFullScreen           kE1BT+85  
#define kStndrd                kE1BT+86  
#define kParam                kE1BT+87  
#define kPolar                kE1BT+88  
#define kSeqG                kE1BT+89  
#define kAFillOn           kE1BT+90  
#define kAFillOff           kE1BT+91  
#define kACalcOn           kE1BT+92  
#define kACalcOff           kE1BT+93  
#define kFNOn                kE1BT+94  
#define kFNOff                kE1BT+95  
#define kPlotsOn           kE1BT+96  
#define kPlotsOff           kE1BT+97  
#define kPixelChg           kE1BT+98  
#define kSendMBL           kE1BT+99  
#define kRecvMBL           kE1BT+100  
#define kBoxPlot           kE1BT+101  
#define kBoxIcon           kE1BT+102  
#define kCrossIcon           kE1BT+103  
#define kDotIcon           kE1BT+104  
#define kE2BT                kE1BT+105  
#define kSeqential           kE2BT  
#define kSimulG                kE2BT+1  
#define kPolarG                kE2BT+2  
#define kRectG                kE2BT+3  
#define kCoordOn           kE2BT+4  
#define kCoordOff           kE2BT+5  
#define kDrawLine           kE2BT+6  
#define kDrawDot           kE2BT+7  
#define kAxisOn                kE2BT+8  
#define kAxisOff           kE2BT+9  
#define kGridOn                kE2BT+10  
#define kGridOff           kE2BT+11  
#define kLblOn                kE2BT+12  
#define kLblOff                kE2BT+13  
#define kL1                kE2BT+14  
#define kL2                kE2BT+15  
#define kL3                kE2BT+16  
#define kL4                kE2BT+17  
#define kL5                kE2BT+18  
#define kL6                kE2BT+19  

//These keys are laid on top of existing keys to
//enable localization in the inferential stats editor.
//----------------------------------------------------
#define kinfData           kL1  
#define kinfStats           kL1+1  
#define kinfYes                kL1+2  
#define kinfNo                kL1+3  
#define kinfCalc           kL1+4  
#define kinfDraw           kL1+5  
#define kinfAlt1ne           kL1+6  
#define kinfAlt1lt           kL1+7  
#define kinfAlt1gt           kL1+8  
#define kinfAlt2ne           kL1+9  
#define kinfAlt2lt           kL1+10  
#define kinfAlt2gt           kL1+11  
#define kinfAlt3ne           kL1+12  
#define kinfAlt3lt           kL1+13  
#define kinfAlt3gt           kL1+14  
#define kinfAlt4ne           kL1+15  
#define kinfAlt4lt           kL1+16  
#define kinfAlt4gt           kL1+17  
#define kinfAlt5ne           kL1+18  
#define kinfAlt5lt           kL1+19  
#define kinfAlt5gt           kL1+20  
#define kinfAlt6ne           kL1+21  
#define kinfAlt6lt           kL1+22  
#define kinfAlt6gt           kL1+23  
#define kMatA                kE2BT+20  
#define kMatB                kE2BT+21  
#define kMatC                kE2BT+22  
#define kMatD                kE2BT+23  
#define kMatE                kE2BT+24  
#define kXmin                kE2BT+25  
#define kXmax                kE2BT+26  
#define kXscl                kE2BT+27  
#define kYmin                kE2BT+28  
#define kYmax                kE2BT+29  
#define kYscl                kE2BT+30  
#define kTmin                kE2BT+31  
#define kTmax                kE2BT+32  
#define kTStep                kE2BT+33  
#define kOmin                kE2BT+34  
#define kOmax                kE2BT+35  
#define kOStep                kE2BT+36  
#define ku0                kE2BT+37  
#define kv0                kE2BT+38  
#define knMin                kE2BT+39  
#define knMax                kE2BT+40  
#define kDeltaY                kE2BT+41  
#define kDeltaX                kE2BT+42  
#define kZXmin                kE2BT+43  
#define kZXmax                kE2BT+44  
#define kZXscl                kE2BT+45  
#define kZYmin                kE2BT+46  
#define kZYmax                kE2BT+47  
#define kZYscl                kE2BT+48  
#define kZTmin                kE2BT+49  
#define kZTmax                kE2BT+50  
#define kZTStep                kE2BT+51  
#define kZOmin                kE2BT+52  
#define kZOmax                kE2BT+53  
#define kZOStep                kE2BT+54  
#define kZu0                kE2BT+55  
#define kZv0                kE2BT+56  
#define kZnMin                kE2BT+57  
#define kZnMax                kE2BT+58  
#define kDelLast           kE2BT+59  
#define kSinReg                kE2BT+60  
#define kConstE                kE2BT+61  
#define kPic1                kE2BT+62  
#define kPic2                kE2BT+63  
#define kPic3                kE2BT+64  
#define kDelVar                kE2BT+65  
#define kGetCalc           kE2BT+66  
#define kRealM                kE2BT+67  
#define kPolarM                kE2BT+68  
#define kRectM                kE2BT+69  
#define kuv                kE2BT+70   //U vs V
#define kvw                kE2BT+71   //V vs W
#define kuw                kE2BT+72   //U vs W
#define kFinPMTend           kE2BT+73  
#define kFinPMTbeg           kE2BT+74  
#define kGraphStyle           kE2BT+75  
#define kExprOn                kE2BT+76  
#define kExprOff           kE2BT+77  
#define kStatA                kE2BT+78  
#define kStatB                kE2BT+79  
#define kStatC                kE2BT+80  
#define kCorr                kE2BT+81  
#define kStatD                kE2BT+82  
#define kStatE                kE2BT+83  
#define kRegEq                kE2BT+84  
#define kMinX                kE2BT+85  
#define kQ1                kE2BT+86  
#define kMD                kE2BT+87  
#define kQ3                kE2BT+88  
#define kMaxX                kE2BT+89  
#define kStatX1                kE2BT+90  
#define kStatY1                kE2BT+91  
#define kStatX2                kE2BT+92  
#define kStatY2                kE2BT+93  
#define kStatX3                kE2BT+94  
#define kStatY3                kE2BT+95  
#define kTblMin                kE2BT+96  
#define kTblStep           kE2BT+97  
#define kSetupLst           kE2BT+98  
#define kClrAllLst           kE2BT+99  
#define kLogistic           kE2BT+100  
#define kZTest                kE2BT+101  
#define kTTest                kE2BT+102  
#define k2SampZTest           kE2BT+103  
#define k2SampTTest           kE2BT+104  
#define k1PropZTest           kE2BT+105  
#define k2PropZTest           kE2BT+106  
#define kChiTest           kE2BT+107  
#define k2SampFTest           kE2BT+108  
#define kZIntVal           kE2BT+109  
#define kTIntVal           kE2BT+110  
#define k2SampTInt           kE2BT+111  
#define k2SampZInt           kE2BT+112  
#define k1PropZInt           kE2BT+113  
#define k2PropZInt           kE2BT+114  
#define kDNormal           kE2BT+115  
#define kInvNorm           kE2BT+116  
#define kDT                kE2BT+117  
#define kChi                kE2BT+118  
#define kDF                kE2BT+119  
#define kBinPDF                kE2BT+120  
#define kBinCDF                kE2BT+121  
#define kPoiPDF                kE2BT+122  
#define kPoiCDF                kE2BT+123  
#define kun                kE2BT+124  
#define kvn                kE2BT+125  
#define kwn                kE2BT+126  
#define kRecn                kE2BT+127  
#define kPlotStart           kE2BT+128  
#define kZPlotStart           kE2BT+129   //recursion n
#define kXFact                kE2BT+130   //PlotStart
#define kYFact                kE2BT+131   //ZPlotStart
#define kANOVA                kE2BT+132   //XFact
#define kMaxY                kE2BT+133   //YFact
#define kWebOn                kE2BT+134   //MinY
#define kWebOff                kE2BT+135   //MaxY
#define kTblInput           kE2BT+136   //WEB ON
#define kGeoPDF                kE2BT+137   //WEB OFF
#define kGeoCDF                kE2BT+138   //WEB OFF
#define kShadeNorm           kE2BT+139  
#define kShadeT                kE2BT+140  
#define kShadeChi           kE2BT+141  
#define kShadeF                kE2BT+142  
#define kPlotStep           kE2BT+143  
#define kZPlotStep           kE2BT+144  
#define kLinRegtTest           kE2BT+145  
#define KMGT                kE2BT+146   //VERT SPLIT
#define kSelectA           kE2BT+147  
#define kZFitA                kE2BT+148  
#define kE2BT_End           kZFitA  

//More 2 Byte Keys 
//------------------------------------
#define kE2BT2                0  
#define kGDB1                kE2BT2  
#define kGDB2                kE2BT2+1  
#define kGDB3                kE2BT2+2  
#define kY1                kE2BT2+3  
#define kY2                kE2BT2+4  
#define kY3                kE2BT2+5  
#define kY4                kE2BT2+6  
#define kY5                kE2BT2+7  
#define kY6                kE2BT2+8  
#define kY7                kE2BT2+9  
#define kY8                kE2BT2+10  
#define kY9                kE2BT2+11  
#define kY0                kE2BT2+12  
#define kX1T                kE2BT2+13  
#define kY1T                kE2BT2+14  
#define kX2T                kE2BT2+15  
#define kY2T                kE2BT2+16  
#define kX3T                kE2BT2+17  
#define kY3T                kE2BT2+18  
#define kX4T                kE2BT2+19  
#define kY4T                kE2BT2+20  
#define kX5T                kE2BT2+21  
#define kY5T                kE2BT2+22  
#define kX6T                kE2BT2+23  
#define kY6T                kE2BT2+24  
#define kR1                kE2BT2+25  
#define kR2                kE2BT2+26  
#define kR3                kE2BT2+27  
#define kR4                kE2BT2+28  
#define kR5                kE2BT2+29  
#define kR6                kE2BT2+30  
#define kGDB4                kE2BT2+31  
#define kGDB5                kE2BT2+32  
#define kGDB6                kE2BT2+33  
#define kPic4                kE2BT2+34  
#define kPic5                kE2BT2+35  
#define kPic6                kE2BT2+36  
#define kGDB7                kE2BT2+37  
#define kGDB8                kE2BT2+38  
#define kGDB9                kE2BT2+39  
#define kGDB0                kE2BT2+40  
#define kPic7                kE2BT2+41  
#define kPic8                kE2BT2+42  
#define kPic9                kE2BT2+43  
#define kPic0                kE2BT2+44  
#define kStatN                kE2BT2+45  
#define kXMean                kE2BT2+46  
#define kConj                kE2BT2+47  
#define kReal                kE2BT2+48  
#define kFAngle                kE2BT2+49  
#define kLCM                kE2BT2+50  
#define kGCD                kE2BT2+51  
#define kRandInt           kE2BT2+52  
#define kRandNorm           kE2BT2+53  
#define kToPolar           kE2BT2+54  
#define kToRect                kE2BT2+55  
#define kYMean                kE2BT2+56  
#define kStdX                kE2BT2+57  
#define kStdX1                kE2BT2+58  
#define kw0                kE2BT2+59  
#define kMatF                kE2BT2+60  
#define kMatG                kE2BT2+61  
#define kMatRH                kE2BT2+62  
#define kMatI                kE2BT2+63  
#define kMatJ                kE2BT2+64  
#define kYMean1                kE2BT2+65  
#define kStdY                kE2BT2+66  
#define kStdY1                kE2BT2+67  
#define kMatToLst           kE2BT2+68  
#define kLstToMat           kE2BT2+69  
#define kCumSum                kE2BT2+70  
#define kDeltaLst           kE2BT2+71  
#define kStdDev                kE2BT2+72  
#define kVariance           kE2BT2+73  
#define kLength                kE2BT2+74  
#define kEquToStrng           kE2BT2+75  
#define kStrngToEqu           kE2BT2+76  
#define kExpr                kE2BT2+77  
#define kSubStrng           kE2BT2+78  
#define kInStrng           kE2BT2+79  
#define kStr1                kE2BT2+80  
#define kStr2                kE2BT2+81  
#define kStr3                kE2BT2+82  
#define kStr4                 kE2BT2+83  
#define kStr5                 kE2BT2+84  
#define kStr6                 kE2BT2+85  
#define kStr7                 kE2BT2+86  
#define kStr8                 kE2BT2+87  
#define kStr9                 kE2BT2+88  
#define kStr0                 kE2BT2+89  
#define kFinN                 kE2BT2+90  
#define kFinI                 kE2BT2+91  
#define kFinPV                kE2BT2+92  
#define kFinPMT               kE2BT2+93  
#define kFinFV                kE2BT2+94  
#define kFinPY                kE2BT2+95  
#define kFinCY                kE2BT2+96  
#define kFinFPMT              kE2BT2+97  
#define kFinFI                kE2BT2+98  
#define kFinFPV               kE2BT2+99  
#define kFinFN                kE2BT2+100  
#define kFinFFV               kE2BT2+101  
#define kFinNPV               kE2BT2+102  
#define kFinIRR               kE2BT2+103  
#define kFinBAL               kE2BT2+104  
#define kFinPRN               kE2BT2+105  
#define kFinINT               kE2BT2+106  
#define kSumX                 kE2BT2+107  
#define kSumX2                kE2BT2+108  
#define kFinToNom             kE2BT2+109  
#define kFinToEff             kE2BT2+110  
#define kFinDBD               kE2BT2+111  
#define kStatVP               kE2BT2+112  
#define kStatZ                kE2BT2+113  
#define kStatT                kE2BT2+114  
#define kStatChi              kE2BT2+115  
#define kStatF                kE2BT2+116  
#define kStatDF               kE2BT2+117  
#define kStatPhat             kE2BT2+118  
#define kStatPhat1            kE2BT2+119  
#define kStatPhat2            kE2BT2+120  
#define kStatMeanX1           kE2BT2+121  
#define kStatMeanX2           kE2BT2+122  
#define kStatStdX1            kE2BT2+123  
#define kStatStdX2            kE2BT2+124  
#define kStatStdXP           kE2BT2+125  
#define kStatN1                kE2BT2+126  
#define kStatN2                kE2BT2+127  
#define kStatLower           kE2BT2+128  
#define kStatUpper           kE2BT2+129  
#define kuw0                kE2BT2+130  
#define kImag                kE2BT2+131  
#define kSumY                kE2BT2+132  
#define kXres                kE2BT2+133  
#define kStat_s                kE2BT2+134  
#define kSumY2                kE2BT2+135  
#define kSumXY                kE2BT2+136  
#define kuXres                kE2BT2+137  
#define kModBox                kE2BT2+138  
#define kNormProb           kE2BT2+139  
#define kNormalPDF           kE2BT2+140  
#define kTPDF                kE2BT2+141  
#define kChiPDF                kE2BT2+142  
#define kFPDF                kE2BT2+143  
#define kMinY                kE2BT2+144   //MinY
#define kRandBin           kE2BT2+145  
#define kRef                kE2BT2+146  
#define kRRef                kE2BT2+147  
#define kLRSqr                kE2BT2+148  
#define kBRSqr                kE2BT2+149  
#define kDiagOn                kE2BT2+150  
#define kDiagOff           kE2BT2+151  
#define kun1                kE2BT2+152   //FOR RCL USE WHEN GOTTEN FROM 82
#define kvn1                kE2BT2+153   //FOR RCL USE WHEN GOTTEN FROM 82
#define k83_00End           kvn1   //end of original keys...
#define kArchive           k83_00End + 1  
#define kUnarchive           k83_00End + 2  
#define kAsm                k83_00End + 3   //Asm(
#define kAsmPrgm           k83_00End + 4   //AsmPrgm
#define kAsmComp           k83_00End + 5   //AsmComp(
#define kcapAAcute           k83_00End + 6  
#define kcapAGrave           k83_00End + 7  
#define kcapACaret           k83_00End + 8  
#define kcapADier           k83_00End + 9  
#define kaAcute                k83_00End + 10  
#define kaGrave                k83_00End + 11  
#define kaCaret                k83_00End + 12  
#define kaDier                k83_00End + 13  
#define kcapEAcute           k83_00End + 14  
#define kcapEGrave           k83_00End + 15  
#define kcapECaret           k83_00End + 16  
#define kcapEDier           k83_00End + 17  
#define keAcute                k83_00End + 18  
#define keGrave                k83_00End + 19  
#define keCaret                k83_00End + 20  
#define keDier                k83_00End + 21  
#define kcapIAcute           k83_00End + 22  
#define kcapIGrave           k83_00End + 23  
#define kcapICaret           k83_00End + 24  
#define kcapIDier           k83_00End + 25  
#define kiAcute                k83_00End + 26  
#define kiGrave                k83_00End + 27  
#define kiCaret                k83_00End + 28  
#define kiDier                k83_00End + 29  
#define kcapOAcute           k83_00End + 30  
#define kcapOGrave           k83_00End + 31  
#define kcapOCaret           k83_00End + 32  
#define kcapODier           k83_00End + 33  
#define koAcute                k83_00End + 34  
#define koGrave                k83_00End + 35  
#define koCaret                k83_00End + 36  
#define koDier                k83_00End + 37  
#define kcapUAcute           k83_00End + 38  
#define kcapUGrave           k83_00End + 39  
#define kcapUCaret           k83_00End + 40  
#define kcapUDier           k83_00End + 41  
#define kuAcute                k83_00End + 42  
#define kuGrave                k83_00End + 43  
#define kuCaret                k83_00End + 44  
#define kuDier                k83_00End + 45  
#define kcapCCed           k83_00End + 46  
#define kcCed                k83_00End + 47  
#define kcapNTilde           k83_00End + 48  
#define knTilde                k83_00End + 49  
#define kaccent                k83_00End + 50  
#define kgrave                k83_00End + 51  
#define kdieresis           k83_00End + 52  
#define kquesDown           k83_00End + 53  
#define kexclamDown           k83_00End + 54  
#define kalpha                k83_00End + 55  
#define kbeta                 k83_00End + 56  
#define kgamma                k83_00End + 57  
#define kcapDelta           k83_00End + 58  
#define kdelta                k83_00End + 59  
#define kepsilon           k83_00End + 60  
#define klambda                k83_00End + 61  
#define kmu                k83_00End + 62  
#define kpi2                k83_00End + 63  
#define krho                k83_00End + 64  
#define kcapSigma           k83_00End + 65  
#define ksigma                k83_00End + 66  
#define ktau                k83_00End + 67  
#define kphi                k83_00End + 68  
#define kcapOmega           k83_00End + 69  
#define kphat                k83_00End + 70  
#define kchi2                k83_00End + 71  
#define kstatF2                k83_00End + 72  
#define kLa                k83_00End + 73  
#define kLb                k83_00End + 74  
#define kLc                k83_00End + 75  
#define kLd                k83_00End + 76  
#define kLe                k83_00End + 77  
#define kLf                k83_00End + 78  
#define kLg                k83_00End + 79  
#define kLh                k83_00End + 80  
#define kLi                k83_00End + 81  
#define kLj                k83_00End + 82  
#define kLk                k83_00End + 83  
#define kLl                k83_00End + 84  
#define kLm                k83_00End + 85  
#define kLsmalln           k83_00End + 86  
#define kLo                k83_00End + 87  
#define kLp                k83_00End + 88  
#define kLq                k83_00End + 89  
#define kLsmallr           k83_00End + 90  
#define kLs                k83_00End + 91  
#define kLt                k83_00End + 92  
#define kLu                k83_00End + 93  
#define kLv                k83_00End + 94  
#define kLw                k83_00End + 95  
#define kLx                k83_00End + 96  
#define kLy                k83_00End + 97  
#define kLz                k83_00End + 98  
#define kGarbageC           k83_00End + 99   //GarbageCollect
#define kE2BT2_End           kGarbageC  

//TI-83 Plus Context Equates
//---------------------------------------------
#define cxCmd                kQuit   //home screen
#define cxMatEdit           kMatrixEd   //matrix editor
#define cxPrgmEdit           kPrgmEd   //program editor
#define cxEquEdit           kYequ   //equation editor
#define cxGrRange           kWindow   //graph range editor
#define cxGrZfact           kZFactEd   //graph zoom factors editor
#define cxGraph                kGraph   //graph mode
#define cxStatEdit           kStatEd   //statistics list editor
#define cxPrgmInput           kPrgmInput   //programmed input
#define cxError                kError   //error handler
#define cxLinkIO           kLinkIO   //LINK I/O interface
#define cxMem                kResetMem   //reset memory
#define cxDefMem           kResetDef   //reset default
#define cxRAMApp           kChkRAM   //RAM usage screen
#define cxMode                kMode   //mode settings screen
#define cxErase                kDelMem   //memory erase
#define cxPrgmCreate           kPrgmCr   //PROGRAM CREATE
#define cxTableEditor           kTable   //TABLE EDITOR
#define cxTableSet           kTblSet   //TABLE SET UP
#define cxStatPlot           kStatP   //STAT PLOTS
#define cxInfStat           kInfStat   //Inferential Statistic
#define cxFormat           kFormat   //FORMAT CONTEXT
#define cxSolveTVM           kSolveTVM   //Solve TVM
#define cxSolveRoot           kSolveRoot   //Solve Root
#define lastOldApp           kExtApps   //external applications
#define cxextapps           kExtApps  
#define cxNewApps           kNewApps   //new cerberus applications
#define cxGroup                cxNewApps+0   //1st new app.
#define cxUnGroup           cxNewApps+1   //2nd new app.
#define lastNewApp           cxUnGroup   //last new app for this ver

//Scan Code Equates
//-------------------------------
#define skDown              0x01 
#define skLeft              0x02 
#define skRight              0x03 
#define skUp              0x04 
#define skEnter              0x09 
#define skAdd              0x0A 
#define skSub              0x0B 
#define skMul              0x0C 
#define skDiv              0x0D 
#define skPower              0x0E 
#define skClear              0x0F 
#define skChs              0x11 
#define sk3              0x12 
#define sk6              0x13 
#define sk9              0x14 
#define skRParen         0x15 
#define skTan              0x16 
#define skVars              0x17 
#define skDecPnt         0x19 
#define sk2              0x1A 
#define sk5              0x1B 
#define sk8              0x1C 
#define skLParen         0x1D 
#define skCos              0x1E 
#define skPrgm              0x1F 
#define skStat              0x20 
#define sk0              0x21 
#define sk1              0x22 
#define sk4              0x23 
#define sk7              0x24 
#define skComma              0x25 
#define skSin              0x26 
#define skMatrix         0x27 
#define skGraphvar         0x28 
#define skStore              0x2A 
#define skLn              0x2B 
#define skLog              0x2C 
#define skSquare         0x2D 
#define skRecip              0x2E 
#define skMath              0x2F 
#define skAlpha              0x30 
#define skGraph              0x31 
#define skTrace              0x32 
#define skZoom              0x33 
#define skWindow         0x34 
#define skYEqu              0x35 
#define sk2nd              0x36 
#define skMode              0x37 
#define skDel              0x38 

//Tokens
//----------------------------------------------------
#define EOSSTART           0  

//DISPLAY CONVERSIONS COME IMMEDIATELY BEFORE 'TSTORE'
//
#define DCONV              0x01 
//
#define tToDMS                DCONV   //01h
#define tToDEC                DCONV+1   //02h
#define tToAbc                DCONV+2   //03h > A b/c
//
#define tStore                DCONV+3   //04h Lstore 01
//
#define tBoxPlot         0x05 
//
#define BRACKS              0x06 
//
#define tLBrack                BRACKS   //06h '['
#define tRBrack                BRACKS+1   //07h ']'
#define tLBrace                BRACKS+2   //08h '{'
#define tRBrace                BRACKS+3   //09h '}'
//
#define tPOST1                BRACKS+4  
//
#define tFromRad           tPOST1   //0Ah Lradian
#define tFromDeg           tPOST1+1   //0Bh Ldegree
#define tRecip                tPOST1+2   //0Ch Linverse
#define tSqr                tPOST1+3   //0Dh Lsquare
#define tTrnspos           tPOST1+4   //0Eh Ltranspose
#define tCube                tPOST1+5   //0Fh '^3'
//
#define tLParen              0x10  //10h '('
#define tRParen              0x11  //11h ')'
//
#define IMUN              0x12 
//
#define tRound                IMUN   //12h 'round'
#define tPxTst                IMUN+1   //13h 'PXL-TEST'
#define tAug                IMUN+2   //14h 'aug'
#define tRowSwap           IMUN+3   //15h 'rSwap'
#define tRowPlus           IMUN+4   //16h 'rAdd'
#define tmRow                IMUN+5   //17h 'multR'
#define tmRowPlus           IMUN+6   //18h 'mRAdd'
#define tMax                IMUN+7   //19h 'max'
#define tMin                IMUN+8   //1Ah 'min'
#define tRToPr                IMUN+9   //1Bh 'R>Pr
#define tRToPo                IMUN+10   //1Ch 'R>Po
#define tPToRx                IMUN+11   //1Dh 'P>Rx
#define tPToRy                IMUN+12   //1Eh 'P>Ry
#define tMedian                IMUN+13   //1Fh 'MEDIAN
#define tRandM                IMUN+14   //20h 'randM'
#define tMean                IMUN+15   //21h
#define tRoot                IMUN+16   //22h 'ROOT'
#define tSeries                IMUN+17   //23h 'seq'
#define tFnInt                IMUN+18   //24h 'fnInt'
#define tNDeriv                IMUN+19   //25h 'fnIr'
#define tEvalF                IMUN+20   //26h
#define tFmin                IMUN+21   //27h
#define tFmax                IMUN+22   //28h
//
#define tEOSEL                IMUN+23  
//
#define tSpace                tEOSEL   //29h ' '
#define tString                tEOSEL+1   //2Ah '"'
#define tComma                tEOSEL+2   //2Bh ','
//
#define tii              0x2C  //i

//Postfix Functions
//-----------------------------------------
#define tPost              0x2D 
//
#define tFact                tPost   //2Dh '!'
//
#define tCubicR              0x2E 
#define tQuartR              0x2F 

//Number Tokens 
//---------------------------------------
#define NUMS              0x30 
//
#define t0                NUMS   //30h
#define t1                NUMS+1   //31h
#define t2                NUMS+2   //32h
#define t3                NUMS+3   //33h
#define t4                NUMS+4   //34h
#define t5                NUMS+5   //35h
#define t6                NUMS+6   //36h
#define t7                NUMS+7   //37h
#define t8                NUMS+8   //38h
#define t9                NUMS+9   //39h
#define tDecPt                NUMS+10   //3Ah
#define tee                NUMS+11   //3Bh

//Binary OP
//-------------------------------------------
#define tOr              0x3C  //3Ch '_or_'
#define tXor              0x3D  //3Dh
//
#define tColon              0x3E  //3Eh ':'
#define tEnter              0x3F  //3Fh Lenter
//
#define tAnd              0x40  //40h '_and_'

//Letter Tokens
//--------------------------------------
#define LET              0x41 
#define tA                LET   //41h
#define tB                LET+1   //42h
#define tC                LET+2   //43h
#define tD                LET+3   //44h
#define tE                LET+4   //45h
#define tF                LET+5   //46h
#define tG                LET+6   //47h
#define tH                LET+7   //48h
#define tI                LET+8   //49h
#define tJ                LET+9   //4Ah
#define tK                LET+10   //4Bh
#define tL                LET+11   //4Ch
#define tM                LET+12   //4Dh
#define tN                LET+13   //4Eh
#define tO                LET+14   //4Fh
#define tP                LET+15   //50h
#define tQ                LET+16   //51h
#define tR                LET+17   //52h
#define tS                LET+18   //53h
#define tT                LET+19   //54h
#define tU                LET+20   //55h
#define tV                LET+21   //56h
#define tW                LET+22   //57h
#define tX                LET+23   //58h
#define tY                LET+24   //59h
#define tZ                LET+25   //5Ah
#define tTheta                LET+26   //5Bh

//These Var Tokens Are 1st Of A Double Token
//------------------------------------------

#define vToks                LET+27  

//User Matrix Token, 2nd Token Needed For Name
//
#define tVarMat                vToks   //5Ch
//
//User List Token, 2nd Token Needed For Name
//
#define tVarLst                vToks+1   //5Dh
//
//User Equation Token, 2nd Token Needed For Name
//
#define tVarEqu                vToks+2   //5Eh
#define tProg                vToks+3   //5Fh
//
//User Pict Token, 2nd Token Needed For Name
//
#define tVarPict           vToks+4   //60h
//
//User GDB Token, 2nd Token Needed For Name
//
#define tVarGDB                vToks+5   //61h
#define tVarOut                vToks+6   //62h
#define tVarSys                vToks+7   //63h

//Mode Setting Commands
//-------------------------------------------------
#define MODESA                vToks+8   //64h
#define tRad                MODESA   //64h 'Radian'
#define tDeg                MODESA+1   //65h 'Degree'
#define tNormF                MODESA+2   //66h 'Normal'
#define tSci                MODESA+3   //67h 'Sci'
#define tEng                MODESA+4   //68h 'Eng'
#define tFloat                MODESA+5   //69h 'Float'
#define CMPS              0x6A 
#define tEQ                CMPS   //6Ah '=='
#define tLT                CMPS+1   //6Bh '<'
#define tGT                CMPS+2   //6Ch '>'
#define tLE                CMPS+3   //6Dh LLE
#define tGE                CMPS+4   //6Eh LGE
#define tNE                CMPS+5   //6Fh LNE

//Binary OP
//---------------------------------------
#define tAdd              0x70  //70h '+'
#define tSub              0x71  //71h '-'
#define tAns              0x72  //72h

//Mode Setting Commands
//-------------------------------------------------------
#define MODES              0x73 
#define tFix                MODES   //73h 'Fix_'
#define tSplitOn           MODES+1   //74h
#define tFullScreen           MODES+2   //75h
#define tStndrd                MODES+3   //76h 'Func'
#define tParam                MODES+4   //77h 'Param'
#define tPolar                MODES+5   //78h 'Pol'
#define tSeqG                MODES+6   //79h
#define tAFillOn           MODES+7   //7Ah 'AUTO FILL ON'
#define tAFillOff           MODES+8   //7Bh
#define tACalcOn           MODES+9   //7Ch
#define tACalcOff           MODES+10   //7Dh 'AutoFill OFF'

//Graph Format Tokens Are 2 Byte Tokens
//----------------------------------------
#define tGFormat           MODES+11   //7Eh
#define tBoxIcon         0x7F 
#define tCrossIcon         0x80 
#define tDotIcon         0x81 

//(More) Binary OP
//---------------------------------------
#define tMul              0x82  //82h '*'
#define tDiv              0x83  //83h '/'

//Some Graph Commands
//------------------------------------------------------
#define GRCMDS              0x84 
#define tTrace                GRCMDS   // 84h 'Trace'
#define tClDrw                GRCMDS+1   // 85h 'ClDrw'
#define tZoomStd           GRCMDS+2   // 86h 'ZStd'
#define tZoomtrg           GRCMDS+3   // 87h 'Ztrg'
#define tZoomBox           GRCMDS+4   // 88h 'ZBOX'
#define tZoomIn                GRCMDS+5   // 89h 'ZIn'
#define tZoomOut           GRCMDS+6   // 8Ah 'ZOut'
#define tZoomSqr           GRCMDS+7   // 8Bh 'ZSqr'
#define tZoomInt           GRCMDS+8   // 8Ch 'ZInt'
#define tZoomPrev           GRCMDS+9   // 8Dh 'ZPrev'
#define tZoomDec           GRCMDS+10   // 8Eh 'ZDecm'
#define tZoomStat           GRCMDS+11   // 8Fh 'ZStat
#define tUsrZm                GRCMDS+12   // 90h 'ZRcl'
#define tPrtScrn           GRCMDS+13   // 91h 'PrtScrn'
#define tZoomSto           GRCMDS+14   // 92h  ZOOM STORE
#define tText                GRCMDS+15   // 93h

//Binary OP (Combination & Permutation)
//-------------------------------------------------
#define tnPr                GRCMDS+16   //94h '_nPr_'
#define tnCr                GRCMDS+17   //95h '_nCr_'

//More Graph Commands
//--------------------------------------------------
#define tYOn                GRCMDS+18   //96h 'FnOn_'
#define tYOff                GRCMDS+19   //97h 'FnOff_'
#define tStPic                GRCMDS+20   //98h 'StPic_'
#define tRcPic                GRCMDS+21   //99h 'RcPic_'
#define tStoDB                GRCMDS+22   //9Ah 'StGDB_'
#define tRclDB                GRCMDS+23   //9Bh 'RcGDB_'
#define tLine                GRCMDS+24   //9Ch 'Line'
#define tVert                GRCMDS+25   //9Dh 'Vert_'
#define tPtOn                GRCMDS+26   //9Eh 'PtOn'
#define tPtOff                GRCMDS+27   //9Fh 'PtOff'

//Token A0 Cannot Be An EOS Function Since Low MULT=A0 Already
//------------------------------------------------------------
#define tPtChg                GRCMDS+28   //A0h 'PtChg'
#define tPXOn                GRCMDS+29   //A1h
#define tPXOff                GRCMDS+30   //A2h
#define tPXChg                GRCMDS+31   //A3h
#define tShade                GRCMDS+32   //A4h 'Shade'
#define tCircl                GRCMDS+33   //A5h 'Circl'
#define tHorz                GRCMDS+34   //A6h 'HORIZONTAL'
#define tTanLn                GRCMDS+35   //A7h 'TanLn'
#define tDrInv                GRCMDS+36   //A8h 'DrInv_'
#define tDrawF                GRCMDS+37   //A9h 'DrawF_'
#define tVarStrng         0x0AA 

//Functions with No Arguments                                    
//--------------------------------------------------
#define NOARG              0x0AB 
#define tRand                NOARG   //ABh 'rand'
#define tPi                NOARG+1   //ACh  Lpi
#define tGetKey                NOARG+2   //ADh 'getKy'
#define tAPost                tGetKey+1   //APOSTROPHY
#define tQuest                tAPost+1   //QUESTION MARK
#define UNARY                tQuest+1   //B0h
#define tChs                UNARY   //B0h
#define tInt                UNARY+1   //B1h
#define tAbs                UNARY+2   //B2h
#define tDet                UNARY+3   //B3h
#define tIdent                UNARY+4   //B4h
#define tDim                UNARY+5   //B5h
#define tSum                UNARY+6   //B6h
#define tProd                UNARY+7   //B7h
#define tNot                UNARY+8   //B8h
#define tIPart                UNARY+9   //B9h
#define tFPart                UNARY+10   //BAh

//New 2 Byte Tokens
//------------------------------------------
#define t2ByteTok         0x0BB 
#define UNARYLR                UNARY+12  
#define tSqrt                UNARYLR   //BCh
#define tCubRt                UNARYLR+1   //BDh
#define tLn                UNARYLR+2   //BEh
#define tExp                UNARYLR+3   //BFh
#define tLog                UNARYLR+4   //C0h
#define tALog                UNARYLR+5   //C1h
#define tSin                UNARYLR+6   //C2h
#define tASin                UNARYLR+7   //C3h
#define tCos                UNARYLR+8   //C4h
#define tACos                UNARYLR+9   //C5h
#define tTan                UNARYLR+10   //C6h
#define tATan                UNARYLR+11   //C7h
#define tSinH                UNARYLR+12   //C8h
#define tASinH                UNARYLR+13   //C9h
#define tCoshH                UNARYLR+14   //CAh
#define tACosH                UNARYLR+15   //CBh
#define tTanH                UNARYLR+16   //CCh
#define tATanH                UNARYLR+17   //CDh

//Some Programming Commands
//------------------------------------------------------
#define PROGTOK                UNARYLR+18  
#define tIf                PROGTOK   //CEh
#define tThen                PROGTOK+1   //CFh
#define tElse                PROGTOK+2   //D0h
#define tWhile                PROGTOK+3   //D1h
#define tRepeat                PROGTOK+4   //D2h
#define tFor                PROGTOK+5   //D3h
#define tEnd                PROGTOK+6   //D4h
#define tReturn                PROGTOK+7   //D5h
#define tLbl                PROGTOK+8   //D6h 'Lbl_'
#define tGoto                PROGTOK+9   //D7h 'Goto_'
#define tPause                PROGTOK+10   //D8h 'Pause_'
#define tStop                PROGTOK+11   //D9h 'Stop'
#define tISG                PROGTOK+12   //DAh 'IS>'
#define tDSL                PROGTOK+13   //DBh 'DS<'
#define tInput                PROGTOK+14   //DCh 'Input_'
#define tPrompt                PROGTOK+15   //DDh 'Prompt_'
#define tDisp                PROGTOK+16   //DEh 'Disp_'
#define tDispG                PROGTOK+17   //DFh 'DispG'
#define tOutput                PROGTOK+18   //E0h 'Outpt'
#define tClLCD                PROGTOK+19   //E1h 'ClLCD'
#define tConst                PROGTOK+20   //E2h 'Fill'
#define tSortA                PROGTOK+21   //E3h 'sortA_'
#define tSortD                PROGTOK+22   //E4h 'sortD_'
#define tDispTab           PROGTOK+23   //E5h 'Disp Table
#define tMenu                PROGTOK+24   //E6h 'Menu'
#define tSendMBL           PROGTOK+25   //E7h 'SEND'
#define tGetMBL                PROGTOK+26   //E8h 'GET'

//Stat Plot Commands
//------------------------------------------------------
#define statPCmd           PROGTOK+27  
#define tPlotOn                statPCmd   //E9h ' PLOTSON'
#define tPlotOff           statPCmd+1   //EAh ' PLOTSOFF
#define tListName         0x0EB  //LIST DESIGNATOR
#define tPlot1              0x0EC 
#define tPlot2              0x0ED 
#define tPlot3              0x0EE 
#define tUnused01         0x0EF  //available?
#define tPower              0x0F0  //'^'
#define tXRoot              0x0F1  //LsupX,Lroot
#define STATCMD              0x0F2 
#define tOneVar                STATCMD   //F2h 'OneVar_'
#define tTwoVar                STATCMD+1   //F3h
#define tLR                STATCMD+2   //F4h 'LinR(A+BX
#define tLRExp                STATCMD+3   //F5h 'ExpR_'
#define tLRLn                STATCMD+4   //F6h 'LnR_'
#define tLRPwr                STATCMD+5   //F7h 'PwrR_'
#define tMedMed                STATCMD+6   //F8h
#define tQuad                STATCMD+7   //F9h
#define tClrLst                STATCMD+8   //FAh 'CLEAR LIST
#define tClrTbl                STATCMD+9   //FBh CLEAR TABLE
#define tHist                STATCMD+10   //FCh 'Hist_'
#define txyLine                STATCMD+11   //FDh 'xyline_'
#define tScatter           STATCMD+12   //FEh 'Scatter_'
#define tLR1                STATCMD+13   //FFh 'LINR(AX+B

//2nd Half Of Graph Format Tokens
//----------------------------------------------
//           Format settings commands
//
#define GFMT                0  
#define tSeq                GFMT   // 'SeqG'
#define tSimulG                GFMT+1   // 'SimulG'
#define tPolarG                GFMT+2   // 'PolarGC'
#define tRectG                GFMT+3   // 'RectGC'
#define tCoordOn           GFMT+4   // 'CoordOn'
#define tCoordOff           GFMT+5   // 'CoordOff'
#define tDrawLine           GFMT+6   // 'DrawLine'
#define tDrawDot           GFMT+7   // 'DrawDot'
#define tAxisOn                GFMT+8   // 'AxesOn'
#define tAxisOff           GFMT+9   // 'AxesOff'
#define tGridOn                GFMT+10   // 'GridOn'
#define tGridOff           GFMT+11   // 'GridOff'
#define tLblOn                GFMT+12   // 'LabelOn'
#define tLblOff                GFMT+13   // 'LabelOff'
#define tWebOn                GFMT+14   // 'WebOn'
#define tWebOff                GFMT+15   // 'WebOFF'
#define tuv                GFMT+16   // U vs V
#define tvw                GFMT+17   // V vs W
#define tuw                GFMT+18   // U vs W

//2nd Half Of User Matrix Tokens
//-------------------------------------
#define tMatA              0x00  //MAT A
#define tMatB              0x01  //MAT B
#define tMatC              0x02  //MAT C
#define tMatD              0x03  //MAT D
#define tMatE              0x04  //MAT E
#define tMatF              0x05  //MAT F
#define tMatG              0x06  //MAT G
#define tMatH              0x07  //MAT H
#define tMatI              0x08  //MAT I
#define tMatJ              0x09  //MAT J

//2nd Half Of User List Tokens
//--------------------------------------
#define tL1              0x00  //LIST 1
#define tL2              0x01  //LIST 2
#define tL3              0x02  //LIST 3
#define tL4              0x03  //LIST 4
#define tL5              0x04  //LIST 5
#define tL6              0x05  //LIST 6

//2nd Half Of User Equation Tokens
//----------------------------------
//  "Y" EQUATIONS HAVE BIT 4 SET
//
#define tY1              0x10  //Y1
#define tY2              0x11  //Y2
#define tY3              0x12  //Y3
#define tY4              0x13  //Y4
#define tY5              0x14  //Y5
#define tY6              0x15  //Y6
#define tY7              0x16  //Y7
#define tY8              0x17  //Y8
#define tY9              0x18  //Y9
#define tY0              0x19  //Y0

//Param Equations Have Bit 5 Set
//-----------------------------------
#define tX1T              0x20  //X1t
#define tY1T              0x21  //Y1t
#define tX2T              0x22  //X2t
#define tY2T              0x23  //Y2t
#define tX3T              0x24  //X3t
#define tY3T              0x25  //Y3t
#define tX4T              0x26  //X4t
#define tY4T              0x27  //Y4t
#define tX5T              0x28  //X5t
#define tY5T              0x29  //Y5t
#define tX6T              0x2A  //X6t
#define tY6T              0x2B  //Y6t

//Polar Equations Have Bit 6 Set
//----------------------------------
#define tR1              0x40  //R1
#define tR2              0x41  //R2
#define tR3              0x42  //R3
#define tR4              0x43  //R4
#define tR5              0x44  //R5
#define tR6              0x45  //R6

//Recursion Equations Have Bit 7 Set
//----------------------------------
#define tun              0x80  //Un
#define tvn              0x81  //Vn
#define twn              0x82  //Wn

//2nd Half Of User Picture Tokens
//------------------------------------
#define tPic1              0x00  //PIC1
#define tPic2              0x01  //PIC2
#define tPic3              0x02  //PIC3
#define tPic4              0x03  //PIC4
#define tPic5              0x04  //PIC5
#define tPic6              0x05  //PIC6
#define tPic7              0x06  //PIC7
#define tPic8              0x07  //PIC8
#define tPic9              0x08  //PIC9
#define tPic0              0x09  //PIC0

//2nd Half Of User Graph Database Tokens
//--------------------------------------
#define tGDB1              0x00  //GDB1
#define tGDB2              0x01  //GDB2
#define tGDB3              0x02  //GDB3
#define tGDB4              0x03  //GDB4
#define tGDB5              0x04  //GDB5
#define tGDB6              0x05  //GDB6
#define tGDB7              0x06  //GDB7
#define tGDB8              0x07  //GDB8
#define tGDB9              0x08  //GDB9
#define tGDB0              0x09  //GDB0

//2nd Half Of String Vars
//------------------------------
#define tStr1              0x00 
#define tStr2              0x01 
#define tStr3              0x02 
#define tStr4              0x03 
#define tStr5              0x04 
#define tStr6              0x05 
#define tStr7              0x06 
#define tStr8              0x07 
#define tStr9              0x08 
#define tStr0              0x09 

//2nd Half Of System Output Only Variables
//-----------------------------------------------------------------
//OPEN               equ 00h
#define tRegEq              0x01  //REGRESSION EQUATION
#define tStatN              0x02  //STATISTICS N
#define tXMean              0x03  //X MEAN
#define tSumX              0x04  //SUM(X)
#define tSumXSqr         0x05  //SUM(X^2)
#define tStdX              0x06  //STANDARD DEV X
#define tStdPX              0x07  //STANDARD DEV POP X
#define tMinX              0x08  //Min X VALUE
#define tMaxX              0x09  //Max X VALUE
#define tMinY              0x0A  //Min Y VALUE
#define tMaxY              0x0B  //Max Y VALUE
#define tYmean              0x0C  //Y MEAN
#define tSumY              0x0D  //SUM(Y)
#define tSumYSqr         0x0E  //SUM(Y^2)
#define tStdY              0x0F  //STANDARD DEV Y
#define tStdPY              0x10  //STANDARD DEV POP Y
#define tSumXY              0x11  //SUM(XY)
#define tCorr              0x12  //CORRELATION
#define tMedX              0x13  //MED(X)
#define tQ1              0x14  //1ST QUADRANT OF X
#define tQ3              0x15  //3RD QUADRANT OF X
#define tQuadA              0x16  //1ST TERM OF QUAD POLY REG/ Y-INT
#define tQuadB              0x17  //2ND TERM OF QUAD POLY REG/ SLOPE
#define tQuadC              0x18  //3RD TERM OF QUAD POLY REG
#define tCubeD              0x19  //4TH TERM OF CUBIC POLY REG
#define tQuartE              0x1A  //5TH TERM OF QUART POLY REG
#define tMedX1              0x1B  //x1 FOR MED-MED
#define tMedX2              0x1C  //x2 FOR MED-MED
#define tMedX3              0x1D  //x3 FOR MED-MED
#define tMedY1              0x1E  //y1 FOR MED-MED
#define tMedY2              0x1F  //y2 FOR MED-MED
#define tMedY3              0x20  //y3 FOR MED-MED
#define tRecurn              0x21      //RECURSION N
#define tStatP              0x22 
#define tStatZ              0x23 
#define tStatT              0x24 
#define tStatChi         0x25 
#define tStatF              0x26 
#define tStatDF              0x27 
#define tStatPhat         0x28 
#define tStatPhat1         0x29 
#define tStatPhat2         0x2A 
#define tStatMeanX1         0x2B 
#define tStatStdX1         0x2C 
#define tStatN1              0x2D 
#define tStatMeanX2         0x2E 
#define tStatStdX2         0x2F 
#define tStatN2              0x30 
#define tStatStdXP         0x31 
#define tStatLower         0x32 
#define tStatUpper         0x33 
#define tStat_s              0x34 
#define tLRSqr              0x35  //r^2
#define tBRSqr              0x36  //R^2

//These next tokens are only used to access the data
//they are display only and the user cannot access them at all
//------------------------------------------------------------
#define tF_DF              0x37  //ANOFAV FACTOR DF
#define tF_SS              0x38  //ANOFAV FACTOR SS
#define tF_MS              0x39  //ANOFAV FACTOR MS
#define tE_DF              0x3A  //ANOFAV ERROR DF
#define tE_SS              0x3B  //ANOFAV ERROR SS
#define tE_MS              0x3C  //ANOFAV ERROR MS

//2nd Half Of System Input/Output Variables
//------------------------------------------------
//      SYSTEM VARIABLE EQUATES
//
#define tuXscl                0  
#define tuYscl                1  
#define tXscl                2  
#define tYscl                3  
#define tRecuru0           4   //U 1ST INITIAL COND
#define tRecurv0           5   //V 1ST INITIAL COND
#define tun1                6   //U(N-1); NOT USED
#define tvn1                7   //V(N-1); NOT USED
#define tuRecuru0           8   //
#define tuRecurv0           9   //
#define tXmin              0x0A 
#define tXmax              0x0B 
#define tYmin              0x0C 
#define tYmax              0x0D 
#define tTmin              0x0E 
#define tTmax              0x0F 
#define tThetaMin         0x10 
#define tThetaMax         0x11 
#define tuXmin              0x12 
#define tuXmax              0x13 
#define tuYmin              0x14 
#define tuYmax              0x15 
#define tuThetMin         0x16 
#define tuThetMax         0x17 
#define tuTmin              0x18 
#define tuTmax              0x19 
#define tTblMin              0x1A 
#define tPlotStart         0x1B 
#define tuPlotStart         0x1C 
#define tnMax              0x1D 
#define tunMax              0x1E 
#define tnMin              0x1F 
#define tunMin              0x20 
#define tTblStep         0x21 
#define tTStep              0x22 
#define tThetaStep         0x23 
#define tuTStep              0x24 
#define tuThetStep         0x25 
#define tDeltaX              0x26 
#define tDeltaY              0x27 
#define tXFact              0x28 
#define tYFact              0x29 
#define tTblInput         0x2A 
#define tFinN              0x2B 
#define tFinI              0x2C 
#define tFinPV              0x2D 
#define tFinPMT              0x2E 
#define tFinFV              0x2F 
#define tFinPY              0x30 
#define tFinCY              0x31 
#define tRecurw0         0x32  //w0(1)
#define tuRecurw0         0x33 
#define tPlotStep         0x34 
#define tuPlotStep         0x35 
#define tXres              0x36 
#define tuXres              0x37 
#define tRecuru02         0x38  //u0(2)
#define tuRecuru02         0x39 
#define tRecurv02         0x3C  //v0(2)
#define tuRecurv02         0x3D 
#define tRecurw02         0x3E  //w0(2)
#define tuRecurw02         0x3F 

//2nd Byte Of t2ByteTok Tokens
//------------------------------
#define tFinNPV              0x00 
#define tFinIRR              0x01 
#define tFinBAL              0x02 
#define tFinPRN              0x03 
#define tFinINT              0x04 
#define tFinToNom         0x05 
#define tFinToEff         0x06 
#define tFinDBD              0x07 
#define tLCM              0x08 
#define tGCD              0x09 
#define tRandInt         0x0A 
#define tRandBin         0x0B 
#define tSubStrng         0x0C 
#define tStdDev              0x0D 
#define tVariance         0x0E 
#define tInStrng         0x0F 
#define tDNormal         0x10 
#define tInvNorm         0x11 
#define tDT              0x12 
#define tChI              0x13 
#define tDF              0x14 
#define tBINPDF              0x15 
#define tBINCDF              0x16 
#define tPOIPDF              0x17 
#define tPOICDF              0x18 
#define tGEOPDF              0x19 
#define tGEOCDF              0x1A 
#define tNormalPDF         0x1B 
#define tTPDF              0x1C 
#define tChiPDF              0x1D 
#define tFPDF              0x1E 
#define tRandNorm         0x1F 
#define tFinFPMT         0x20 
#define tFinFI              0x21 
#define tFinFPV              0x22 
#define tFinFN              0x23 
#define tFinFFV              0x24 
#define tConj              0x25 
#define tReal              0x26 
#define tImag              0x27 
#define tAngle              0x28 
#define tCumSum              0x29 
#define tExpr              0x2A 
#define tLength              0x2B 
#define tDeltaLst         0x2C 
#define tRef              0x2D 
#define tRRef              0x2E 
#define tToRect              0x2F 
#define tToPolar         0x30 
#define tConste              0x31 
#define tSinReg              0x32 
#define tLogistic         0x33 
#define tLinRegTTest         0x34 
#define tShadeNorm         0x35 
#define tShadeT              0x36 
#define tShadeChi         0x37 
#define tShadeF              0x38 
#define tMatToLst         0x39 
#define tLstToMat         0x3A 
#define tZTest              0x3B 
#define tTTest              0x3C 
#define t2SampZTest         0x3D 
#define t1PropZTest         0x3E 
#define t2PropZTest         0x3F 
#define tChiTest         0x40 
#define tZIntVal         0x41 
#define t2SampZInt         0x42 
#define t1PropZInt         0x43 
#define t2PropZInt         0x44 
#define tGraphStyle         0x45 
#define t2SampTTest         0x46 
#define t2SampFTest         0x47 
#define tTIntVal         0x48 
#define t2SampTInt         0x49 
#define tSetupLst         0x4A 
#define tFinPMTend         0x4B 
#define tFinPMTbeg         0x4C 
#define tRealM              0x4D 
#define tPolarM              0x4E 
#define tRectM              0x4F 
#define tExprOn              0x50 
#define tExprOff         0x51 
#define tClrAllLst         0x52 
#define tGetCalc         0x53 
#define tDelVar              0x54 
#define tEquToStrng         0x55 
#define tStrngToEqu         0x56 
#define tDelLast         0x57 
#define tSelect              0x58 
#define tANOVA              0x59 
#define tModBox              0x5A 
#define tNormProb         0x5B 
#define tMGT              0x64  //VERTICAL SPLIT
#define tZFit              0x65  //ZOOM FIT
#define tDiag_on         0x66  //DIANOSTIC DISPLAY ON
#define tDiag_off         0x67  //DIANOSTIC DISPLAY OFF
#define tOkEnd2v0         0x67  //end of 2byte tokens for version 0.
#define tArchive         0x68  //archive
#define tUnarchive         0x69  //unarchive
#define tasm              0x6A 
#define tasmComp         0x6B      //asm compile
#define tasmPrgm         0x6C      //signifies a program is asm
#define tasmCmp              0x6D      //asm program is compiled
#define tLcapAAcute         0x6E 
#define tLcapAGrave         0x6F 
#define tLcapACaret         0x70 
#define tLcapADier         0x71 
#define tLaAcute         0x72 
#define tLaGrave         0x73 
#define tLaCaret         0x74 
#define tLaDier              0x75 
#define tLcapEAcute         0x76 
#define tLcapEGrave         0x77 
#define tLcapECaret         0x78 
#define tLcapEDier         0x79 
#define tLeAcute         0x7A 
#define tLeGrave         0x7B 
#define tLeCaret         0x7C 
#define tLeDier              0x7D 
#define tLcapIGrave         0x7F 
#define tLcapICaret         0x80 
#define tLcapIDier         0x81 
#define tLiAcute         0x82 
#define tLiGrave         0x83 
#define tLiCaret         0x84 
#define tLiDier              0x85 
#define tLcapOAcute         0x86 
#define tLcapOGrave         0x87 
#define tLcapOCaret         0x88 
#define tLcapODier         0x89 
#define tLoAcute         0x8A 
#define tLoGrave         0x8B 
#define tLoCaret         0x8C 
#define tLoDier              0x8D 
#define tLcapUAcute         0x8E 
#define tLcapUGrave         0x8F 
#define tLcapUCaret         0x90 
#define tLcapUDier         0x91 
#define tLuAcute         0x92 
#define tLuGrave         0x93 
#define tLuCaret         0x94 
#define tLuDier              0x95 
#define tLcapCCed         0x96 
#define tLcCed              0x97 
#define tLcapNTilde         0x98 
#define tLnTilde         0x99 
#define tLaccent         0x9A 
#define tLgrave              0x9B 
#define tLdieresis         0x9C 
#define tLquesDown         0x9D 
#define tLexclamDown         0x9E 
#define tLalpha              0x9F 
#define tLbeta              0x0A0 
#define tLgamma              0x0A1 
#define tLcapDelta         0x0A2 
#define tLdelta              0x0A3 
#define tLepsilon         0x0A4 
#define tLlambda         0x0A5 
#define tLmu              0x0A6 
#define tLpi              0x0A7 
#define tLrho              0x0A8 
#define tLcapSigma         0x0A9 
#define tLphi              0x0AB 
#define tLcapOmega         0x0AC 
#define tLphat              0x0AD 
#define tLchi              0x0AE 
#define tLstatF              0x0AF 
#define tLa              0x0B0 
#define tLb              0x0B1 
#define tLc              0x0B2 
#define tLd              0x0B3 
#define tLsmalle         0x0B4 
#define tLf              0x0B5 
#define tLsmallg         0x0B6 
#define tLh              0x0B7 
#define tLi              0x0B8 
#define tLj              0x0B9 
#define tLk              0x0BA 
#define tLl              0x0BC 
#define tLm              0x0BD 
#define tLsmalln         0x0BE 
#define tLo              0x0BF 
#define tLp              0x0C0 
#define tLq              0x0C1 
#define tLsmallr         0x0C2 
#define tLs              0x0C3 
#define tLsmallt         0x0C4 
#define tLu              0x0C5 
#define tLv              0x0C6 
#define tLw              0x0C7 
#define tLx              0x0C8 
#define tLy              0x0C9 
#define tLz              0x0CA 
#define tLsigma              0x0CB 
#define tLtau              0x0CC 
#define tLcapIAcute         0x0CD 
#define tGarbagec         0x0CE 
#define LastToken         0x0CE  //tLAST TOKEN IN THIS VERSION...

//Data Type Equates                                                    
//---------------------------------------------------------------------
#define RealObj                0  
#define ListObj                1  
#define MatObj                2  
#define EquObj                3  
#define StrngObj           4  
#define ProgObj                5  
#define ProtProgObj           6  
#define PictObj                7  
#define GDBObj                8  
#define UnknownObj           9  
#define UnknownEquObj         0x0A 
#define NewEquObj         0x0B 
#define CplxObj              0x0C 
#define CListObj         0x0D 
#define UndefObj         0x0E 
#define WindowObj         0x0F 
#define ZStoObj              0x10 
#define TblRngObj         0x11 
#define LCDObj              0x12 
#define BackupObj         0x13 
#define AppObj              0x14      //application, only used in menus/link
#define AppVarObj         0x15      //application variable
#define TempProgObj         0x16  //program, home deletes when finished
#define GroupObj         0x17  //group.

//I/O Equates                                                          
//---------------------------------------------------
#define D0D1_bits         0x03 
#define D0LD1L              0x03 
#define D0LD1H              0x01 
#define D0HD1L              0x02 
#define D0HD1H              0x00 
#define bport                0   //4-bit link port (I/O) 

//Device Codes
//-----------------------------------------------------------------
#define TI82DEV              0x82 
#define PC82DEV              0x02 
#define MAC82DEV         0x12 
#define TI83FDEV         0x73 
#define LINK83FDEV         0x23 
#define TI83DEV              0x83 
#define PC83DEV              0x03 
#define MAC83DEV         0x13 
#define TI85DEV              0x95  //different than real 85 so me talk
#define PC85DEV              0x05 
#define MAC85DEV         0x15 
#define TI73DEV              0x74  //device x3 is always an 83
#define PC73DEV              0x07 
#define MAC73DEV         0x17 
#define LINK73FDEV         0x23 
#define PC83FDEV         0x23 

//System Error Codes                                                  
//-----------------------------------------------------------
#define E_EDITF                7   //allow re-entering application
#define E_EDIT                1<<E_EDITF  
#define E_Mask              0x7F 
#define E_Overflow           1+E_EDIT  
#define E_DivBy0           2+E_EDIT  
#define E_SingularMat           3+E_EDIT  
#define E_Domain           4+E_EDIT  
#define E_Increment           5+E_EDIT  
#define E_Break                6+E_EDIT  
#define E_NonReal           7+E_EDIT  
#define E_Syntax           8+E_EDIT  
#define E_DataType           9+E_EDIT  
#define E_Argument           10+E_EDIT  
#define E_DimMismatch           11+E_EDIT  
#define E_Dimension           12+E_EDIT  
#define E_Undefined           13+E_EDIT  
#define E_Memory           14+E_EDIT  
#define E_Invalid           15+E_EDIT  
#define E_IllegalNest           16+E_EDIT  
#define E_Bound                17+E_EDIT  
#define E_GraphRange           18+E_EDIT  
#define E_Zoom                19+E_EDIT  
#define E_Label                20  
#define E_Stat                21  
#define E_Solver           22+E_EDIT  
#define E_Singularity           23+E_EDIT  
#define E_SignChange           24+E_EDIT  
#define E_Iterations           25+E_EDIT  
#define E_BadGuess           26+E_EDIT  
#define E_StatPlo           27  
#define E_TolTooSmall           28+E_EDIT  
#define E_Reserved           29+E_EDIT  
#define E_Mode                30+E_EDIT  
#define E_LnkErr           31+E_EDIT  
#define E_LnkMemErr           32+E_EDIT  
#define E_LnkTransErr           33+E_EDIT  
#define E_LnkDupErr           34+E_EDIT  
#define E_LnkMemFull           35+E_EDIT  
#define E_Unknown           36+E_EDIT  
#define E_Scale                37+E_EDIT  
#define E_IdNotFound           38  
#define E_NoMode           39+E_EDIT  
#define E_Validation           40  
#define E_Length           41+E_EDIT  
#define E_Application           42+E_EDIT  
#define E_AppErr1           43+E_EDIT  
#define E_AppErr2           44+E_EDIT  
#define E_ExpiredApp           45  
#define E_BadAdd           46  
#define E_Archived           47+E_EDIT  
#define E_Version           48  
#define E_ArchFull           49  
#define E_Variable           50+E_EDIT  
#define E_Duplicate           51+E_EDIT  
#define HigErrNum           51  
//Obsolete error numbers 34 ;first LINK error
#define E_LinkIOChkSum           34  
#define E_LinkIOTimeOut           35  
#define E_LinkIOBusy           36  
#define E_LinkIOVer           37  

//Equates To RAM Locations For Stat Vars
//----------------------------------------------------------------
#define FPLEN                9   //Length of a floating-point number.
#define StatN                statVars  
#define XMean                StatN + FPLEN  
#define SumX                XMean + FPLEN  
#define SumXSqr                SumX + FPLEN  
#define StdX                SumXSqr + FPLEN  
#define StdPX                StdX + FPLEN  
#define MinX                StdPX + FPLEN  
#define MaxX                MinX + FPLEN  
#define MinY                MaxX + FPLEN  
#define MaxY                MinY + FPLEN  
#define YMean                MaxY + FPLEN  
#define SumY                YMean + FPLEN  
#define SumYSqr                SumY + FPLEN  
#define StdY                SumYSqr + FPLEN  
#define StdPY                StdY + FPLEN  
#define SumXY                StdPY + FPLEN  
#define Corr                SumXY + FPLEN  
#define MedX                Corr + FPLEN  
#define Q1                MedX + FPLEN  
#define Q3                Q1 + FPLEN  
#define QuadA                Q3 + FPLEN  
#define QuadB                QuadA + FPLEN  
#define QuadC                QuadB + FPLEN  
#define CubeD                QuadC + FPLEN  
#define QuartE                CubeD + FPLEN  
#define MedX1                QuartE + FPLEN  
#define MedX2                MedX1 + FPLEN  
#define MedX3                MedX2 + FPLEN  
#define MedY1                MedX3 + FPLEN  
#define MedY2                MedY1 + FPLEN  
#define MedY3                MedY2 + FPLEN  
#define PStat                MedY3 + 2*FPLEN  
#define ZStat                PStat + FPLEN  
#define TStat                ZStat + FPLEN  
#define ChiStat                TStat + FPLEN  
#define FStat                ChiStat + FPLEN  
#define DF                FStat + FPLEN  
#define Phat                DF + FPLEN  
#define Phat1                Phat + FPLEN  
#define Phat2                Phat1 + FPLEN  
#define MeanX1                Phat2 + FPLEN  
#define StdX1                MeanX1 + FPLEN  
#define StatN1                StdX1 + FPLEN  
#define MeanX2                StatN1 + FPLEN  
#define StdX2                MeanX2 + FPLEN  
#define StatN2                StdX2 + FPLEN  
#define StdXP2                StatN2 + FPLEN  
#define SLower                StdXP2 + FPLEN  
#define SUpper                SLower + FPLEN  
#define SStat                SUpper + FPLEN  
#define F_DF                anovaf_vars  
#define F_SS                F_DF + FPLEN  
#define F_MS                F_SS + FPLEN  
#define E_DF                F_MS + FPLEN  
#define E_SS                E_DF + FPLEN  
#define E_MS                E_SS + FPLEN  



//! [bulk]


#endif

#ifdef DOXYGEN
void _();     // needed to keep doxygen including the file
#endif
