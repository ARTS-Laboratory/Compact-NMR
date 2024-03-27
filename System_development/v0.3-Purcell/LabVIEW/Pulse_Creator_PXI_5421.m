clc
clear all

%Output sample rate
fs = 1e6;

%90 Degree pulse time (us)
time90 = 7;

%tau time 
tau = 0.64e-3;
tau2 = 1.25e-3;

%Number of 180 pulses
np = 4;

%90 degree pulse low & high times
h90 = fs*time90*1E-6;
hT90 = round(h90);
lT90 = tau*fs;

%180 degree pulse low & high times
hT180 = hT90*2;
lT180 = tau2*fs;

%Delay at the beginning & end of generation
delayB = 250;
delayE = 150001;

%Total AWG length
length = delayB + hT90 + lT90 + np*(hT180 + lT180) + delayE;

%Total Time of Test
time = (length - delayE)/fs;

Z2W = mod(length,4);

%%
%Matrix that holds the data
waveform = zeros(length,1);

%Data population
waveform(1:delayB,1) = 0;
waveform((delayB + 1):(delayB + hT90),1) = 1;
waveform((delayB + hT90 + 1):(delayB + hT90 + lT90),1) = 0;
c = delayB + hT90 + lT90;
for a = 1:np
    waveform((c + 1):(c + hT180),1) = 1;
    waveform((c + hT180 + 1):(c + hT180 + lT180),1) = 0;
    c = c + hT180 + lT180;
end
waveform((c + 1):(c + delayE),1) = 0;

%File used by LabView
formatSpec = "%d us 90 Degree - 1.25 ms Tau - %d Pulses.txt";
str = sprintf(formatSpec,time90,np);
fileID = fopen(str,'w');
fprintf(fileID,'%1.1f\t',waveform);