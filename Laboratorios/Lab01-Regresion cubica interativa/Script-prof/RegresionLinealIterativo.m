clear;
clc;
close all;

x = -3:0.075:4;
x = x';
N = length(x);
an = -3;
bn = 5;
yb = an*x + bn + 0.75*randn(N,1);
figure(1);
plot(x,yb,'or');

sumx2 = sum(x.*x);
sumx  = sum(x);
sumxyb = sum(x.*yb);
sumyb  = sum(yb);

a = 4.5;
b = 8;
eta = 0.05;
cero = 0.005;
Jold = 1e5;
for k = 1:10000
   aa(k,1) = a;
   bb(k,1) = b;
   iteracion(k,1) = k;
   y = a*x + b;
   er = y - yb;
   J = 0.5*er'*er;
   JJ(k,1) = J;
   dJ = J - Jold;
   dJrel = abs(dJ)/J;
   if(dJrel < cero)
       break;
   end  
   dJda = a*sumx2 + b*sumx - sumxyb;
   dJda = dJda/N;
   dJdb = a*sumx + b*N - sumyb;
   dJdb = dJdb/N;
   a = a - eta*dJda;
   b = b - eta*dJdb;     %  
   plot(x,yb,'or',x,y,'-b');
   pause(0.1);
   Jold = J;
end

y = a*x + b;
figure(1);
plot(x,yb,'or',x,y,'-b');
figure(2);
subplot(2,1,1);   plot(iteracion,aa,'*b');
subplot(2,1,2);   plot(iteracion,bb,'*r');
figure(3);
plot(iteracion,JJ,'*b');

[ a  an
  b  bn ]  


