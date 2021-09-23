%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-09-23 18-21-36 Oscilloscope - Waveform Data';
file2 = '2021-09-21 15-27-32 Oscilloscope - Waveform Data - Toluene';
file3 = '2021-09-22 09-51-59 Oscilloscope - Waveform Data - Toluene';
file4 = '2021-09-22 15-17-04 Oscilloscope - Waveform Data - Toluene';
file5 = '2021-09-23 14-16-37 Oscilloscope - Waveform Data - Toluene';
size = 495;
d = 1.25;
t2 = (0:d/((size-10)*10):d)';
t = (0:d/(size-10):d)';
fs = (size-10)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3); 
Z4 = readmatrix(file4);
Z5 = readmatrix(file5);
X1 = Z1(6501:389949,1);
X2 = Z2(6501:389949,1);
X3 = Z3(6501:389949,1);
X4 = Z4(6501:389949,1);
X5 = Z5(6501:389949,1);
Y1 = zeros(size-9,1);
Y1a = zeros(size-9,1);
Y2 = zeros(size-9,1);
Y3 = zeros(size-9,1);
Y4 = zeros(size-9,1);
Y5 = zeros(size-9,1);
i = 400;
j = 754;
% Grabs the peak voltage of every echo %
for c = 10:size
    if c == 1
       k = 1;
    else
        k = (c-1)*j;
    end
    max1 = X1(k,:);
    max2 = X2(k,:);
    max3 = X3(k,:);
    max4 = X4(k,:);
    max5 = X5(k,:);
    for g = k:(k+i)
        if X1(g+1,:) > max1
           max1 = X1(g+1,:);
           ax1 = g+1;
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
        if X5(g+1,:) > max5
            max5 = X5(g+1,:);
        end
    end
    Y1(c-9,:) = max1;
    Y2(c-9,:) = max2;
    Y3(c-9,:) = max3;
    Y4(c-9,:) = max4;
    Y5(c-9,:) = max5;
end

matOut = zeros(486,6);
matOut(:,1) = t;
matOut(:,2) = Y1;
matOut(:,3) = Y2;
matOut(:,4) = Y3;
matOut(:,5) = Y4;
matOut(:,6) = Y5;

i1 = trapz(Y1)
i2 = trapz(Y2)
i3 = trapz(Y3)
i4 = trapz(Y4)
i5 = trapz(Y5)

%% Functions
f1 = fit(t,Y1,'exp2')
f2 = fit(t,Y2,'exp2')
f3 = fit(t,Y3,'exp2')
f4 = fit(t,Y4,'exp2')
f5 = fit(t,Y5,'exp2')

lp1 = lowpass(Y1,0.1,fs);
lp2 = lowpass(Y2,0.1,fs);
lp3 = lowpass(Y3,0.1,fs);
lp4 = lowpass(Y4,0.1,fs);
lp5 = lowpass(Y5,0.1,fs);

LP = zeros(428,6);
LP(:,1) = t(40:467);
LP(:,2) = lp1(40:467,1);
LP(:,3) = lp2(40:467,1);
LP(:,4) = lp3(40:467,1);
LP(:,5) = lp4(40:467,1);
LP(:,6) = lp5(40:467,1);

my1 = movmean(Y1,5);
my2 = movmean(Y2,5);
my3 = movmean(Y3,5);
my4 = movmean(Y4,5);
my5 = movmean(Y5,5);

Yq = zeros(4851,6);
Yq(:,1) = t2;
Yq(:,2) = interp1(t,my1,t2,'spline');
Yq(:,3) = interp1(t,my2,t2,'spline');
Yq(:,4) = interp1(t,my3,t2,'spline');
Yq(:,5) = interp1(t,my4,t2,'spline');
Yq(:,6) = interp1(t,my5,t2,'spline');

m1 = movmean(Yq(:,2),250);
m2 = movmean(Yq(:,3),250);
m3 = movmean(Yq(:,4),250);
m4 = movmean(Yq(:,5),250);
m5 = movmean(Yq(:,6),250);

meanOut = zeros(4722,6);
meanOut(:,1) = t2(130:4851,1);
meanOut(:,2) = m1(130:4851);
meanOut(:,3) = m2(130:4851);
meanOut(:,4) = m3(130:4851);
meanOut(:,5) = m4(130:4851);
meanOut(:,6) = m5(130:4851);

%% Plots
tiledlayout(1,2)
nexttile
plot(t,Y1,'b',t,Y2,'k',t,Y3,'r',t,Y4,'m',t,Y5,'c')
%plot(t,Y1,'b',t2,m1,'k',t,Y2,'r',t2,m2,'k')
axis([0 1.25 0 0.6])
legend('Y1','Y2','Y3','Y4','Y5')
grid 
title('T2 Relaxation Curves - Raw')
xlabel('Time (s)')
ylabel('Voltage (V)')
%%{
nexttile
plot(meanOut(:,1),meanOut(:,2),'b',meanOut(:,1),meanOut(:,3),'k',meanOut(:,1),meanOut(:,4),'r',meanOut(:,1),meanOut(:,5),'m',meanOut(:,1),meanOut(:,6),'c')
%plot(t2,m1,'b',t2,m2,'k',t2,m3,'r',t2,m4,'m',t2,m5,'c')
%plot(t2,Yq(:,2),'b',t2,Yq(:,3),'k',t2,Yq(:,4),'r',t2,Yq(:,5),'m',t2,Yq(:,6),'c')
axis([0 1.25 0 0.6])
legend('LP1','LP2','LP3','LP4','LP5')
grid 
title('T2 Relaxation Curves - Filtered')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}

