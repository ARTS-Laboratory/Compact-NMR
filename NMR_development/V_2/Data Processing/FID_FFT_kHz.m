clc
clear all

filename1 = 'iso-Octane Echo.csv';
filename2 = 'Toluene 3.csv';
filename3 = 'Toluene Echo.csv';
filename4 = 'n-Octane Echo.csv';
filename5 = 'Heptane FID.csv';
X = readmatrix(filename2);
T = 2e-7;
Fs = 1/T;
L = 6502;
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
xlim([3 30])
%ylim([0 0.1])
title('Fourier Transform Of Original Signal')
xlabel('Frequency (kHz)')
ylabel('Amplitude')