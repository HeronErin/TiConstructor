#pragma once
/** @file variables.c @brief Used for working with calculator variables 
 */

/** @{ \name Adds token to string constant for variable name */
#define addRealObj(xxxxxxxxxx)					("\x00" xxxxxxxxxx)
#define addListObj(xxxxxxxxxx)					("\x01" xxxxxxxxxx)
#define addMatObj(xxxxxxxxxx)					("\x02" xxxxxxxxxx)
#define addEquObj(xxxxxxxxxx)					("\x03" xxxxxxxxxx)
#define addStrngObj(xxxxxxxxxx)					("\x04" xxxxxxxxxx)
#define addProgObj(xxxxxxxxxx)					("\x05" xxxxxxxxxx)
#define addProtProgObj(xxxxxxxxxx)				("\x06" xxxxxxxxxx)
#define addPictObj(xxxxxxxxxx)					("\x07" xxxxxxxxxx)
#define addGDBObj(xxxxxxxxxx)					("\x08" xxxxxxxxxx)
#define addUnknownObj(xxxxxxxxxx)				("\x09" xxxxxxxxxx)
#define addUnknownEquObj(xxxxxxxxxx)			("\x0A" xxxxxxxxxx)
#define addNewEquObj(xxxxxxxxxx)				("\x0B" xxxxxxxxxx)
#define addCplxObj(xxxxxxxxxx)					("\x0C" xxxxxxxxxx)
#define addCListObj(xxxxxxxxxx)					("\x0D" xxxxxxxxxx)
#define addUndefObj(xxxxxxxxxx)					("\x0E" xxxxxxxxxx)
#define addWindowObj(xxxxxxxxxx)				("\x0F" xxxxxxxxxx)
#define addZStoObj(xxxxxxxxxx)					("\x10" xxxxxxxxxx)
#define addTblRngObj(xxxxxxxxxx)				("\x11" xxxxxxxxxx)
#define addLCDObj(xxxxxxxxxx)					("\x12" xxxxxxxxxx)
#define addBackupObj(xxxxxxxxxx)				("\x13" xxxxxxxxxx)
#define addAppObj(xxxxxxxxxx)					("\x14" xxxxxxxxxx)
#define addAppVarObj(xxxxxxxxxx)				("\x15" xxxxxxxxxx)
#define addTempProgObj(xxxxxxxxxx)				("\x16" xxxxxxxxxx)
#define addGroupObj(xxxxxxxxxx)					("\x17" xxxxxxxxxx)

/** @} */



/** @brief Gets a var or creates one a given size
* @param[name] the name of a variable after adding the type to the name (like with addAppVarObj())
* @param[size] the size of a variable
* @return Memory address of the variable
* 
*  
* I only care about appvars, but delete and archive should work for anything
* Also float math could be combined with these of you use _StoSysTok
* see: https://taricorp.gitlab.io/83pa28d/lesson/day19.html and https://taricorp.gitlab.io/83pa28d/lesson/day20.html
*/

char* getOrCreateVar(char* name, int size)__naked{
	__asm
		pop de
		pop hl
		push hl
		push de



		rst 0x20 //  Mov9ToOP1
		abcall(_ChkFindSym)
		jr c,notfound  
		ex de,hl  
		xor a 
		cp  b
		jr z,unarchived


		di

		exx
		push ix
		abcall(_Arc_Unarc)
		pop ix
		exx

		ei
		jp _getOrCreateVar


		unarchived:

		ret

		notfound:
			pop de
			pop bc
			pop hl // hl = size
			push hl
			push bc
			push de

			abcall(_CreateAppVar)
			jp _getOrCreateVar


		
	__endasm;
}

/** 
 * @brief Toggles if a var is archived.
 * @param[name] Name of the var to be archived/archived
 * 
 * See: https://wikiti.brandonw.net/index.php?title=83Plus:BCALLs:4FD8
 */ 


// took me 7 hours to figure out, but _Arc_Unarc destroys everything and it is better off to let it destroy the shadow registers instead, otherwise everything crashes
void archive(char* name)__naked{
	__asm
		pop de
		pop hl
		push hl
		push de

		rst 0x20 ; Mov9ToOP1
		di

		exx
		push ix
		abcall(_Arc_Unarc)
		pop ix
		exx

		ei
		ret

	__endasm;

}

/** 
 * @brief Delete a var
 * @param[name] Name of the var to be removed 
 */ 

void delete(char* name)__naked{
	__asm
		pop de
		pop hl
		push hl
		push de

		rst 0x20 ; Mov9ToOP1
		abcall(_ChkFindSym)
		abcall(_DelVar)
		ret
	__endasm;
}