#define FX_TRIG
#define USE_NUMBER
#define USE_LINE
#define USE_CPU_SPEED

#define FORCE_FAST_MATH_CORRECT_SIGN

#include "../../lib/essentials.c"
#include "../../lib/textio.c"
#include "../../lib/fast_math.c"
#include "../../lib/userinput.c"
#include "../../lib/graphics.c"
#include "../../lib/misc.c"


#define mapWidth 8
#define mapHeight 8
const char worldMap[mapWidth][mapHeight]={
	{1, 1, 1, 1, 1, 1, 1, 1},
	{1, 0, 1, 0, 0, 0, 0, 1},
	{1, 0, 1, 0, 0, 1, 0, 1},
	{1, 0, 1, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 1},
	{1, 1, 1, 1, 1, 1, 1, 1},
};

#define CONSTANTS 0x865F


#define posX *((int*)VAR_BASE)
#define posY *((int*)(&posX  + sizeof(int)   ))


void draw2d(){
	for (char x = 0; x != mapWidth; x++){
		for (char y = 0; y != mapHeight; y++){
			char xoof = x<<
			line(x, y, x, y);
		}
	}
}



void main() {
	posX = FX(1);
	posY = FX(1);

	clearScreen();
	resetPen();

	println("Hello 8-bit World!");

	FX_number(FX(12.34));

	PressAnyKey();

}