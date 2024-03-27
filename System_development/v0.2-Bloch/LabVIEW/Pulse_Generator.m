clc
clear all

%Number of 180 pulses
np = 2;

%90 degree pulse low & high times
hT90 = 20;
lT90 = 640;

%180 degree pulse low & high times
hT180 = 40;
lT180 = 1250;

%Delay at the beginning & end of generation
delayB = 250;
delayE = 150001;

%Total AWG length
length = delayB + hT90 + lT90 + np*(hT180 + lT180) + delayE;

%Total Time of Test
fs = 1e6;
time = (length - delayE)/fs;

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
fileID = fopen('Single 90 & Double 180 Degree Pulse Echo.txt','w');
fprintf(fileID,'%1.1f\t',waveform);







