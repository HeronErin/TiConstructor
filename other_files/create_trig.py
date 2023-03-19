import math

x = []
for i in range(360):
	if i%2==0: continue
	deg = i

	sn = int(math.sin(math.radians(i)) * 256)
	
	x.append(sn)
print(x)