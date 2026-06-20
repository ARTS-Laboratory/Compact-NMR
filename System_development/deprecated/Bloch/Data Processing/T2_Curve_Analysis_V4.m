%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-10-25 15-24-52 Oscilloscope - Waveform Data - JP-8 POSF 10264 (64)';
file2 = '2021-10-25 14-55-08 Oscilloscope - Waveform Data - Jet-A POSF 10325 (64)';
file3 = '2021-10-25 15-09-15 Oscilloscope - Waveform Data - JP-5 POSF 10289 (64)';
file4 = '2021-10-25 15-36-14 Oscilloscope - Waveform Data - Shell SPK POSF 5729 (64)';
file5 = '2021-10-26 13-38-00 Oscilloscope - Waveform Data - Heptane (64 Scans - 2s)';
file6 = '2021-10-26 13-19-27 Oscilloscope - Waveform Data - Toluene (64 Scans - 2s)';

f1name = file1(52:size(file1,2));
f2name = file2(52:size(file2,2));
f3name = file3(52:size(file3,2));
f4name = file4(52:size(file4,2));
f5name = file5(52:size(file5,2));
f6name = file6(52:size(file6,2));

%File Parameters
size = 1740;
d = 2.2;
t2 = (0:d/((size)*10):d)';
t = (0:d/(size):d)';
t = t(1:size,1);
fs = (size)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
Z5 = readmatrix(file5);
Z6 = readmatrix(file6);
X1 = Z1(12200:720000,1);
X2 = Z2(12200:720000,1);
X3 = Z3(12200:720000,1);
X4 = Z4(12200:720000,1);
X5 = Z5(12200:720000,1);
X6 = Z6(12200:720000,1);
Y1 = zeros(size,1);
Y2 = zeros(size,1);
Y3 = zeros(size,1);
Y4 = zeros(size,1);
Y5 = zeros(size,1);
Y6 = zeros(size,1);

% Grabs the peak voltage of every echo %
for c = 1:size
    i = 190;
    j = 379;
    k = c*j;
    if c > 330 && c < 850
        k = k - 160;
        if c > 720
            k = k - 60;
        end
    end
    if c > 1250
        k = k - 150;
        if c > 1615
            k = k - 50;
        end
    end
    max1 = X1(k,:);
    max2 = X2(k,:);
    max3 = X3(k,:);
    max4 = X4(k,:);
    max5 = X5(k,:);
    max6 = X6(k,:);
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
        if X5(g+1,:) > max5
           max5 = X5(g+1,:);
        end
        if X6(g+1,:) > max6
           max6 = X6(g+1,:);
        end
    end
    Y1(c,:) = max1;
    Y2(c,:) = max2;
    Y3(c,:) = max3;
    Y4(c,:) = max4;
    Y5(c,:) = max5;
    Y6(c,:) = max6;
end

%Integral, Average, Fitting 

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;
Ye = Y5;
Yf = Y6;

for i=1:100
    Ya = movmean(Ya,5);
    Yb = movmean(Yb,5);
    Yc = movmean(Yc,5);
    Yd = movmean(Yd,5);
    Ye = movmean(Ye,5);
    Yf = movmean(Yf,5);
end

i1 = trapz(Ya)
i2 = trapz(Yb)
i3 = trapz(Yc)
i4 = trapz(Yd)
i5 = trapz(Ye)
i6 = trapz(Yf)

%{
f1 = fit(t,Y1,'exp1');
f2 = fit(t,Y2,'exp1');
f3 = fit(t,Y3,'exp1');
f4 = fit(t,Y4,'exp1');
%}

%% Plot
%{
tiledlayout(1,2)
nexttile
plot(t,Ya,'g',t,Yb,'m',t,Yc,'c',t,Yd,'b',t,Ye,'k',t,Yf,'r')
axis([0 2.2 0 0.7])
legend(f1name,f2name,f3name,f4name,f5name,f6name)
grid 
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}
%%{
%nexttile
plot(t,Y1,'b',t,Y2,'r',t,Y3,'k',t,Y4,'m',t,Y5,'c',t,Y6,'g')
axis([0 2.2 0 0.7])
legend(f1name,f2name,f3name,f4name,f5name,f6name)
grid 
title('T2 Relaxation Curves - 10/25/21')
xlabel('Time (s)')
ylabel('Voltage (V)')
%}
