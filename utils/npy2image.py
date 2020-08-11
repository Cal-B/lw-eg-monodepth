## convert npy to image
'''
date:   2020-06-14
author: kuo
'''
import os
import numpy as np
import scipy.misc
import matplotlib.pyplot as plt
import os
from PIL import Image

save_source = not True
postproc = True
surfix = '_ppp'

## setup root path
model_name = 'kitti_vggASPP_8x100_Ccor_25'
path2root   = '/home/u22/cpbarrett/lw-eg-monodepth/models/{}/'.format(model_name)
path2out = path2root + 'dashcam4_ppp/'
print("Outputting disps to: " + path2out)
if not os.path.exists(path2out):
    print("Making output path: " + path2out)
    os.makedirs(path2out)

## load npy
path2npy    = "/home/u22/cpbarrett/lw-eg-monodepth/models/kitti_vggASPP_8x100_Ccor_25/disparities{}.npy".format(surfix)

npy         = np.load(path2npy)

## get dimension
num, _, _   = npy.shape
for n in np.arange(num):
    fName   = str(n).zfill(6)
    npy_    = npy[n,:-10,:]
    npy_    = np.array(Image.fromarray(npy_).resize([1242,375], Image.BILINEAR))#LANCZOS))  

    plt.imsave(os.path.join(path2out,
    "{}_disp.png".format(fName)), npy_, cmap='plasma')

    if n % 10 == 0:
        print("Status: {}%".format(np.round(n/num*100,2)))

print("Done!")



