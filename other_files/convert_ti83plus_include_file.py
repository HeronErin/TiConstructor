import requests, re

HEX_FIND_PATTERN = r'[0-9A-Fa-f]h[^0-9A-Za-z]'
HEX_GET_PATTERN = r'[0-9A-Fa-f]h'

BIN_FIND_PATTERN = r'[01]b'
def main():
	base = requests.get("https://www.brandonw.net/calcstuff/ti83plus.txt").text
	lines = base.split("\n")

	out = ""

	for line in lines:
		line = line.replace("\t", " "*5)

		comment = ""
		if ";" in line:
			Loc = line.find(";")
			comment = "//"+line[Loc+1:]
			line = line[:Loc]
		if not line.strip():
			# print(line.strip(), comment)
			out+=comment + '\n'
		elif " equ " in line:
			

			p1, p2 = line[:line.find(" equ ")], line[4+line.find(" equ "):]+"  "
			

			hx_rg = re.search(HEX_FIND_PATTERN, p2)
			bn_rg = re.search(BIN_FIND_PATTERN, p2)

			if hx_rg:
				hx_rg = re.search(HEX_GET_PATTERN, p2)

				out += "#define " + p1 + "0x"+p2[:hx_rg.end()-1].lstrip() + p2[hx_rg.end()+1:]+comment +"\n"
			elif bn_rg:
				out +="#define " + p1 + "0b"+p2[:bn_rg.end()-1].lstrip() + p2[bn_rg.end()+1:] +comment+"\n"
			else:
				out += "#define " + p1 +" "+ p2 +comment+ "\n"
		else:
			if line.strip():
				out += "// OMITED LINE: " + line +comment+"\n"
	f = open("ti83plus.inc.out", "w")
	f.write(out)
	f.close()
	# print(out, "4FD8" in out)
	# print(out)



if __name__ == "__main__":
	main()