clear;
clc;
close all;

x = -3:0.05:4;
x = x';
N = length(x);
an = 3;
bn = 5;
yb = an*x + bn + 4*0.5*randn(N,1);
figure(1);
plot(x,yb,'or');

A11 = sum(x.*x);
A12 = sum(x);
A21 = A12;
A22 = N;
B1 = sum(x.*yb);
B2 = sum(yb);
A = [ A11  A12
        A21  A22 ];
B = [ B1
      B2 ];

z = inv(A)*B;
a = z(1,1);
b = z(2,1);

y = a*x + b;
figure(1);
plot(x,yb,'or',x,y,'-b');

[ a  an
  b  bn ]  


