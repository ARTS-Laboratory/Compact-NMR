clc
clear all

filename1 = 'n-Propylbenzene Echo.csv';
filename2 = 'n-Dodecane Echo.csv';
X1 = readmatrix(filename1);
X2 = readmatrix(filename2);
X1 = X1(:,2);
X2 = X2(:,2);
Fs = 300e3;
T = 1/Fs;
Fn = Fs/2;
L1 = size(X1,1);
t1 = linspace(0,L1/Fs,L1)*1000;                                                                                
FX1 = fft(X1)/L1;                                     
Fv1 = linspace(0, 1, fix(L1/2)+1)*Fn/1000;                 
Iv1 = 1:length(Fv1);
L2 = size(X2,1);
t2 = linspace(0,2,L1);                                                                                
FX2 = fft(X2)/L2;                                     
Fv2 = linspace(0, 1, fix(L2/2)+1)*Fn/1000;                 
Iv2 = 1:length(Fv2);

tiledlayout(1,2)
nexttile()
plot(Fv1, abs(FX1(Iv1))*2, Fv2, abs(FX2(Iv2))*2)
xlim([0 30])
grid
title('Fourier Transform Of Original Signal')
%xlim([0 30])
xlabel('Frequency (kHz)')
ylabel('Amplitude')
nexttile()
plot(t1,X1,t1,X2)
axis([0 3.5 -0.6 0.6])
grid
title('Original Signal')
xlabel('Time (ms)')
ylabel('Voltage (V)')