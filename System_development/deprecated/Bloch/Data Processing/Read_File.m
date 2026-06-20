clc
clear all

file = 'Waveform.txt';
length = 600001;
fs = 300e3;
t = (0:1/fs:2)';
text = fileread(file);
Y = zeros(length,1);
j = 1;
c = 0;
for i = 1:size(text,2)
    if(text(1,i) == ',')
        str = text(1,i-c:i);
        x = str2double(str);
        Y(j,1) = x;
        j = j+1;
        c = 0;
    else
        c = c+1;
    end
end
%%
Z = Y(450:length,1);
t2 = t(910:length,1);
i = 360;
j = 754;
num = 745;
Y1 = zeros(num-9,1);
d = 1.885;
t1 = (0:d/(num-10):d)';

for c = 10:num
    if c == 1
       k = 1;
    else
        k = (c-1)*j;
    end
    max1 = Z(k,:);
    for g = k:(k+i)
        if Z(g+1,:) > max1
           max1 = Z(g+1,:);
        end
    end
    Y1(c-9,:) = max1;
end

plot(t1,Y1)
grid
