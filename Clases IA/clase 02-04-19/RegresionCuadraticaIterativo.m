clear;
clc;
close all;

x = -4:0.05:4;
x = x';
N = length(x);
an = 1;
bn = 2;
cn = -3;
yb = an*x.*x + bn*x + cn + 1*randn(N,1);
figure(1);
plot(x,yb,'or');

sumx4 = sum(x.*x.*x.*x);
sumx3 = sum(x.*x.*x);
sumx2 = sum(x.*x);
sumx  = sum(x);
sumx3yb = sum(x.*x.*x.*yb);
sumx2yb = sum(x.*x.*yb); 
sumxyb = sum(x.*yb);
sumyb  = sum(yb);

a = -3;
b = -3;
c = 1;
eta = 0.025;
cero = 1e-1;
for k = 1:10000
   aa(k,1) = a;
   bb(k,1) = b;
   cc(k,1) = c;
   iteracion(k,1) = k;
   dJda = a*sumx4 + b*sumx3 + c*sumx2 - sumx2yb;
   dJda = dJda/N;
   dJdb = a*sumx3 + b*sumx2 + c*sumx - sumxyb;
   dJdb = dJdb/N;
   dJdc = a*sumx2 + b*sumx  + c*N - sumyb;
   dJdc = dJdc/N;
   if((abs(dJda) < cero) && (abs(dJdb) < cero) && (abs(dJdc) < cero ))
       break;
   end
   y = a*x.*x + b*x + c;
   plot(x,yb,'or',x,y,'-b');
   pause(0.2);
   a = a - eta*dJda;
   b = b - eta*dJdb;
   c = c - 2*eta*dJdc;

end

y = a*x.*x + b*x + c;
figure(1);
plot(x,yb,'or',x,y,'-b');
figure(2);
subplot(3,1,1);   plot(iteracion,aa,'*b');
subplot(3,1,2);   plot(iteracion,bb,'*b');
subplot(3,1,3);   plot(iteracion,cc,'*b');

[ a  an
  b  bn
  c  cn ]  


