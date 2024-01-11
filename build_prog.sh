#!/bin/bash
export MAINC="main.c"
export OUT_NAME=$2

cd $1
zcc +ti83p -subtype=asm -create-app -o $OUT_NAME.bin $MAINC
# echo docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -subtype=asm -o $OUT_NAME.bin $MAINC
# +ti83p -DRAM_PROG -subtype=asm -create-app -o $1/$OUT_NAME.bin $1/$MAINC $3
# rm $OUT_NAME.bin $OUT_NAME.bin2

