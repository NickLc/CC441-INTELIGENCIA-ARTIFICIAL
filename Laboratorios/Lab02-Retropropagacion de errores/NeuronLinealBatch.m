% Entrenamiento Batch con bias
clear;
clc;
close all;

% funcion lineal: y = ax+b
a = 3;
b = 4;

% x toma valores [limInf , limSup] con intevalo itv
limInf = -4
limSup = 4
itv = 0.1
x = limInf:itv:limSup;
x = x'; %transpuesta del vector x
N = length(x);
yb = a*x + b; 
yb = yb + 0.75*randn(N,1); % puntos aletorios 
% Notar que 0.75*randn(N,1) es el error 

ne = 1;
nm = 10;


%bias = input('Bias:  SI = 1 : ');
bias = 1
if(bias == 1)
   ne = ne +1;
   x = [ x ones(N,1) ]; %se agrega como segunda variable 1  
end

%v = Intensidad de conexion entre la entrada y la neurona intermedia
v = 0.1*randn(ne,nm);  
%w = Intensidad de conexion entre la neurona intermedia y la salida
w = 0.1*randn(nm,1);

% radio de aprendizaje
%eta = input('eta : ') 
eta = 0.05
for iter = 1:2000
   dJdv = 0;
   dJdw = 0;
   for k = 1:N
     %in valor de la capa de entrada
     in = (x(k,:))';
     %m = entrada de la neurona
     m = v'*in;  
     %n= salida de la funcion de activacion(neurona)
     %n = 2.0./(1+exp(-m)) - 1;     % Sigmoidea 2
     n = exp(-m.^2);               % Gaussiana
     
     out = w'*n; % intensidad de conexion x salida
     %y = valor de la capa final
     y(k,1) = out; 
     
     %----------- Retropropagacion de errores-----------  
     er = out - yb(k,1); 
     error(k,1) = er;
     %dndm = (1 - n.*n)/2;            % Sigmoidea 2
     dndm = -2.0*(n.*m);           % Gaussiana
     
     % (error retro) x (salida de la neurona en la capa anterior)
     dJdw = 0*dJdw + er.*n;        
     dJdv = 0*dJdv + er.*in*(w.*dndm)';
     
     % Actualiza las intensidades de las conexiones
     w = w - eta*dJdw/N;  % Patron
     v = v - eta*dJdv/N;  % Patron
    
   end
  %w = w - eta*dJdw/N;
  %v = v - eta*dJdv/N;
  %Batch porque la funcion de coste J se actualiza al final 
  JJ = 0.5*sum(error.*error)
  J(iter,1) = JJ;
end

figure(1);
plot(x(:,1),y,x(:,1),yb,'*');
figure(2);
plot(J);
