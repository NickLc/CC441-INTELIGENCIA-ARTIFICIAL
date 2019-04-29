clear;
clc;
close all;

an = 2;
bn = 3;
cn = -4;
x = -3:0.1:3;   x = x';
N = length(x);
yb = an*x.*x + bn*x + cn + 1*randn(N,1);

figure(1);
plot(x,yb,'o')

A11 = sum(x.^4);
A12 = sum(x.^3);
A13 = sum(x.*x);
A21 = A12;
A22 = sum(x.*x);
A23 = sum(x);
A31 = A13;
A32 = A23;
A33 = N;
B1 = sum(x.*x.*yb);
B2 = sum(x.*yb);
B3 = sum(yb);
A = [ A11   A12   A13
        A21   A22   A23
        A31   A32   A33 ];
B = [ B1
        B2
        B3 ];
z = inv(A)*B;
a = z(1,1);
b = z(2,1); 
c = z(3,1);

y = a*x.*x + b*x + c;
figure(1);
plot(x,yb,'o',x,y,'-r');
grid;

[ an  a
  bn  b
  cn  c ]


    
    



