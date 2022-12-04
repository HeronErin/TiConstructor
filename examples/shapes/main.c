#define USE_LINE
#define USE_CIRCLE
#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/userinput.c"
#include "../../lib/graphics.c"

void main() {

	clearScreen(); // prepare screen
	clearBuffer(); // clear drawing buffer
	
	// triangle 
	line(15, 20, 5, 40);
	line(15, 20, 25, 40);
	line(5, 40, 25, 40);

	// rectangle
	line(3, 5, 3, 20);
	line(10, 5, 10, 20);
	line(3, 5, 10, 5);
	line(3, 20, 10, 20);

	// cube
	#define X1 30
	#define Y1 24
	#define X2 50
	#define Y2 44
	#define OF 13
	line(X1, Y1, X2, Y1);
	line(X1, Y2, X2, Y2);
	line(X1, Y1, X1, Y2);
	line(X2, Y1, X2, Y2);

	line(X1+OF, Y1+OF, X2+OF, Y1+OF);
	line(X1+OF, Y2+OF, X2+OF, Y2+OF);
	line(X1+OF, Y1+OF, X1+OF, Y2+OF);
	line(X2+OF, Y1+OF, X2+OF, Y2+OF);

	line(X1, Y1, X1+OF, Y1+OF);
	line(X1, Y2, X1+OF, Y2+OF);
	line(X2, Y1, X2+OF, Y1+OF);
	line(X2, Y2, X2+OF, Y2+OF);
	
	// single circle
	circle(40, 10, 10);


	// cylinder
	circle(70, 10, 8);
	circle(XMAX-10, 40, 8);
	line(70+8, 10, XMAX-10+9, 40);
	line(70-8, 10, XMAX-10-9, 40);
	

	swap();





	PressAnyKey();

}