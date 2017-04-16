#!/usr/bin/env python2
import numpy as np
import sys
from random import randrange, uniform

def genSApp(i, j, s):

    sApp = np.zeros((2, i))
    for index in range(0, i):
        sApp[0, index]=round(uniform(0, j), s)
        sApp[1, index]=randrange(1, 4)
    print('Schedulable Applicances Runtime Table')
    print(sApp[0, :])
    print('Schedulable Applicances power consumption Table')
    print(sApp[1, :])    
           

    return sApp



