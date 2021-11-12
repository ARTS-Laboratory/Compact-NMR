%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-11-01 12-06 Oscilloscope - Waveform Data - Toluene (32 Scans - 5s)';
file2 = '2021-11-01 13-52 Oscilloscope - Waveform Data - Heptane (32 Scans - 5s)';
file3 = '2021-11-01 14-43 Oscilloscope - Waveform Data - Jet-A (32 Scans - 5s)';
file4 = '2021-11-01 18-31 Oscilloscope - Waveform Data - JP-5 (32 Scans - 5s)';

f1name = file1(48:size(file1,2));
f2name = file2(48:size(file2,2));
f3name = file3(48:size(file3,2));
f4name = file4(48:size(file4,2));

%File Parameters
size = 3965;
d = 5;
t = (0:d/(size):d)';
t = t(1:size,1);
tq = (0:d/(10*size):d)';
tq = tq(1:size*10,1);
fs = (size)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
X1 = Z1(250:1560000,2);
X2 = Z2(250:1560000,2);
X3 = Z3(250:1560000,2);
X4 = Z4(250:1560000,2);
Y1 = zeros(size,1);
Y2 = zeros(size,1);
Y3 = zeros(size,1);
Y4 = zeros(size,1);

% Grabs the peak voltage of every echo %
for c = 1:size
    i = 160;    %Window size
    j = 379;    %Step size
    w = 365;    %Correction parameter
    q = 330;    %Correction parameter
    k = c*j;    %Step
    for u=0:10
        if c > q + w*u
            k = k-150;
        end
        if c > 2885 && c < 2910
            k = k+10;
        end
        if c > 3250 && c < 3280
            k = k+10;
        end
        if c > 3615 && c < 3645
            k = k+10;
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

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;

%Filters out noisy components
for i=1:50
    Ya(1:size,1) = movmean(Ya(1:size,1),25);
    Yb(1:size,1) = movmean(Yb(1:size,1),25);
    Yc(1:size,1) = movmean(Yc(1:size,1),25);
    Yd(1:size,1) = movmean(Yd(1:size,1),25);
end

Yarr = zeros(size-19,5);
Yarr(:,1) = t(20:size,1);
Yarr(:,2) = Ya(20:size,1);
Yarr(:,3) = Yb(20:size,1);
Yarr(:,4) = Yc(20:size,1);
Yarr(:,5) = Yd(20:size,1);

%Interpolates data to be 10 times original length/size
%{
YIarr = zeros(size,4);
YIarr(1:size*10,1) = interp1(t,Yarr(:,1),tq,'spline');
YIarr(1:size*10,2) = interp1(t,Yarr(:,2),tq,'spline');
YIarr(1:size*10,3) = interp1(t,Yarr(:,3),tq,'spline');
YIarr(1:size*10,4) = interp1(t,Yarr(:,4),tq,'spline');
%}

%Fits data to exponential curve
f1 = fit(t,Ya,'exp2');
f2 = fit(t,Yb,'exp2');
f3 = fit(t,Yc,'exp2');
f4 = fit(t,Yd,'exp2');

%Extracts coefficients from curve fitting
f1coeff = coeffvalues(f1); f1sd = confint(f1);
f2coeff = coeffvalues(f2); f2sd = confint(f2); 
f3coeff = coeffvalues(f3); f3sd = confint(f3);
f4coeff = coeffvalues(f4); f4sd = confint(f4);

%Builds T2 distributions from curve fitting parameters
t2 = (0:0.0001:1.5)';
d1 = normpdf(t2,-1/f1coeff(1,2),-1/f1coeff(1,2)+1/f1sd(1,2)) + normpdf(t2,-1/f1coeff(1,4),-1/f1coeff(1,4)+1/f1sd(1,4));
d2 = normpdf(t2,-1/f2coeff(1,2),-1/f2coeff(1,2)+1/f2sd(1,2)) + normpdf(t2,-1/f2coeff(1,4),-1/f2coeff(1,4)+1/f2sd(1,4));
d3 = normpdf(t2,-1/f3coeff(1,2),-1/f3coeff(1,2)+1/f3sd(1,2)) + normpdf(t2,-1/f3coeff(1,4),-1/f3coeff(1,4)+1/f3sd(1,4));
%d2 = normpdf(t2,-1/f2coeff(1,2),-1/f2coeff(1,2)+1/f2sd(1,2));
d4 = normpdf(t2,-1/f4coeff(1,2),-1/f4coeff(1,2)+1/f4sd(1,2)) + normpdf(t2,-1/f4coeff(1,4),-1/f4coeff(1,4)+1/f4sd(1,4));

%% Plots

Ys1 = 0.2*exp(-t/1.40464)+0.83125*exp(-t/0.90109);
Ys2 = 0.4*exp(-t/1.21479)+0.63096*exp(-t/0.85484);
Ys3 = 0.6*exp(-t/1.12966)+0.43086*exp(-t/0.80034);
Ys4 = 0.8*exp(-t/1.06966)+0.23083*exp(-t/0.71097);
Ys5 = 0.9*exp(-t/1.04049)+0.13089*exp(-t/0.62022);

Ys1e = sum(abs(Yarr(:,2) - Ys1(20:size)));
Ys2e = sum(abs(Yarr(:,2) - Ys2(20:size)));
Ys3e = sum(abs(Yarr(:,2) - Ys3(20:size)));
Ys4e = sum(abs(Yarr(:,2) - Ys4(20:size)));
Ys5e = sum(abs(Yarr(:,2) - Ys5(20:size)));

HC1 = (mean(Y1(1:50))+mean(Y2(1:50)))/2
HC2 = (mean(Y3(1:50))+mean(Y4(1:50)))/2
HC11 = mean(Y1(10:20))
HC22 = mean(Y2(10:20))
HC33 = mean(Y3(10:20))
HC44 = mean(Y4(10:20))

%{
for c = 1:size
   if mod(c,2) == 0
       Ys(c,:) = Ys(c,:) + rand()/1000;
   else 
       Ys(c,:) = Ys(c,:) - rand()/1000;
   end
end
%}

%tiledlayout(1,3)

% Raw Relaxation Data
%nexttile
plot(Yarr(:,1),Yarr(:,2),'b',Yarr(:,1),Yarr(:,3),'k',Yarr(:,1),Yarr(:,4),'r',Yarr(:,1),Yarr(:,5),'m')
axis([0 5 0 1])
grid
legend(f1name,f2name,f3name,f4name)
title('Normalized T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')

% T2 Distribution
%{
nexttile(1:2)
plot(t2,d1,'b',t2,d2,'k',t2,d3,'r',t2,d4,'m')
%axis([0 1.5 0 50])
grid
legend(f1name,f2name,f3name,f4name)
title('T2 Distribution')
xlabel('T2 Time Constant (s)')
ylabel('Amplitude')
%}
