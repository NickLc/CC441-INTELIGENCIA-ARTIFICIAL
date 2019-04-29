% Entrenamiento patron - Salida vectorial
% Basico

clear;
clc;
close all;

a3 = 0.5*2;
a2 = 0.3*4;
a1 = -0.8*25;
a0 = -0*30;

x1 = -4:0.1:4;
x1 = x1';
N = length(x1);
x2 = linspace(-3,3,N);
x2 = x2';
x = [ x1 x2 ];

yb1 = a3*x1.^3 + a2*x1.^2 + a1*x2.^1 + a0;
yb1 = 0.075*yb1;
yb1 = yb1 + 0.1*randn(N,1);
yb2 = a3*x2.^3 + a2*x2.^2 + a1*x1.^1 + a0;
yb2 = 0.075*yb2;
yb2 = yb2 + 0.1*randn(N,1);
yb = [ yb1  yb2 ];

ne = 2;
nm = 10;
pq = 10;
ns = 2;

bias = input('Bias:  SI = 1 : ');
if(bias == 1)
      ne = ne +1;
      x = [ x ones(N,1) ];   
end

u = 0.25*randn(ne,nm);
v = 0.25*randn(nm,pq);
w = 0.25*randn(pq,ns);
%load pesos;

eta = input('eta pesos : ');

for iter = 1:4500
JJ = 0;
dJdu = zeros(ne,nm);
dJdv = zeros(nm,pq);
dJdw = zeros(pq,ns);
for k = 1:N   
  in = (x(k,:))';
  m = u'*in;
  n = 2.0./(1+exp(-m./1)) - 1;
  p = v'*n;
  q = 2.0./(1+exp(-p./1)) - 1;
  out = w'*q;
  y(k,:) = out';
  er = out - (yb(k,:))';
  error(k,:) = er';
  JJ = JJ + 0.5*er'*er;
  dqdp = (1 - q.*q)/2;
  dndm = (1 - n.*n)/2;
%  dndm = -2.0*(n.*m);
  eb = dqdp.*(w*er);
  e2b = dndm.*(v*eb);
  dJdw = dJdw + q*er';
  dJdv  = dJdv + n*eb';
  dJdu = dJdu + in*e2b';
%   w = w - eta*dJdw;
%   v = v - eta*dJdv;
%   u = u - eta*dJdu;
end
  w = w - eta*dJdw/N;
  v = v - eta*dJdv/N;
  u = u - eta*dJdu/N;
JJ
J(iter,1) = JJ;
end

figure(1);
plot(y(:,1),'-r');
hold on;
plot(yb(:,1),'*b');
title('Salida y1');
figure(2);
plot(y(:,2),'-r');
hold on;
plot(yb(:,2),'*b');
title('Salida y2');
figure(3);
plot(J);
title('Funcion de costo J');
figure(5);
plot3(x1,x2,y(:,1),'-r',x1,x2,yb(:,1),'-b');
title('Salida y1');
figure(6);
plot3(x1,x2,y(:,2),'-r',x1,x2,yb(:,2),'-b');
title('Salida y2');