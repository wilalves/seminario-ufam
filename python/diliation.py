# -*- coding: utf-8 -*-
"""
Created on Mon Jul  3 22:35:35 2017 by Shion Honda
"""


from PIL import Image
import numpy as np

nm = 'crocodile'

im = Image.open('../imgs/original.png').convert('L')
im = np.array(im)
shape = im.shape
flags = np.ones([shape[0],shape[1]])

def diliate(x,y):
    if im[x,y][0] == 255:
        im[x,y] = [0,0,0]
        flags[x,y] = 0

# ラスタースキャン
for x in range(1,shape[0]-1):
    for y in range(1,shape[0]-1):
        if im[x,y][0]==0 and flags[x,y]==1:
            diliate(x-1,y-1)
            diliate(x,y-1)
            diliate(x+1,y-1)
            diliate(x-1,y)
            diliate(x+1,y)
            diliate(x-1,y+1)
            diliate(x,y+1)
            diliate(x+1,y+1)

output = Image.fromarray(np.uint8(im))
output.save(nm + "_dil.bmp")
