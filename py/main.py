#!/usr/bin/env python2
import numpy as np
import sys
import getopt
from schedulableApp import genSApp


def main():
    options, remainder = getopt.getopt(sys.argv[1:], 'i:j:s:', ['numOfSapp=', 'totalTime=', 'timeStep='])    
    for opt, arg in options:
        if opt in ('-i', 'numOfSapp'):
            numOfSapp = arg
        elif opt in ('-j', 'totalTime'):
            totalTime = arg
        elif opt in ('-s', 'timeStep'):
            timeStep = arg

    print ('Number of schedulable appliances: ' + numOfSapp )
    print ('The total time: '+ totalTime)
    print ('The time slot (step): ' + timeStep)
    
    timeStep = len(timeStep)-2
    
    sapp = genSApp(int(numOfSapp), int(totalTime), timeStep)


if __name__ == "__main__":
    print ('Welcome to smartHome!')
    main()

