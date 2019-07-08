% Entrenamiento Patron con bias

clear;
clc;
close all;
disp('Hello');

a = 1;
b = 2;

x = -2:0.05:3;
x = x';
N = length(x);
yb = a*x + b + 0.2*randn(N,1);

ne = 1;
nm = 20;
bias = input('Bias:  SI = 1 : ');
if(bias == 1)
   ne = ne +1;
   x = [ x ones(N,1) ];   
end
v  = 0.25*randn(ne,nm);
w = 0.25*randn(nm,1);
Jold = 1e15;
eta = input('eta : ');
for iter = 1:5000
w11(iter,1) = w(1,1); 
dJdv = 0;     dJdw = 0;
for k = 1:N  
in = (x(k,:))';
m = v'*in; 
n = 1.0./(1+exp(-m));       % Sigmoidea 1
% n = 2.0./(1+exp(-m)) - 1;  % Sigmoidea 2
% n = exp(-m.^2);            % Gaussiana
out = w'*n;
y(k,1) = out;
er = out - yb(k,1);
error(k,1) = er;
dndm = n.*(1-n);     % Sigmoidea 1
% dndm = (1 - n.*n)/2;   % Sigmoidea 2
% dndm = -2.0*(n.*m);     % Gaussiana
dJdw = 1*dJdw +  er.*n;
dJdv  = 1*dJdv + er.*in*(w.*dndm)';
% w = w - eta*dJdw;
% v = v - eta*dJdv;
end
w = w - eta*dJdw/N;
v = v - eta*dJdv/N;

JJ = 0.5*sum(error.*error)
dJ = abs(JJ - Jold);
dJpor = sqrt(dJ/JJ)*100;
if(dJpor < 0.75)    % Porcentual
    break;
end
J(iter,1) = JJ;
Jold = JJ;
end

figure(1);
plot(x(:,1),y,x(:,1),yb,'*');
figure(2);
subplot(2,1,1);  plot(J);
subplot(2,1,2);  plot(w11);
