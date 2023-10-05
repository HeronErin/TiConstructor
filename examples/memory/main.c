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

	fputs("Here is 2 sets of 20 bytes: ");
	newline();
	void* temp4 = malloc(20);
	doubleHexdump((int)temp4);
	newline();
	void* temp5 = malloc(20);
	doubleHexdump((int)temp5);

	PressAnyKey();
	purge_heap();         // Resets the heap for the next person
}