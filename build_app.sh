DIRECTORY=$(cd `dirname $0` && pwd)

cd $1

if [ ! -f .buildid ]; then
    echo 0x$(openssl rand -hex 2) > .buildid
fi
BC="$(cat .buildid)"
echo $BC



export MAINC="main.c"
export OUT_NAME=$2

trunkName=$(head -c 8 <<<$2) # truncate name to make sure it is no more than 8 char long

# Compile with custom crt0
docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -subtype=asm -o $1/$OUT_NAME.bin $1/$MAINC -crt0 other_files/ti83p_crt0_app.asm

# Now we need to rebuild the .bin with our custom name

nameLn=${#trunkName} #length of trunkName

cat $OUT_NAME.bin | head -c 18 > x.bin # Write bytes before name in header
echo -n $trunkName >> x.bin # Write your name

# Pad name (if needed)
while [ $nameLn -lt 8 ]
do
  echo -n " " >> x.bin
  ((nameLn++))
done

# Write rest of app
cat $OUT_NAME.bin | tail -c+27 >> x.bin
mv x.bin $OUT_NAME.bin

$DIRECTORY/other_files/rabbitsign -t 8xk -g -f $OUT_NAME.bin

# rm $OUT_NAME.bin