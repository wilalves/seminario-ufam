# -*- coding: utf-8 -*-
"""
Created on Mon Jul  3 23:23:18 2017 by Shion Honda
"""

from PIL import Image
import numpy as np

im = Image.open('../imgs/imagem1.jfif')
im = np.array(im)
shape = im.shape

flags = np.ones([shape[0],shape[1]])

def erode(x,y):
    if im[x,y][0] == 0:
        im[x,y] = [255,255,255]
        flags[x,y] = 0
        
for x in range(1,shape[0]-1):
    for y in range(1,shape[1]-1):
        if im[x,y][0]==255 and flags[x,y]==1:
            erode(x-1,y-1)
            erode(x,y-1)
            erode(x+1,y-1)
            erode(x-1,y)
            erode(x+1,y)
            erode(x-1,y+1)
            erode(x,y+1)
            erode(x+1,y+1)

output = Image.fromarray(np.uint8(im))
output.save('jfif.png')
