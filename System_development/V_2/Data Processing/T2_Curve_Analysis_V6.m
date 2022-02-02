%% Parameters & Curve Extraction
clc
clear all
file1 = '2021-12-09 16-52 Oscilloscope - Waveform Data - Creek Water (June 29) (32 Scans - 5s)';
file2 = '2021-12-09 16-21 Oscilloscope - Waveform Data - Distilled Water (32 Scans - 5s)';
file3 = '2021-12-06 13-33 Oscilloscope - Waveform Data - n-Hexadecane (32 Scans - 5s)';
file4 = '2021-11-30 08-44 Oscilloscope - Waveform Data - n-Dodecane (32 Scans - 5s)';

f1name = file1(48:size(file1,2)-16);
f2name = file2(48:size(file2,2)-16);
f3name = file3(48:size(file3,2)-16);
f4name = file4(48:size(file4,2)-16);

%File Parameters
numEchos = 3965;
d = 5;
t = (0:d/(numEchos):d)';
t = t(1:numEchos,1);
tq = (0:d/(10*numEchos):d)';
tq = tq(1:numEchos*10,1);
fs = (numEchos)/d;
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
X1 = Z1(250:1560000,2);
X2 = Z2(250:1560000,2);
X3 = Z3(250:1560000,2);
X4 = Z4(250:1560000,2);
traw = (0:d/(size(X1,1)):d)';
traw = traw(1:size(X1,1),1);
Y1 = zeros(numEchos,1);
Y2 = zeros(numEchos,1);
Y3 = zeros(numEchos,1);
Y4 = zeros(numEchos,1);

% Grabs the peak voltage of every echo %
for c = 1:numEchos
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

Yraw = zeros(numEchos,4);
Yraw(:,1) = Y1;
Yraw(:,2) = Y2;
Yraw(:,3) = Y3;
Yraw(:,4) = Y4;

Ya = Y1;
Yb = Y2;
Yc = Y3;
Yd = Y4;

%Filters out noisy components
for i=1:1
    Ya(1:numEchos,1) = movmean(Ya(1:numEchos,1),2);
    Yb(1:numEchos,1) = movmean(Yb(1:numEchos,1),2);
    Yc(1:numEchos,1) = movmean(Yc(1:numEchos,1),2);
    Yd(1:numEchos,1) = movmean(Yd(1:numEchos,1),2);
end

Yarr = zeros(numEchos-19,5);
Yarr(:,1) = t(20:numEchos,1);
Yarr(:,2) = Ya(20:numEchos,1);
Yarr(:,3) = Yb(20:numEchos,1);
Yarr(:,4) = Yc(20:numEchos,1);
Yarr(:,5) = Yd(20:numEchos,1);

Ynorm = zeros(numEchos-19,5);
Ynorm(:,1) = t(20:numEchos,1);
Ynorm(:,2) = Ya(20:numEchos,1)/max(Ya(20:numEchos,1));
Ynorm(:,3) = Yb(20:numEchos,1)/max(Yb(20:numEchos,1));
Ynorm(:,4) = Yc(20:numEchos,1)/max(Yc(20:numEchos,1));
Ynorm(:,5) = Yd(20:numEchos,1)/max(Yd(20:numEchos,1));

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
d4 = normpdf(t2,-1/f4coeff(1,2),-1/f4coeff(1,2)+1/f4sd(1,2)) + normpdf(t2,-1/f4coeff(1,4),-1/f4coeff(1,4)+1/f4sd(1,4));

%% Plots

%Test Functions
Ys1 = 0.18*exp(-t/1.6)+0.178*exp(-t/1.18)+0.22*exp(-t/1.15)+0.43*exp(-t/0.88);
Ys2 = 0.4*exp(-t/1.21479)+0.63096*exp(-t/0.85484);
Ys3 = 0.6*exp(-t/1.12966)+0.43086*exp(-t/0.80034);
Ys4 = 0.8*exp(-t/1.06966)+0.23083*exp(-t/0.71097);
Ys5 = 0.9*exp(-t/1.04049)+0.13089*exp(-t/0.62022);

Yarr(2500:2550,4) = Yarr(2450:2500,4);
Yarr(2135:2165,4) = Yarr(2105:2135,4);

% Integral of Averaged Data %
%{
trapz(Yarr(:,2))
trapz(Yarr(:,3))
trapz(Yarr(:,4))
trapz(Yarr(:,5))
%}

% Adds noise to the data %
%{
for c = 1:size
   if mod(c,2) == 0
       Ys1(c,:) = Ys1(c,:) + rand()/1000;
       Ys2(c,:) = Ys2(c,:) + rand()/500;
       Ys3(c,:) = Ys3(c,:) + rand()/500;
       Ys4(c,:) = Ys4(c,:) + rand()/500;
       Ys5(c,:) = Ys5(c,:) + rand()/500;
   else 
       Ys1(c,:) = Ys1(c,:) - rand()/1000;
       Ys2(c,:) = Ys2(c,:) + rand()/500;
       Ys3(c,:) = Ys3(c,:) + rand()/500;
       Ys4(c,:) = Ys4(c,:) + rand()/500;
       Ys5(c,:) = Ys5(c,:) + rand()/500;
   end
end
%}

%plot(t,Y1,'b',t,Y2,'k',t,Y3,'r',t,Y4,'m')
%plot(Yarr(:,1),Yarr(:,2),'b',Yarr(:,1),Yarr(:,3),'k',Yarr(:,1),Yarr(:,4),'r')
plot(Yarr(:,1),Ynorm(:,2),'b',Yarr(:,1),Ynorm(:,3),'k',Yarr(:,1),Ynorm(:,4),'r',Yarr(:,1),Ynorm(:,5),'m')
axis([0 5 0 1])  
grid
legend(f1name,f2name,f3name,f4name)
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')

