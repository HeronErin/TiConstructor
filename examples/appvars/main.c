#define USE_HEXDUMP
#define USE_WAIT8
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/misc.c"
#include "../../lib/userinput.c"
#include "../../lib/variables.c"


#define dataName addAppVarObj("myappdata") // need to add type data to appVar name




void main() {

	clearScreen();
	resetPen();



	char* dataLoc=getOrCreateVar(dataName, 20)+2; // 20 bytes long, add 2 to dataLoc because first 2 bytes if appvar is the length

	while (1){
		wait(2);

		if (skClear == lastPressedKey())
			break;
		else if (skLeft == lastPressedKey()){
			*dataLoc -=1;
		}
		else if (skRight == lastPressedKey()){
			*dataLoc +=1;
		}
		else if (skUp == lastPressedKey()){
			*(dataLoc+1) +=1;
		}
		else if (skDown == lastPressedKey()){
			*(dataLoc+1) -=1;
		}

		resetPen();
		hexdump(*(char*)dataLoc);
		hexdump(*(char*)(dataLoc+1));
	}

	archive(dataName); // this makes the appVar persist after ram clears (also means corrupt settings data will persist)
	

}