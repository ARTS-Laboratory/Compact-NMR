clc
clear all

%Number of 180 pulses
np = 750;

%90 degree pulse low & high times
hT90 = 150;
lT90 = 31875;

%180 degree pulse low & high times
hT180 = 300;
lT180 = 62500;

%Delay at the beginning of generation
delay = 500;

%Total AWG length
length = delay + hT90 + lT90 + np*(hT180 + lT180);

%Matrix that holds the data
waveform = zeros(length,1);

%Data population
waveform(1:delay,1) = 0;
waveform(delay + 1:delay + hT90,1) = 1;
waveform(delay + hT90 + 1:delay + hT90 + lT90,1) = 0;
c = delay + hT90 + lT90;
for a = 1:np
    waveform(c + 1:c + hT180,1) = 1;
    waveform(c + hT180 + 1:c + hT180 + lT180,1) = 0;
    c = c + hT180 + lT180;
end

%File used by LabView
fileID = fopen('wfm.txt','w');
fprintf(fileID,'%12.15f\t',waveform);







