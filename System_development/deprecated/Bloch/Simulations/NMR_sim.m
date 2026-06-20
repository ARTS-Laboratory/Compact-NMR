clc
clear all

% 2 Signal Parameters %
fs = 1e6;
d = 500e-3;
t = 0:1/fs:d;
iT2 = 2.5/d;
wO = 15e3*2*pi;
mO = exp(-iT2*t);
wA = 15.011e3*2*pi;
mA = exp(-iT2*t);
oSig = mO.*cos(wO*t);
aSig = mA.*cos(wA*t);
sSig = oSig + aSig;

% Fourier Transform %
L = d*fs;
Fn = fs/2;                                          
FX = fft(sSig)/L;                                     
Fv = linspace(0, 1, fix(L/2)+1)*Fn/1000;                 
Iv = 1:length(Fv); 

% Plot commands %
tiledlayout(2,1)

nexttile
plot(t, sSig)
grid
title('Simulated Free Induction Decay')
xlabel('Time')
ylabel('Voltage')

nexttile                              
plot(Fv, abs(FX(Iv))*2)
grid
xlim([3 30])
title('Fourier Transform Of Original Signal')
xlabel('Frequency (kHz)')
ylabel('Amplitude')


