clc
clear all

t2 = 0:0.0001:1.25;

name1 = 'Jet-A';
sd1 = 0.15009;
u1 = 0.37069;
n1 = normpdf(t2,u1,sd1);
sd11 = 0.03044;
u11 = 0.94357;
n11 = normpdf(t2,u11,sd11);
n1 = n1 + n11;


name2 = 'JP-8';
sd2 = 0.05819;
u2 = 0.16152;
n2 = normpdf(t2,u2,sd2);
sd22 = 0.00622;
u22 = 0.97366;
n22 = normpdf(t2,u22,sd22);
n2 = n2 + n22;

name3 = 'JP-5';
sd3 = 0.0435;
u3 = 0.15972;
n3 = normpdf(t2,u3,sd3);
sd31 = 0.0048;
u31 = 0.84537;
n31 = normpdf(t2,u31,sd31);
n3 = n3 + n31;

name4 = 'Shell SPK';
sd4 = 0.01834;
u4 = 0.07253;
n4 = normpdf(t2,u4,sd4);
sd41 = 0.00328;
u41 = 1.02136;
n41 = normpdf(t2,u41,sd41);
n4 = n4 + n41;

name5 = 'Shell CPK';
sd5 = 0.22913;
u5 = 0.37406;
n5 = normpdf(t2,u5,sd5);
sd51 = 0.03385;
u51 = 1.0032;
n51 = normpdf(t2,u51,sd51);
n5 = n5 + n51;

name6 = 'Gevo-ATJ'; 
sd6 = 0.14526;
u6 = 0.26154;
n6 = normpdf(t2,u6,sd6);
sd61 = 0.01184;
u61 = 0.90647;
n61 = normpdf(t2,u61,sd61);
n6 = n6 + n61;

plot(t2,n1,'b',t2,n2,'r',t2,n3,'k',t2,n4,'m',t2,n5,'c',t2,n6,'g')
grid
%axis([0 1.25 0 80])
legend(name1,name2,name3,name4,name5,name6)
title('Two Term T2 Value Distribution')
xlabel('T2 Time Constant (s)')



