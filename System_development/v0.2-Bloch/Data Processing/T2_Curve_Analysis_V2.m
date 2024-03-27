%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-09-28 10-29-35 Oscilloscope - Waveform Data - Toluene (128)';
file2 = '2021-09-30 10-34-58 Oscilloscope - Waveform Data - Toluene (128)';
file3 = '2021-09-28 16-22-48 Oscilloscope - Waveform Data - n-Dodecane (128)';

%File Parameters
size = 745;
d = 1.885;
t2 = (0:d/((size-10)*10):d)';
t = (0:d/(size-10):d)';
fs = (size-10)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
X1 = Z1(12370:700000,1);
X2 = Z2(12370:700000,1);
X3 = Z3(12370:700000,1);
Y1 = zeros(size-9,1);
Y2 = zeros(size-9,1);
Y3 = zeros(size-9,1);

% Grabs the peak voltage of every echo %
i = 400;
j = 754;
for c = 10:size
    if c == 1
       k = 1;
    else
        k = (c-1)*j;
    end
    max1 = X1(k,:);
    max2 = X2(k,:);
    max3 = X3(k,:);
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
    end
    Y1(c-9,:) = max1;
    Y2(c-9,:) = max2;
    Y3(c-9,:) = max3;
end

%Integral, Average, Fitting

i1 = trapz(Y1)
i2 = trapz(Y2)
i3 = trapz(Y3)

lp1 = lowpass(Y1,0.1,fs);

Yq1 = interp1(t,Y1,t2,'spline');
Yq2 = interp1(t,Y2,t2,'spline');
Yq3 = interp1(t,Y3,t2,'spline');

Ya = Y1;
Yb = Y2;
Yc = Y3;

for i=1:100
    Y1 = movmean(Y1,5);
    Y2 = movmean(Y2,5);
    Y3 = movmean(Y3,5);
end

for j=1:7
    Y1(j,1) = Y1(j,1) + 0.008 - j*0.001;
    Y2(j,1) = Y2(j,1) + 0.008 - j*0.001;
    Y3(j,1) = Y3(j,1) + 0.008 - j*0.001;
end

mY1i = movmean(Yq1,100);
mY2i = movmean(Yq2,100);
mY3i = movmean(Yq3,100);

f1 = fit(t2,mY1i,'exp1')
f2 = fit(t2,mY2i,'exp1')
f3 = fit(t2,mY3i,'exp1')

%% Plot
tiledlayout(1,2)
nexttile
plot(t,Y1,'k',t,Y2,'r',t,Y3,'b')
axis([0 1.885 0 0.6])
legend('Y1','Y2','Y3')
%legend('9/28/2021 (9AM) - 27.437 MHz','9/27/2021 (4PM) - 27.422 MHz','9/24/2021 (5PM) - 27.422 MHz')
grid 
title('T2 Relaxation Curves - Toluene')
xlabel('Time (s)')
ylabel('Voltage (V)')
%%{
nexttile
plot(t,Ya,'k',t,Yb,'r',t,Yc,'b')
axis([0 1.885 0 0.6])
legend('Y1','Y2','Y3')
%legend('9/28/2021 (9AM) - 27.437 MHz','9/27/2021 (4PM) - 27.422 MHz','9/24/2021 (5PM) - 27.422 MHz')
grid 
title('T2 Relaxation Curves - Moving Average')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}
