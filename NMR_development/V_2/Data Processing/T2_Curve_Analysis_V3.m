%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-10-12 18-41-18 Oscilloscope - Waveform Data - JP-5 POSF 10289 (64)';
file2 = '2021-10-12 17-55-34 Oscilloscope - Waveform Data - Jet-A POSF 10325 (64)';
file3 = '2021-10-12 18-28-03 Oscilloscope - Waveform Data - JP-8 POSF 10264 (64)';
file4 = '2021-10-13 10-09-35 Oscilloscope - Waveform Data - JP-5 POSF 10289 (64)';

f1name = file1(52:size(file1,2));
f2name = file2(52:size(file2,2));
f3name = file3(52:size(file3,2));
f4name = file4(52:size(file4,2));

%File Parameters
size = 870;
d = 2.2;
t2 = (0:d/((size-10)*10):d)';
t = (0:d/(size-10):d)';
fs = (size-10)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
X1 = Z1(12370:720000,1);
X2 = Z2(12370:700000,1);
X3 = Z3(12370:700000,1);
X4 = Z4(12370:700000,1);
Y1 = zeros(size-9,1);
Y2 = zeros(size-9,1);
Y3 = zeros(size-9,1);
Y4 = zeros(size-9,1);

% Grabs the peak voltage of every echo %
i = 350;
j = 754;
for c = 10:size
    if c > (size-120)
       k = (c-1)*j - 50;
    else
        k = (c-1)*j;
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
    Y1(c-9,:) = max1;
    Y2(c-9,:) = max2;
    Y3(c-9,:) = max3;
    Y4(c-9,:) = max4;
end

%Integral, Average, Fitting

i1 = trapz(Y1);
i2 = trapz(Y2);
i3 = trapz(Y3);
i4 = trapz(Y4);

Yq1 = interp1(t,Y1,t2,'spline');
Yq2 = interp1(t,Y2,t2,'spline');
Yq3 = interp1(t,Y3,t2,'spline');

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;

for i=1:100
    Y1 = movmean(Y1,5);
    Y2 = movmean(Y2,5);
    Y3 = movmean(Y3,5);
    Y4 = movmean(Y4,5);
end

mY1i = movmean(Yq1,100);
mY2i = movmean(Yq2,100);
mY3i = movmean(Yq3,100);

f1 = fit(t2,mY1i,'exp2');
f2 = fit(t2,mY2i,'exp2');
f3 = fit(t2,mY3i,'exp2');

%% Plot
%tiledlayout(1,2)
%nexttile
plot(t,Ya,'k',t,Yb,'r',t,Yc,'b')
axis([0 2.2 0 0.6])
legend(f1name,f2name,f3name,f4name)
grid 
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')
%{
nexttile
plot(t,Y1,'k',t,Y2,'r',t,Y3,'b')
axis([0 2.2 0 0.6])
legend(f1name,f2name,f3name,f4name)
grid 
title('T2 Relaxation Curves - Moving Average')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}
