% Entrenamiento Batch con bias
clear;
clc;
close all;

a = 3;
b = 4;

x = -4:0.1:4;
x = x';
N = length(x);
yb = a*x + b;
yb = yb + 0.75*randn(N,1);

ne = 1;
nm = 10;
bias = input('Bias:  SI = 1 : ');
if(bias == 1)
   ne = ne +1;
   x = [ x ones(N,1) ];   
end
v = 0.1*randn(ne,nm);
w = 0.1*randn(nm,1);

eta = input('eta : ')
for iter = 1:2000
   dJdv = 0;
   dJdw = 0;
   for k = 1:N   
     in = (x(k,:))';
     m = v'*in; 
     n = 2.0./(1+exp(-m)) - 1;     % Sigmoidea 2
     % n = exp(-m.^2);               % Gaussiana
     out = w'*n;
     y(k,1) = out;
     er = out - yb(k,1);
     error(k,1) = er;
     dndm = (1 - n.*n)/2;            % Sigmoidea 2
     % dndm = -2.0*(n.*m);        % Gaussiana
     dJdw = dJdw + er.*n;        
     dJdv = dJdv + er.*in*(w.*dndm)';
     % w = w - eta*dJdw/nx;
     % v = v - eta*dJdv/nx;
   end
w = w - eta*dJdw/N;
v = v - eta*dJdv/N;
JJ = 0.5*sum(error.*error)
J(iter,1) = JJ;
end

figure(1);
plot(x(:,1),y,x(:,1),yb,'*');
figure(2);
plot(J);
