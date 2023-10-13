DIRECTORY=$(cd `dirname $0` && pwd)



export MAINC="main.c"
export OUT_NAME=$2


docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -subtype=asm -o $1/$OUT_NAME.bin $1/$MAINC
cat <( echo -ne "\xbb\x6d" ) $1/$OUT_NAME.bin > $1/$OUT_NAME.bin2

cd $1
python $DIRECTORY/other_files/binpac8x.py $OUT_NAME.bin2 -O $OUT_NAME


