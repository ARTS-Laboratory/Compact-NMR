clc
clear all

% Parameters %
file1 = 'Toluene T2.csv';
file2 = 'Heptane T2.csv';
size = 98;
d = 250e-3;
t2 = -20:0.01:10;
t = (0:d/(size-5):d)';
X1 = readmatrix(file1);
X2 = readmatrix(file2);
Y1 = zeros(size-4,1);
Y2 = zeros(size-4,1);
i = 700;
j = 974;

% Grabs the peak voltage of every echo %
for c = 5:size
    if c == 1
       k = 1;
    else
        k = (c-1)*j;
    end
    max1 = X1(k,:);
    max2 = X2(k,:);
    for g = k:(k+i)
        if X1(g+1,:) > max1
            max1 = X1(g+1,:);
        end
        if X2(g+1,:) > max2
            max2 = X2(g+1,:);
        end
    end
    Y1(c-4,:) = max1;
    Y2(c-4,:) = max2;
    
end

fT = fit(t,Y1,'exp2')
fH = fit(t,Y2,'exp2')


% Toluene Values %
sd1T = 3.5455;
u1T = -5.79;
sd2T = 2.1472;
u2T = -0.7892;
nT1 = 0.1378*normpdf(t2,u1T,sd1T);
nT2 = 0.2549*normpdf(t2,u2T,sd2T);
nT = nT1 + nT2;

% Heptane Values %
sd1H = 3.948;
u1H = -5.23;
sd2H = 1.388;
u2H = -1.084;
nH1 = 0.2484*normpdf(t2,u1H,sd1H);
nH2 = 0.4362*normpdf(t2,u2H,sd2H);
nH = nH1+nH2;

% Plots %
tiledlayout(2,2)

nexttile
plot(fT,t,Y1)
grid
title('Toluene T2 Relaxation Curve')
xlabel('Time')
ylabel('Voltage')

nexttile
plot(t2,nT)
ylim([0,0.2])
grid
title('Relaxation Rates Distribution - Toluene')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile
plot(fH,t,Y2)
grid
title('Heptane T2 Relaxation Curve')
xlabel('Time')
ylabel('Voltage')

nexttile
plot(t2,nH)
grid
ylim([0,0.2])
title('Relaxation Rates Distribution - Heptane')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')






