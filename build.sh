DIRECTORY=$(cd `dirname $0` && pwd)



export MAINC="hello.c"
export OUT_NAME="helloworld"


# sdasz80 -p -g -o tios_crt0.rel $DIRECTORY/other_files/tios_crt0.s


# sdcc -DRAM_PROG --no-std-crt0 --code-loc 40347 --data-loc 0 --std-sdcc99 -mz80 --reserve-regs-iy -o $OUT_NAME.ihx tios_crt0.rel $MAINC

# /opt/z88dk/lib/target/ti83p/classic/ti83p_crt0.asm
# docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -subtype=asm -Cz--altfmt -lm -o x/hello.bin hello.c

docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -lm -o x/v.bin hello.c -create-app

# sleep 1

cd x
cp v.bin x.bin
python $DIRECTORY/other_files/binpac8x.py x.bin -O ad
# docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -crt0 other_files/tios_crt0.s -lm -o x/hello.bin hello.c
# zcc +ti83p -startup=10 -Cz--altfmt -lm -o x/adv_a -create-app hello.c

# python $DIRECTORY/other_files/binpac8x.py $DIRECTORY/x/hello.bin -O wee


# docker run -v ${DIRECTORY}:/src/ z88dk/z88dk z88dk-dis x/hello.bin

# +z80 -vn -mz80 --reserve-regs-iy --no-cleanup -o examples/helloworld examples/helloworld/main.c