%----------------------------------
% Regresion Exacta Cubica
% Lazaro Camasca Edson 
% PC 1 - Inteligencia Artificial
%----------------------------------

clc 
clear
close all;

an = 4;
bn = 1;
cn = 3;
dn = -4;
x_inf = -2; x_aum = 0.1; x_sup = 2;
x = x_inf:x_aum:x_sup;	% Vector[inf:aum:sup]
x = x';			% Transpuesta de x
N = length(x);

error = 10*rand(N,1); %Cuando se aumenta el error, los datos son más dispersos
yb = an*x.^3 + bn*x.^2 + cn*x + dn + error;

figure(1);
plot(x,yb,'o')

%--- Fila 1----
A11 = sum(x.^6);
A12 = sum(x.^5);
A13 = sum(x.^4);
A14 = sum(x.^3);

%--- Fila 2----
A21 = sum(x.^5);
A22 = sum(x.^4);
A23 = sum(x.^3);
A24 = sum(x.*x);

%--- Fila 3 --
A31 = sum(x.^4);
A32 = sum(x.^3);
A33 = sum(x.*x);
A34 = sum(x);

%--- Fila 4 ---
A41 = sum(x.^3);
A42 = sum(x.*x);
A43 = sum(x);
A44 = N;

%---   B -----

B1 = sum(x.*x.*x.*yb);
B2 = sum(x.*x.*yb);
B3 = sum(x.*yb);
B4 = sum(yb);


A = [ A11   A12   A13   A14
      A21   A22   A23   A24
      A31   A32   A33   A34
      A41   A42   A43   A44];
        
B = [ B1
        B2
        B3 
        B4];
        
z = inv(A)*B;
a = z(1,1);
b = z(2,1); 
c = z(3,1);
d = z(4,1);

y = a*x.^3 + b*x.^2 + c*x + d;

figure(1);
plot(x,yb,'o',x,y,'-r');
grid;

[ an  a
  bn  b
  cn  c
  dn  d ]