clc
clear all

file = 'Fuel ILTs';

Z1 = readmatrix(file);
Y = zeros(500,6);
t = Z1(:,1);
t2 = (0.05:1e-4:1.5)';
Y1 = zeros(size(t2,1),6);
for i = 1:6
    Y(:,i) = Z1(:,i+1);
    %Y1(:,i) = interp1(t,Y(:,i),t2,'spline');
end

Y1(:,1) = interp1(t,Y(:,1),t2,'spline');