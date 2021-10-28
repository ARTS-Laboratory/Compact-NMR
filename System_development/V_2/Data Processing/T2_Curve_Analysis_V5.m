%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-10-28 17-19 Oscilloscope - Waveform Data - JP-5 (32 Scans - 4s)';
file2 = '2021-10-28 15-01 Oscilloscope - Waveform Data - JP-8 (32 Scans - 4s)';
file3 = '2021-10-28 14-20 Oscilloscope - Waveform Data - Jet-A (32 Scans - 4s)';
file4 = '2021-10-28 18-56 Oscilloscope - Waveform Data - Gevo ATJ (32 Scans - 4s)';

f1name = file1(48:size(file1,2));
f2name = file2(48:size(file2,2));
f3name = file3(48:size(file3,2));
f4name = file4(48:size(file4,2));

%File Parameters
size = 3170;
d = 4;
t = (0:d/(size):d)';
t = t(1:size,1);
fs = (size)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
X1 = Z1(250:1260000,2);
X2 = Z2(250:1260000,2);
X3 = Z3(250:1260000,2);
X4 = Z4(250:1260000,2);
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
            if c > 2115 && c < 2156
                k = k - 20;
            end
            if c > 1755 && c < 1790
                k = k - 20;
            end
            if c > 2484 && c < 2521
                k = k - 20;
            end
            if c > 2850 && c < 2886
                k = k - 20;
            end
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

Yarr = zeros(size,4);
Yarr(1:size,1) = Y1;
Yarr(1:size,2) = Y2;
Yarr(1:size,3) = Y3;
Yarr(1:size,4) = Y4;

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;

for i=1:100
    Ya = movmean(Y1,5);
    Yb = movmean(Y2,5);
    Yc = movmean(Y3,5);
    Yd = movmean(Y4,5);
end

%%{
f1 = fit(t,Ya,'exp2')
f2 = fit(t,Yb,'exp2')
f3 = fit(t,Yc,'exp2')
f4 = fit(t,Yd,'exp2')
%}

f1coeff = coeffvalues(f1);
f1sd = confint(f1);
f2coeff = coeffvalues(f2);
f2sd = confint(f2);
f3coeff = coeffvalues(f3);
f3sd = confint(f3);
f4coeff = coeffvalues(f4);
f4sd = confint(f4);

t2 = (0:0.0001:1.5)';
d1 = normpdf(t2,-1/f1coeff(1,2),-1/f1coeff(1,2)+1/f1sd(1,2)) + normpdf(t2,-1/f1coeff(1,4),-1/f1coeff(1,4)+1/f1sd(1,4));
d2 = normpdf(t2,-1/f2coeff(1,2),-1/f2coeff(1,2)+1/f2sd(1,2)) + normpdf(t2,-1/f2coeff(1,4),-1/f2coeff(1,4)+1/f2sd(1,4));
d3 = normpdf(t2,-1/f3coeff(1,2),-1/f3coeff(1,2)+1/f3sd(1,2)) + normpdf(t2,-1/f3coeff(1,4),-1/f3coeff(1,4)+1/f3sd(1,4));
d4 = normpdf(t2,-1/f4coeff(1,2),-1/f4coeff(1,2)+1/f4sd(1,2)) + normpdf(t2,-1/f4coeff(1,4),-1/f4coeff(1,4)+1/f4sd(1,4));

%{
d1 = d1/max(d1);
d2 = d2/max(d2);
d3 = d3/max(d3);
d4 = d4/max(d4);
%}

%% Plots

tiledlayout(1,3)

% Raw Relaxation Data
nexttile
plot(t,Y1,'b',t,Y2,'k',t,Y3,'m',t,Y4,'r')
axis([0 4 0 0.7])
grid
legend(f1name,f2name,f3name,f4name)
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')

% T2 Distribution
nexttile(1:2)
plot(t2,d1,'b',t2,d2,'k',t2,d3,'m',t2,d4,'r')
axis([0 1.5 0 50])
grid
%legend(f1name,f2name,f3name,f4name)
title('T2 Distribution')
xlabel('T2 Time Constant (s)')
ylabel('Amplitude')
%}
