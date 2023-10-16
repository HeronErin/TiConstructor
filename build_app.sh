DIRECTORY=$(cd `dirname $0` && pwd)

cd $1




export MAINC="main.c"
export OUT_NAME=$2

trunkName=$(head -c 8 <<<$2) # truncate name to make sure it is no more than 8 char long

# Compile with custom crt0
docker run -v ${DIRECTORY}:/src/ z88dk/z88dk zcc +ti83p -DFLASH_APP -subtype=asm -o $1/$OUT_NAME.bin $1/$MAINC -crt0 other_files/ti83p_crt0_app.asm $3

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
rm -f $OUT_NAME.bin # Could be write protected 
mv x.bin $OUT_NAME.bin

$DIRECTORY/other_files/rabbitsign -t 8xk -g -f $OUT_NAME.bin

# rm $OUT_NAME.bin