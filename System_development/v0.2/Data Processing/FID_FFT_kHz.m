clc
clear all

filename1 = 'DW Echo.csv';
X = readmatrix(filename1);
Fs = 300e3;
T = 1/Fs;
L = 251;
t = (0:L-1)*T;                                      
Fn = Fs/2;                                          
FX = fft(X)/L;                                     
Fv = linspace(0, 1, fix(L/2)+1)*Fn/1000;                 
Iv = 1:length(Fv);                                  

tiledlayout(2,1)

%Original Signal
nexttile
plot(t, X)
grid
title('Original Signal')
xlabel('Time (s)')
ylabel('Voltage (V)')

%Fourier Transform
nexttile
plot(Fv, abs(FX(Iv))*2)
grid
axis([0 150 -0.01 0.05])
%ylim([0 0.1])
title('Fourier Transform Of Original Signal')
xlabel('Frequency (kHz)')
ylabel('Amplitude')