from PIL import Image
import sys, os

if len(sys.argv) != 3:
	print("Must have 2 arguments! \npython png2sprite.py IMAGE.png [mono or grey]")
	exit()

GREYSCALE=False if sys.argv[-1].lower() == "mono" else True
name = os.path.basename(sys.argv[1]).split(".")[0]

i = Image.open(sys.argv[1]).convert('L')
# print(i.__dict__)
upsize = i.width - (i.width%8) + 8
if i.width%8!=0:
	print(f"WARNING: {i.width} is not a multiple of 8! Assuming size of {upsize}")
else:
	upsize -=8
if GREYSCALE:

	light_grey = ["0b"]*(upsize//8)
	dark_grey = ["0b"]*(upsize//8)

	bitcount = [0]*(upsize//8)
	print(upsize)
	for y in range(i.height):
		for mx in range(len(bitcount)):
			for x in range(8):
				px = 0
				try:
					px = i.getpixel((x+ (mx*8), y))  
				except IndexError: pass
				
				q = [px, abs( (256/3)-px ), abs( (256/3*2)-px ), abs( 256-px ) ]
				ix = 3-q.index(min(q))
				# print(ix)
				binn = '{0:02b}'.format(ix)

				bitcount[mx]+=1
				light_grey[mx]+=binn[0]
				dark_grey[mx]+=binn[1]
				if bitcount[mx]%8==0:
					light_grey[mx]+=", 0b"
					dark_grey[mx]+=", 0b"

	# print(light_grey)
	pixels = ", ".join([o[:-4] for o in dark_grey ])+", "+ ", ".join([o[:-4] for o in light_grey])
	print("const char "+name+"_DATA[] ={" + pixels + "};")
	print(f"#define {name}_WIDTH {upsize}/8")
	print(f"#define {name}_HEIGHT {i.height}")
	print(f"// greyPutSprite(x, y, {name}_WIDTH, {name}_HEIGHT, {name}_DATA);")
else:
	bitcount = [0]*(upsize//8+1)
	out=["0b"]*(upsize//8+1)
	for y in range(i.height):
		for mx in range(len(out)):
			for x in range(8):
				px = 0
				try:
					px = i.getpixel((x+ (mx*8), y)) 
				except IndexError: pass
				num = int(1-round(px/256))
				# print(mx, bitcount)
				bitcount[mx]+=1
				out[mx]+=str(num)
				if bitcount[mx]%8==0:
					out[mx]+=", 0b"
	print("const char "+name+"_DATA[] ={" + ", ".join([o[:-4] for o in out]) + "};")
	print(f"#define {name}_WIDTH {upsize}/8")
	print(f"#define {name}_HEIGHT {i.height}")
	print(f"// fullPutSprite(x, y, {name}_WIDTH, {name}_HEIGHT, {name}_DATA);")