clc
clear all

% Parameters %
file1 = 'Toluene T2.csv';
file2 = 'n-Heptane T2.csv';
file3 = 'iso-Octane T2.csv';
file4 = 'n-Octane T2.csv';
size = 399;
d = 1;
t2 = -15:0.01:0;
t = (0:d/(size-5):d)';
X1 = readmatrix(file1);
X2 = readmatrix(file2);
X3 = readmatrix(file3);
X4 = readmatrix(file4);
Y1 = zeros(size-4,1);
Y2 = zeros(size-4,1);
Y3 = zeros(size-4,1);
Y4 = zeros(size-4,1);
i = 400;
j = 754;

% Grabs the peak voltage of every echo %
for c = 5:size
    if c == 1
       k = 1;
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
    Y1(c-4,:) = max1;
    Y2(c-4,:) = max2;
    Y3(c-4,:) = max3;
    Y4(c-4,:) = max4;
    
end

fT = fit(t,Y1,'exp2')
fH = fit(t,Y2,'exp2')
fiO = fit(t,Y3,'exp2')
fnO = fit(t,Y4,'exp2')

% Toluene Values %
u1T = -10.56;
u2T = -1.634;
aT1 = 0.03915;
aT2 = 0.3307;
nT1 = aT1*normpdf(t2,u1T,0.41425);
nT2 = aT2*normpdf(t2,u2T,0.0045);
nT = nT1 + nT2;

% Heptane Values %
u1H = -8.076;
u2H = -1.894;
aH1 = 0.09709;
aH2 = 0.5555;
nH1 = aH1*normpdf(t2,u1H,0.18275);
nH2 = aH2*normpdf(t2,u2H,0.00525);
nH = nH1+nH2;

% iso-Octane Values %
u1iO = -12.41;
u2iO = -1.75;
aiO1 = 0.06254;
aiO2 = 0.5599;
niO1 = aiO1*normpdf(t2,u1iO,0.395);
niO2 = aiO2*normpdf(t2,u2iO,0.0035);
niO = niO1+niO2;

% n-Octane Values %
u1nO = -11.78;
u2nO = -1.841;
anO1 = 0.066;
anO2 = 0.5063;
nO1 = anO1*normpdf(t2,u1nO,0.4325);
nO2 = anO2*normpdf(t2,u2nO,0.005);
nO = nO1+nO2;

% Plots %
tiledlayout(2,4)

nexttile(1,[2,2])
plot(t,Y1,'b',t,Y2,'g',t,Y3,'r',t,Y4,'m')
legend('Toluene','n-Heptane','iso-Octane','n-Octane')
grid
title('T2 Relaxation Curves')
xlabel('Time')
ylabel('Voltage')

nexttile
plot(t2,nT)
ylim([0,0.25])
grid
title('R.R. Distr. - Toluene')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile
plot(t2,nH)
grid
ylim([0,0.25])
title('R.R. Distr. - Heptane')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile
plot(t2,niO)
grid
ylim([0,0.25])
title('R.R. Distr. - iso-Octane')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile
plot(t2,nO)
grid
ylim([0,0.25])
title('R.R. Distr. - n-Octane')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')
