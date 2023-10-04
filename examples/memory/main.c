#define USE_HEXDUMP

#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/memory.c"




void main() {

	clearScreen();
	resetPen();

	initHeap();             // Create the heap 

	fputs("Here is 50 bytes: ");
	void* temp = malloc(50);
	doubleHexdump((int)temp);
	newline();
	newline();


	fputs("Here is another 50: ");
	void* temp2 = malloc(50);
	doubleHexdump((int)temp2);
	newline();
	newline();

	println("Lets free the first 50.");
	newline();
	free(temp);

	fputs("Here is 50 more bytes: ");
	void* temp3 = malloc(50);
	doubleHexdump((int)temp3);
	newline();





	
	PressAnyKey();
	purge_heap();
}