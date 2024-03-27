clc
clear all

% Parameters %
file1 = '2021-08-19 15-15-46 Oscilloscope - Waveform Data - Toluene.csv';
file2 = '2021-08-19 15-25-04 Oscilloscope - Waveform Data - 25 & 75 Heptane & Toluene';
file3 = '2021-08-19 15-32-36 Oscilloscope - Waveform Data - 50 & 50 Heptane & Toluene.csv';
file4 = '2021-08-19 15-39-22 Oscilloscope - Waveform Data - 75 & 25 Heptane & Toluene.csv';
file5 = '2021-08-19 15-46-07 Oscilloscope - Waveform Data - Heptane.csv';
size = 499;
d = 1.25;
t2 = -14:0.01:0;
t = (0:d/(size-5):d)';
X1 = readmatrix(file1);
X2 = readmatrix(file2);
X3 = readmatrix(file3);
X4 = readmatrix(file4);
X5 = readmatrix(file5);
Y1 = zeros(size-4,1);
Y2 = zeros(size-4,1);
Y3 = zeros(size-4,1);
Y4 = zeros(size-4,1);
Y5 = zeros(size-4,1);
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
    max5 = X5(k,:);
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
    end
    Y1(c-4,:) = max1;
    Y2(c-4,:) = max2;
    Y3(c-4,:) = max3;
    Y4(c-4,:) = max4;
    Y5(c-4,:) = max5; 
end

fT = fit(t,Y1,'exp2')
f25 = fit(t,Y2,'exp2')
f50 = fit(t,Y3,'exp2')
f75 = fit(t,Y4,'exp2')
fH = fit(t,Y5,'exp2')

% Toluene Values %
u1T = -5.795;
u2T = -1.491;
aT1 = 0.05708;
aT2 = 0.3338;
nT1 = aT1*normpdf(t2,u1T,0.20325);
nT2 = aT2*normpdf(t2,u2T,0.0065);
nT = nT1 + nT2;

% 25/75 Values %
u251 = -7.077;
u252 = -1.681;
a251 = 0.06264;
a252 =  0.3932;
n251 = a251*normpdf(t2,u251,0.21425);
n252 = a252*normpdf(t2,u252,0.00525);
n25 = n251+n252;

% 50/50 Values %
u501 = -9.272;
u502 = -1.88;
a501 = 0.06256;
a502 =  0.4317;
n501 = a501*normpdf(t2,u501,0.26125);
n502 = a502*normpdf(t2,u502,0.00425);
n50 = n501+n502;

% 75/25 Values %
u751 = -11.2;
u752 = -1.983;
a751 = 0.0634;
a752 =  0.4195;
n751 = a751*normpdf(t2,u751,0.32);
n752 = a752*normpdf(t2,u752,0.00425);
n75 = n751+n752;

% Heptane Values %
u1H = -11.95;
u2H = -2.076;
aH1 = 0.06911;
aH2 = 0.3917;
nH1 = aH1*normpdf(t2,u1H,0.3275);
nH2 = aH2*normpdf(t2,u2H,0.005);
nH = nH1+nH2;

% Plots %
tiledlayout(5,4)

nexttile([5,2])
hold on
plot(t,Y1,'b',t,Y2,'k',t,Y3,'r',t,Y4,'m')
plot(t,Y5,'Color','#EDB120')
axis([0 1.25 0 0.5])
hold off
legend('Toluene','25/75 Hept./Tol.','50/50 Hep./Tol.','75/25 Hept./Tol.','n-Heptane')
grid 
title('T2 Relaxation Curves')
xlabel('Time (s)')
ylabel('Voltage (V)')

nexttile([1,2])
xticks([-14 -12 -10 -8 -6 -4 -2 0])
plot(t2,nT,'b')
ylim([0,0.25])
grid minor
title('R.R. Distr. - Toluene')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile([1,2])
plot(t2,n25,'k')
grid minor
ylim([0,0.25])
title('R.R. Distr. - 25/75 Hep./Tol.')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile([1,2])
plot(t2,n50,'r')
grid minor
ylim([0,0.25])
title('R.R. Distr. - 50/50 Hep./Tol.')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile([1,2])
plot(t2,n75,'m')
grid minor
ylim([0,0.25])
title('R.R. Distr. - 75/25 Hep./Tol.')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')

nexttile([1,2])
plot(t2,nH,'Color','#EDB120')
grid minor
ylim([0,0.25])
title('R.R. Distr. - Heptane')
xlabel('Relaxation Rate (s^-^1)')
ylabel('Amplitude')


