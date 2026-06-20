clc
clear all
file1 = '2022-1-17 11-24 Oscilloscope - Waveform Data - 1,3,5 Trimethylbenzene (3 Scans - 4s)';
file2 = '2022-1-17 11-24 Oscilloscope - Waveform Data - 1,3,5 Trimethylbenzene (3 Scans - 4s)';
file3 = '2022-1-17 11-24 Oscilloscope - Waveform Data - 1,3,5 Trimethylbenzene (3 Scans - 4s)';
file4 = '2022-1-17 11-24 Oscilloscope - Waveform Data - 1,3,5 Trimethylbenzene (3 Scans - 4s)';

f1name = file1(48:size(file1,2)-15);
f2name = file2(48:size(file2,2)-15);
f3name = file3(48:size(file3,2)-15);
f4name = file4(48:size(file4,2)-15);

% File Parameters
numEchos1 = 3170;
numEchos2 = 3875;
d = 4;
t1 = (0:d/(numEchos1):d)';
t1 = t1(1:numEchos1,1);
t2 = (0:d/(numEchos2):d)';
t2 = t2(1:numEchos2,1);
Z1 = readmatrix(file1);
Z2 = readmatrix(file2);
Z3 = readmatrix(file3);
Z4 = readmatrix(file4);
Yraw = zeros(numEchos1,4);
Yraw(:,1) = Z1(1:numEchos1,2);
Yraw(:,2) = Z2(1:numEchos1,2);
Yraw(:,3) = Z3(1:numEchos1,2);
Yraw(:,4) = Z4(1:numEchos1,2);
Yarr1 = zeros(numEchos1,4);
Yarr1(:,1) = Yraw(:,1);
Yarr1(:,2) = Yraw(:,2);
Yarr1(:,3) = Yraw(:,3);
Yarr1(:,4) = Yraw(:,4);
Ynorm = zeros(numEchos1,4);

% Normalized & Filtered Data
for j = 1:4
    for i=1:1
        Yarr1(1:numEchos1,j) = movmean(Yarr1(1:numEchos1,j),5);
    end
    Yarr1(:,j) = Yarr1(:,j)-min(Yarr1(:,j));
    Ynorm(:,j) = Yarr1(:,j)/max(Yarr1(:,j));
end

Yarr = zeros(numEchos1-19,5);
Yarr(:,1) = t1(20:numEchos1,1);
Ynorm1 = zeros(numEchos1-19,5);
Ynorm1(:,1) = t1(20:numEchos1,1);

for j = 2:5
    Yarr(:,j) = Yarr1(20:numEchos1,j-1);
    Ynorm1(:,j) = Yarr(:,j)/max(Yarr(:,j));
end

% Plots

%plot(t,Yraw(:,1),t,Yraw(:,2),t,Yraw(:,3),t,Yraw(:,4))
%plot(t1,Yarr1(:,1),t1,Yarr1(:,2),t1,Yarr1(:,3),t1,Yarr1(:,4))
plot(Ynorm1(:,1),Ynorm1(:,2),Ynorm1(:,1),Ynorm1(:,3),Ynorm1(:,1),Ynorm1(:,4),Ynorm1(:,1),Ynorm1(:,5))
set(gca,'fontname','times','FontSize',12)
axis([0 4 0 1])  
grid
legend(f1name,f2name,f3name,f4name)
title('T2 Relaxation Curves')
xlabel('time (s)')
ylabel('amplitude (V)')


