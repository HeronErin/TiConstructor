#pragma once

#define PressAnyKey() bcall(0x4972)


#ifdef USE_GETKEY
int getKey(){
    bcall(0x4015);
    return *((char*)(0x843F));
}
#endif

