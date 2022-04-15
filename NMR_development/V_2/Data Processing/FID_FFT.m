clc
clear all
close all

filename = 'Toluene Echo.csv';
X = readmatrix(filename);                                       
%T = 0.0000002;
T = 0.000001;
Fs = 1/T;
%L = 3501;
L = 6502;
t = (0:L-1)*T;                                      
Fn = Fs/2;                                          
FX = fft(X)/L;                                     
Fv = linspace(0, 1, fix(L/2)+1)*Fn/1000*36;                 
Iv = 1:length(Fv);                                  
figure(1);
plot(Fv, abs(FX(Iv))*2)
xlim([-2000 2000])
ylim([0 0.08])
grid
title('Fourier Transform Of Original Signal')
xlabel('Chemical Shift (ppm)')
ylabel('Amplitude')