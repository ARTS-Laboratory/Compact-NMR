clc
clear all

t2 = 0:0.0001:2;

name1 = 'JP-8';
sd1 = 0.0017;
u1 = 0.90;
sd11 = 0.0026;
u11 = 1.09;
n1 = normpdf(t2,u1,sd1) + normpdf(t2,u11,sd11);

name2 = 'Jet-A';
sd2 = 0.0011;
u2 = 0.82;
sd21 = 0.0017;
u21 = 1.07;
n2 = normpdf(t2,u2,sd2) + normpdf(t2,u21,sd21);

name3 = 'JP-5';
sd3 = 0.0012;
u3 = 0.76;
sd31 = 0.0016;
u31 = 0.99;
n3 = normpdf(t2,u3,sd3) + normpdf(t2,u31,sd31);

name4 = 'Shell CPK';
sd4 = 0.001;
u4 = 0.87;
sd41 = 0.0019;
u41 = 1.16;
n4 = normpdf(t2,u4,sd4) + normpdf(t2,u41,sd41);

name5 = 'Shell SPK';
sd5 = 0.0027;
u5 = 0.97;
sd51 = 0.0048;
u51 = 1.09;
n5 = normpdf(t2,u5,sd5) + normpdf(t2,u51,sd51);

name6 = 'Gevo ATJ'; 
sd6 = 0.0026;
u6 = 0.85;
sd61 = 0.0039;
u61 = 0.95;
n6 = normpdf(t2,u6,sd6) + normpdf(t2,u61,sd61);

name7 = 'n-Octane'; 
sd7 = 0.0015;
u7 = 0.94;
sd71 = 0.0022;
u71 = 1.16;
n7 = normpdf(t2,u7,sd7) + normpdf(t2,u71,sd71);

plot(t2,n1,'b',t2,n2,'k',t2,n3,'r',t2,n4,'m',t2,n5,'c',t2,n6,'g')
grid
axis([0.6 1.4 0 400])
legend(name1,name2,name3,name4,name5,name6)
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



