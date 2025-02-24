%% Parameters & Curve Extraction
clc
clear all
file1 = '2022-2-28 14-40 Oscilloscope - Waveform Data - White Ash (A-011) (16 Scans - 5s)';
file2 = '2022-2-22 11-08 Oscilloscope - Waveform Data - Black Ash (A-013) (16 Scans - 5s)';
file3 = '2022-4-14 16-41 Oscilloscope - Waveform Data - LNU - A051 (8 Scans - 5s)';
file4 = '2022-4-13 13-24 Oscilloscope - Waveform Data - LNU - A025 (8 Scans - 5s)';

f1name = file1(48:size(file1,2)-15);
f2name = file2(48:size(file2,2)-15);
f3name = file3(48:size(file3,2)-15);
f4name = file4(48:size(file4,2)-15);

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
X1 = Z1(180:1560000,2);
X2 = Z2(180:1560000,2);
X3 = Z3(180:1560000,2);
X4 = Z4(180:1560000,2);
traw = (0:d/(size(X1,1)):d)';
traw = traw(1:size(X1,1),1);
Y1 = zeros(numEchos,1);
Y2 = zeros(numEchos,1);
Y3 = zeros(numEchos,1);
Y4 = zeros(numEchos,1);

% Grabs the peak voltage of every echo %
k = 1;
for c = 1:numEchos
    for n = k:k+100       
        if X1(n,:) > 1.17   % looks for the begining of each RF pulse
            max1 = X1(n+75,:);
            max2 = X2(n+75,:);
            max3 = X3(n+75,:);
            max4 = X4(n+75,:);
            for g = (n+75):(n+275) % Scans window after each RF pulse for the echo peak
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
            k = n + 300;
            break
        end
    end
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
for i=1:2
    Ya(1:numEchos,1) = movmean(Ya(1:numEchos,1),5);
    Yb(1:numEchos,1) = movmean(Yb(1:numEchos,1),5);
    Yc(1:numEchos,1) = movmean(Yc(1:numEchos,1),5);
    Yd(1:numEchos,1) = movmean(Yd(1:numEchos,1),5);
end

% Gets rid of erroneous data points at the beginning
Yarr = zeros(numEchos-19,5);
Yarr(:,1) = t(20:numEchos,1);
Yarr(:,2) = Ya(20:numEchos,1);
Yarr(:,3) = Yb(20:numEchos,1);
Yarr(:,4) = Yc(20:numEchos,1);
Yarr(:,5) = Yd(20:numEchos,1);

% Normalizes the decay curves to start at 1
Ynorm = zeros(numEchos-19,5);
Ynorm(:,1) = Yarr(:,1);

Ynorm1 = zeros(numEchos,4);

for j = 2:5
    Ynorm(:,j) = Yarr(:,j)/max(Yarr(:,j));
    Ynorm1(:,j-1) = Yraw(:,j-1)/max(Yraw(:,j-1));
end

for q=2:5
    Yarr(:,q) = Yarr(:,q)-min(Yarr(:,q));
    %Ynorm(:,q) = Ynorm(:,q)-min(Ynorm(:,q));
    Ynorm1(:,q-1) = Ynorm1(:,q-1)-min(Ynorm(:,q-1));
end

%Interpolates data to be 10 times original length/size
%{
YIarr = zeros(size,4);
YIarr(1:size*10,1) = interp1(t,Yarr(:,1),tq,'spline');
YIarr(1:size*10,2) = interp1(t,Yarr(:,2),tq,'spline');
YIarr(1:size*10,3) = interp1(t,Yarr(:,3),tq,'spline');
YIarr(1:size*10,4) = interp1(t,Yarr(:,4),tq,'spline');
%}

%Fits data to exponential curve
%{
f1 = fit(t,Ya,'exp1');
f2 = fit(t,Yb,'exp1');
f3 = fit(t,Yc,'exp1');
f4 = fit(t,Yd,'exp1');

%Extracts coefficients from curve fitting
f1coeff = coeffvalues(f1);
f1sd = confint(f1);
f2coeff = coeffvalues(f2); 
f2sd = confint(f2); 
f3coeff = coeffvalues(f3); 
f3sd = confint(f3);
f4coeff = coeffvalues(f4);
f4sd = confint(f4);

t21 = 1/f1coeff(1,2);
t22 = 1/f2coeff(1,2);
t23 = 1/f3coeff(1,2);
t24 = 1/f4coeff(1,2);
%}

%Builds T2 distributions from curve fitting parameters
%{
t2 = (0:0.0001:1.5)';
d1 = normpdf(t2,-1/f1coeff(1,2),-1/f1coeff(1,2)+1/f1sd(1,2)) + normpdf(t2,-1/f1coeff(1,4),-1/f1coeff(1,4)+1/f1sd(1,4));
d2 = normpdf(t2,-1/f2coeff(1,2),-1/f2coeff(1,2)+1/f2sd(1,2)) + normpdf(t2,-1/f2coeff(1,4),-1/f2coeff(1,4)+1/f2sd(1,4));
d3 = normpdf(t2,-1/f3coeff(1,2),-1/f3coeff(1,2)+1/f3sd(1,2)) + normpdf(t2,-1/f3coeff(1,4),-1/f3coeff(1,4)+1/f3sd(1,4));
d4 = normpdf(t2,-1/f4coeff(1,2),-1/f4coeff(1,2)+1/f4sd(1,2)) + normpdf(t2,-1/f4coeff(1,4),-1/f4coeff(1,4)+1/f4sd(1,4));
%}

%% Plots

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

%plot(Yarr(:,1),Yarr(:,2),'b',Yarr(:,1),Yarr(:,3),'k',Yarr(:,1),Yarr(:,4),'r',Yarr(:,1),Yarr(:,5),'m')
%plot(t,Yraw(:,1),'b',t,Yraw(:,2),'k',t,Yraw(:,3),'r',t,Yraw(:,4),'m')
%plot(Yarr(:,1),Ynorm(:,2),'b',Yarr(:,1),Ynorm(:,3),'k',Yarr(:,1),Ynorm(:,4),'r',Yarr(:,1),Ynorm(:,5),'m')
%plot(t,Ynorm1(:,1),'b',t,Ynorm1(:,2),'k',t,Ynorm1(:,3),'r',t,Ynorm1(:,4),'m')
axis([0 5 0 1])  
grid
legend(f1name,f2name,f3name,f4name)
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')

