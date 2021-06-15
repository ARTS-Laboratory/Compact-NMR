# -*- coding: utf-8 -*-
""" 
This code simulates the NMR device in the ARTS-Lab

"""

from IPython import get_ipython
get_ipython().magic('reset -sf') 


import numpy as np
from scipy.signal import butter, lfilter, freqz
import matplotlib.pyplot as plt

plt.close('all')

#%% define the custom functions

#lowpass filter established
def butter_lowpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return b, a

def butter_lowpass_filter(data, cutoff, fs, order=5):
    b, a = butter_lowpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y

#%% run the code and plot the results.

# Filter requirements.
T = .0001                   # window
wO = 21770000*2*np.pi       # local oscillator frequency (rad/s)
wA = 21720000*2*np.pi       # sample frequency (rad/s)
mO = 5.0                    # magnitude of LO signal (V)
fs = 1000000000             # sample rate, (Hz)
cutoff = 100000             # desired cutoff frequency of the filter, (Hz) 
nyq = 0.5 * fs              # Nyquist Frequency
n = T*fs                    # number of samples
order = 2                   # sin wave can be approx represented as quadratic

#time vectors
points = np.linspace(0,1,100000,endpoint=False)
t = points/10000
t1 = points/1000000

#local oscillator from function generator
LO1 = mO*np.cos(wO*t1)
LO2 = mO*np.cos(wO*t)

#20% duty cycle pulse 
pulse = [0.0]
for x in range(1,100000):
    if x >= 40000 and x <=60000:
        pulse.append(1.0)
    else:
        pulse.append(0.0)

#pulsed LO
pulseLO = pulse*LO2

#probe free induction decay signal
mA = 1e-6*np.exp(-6e4*t)
RF = mA*np.cos(wA*t)

#probe LC tank energy dissipation
mLC = 2.5*np.exp(-0.5e7*t1)
LC = mLC*np.cos(wO*t1)

#LC dissipation + FID
mlc = 2.5*np.exp(-0.5e7*t)
lc = mlc*np.cos(wO*t)
lcfid = RF+lc

#output after LO and FID signals are mixed
M = mA/2.14*100;
mSig = M*(np.cos((wO+wA)*t)+np.cos((wO-wA)*t))


#%% Plot the results

fig, axs = plt.subplots(3,3)#establish plot windows
# Filter the data, and plot both the original and filtered signals.
y = butter_lowpass_filter(mSig, cutoff, fs, order)
axs[0,0].plot(t1,LO1)
axs[0,0].set_title('A: Local Oscillator - 21.7MHz')
axs[1,0].plot(t,pulse)
axs[1,0].set_title('B: 20us Gate Pulse')
axs[2,0].plot(t,pulseLO)
axs[2,0].set_title('C: Pulsed LO Signal')
axs[0,1].plot(t1,LC,'tab:red')
axs[0,1].set_title('D: Probe LC Dissipation')
axs[1,1].plot(t,RF,'tab:red')
axs[1,1].set_title('E: Atomic Free Induction Decay')
axs[2,1].plot(t,lcfid,'tab:red')
axs[2,1].set_title('F: FID & LC Signals Combined')
axs[0,2].plot(t,RF*100,'tab:green')
axs[0,2].set_title('G: 40dB Amplified FID Signal')
axs[1,2].plot(t,mSig,'tab:green')
axs[1,2].set_title('H: Frequency Mixed LO & FID')
axs[2,2].plot(t,y*100,'tab:green')
stuff = "I: Lowpass Filtered and Amplified FID - %d Hz" %((wO-wA)/(2*np.pi))
axs[2,2].set_title(stuff)
plt.subplots_adjust(hspace=0.5)
plt.subplots_adjust(wspace=0.35)
for ax in axs.flat:
    ax.set(xlabel='Time (s)', ylabel='Voltage (V)')

