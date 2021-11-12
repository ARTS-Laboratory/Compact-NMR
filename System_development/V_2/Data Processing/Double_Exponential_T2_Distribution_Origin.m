clc
clear all

t2 = 0:0.0001:2;

name1 = 'Shell CPK - a=0.2';
sd1 = 0.000376;
u1 = 0.9;
sd11 = 0.00273;
u11 = 1.4;
n1 = normpdf(t2,u1,sd1) + normpdf(t2,u11,sd11);

name2 = 'Shell CPK - a=0.4';
sd2 = 5.28E-4;
u2 = 0.85;
sd21 = 0.00122;
u21 = 1.21;
n2 = normpdf(t2,u2,sd2) + normpdf(t2,u21,sd21);

name3 = 'Con Tol & Hep';
sd3 = 0.04;
u3 = 1.09;
sd31 = 0.4;
u31 = 1.5;
n3 = normpdf(t2,u3,sd3) + normpdf(t2,u31,sd31);

name4 = 'Mix Tol & Hep';
sd4 = 0.0071;
u4 = 1.05;
sd41 = 0.0062;
u41 = 1.16;
n4 = normpdf(t2,u4,sd4) + normpdf(t2,u41,sd41);

name5 = 'Toluene';
sd5 = 0.005;
u5 = 1.15;
sd51 = 0.003;
u51 = 1.53;
n5 = normpdf(t2,u5,sd5) + normpdf(t2,u51,sd51);

name6 = 'Heptane'; 
sd6 = 0.00122;
u6 = -1;
sd61 = 0.003;
u61 = 1.02;
n6 = normpdf(t2,u6,sd6) + normpdf(t2,u61,sd61);

name7 = 'n-Octane'; 
sd7 = 0.00145;
u7 = -1;
sd71 = 0.003;
u71 = 1.09;
n7 = normpdf(t2,u7,sd7) + normpdf(t2,u71,sd71);

plot(t2,n4,'b',t2,n5,'k',t2,n6,'r',t2,n7,'m')
grid
%axis([0 1.25 0 80])
legend(name4,name5,name6,name7)
title('Biexponential T2 Value Distribution - Origin Curve Fitting')
xlabel('T2 Time Constant (s)')

narr = zeros(size(n1,2),7);
narr(:,1) = t2';
narr(:,2) = n1';
narr(:,3) = n2';
narr(:,4) = n3';
narr(:,5) = n4';
narr(:,6) = n5';
narr(:,7) = n6';



