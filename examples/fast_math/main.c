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



#define SPEED_CO 1


// Global vars
#define VAR_BASE 0x8A3A
#define posX *((int*)VAR_BASE)
#define posY *((int*)(&posX  + sizeof(int)   ))
#define dirX *((int*)(&posY  + sizeof(int)   ))
#define dirY *((int*)(&dirX  + sizeof(int)   ))
#define planeX *((int*)(&dirY  + sizeof(int)   ))
#define planeY *((int*)(&planeX  + sizeof(int)   ))
// #define oldDirX *((int*)(&planeY  + sizeof(int)   ))
// #define oldDirY *((int*)(&oldDirX  + sizeof(int)   ))
#define cosTemp *((int*)(&planeX  + sizeof(int)   ))
#define sinTemp *((int*)(&cosTemp  + sizeof(int)   ))
// Temp vars
// #define TVAR_BASE 0x9D95

// FX temp vars
#define cameraX *((int*)(&sinTemp  + sizeof(int)   ))
#define rayDirX *((int*)(&cameraX  + sizeof(int)   ))
#define rayDirY *((int*)(&rayDirX  + sizeof(int)   ))
#define sideDistX *((int*)(&rayDirY  + sizeof(int)   ))
#define sideDistY *((int*)(&sideDistX  + sizeof(int)   ))
#define deltaDistX *((int*)(&sideDistY  + sizeof(int)   ))
#define deltaDistY *((int*)(&deltaDistX  + sizeof(int)   ))
// #define perpWallDist *((int*)(&deltaDistY  + sizeof(int)   ))
#define mapX  *((int*)(&deltaDistY  + sizeof(int)   ))
#define mapY  *((int*)(&mapX  + sizeof(int)   ))
// char temp vars
#define stepX *((signed char*)(&mapY  + sizeof(int)   ))
#define stepY *((signed char*)(&stepX  + sizeof(int)   ))
#define hit *((char*)(&stepY  + sizeof(int)   ))
#define side *((char*)(&hit  + sizeof(char)   ))
// #define lineHeight *((char*)(&side  + sizeof(char)   ))
#define drawStart *((signed char*)(&side  + sizeof(char)   ))
#define drawEnd *((signed char*)(&drawStart  + sizeof(char)   ))

#define x_temp *((int*)(&drawEnd  + sizeof(char)   ))

#define mapX_temp  *((char*)(&x_temp  + sizeof(int)   ))
#define mapY_temp  *((char*)(&mapX_temp  + sizeof(char)   ))

// Constants
#define moveSpeed FX(1)
#define rotSpeed FX(1)
#define w XMAX
#define h YMAX
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


void main() {
	// clearBuffer();
	// // line(30, 0, 30, XMAX-1);
	// for (char x = 0; x!= XMAX; x+=1)
	// vertical_line(w-5, 22, 28, 0);

	// swap();
	// PressAnyKey();
	// return;
	setCpuSpeed(3);
	posX = FX(6); posY = FX(6);  //x and y start position
	dirX = FX(-1); dirY = 0; //initial direction vector
	planeX = 0; planeY = FX(0.66); //the 2d raycaster version of camera plane
	clearScreen();
	resetPen();

	clearBuffer();
	while (1){
		swap();
		clearBuffer();
		// swap();
		for (x_temp = 0; x_temp!=(w*256); x_temp+=(256*SPEED_CO)){
		      //calculate ray position and direction
		      cameraX = 2 *FX_div(x_temp, w*256)-256; //x-coordinate in camera space
		      rayDirX = dirX+FX_mul(planeX, cameraX);
		      rayDirY = dirY+FX_mul(planeY, cameraX);
		      //which box of the map we're in
		      mapX = FX_floor(posX);
		      mapY = FX_floor(posY);



		      //length of ray from one x or y-side to next x or y-side
		      //these are derived as:
		      //deltaDistX = sqrt(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX))
		      //deltaDistY = sqrt(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY))
		      //which can be simplified to abs(|rayDir| / rayDirX) and abs(|rayDir| / rayDirY)
		      //where |rayDir| is the length of the vector (rayDirX, rayDirY). Its length,
		      //unlike (dirX, dirY) is not 1, however this does not matter, only the
		      //ratio between deltaDistX and deltaDistY matters, due to the way the DDA
		      //stepping further below works. So the values can be computed as below.
		      // Division through zero is prevented, even though technically that's not
		      // needed in C++ with IEEE 754 floating point values.
		      if (rayDirX == 0) continue;
		      if (rayDirY == 0) continue;
		      deltaDistX = FX_div(FX(1) , FX_abs(rayDirX) );
		      deltaDistY = FX_div(FX(1) , FX_abs(rayDirY) );


		      // double perpWallDist;

		      //what direction to step in x or y-direction (either +1 or -1)
		      // int stepX;
		      // int stepY;

		      hit = 0; //was there a wall hit?
		      // int side; //was a NS or a EW wall hit?
		      //calculate step and initial sideDist

		      if(rayDirX < 0)
		      {
		        stepX = -1;
		        sideDistX = FX_mul((posX - mapX), deltaDistX);
		      }
		      else
		      {
		        stepX = 1;
		        sideDistX = FX_mul((mapX + 256 - posX) , deltaDistX);
		      }
		      if(rayDirY < 0)
		      {
		        stepY = -1;
		        sideDistY = FX_mul((posY - mapY) , deltaDistY);
		      }
		      else
		      {
		        stepY = 1;
		        sideDistY = FX_mul((mapY + 256 - posY) , deltaDistY);
		      }

		      mapX_temp = FX_floor_int(mapX);
		      mapY_temp = FX_floor_int(mapY);

		      char mapX_temp_temp2 = mapX_temp;
		      // char mapY_temp_temp = mapY_temp;
		      //perform DDA
		      char didhit = 0;
		      while(didhit == 0)
		      {
		        //jump to next map square, either in x-direction, or in y-direction
		        if(sideDistX < sideDistY)
		        {
		          sideDistX += deltaDistX;
		          mapX_temp_temp2 += stepX;
		          side = 0;
		        }
		        else
		        {
		          sideDistY += deltaDistY;
		          mapY_temp += stepY;
		          side = 1;
		        }
		        //Check if ray has hit a wall
		        if(worldMap[mapX_temp_temp2][mapY_temp] > 0) didhit = 1;
		      }
  	      		// number(stepX);
	      		// newline();
	      		// number(stepY);
		      	// newline();

  	      		// FX_number(deltaDistX);
	      		// newline();
	      		// FX_number(deltaDistY);
		      	// newline();

  	      		// number(mapX_temp);
	      		// newline();
	      		// number(mapY_temp);
		      	// newline();

  	      		// FX_number(sideDistX);
	      		// newline();
	      		// FX_number(sideDistY);
		      	// newline();
				// PressAnyKey();
				// return;

		      //Calculate distance projected on camera direction. This is the shortest distance from the point where the wall is
		      //hit to the camera plane. Euclidean to center camera point would give fisheye effect!
		      //This can be computed as (mapX - posX + (1 - stepX) / 2) / rayDirX for side == 0, or same formula with Y
		      //for size == 1, but can be simplified to the code below thanks to how sideDist and deltaDist are computed:
		      //because they were left scaled to |rayDir|. sideDist is the entire length of the ray above after the multiple
		      //steps, but we subtract deltaDist once because one step more into the wall was taken above.
		      int perpWallDist;
		      if(side == 0) perpWallDist = (sideDistX - deltaDistX);
		      else          perpWallDist = (sideDistY - deltaDistY);

		      //Calculate height of line to draw on screen
		      char lineHeight = FX_floor_int( FX_div(FX(h) , perpWallDist));

		      //calculate lowest and highest pixel to fill in current stripe
		      drawStart = -lineHeight / 2 + h / 2;
		      if(drawStart < 0) drawStart = 0;
		      drawEnd = lineHeight / 2 + h / 2;
		      if(drawEnd >= h) drawEnd = h - 1;

		      if (drawStart < 0) drawStart = 0;
		      if (drawEnd < 0) drawEnd = 0;

		      if (drawEnd > YMAX) continue;
		      if (drawStart > drawEnd) drawStart = drawEnd;


		      // number(drawStart);
		      // newline();
		      // number(drawEnd);
		      // newline();
		      // number(drawEnd-drawStart);
		      // PressAnyKey();
		      // clearScreen();
		      // resetPen();
		      // vertical_line(rlx, drawEnd, drawStart, 0);

		      char rlx = FX_floor_int(x_temp);

		      for (char Q = 0; Q != SPEED_CO; Q++){
		      	if (side == 1)
			  		vertical_line(rlx, drawStart, drawEnd-drawStart, 0);
			  	else
			  		vertical_dotted_line(rlx, drawStart, drawEnd-drawStart, 0);
			  	rlx+=1;

			  	// break;
			  }

    	}
    	if (skClear == lastPressedKey())
			break;
		else if (skLeft == lastPressedKey()){
			int crot = FX(0.98); //FX_cos(10);
			int srot = FX(0.17); //FX_sine(10);
			int oldDirX = dirX;
			dirX = FX_mul(dirX , crot) - FX_mul(dirY , srot);
			dirY = FX_mul(oldDirX , srot) + FX_mul(dirY , crot);
			int oldP__laneX = planeX;
			planeX = FX_mul(planeX , crot) - FX_mul(planeY , srot);
			planeY = FX_mul(oldP__laneX , srot) + FX_mul(planeY , crot);
		}
		else if (skRight == lastPressedKey()){
			int crot = FX(0.98);//FX_cos(-10);
			int srot = FX(-0.17);//FX_sine(-10);
			int oldDirX = dirX;
			dirX = FX_mul(dirX , crot) - FX_mul(dirY , srot);
			dirY = FX_mul(oldDirX , srot) + FX_mul(dirY , crot);
			int oldP__laneX = planeX;
			planeX = FX_mul(planeX , crot) - FX_mul(planeY , srot);
			planeY = FX_mul(oldP__laneX , srot) + FX_mul(planeY , crot);

		}
		else if (skUp == lastPressedKey()){
	      if(worldMap[FX_floor_int(posX + dirX )][FX_floor_int(posY)] == 0) posX += dirX>>1;
	      if(worldMap[FX_floor_int(posX)][FX_floor_int(posY + dirY )] == 0) posY += dirY>>1;

		}
		else if (skDown == lastPressedKey()){
	      if(worldMap[FX_floor_int(posX - dirX )][FX_floor_int(posY)] == 0) posX -= dirX>>1;
	      if(worldMap[FX_floor_int(posX)][FX_floor_int(posY - dirY )] == 0) posY -= dirY>>1;

		}

	}

}