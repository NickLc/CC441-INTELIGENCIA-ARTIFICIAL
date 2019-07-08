%----------------------------------
% Regresion Iterativa Cubica
% Lazaro Camasca Edson 
% PC 1 - Inteligencia Artificial
%----------------------------------

clc 
clear
close all;

an = 2;
bn = 1;
cn = 3;
dn = -1;
x_inf = -3; x_aum = 0.2; x_sup = 3;
x = x_inf:x_aum:x_sup;	% Vector[inf:aum:sup]
x = x';			% Transpuesta de x
N = length(x);

error = 15*rand(N,1); %Cuando se aumenta el error, los datos son más dispersos
yb = an*x.^3 + bn*x.^2 + cn*x + dn + error;

figure(1);
plot(x, yb, 'o');	% Graficar la funcion y = f(x)
hold on; 

%---------------------------------------------------

a = 4;
b = 2;
c = 5;
d = -1.5;
eta = 0.00002; %input('eta-radio de aprendizaje-: '); %0.00002

sumx6 = sum(x.^6);
sumx5 = sum(x.^5);
sumx4 = sum(x.^4);
sumx3 = sum(x.^3);
sumx2 = sum(x.*x);
sumx = sum(x);
sumx3yb = sum(x.*x.*x.*yb);
sumx2yb = sum(x.*x.*yb);
sumxyb = sum(x.*yb);
sumyb = sum(yb);

umb = 0.0001;
num_iteraciones = 10000;
Jold = 1e10;

for k = 1:num_iteraciones
	  y = a*x.^3 + b*x.^2 + c*x + d;
	  e = y - yb;
    J = 0.5*e'*e;
    
    JJ(k,1) = J;
	  aa(k,1) = a;
    bb(k,1) = b;
    cc(k,1) = c;
    dd(k,1) = d;
    iter(k,1) = k;

    % Actualizacion de las derivadas parciales
  	dJda = a*sumx6 + b*sumx5 + c*sumx4 + d*sumx3 - sumx3yb;
    dJdb = a*sumx5 + b*sumx4 + c*sumx3 + d*sumx2 - sumx2yb;
    dJdc = a*sumx4 + b*sumx3 + c*sumx2 + d*sumx - sumxyb;
  	dJdd = a*sumx3 + b*sumx2 + c*sumx  + d*N - sumyb;
    
    % Gradiente desendente:
  	% Actualizamos los coeficientes para minimizar el error
    a = a - eta*dJda/N;
    b = b - eta*dJdb/N;
    c = c - eta*dJdc/N;
    d = d - eta*dJdd/N;
    
    % Actualizamos el J - funcion de coste del error
    dJ = J - Jold;
    dJJ = abs(dJ/J);
    if(dJJ*100 < umb)
        break;
    end
    Jold = J;
    
end

y = a*x.^3 + b.*x.^2+c.*x + d;
figure(1);
plot(x,yb,'o',x,y,'-r');
grid;

figure(2);
subplot(4,1,1); plot(iter,aa,'o')
subplot(4,1,2); plot(iter,bb,'o');
subplot(4,1,3); plot(iter,cc,'o');
subplot(4,1,4); plot(iter,dd,'o');

figure(3);
plot(iter,JJ,'o');

[ an  a
  bn  b
  cn  c
  dn  d ]