# sh build_app.sh examples/shapes/ shapes 
# sh build_prog.sh examples/shapes/ shapes
# sh build_prog.sh examples/helloworld/ helloWorld 

docker run -v $(pwd):/src/ z88dk/z88dk cp /opt/z88dk/lib/target/ti83p/classic/intwrap83p.asm other_files/intwrap83p.asm