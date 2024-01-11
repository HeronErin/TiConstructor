#!/bin/bash
export MAINC="main.c"
export OUT_NAME=$2

cd $1
zcc +ti83p -create-app -subtype=app_one_page -o $OUT_NAME.bin $MAINC -pragma-string:name=$2
mv $OUT_NAME.bin.8xk $OUT_NAME.8xk