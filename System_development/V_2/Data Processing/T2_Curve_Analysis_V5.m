%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-10-26 16-41-00 Oscilloscope - Waveform Data - Heptane (1 Scan1 - 4s)';
file2 = '2021-10-25 16-31-00 Oscilloscope - Waveform Data - Shell SPK POSF 5729 (16)';
file3 = '2021-10-25 16-31-00 Oscilloscope - Waveform Data - Shell SPK POSF 5729 (16)';
file4 = '2021-10-25 16-31-00 Oscilloscope - Waveform Data - Shell SPK POSF 5729 (16)';

f1name = file1(52:size(file1,2));
f2name = file2(52:size(file2,2));
f3name = file3(52:size(file3,2));
f4name = file4(52:size(file4,2));

%File Parameters
size = 3170;
d = 4;
t2 = (0:d/((size)*10):d)';
t = (0:d/(size):d)';
t = t(1:size,1);
fs = (size)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
X1 = Z1(250:1260000,1);
X2 = Z2(250:1260000,1);
X3 = Z3(250:1260000,1);
X4 = Z4(250:1260000,1);
Y1 = zeros(size,1);
Y2 = zeros(size,1);
Y3 = zeros(size,1);
Y4 = zeros(size,1);

% Grabs the peak voltage of every echo %
for c = 1:size
    i = 190;    %Window size
    j = 379;    %Step size
    w = 365;    %Correction parameter
    q = 330;    %Correction parameter
    k = c*j;    %Step
    for u=0:8
        if c > q + w*u
            k = k-150;
        end
    end
    max1 = X1(k,:);
    max2 = X2(k,:);
    max3 = X3(k,:);
    max4 = X4(k,:);
    for g = k:(k+i)
        if X1(g+1,:) > max1
           max1 = X1(g+1,:);
        end
        if X2(g+1,:) > max2
           max2 = X2(g+1,:);
        end
        if X3(g+1,:) > max3
           max3 = X3(g+1,:);
        end
        if X4(g+1,:) > max4
           max4 = X4(g+1,:);
        end
    end
    Y1(c,:) = max1;
    Y2(c,:) = max2;
    Y3(c,:) = max3;
    Y4(c,:) = max4;
end

%Integral, Average, Fitting

Yarr = zeros(size,4);
Yarr(1:size,1) = Y1;
Yarr(1:size,2) = Y2;
Yarr(1:size,3) = Y3;
Yarr(1:size,4) = Y4;

i1 = trapz(Y1)
i2 = trapz(Y2)
i3 = trapz(Y3)
i4 = trapz(Y4)

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;

for i=1:100
    Ya = movmean(Ya,5);
    Yb = movmean(Yb,5);
    Yc = movmean(Yc,5);
    Yd = movmean(Yd,5);
end

%{
f1 = fit(t,Y1,'exp2')
f2 = fit(t,Y2,'exp2');
f3 = fit(t,Y3,'exp2');
f4 = fit(t,Y4,'exp2');
%}

%% Plot
%tiledlayout(1,2)
%nexttile
plot(t,Y1,'b')
axis([0 4 0 0.7])
grid
legend(f1name)
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')
%{
nexttile
plot(t,Ya,'b',t,Yb,'k',t,Yc,'r')
axis([0 4 0 0.7])
grid
legend('Shell SPK')
title('T2 Relaxation Curves - Moving Average')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}
