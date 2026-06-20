#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 15 16:05:28 2019

Life satisfaction index example

@author: austin
"""

import IPython as IP
IP.get_ipython().magic('reset -sf')

import numpy as np
import scipy as sp
import pandas as pd
from scipy import fftpack, signal # have to add 
import matplotlib as mpl
import matplotlib.pyplot as plt
import sklearn as sk
import time as time
from sklearn import linear_model
from sklearn import pipeline
from sklearn import datasets
from sklearn import multiclass

cc = plt.rcParams['axes.prop_cycle'].by_key()['color'] 
plt.close('all')

#%% Load the data

data = np.loadtxt('data/LabviewOutput_9-28-20.lvm',skiprows=23)
tt = data[:,0]
v1 = data[:,1]
v2 = data[:,2]


plt.figure()
plt.plot(tt*1000-28.0,-v2)
#plt.plot(tt*1000,v1)
plt.xlim(0,11)
plt.grid(True)
plt.xlabel('time (ms)')
plt.ylabel('-voltage')
plt.tight_layout()
plt.savefig('results',dpi=300)





























