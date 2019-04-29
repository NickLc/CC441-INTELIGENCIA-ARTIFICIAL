clear;
clc;
close all;

an = 1;
bn = -2;
cn = 3;
x = -3:0.1:3;   x = x';
N = length(x);
yb = an*x.*x + bn*x + cn + 0.75*randn(N,1);

figure(1);
plot(x,yb,'o')
hold on;

aini = -1;
bini =  2;
cini = 1;
eta = input('eta: ');
a = aini;
b = bini;
c = cini;
sumx4 = sum(x.^4);
sumx3 = sum(x.^3);
sumx2 = sum(x.*x);
sumx = sum(x);
sumx2yb = sum(x.*x.*yb);
sumxyb = sum(x.*yb);
sumyb = sum(yb);
umb = 0.1;
Jold = 1e10;
for k = 1:10000
    y = a*x.*x + b*x + c;
    figure(1);
    plot(x,yb,'o',x,y,'-r'); 
    pause(0.1);
    plot(x,yb,'ow',x,y,'-w');   
    e = y - yb;
    J = 0.5*e'*e;
    JJ(k,1) = J;
    aa(k,1) = a;
    bb(k,1) = b;
    cc(k,1) = c;
    iter(k,1) = k;
    dJda = a*sumx4 + b*sumx3 + c*sumx2 - sumx2yb;
    dJdb = a*sumx3 + b*sumx2 + c*sumx   - sumxyb;
    dJdc = a*sumx2 + b*sumx   + c*N         - sumyb;
     a = a - eta*dJda/N;
     b = b - eta*dJdb/N; 
     c = c - eta*dJdc/N;
     dJ = J - Jold;
     dJJ = abs(dJ/J);
     if(dJJ*100 < umb)
         break;
     end
     Jold = J;
 end
y = a*x.*x + b*x + c;
figure(1);
plot(x,yb,'o',x,y,'-r');
grid;

figure(2);
subplot(3,1,1);  plot(iter,aa,'o');
subplot(3,1,2);  plot(iter,bb,'o');
subplot(3,1,3);  plot(iter,cc,'o');
figure(3);
plot(iter,JJ,'o');

[ an  a
  bn  b
  cn  c ]


    
    



