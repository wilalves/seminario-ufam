from PIL import Image
import numpy as np

im = Image.open('../imgs/teste.png')
im.show()
M, N = im.size
mm = im.load()

flags = flags = Image.new("L", (M,N), color=1)
ff = flags.load()

def erode(x,y):
    if mm[x,y] == 0:
        mm[x,y] = 255
        ff[x,y] = 0
        
for x in range(1,M-1):
    for y in range(1,N-1):
        if mm[x,y]==255 and ff[x,y] == 1:
            erode(x-1,y-1)
            erode(x,y-1)
            erode(x+1,y-1)
            erode(x-1,y)
            erode(x+1,y)
            erode(x-1,y+1)
            erode(x,y+1)
            erode(x+1,y+1)

output = Image.fromarray(np.uint8(im))
output.show()
out_img.save('out_erode.png', 'png')