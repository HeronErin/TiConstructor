#define USE_NUMBER
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"




void main() {

	clearScreen();
	resetPen();

	println("Hello 8-bit World!");
	newline();
	PressAnyKey();
	
	return;

}