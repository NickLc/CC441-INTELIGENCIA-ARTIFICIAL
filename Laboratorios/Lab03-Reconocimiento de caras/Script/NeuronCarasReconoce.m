% Entrenamiento patron

clear;
clc;
close all;

% Pixel blanco = 0 
% Pixel negro  = 1
load cara1px;
load cara2px;
load cara3px; 
load cara4px;  
load cara5px;   
load cara6px;
load cara7px;
load cara8px;  
load cara9px;   
load cara10px;   
%{
figure(1);
subplot(2,5,1);  imshow(cara1px);
subplot(2,5,2);  imshow(cara2px);
subplot(2,5,3);  imshow(cara3px);
subplot(2,5,4);  imshow(cara4px);
subplot(2,5,5);  imshow(cara5px);
subplot(2,5,6);  imshow(cara6px);
subplot(2,5,7);  imshow(cara7px);
subplot(2,5,8);  imshow(cara8px);
subplot(2,5,9);  imshow(cara9px);
subplot(2,5,10);  imshow(cara10px);
%}
disp('Press ENTER');
pause;
% Transformando del rango 0(negro)-255(blanco) a 0(blanco)-1(negro)  
cara1 = abs((cara1px-255)/255);
cara2 = abs((cara2px-255)/255);
cara3 = abs((cara3px-255)/255);
cara4 = abs((cara4px-255)/255);
cara5 = abs((cara5px-255)/255);
cara6 = abs((cara6px-255)/255);
cara7 = abs((cara7px-255)/255);
cara8 = abs((cara8px-255)/255);
cara9 = abs((cara9px-255)/255);
cara10 = abs((cara10px-255)/255);

%clear cara1px cara2px cara3px cara4px;

% Todas las caras deben tener la misma cantidad de pixeles en columnas
[nf nc] = size(cara1);

% X : entradas a la neurona
x(1,:) = cara1(1,:);
x(2,:) = cara2(1,:);
x(3,:) = cara3(1,:);
x(4,:) = cara4(1,:);
x(5,:) = cara5(1,:);
x(6,:) = cara6(1,:);
x(7,:) = cara7(1,:);
x(8,:) = cara8(1,:);
x(9,:) = cara9(1,:);
x(10,:) = cara10(1,:);

for k = 2:nf
    caras = [ cara1(k,:)
             cara2(k,:)
             cara3(k,:)
             cara4(k,:)
             cara5(k,:)
             cara6(k,:)
             cara7(k,:)
             cara8(k,:)
             cara9(k,:)
             cara10(k,:) ];
% Se reune las filas de las caras intercaladamente 
    x = [ x  caras ];
end
x
[ nxf nxc ] = size(x); 
nx = nxf;

% yb : salida de la neurona
yb(1,:) = [ 1 0 0 0 0 0 0 0 0 0 ]; 
yb(2,:) = [ 0 1 0 0 0 0 0 0 0 0 ]; 
yb(3,:) = [ 0 0 1 0 0 0 0 0 0 0 ]; 
yb(4,:) = [ 0 0 0 1 0 0 0 0 0 0 ]; 
yb(5,:) = [ 0 0 0 0 1 0 0 0 0 0 ]; 
yb(6,:) = [ 0 0 0 0 0 1 0 0 0 0 ]; 
yb(7,:) = [ 0 0 0 0 0 0 1 0 0 0 ]; 
yb(8,:) = [ 0 0 0 0 0 0 0 1 0 0 ]; 
yb(9,:) = [ 0 0 0 0 0 0 0 0 1 0 ]; 
yb(10,:) = [ 0 0 0 0 0 0 0 0 0 1 ]; 


[ nyf nyc ] = size(yb);
ny = nyf;

% Neuronas 
ne = nxc;  % Neuronas entrada
nm = 10;    % Neuronas intermedias
ns = nyc;  % Neuronas salida

% Agregamos 1 al final del vector x 
% x = (x1, x2,.....,xn, 1)
%bias = input('Bias:  SI = 1 : ');
bias = 1;
if(bias == 1)
   ne = ne +1;
   x = [ x ones(nx,1) ];   
end

% Intensidad de las conexiones
% load pesoscaras;
v = 0.2*(rand(ne,nm) - 0.5);
w = 0.2*(rand(nm,ns) - 0.5);


%eta = input('eta pesos : ');  %0.08 buena aprox
eta = 0.08;
for iter = 1:3000  
    count(iter,1) = iter;
    dJdw = 0;
    dJdv = 0;
    for k = 1:nx    
        % Salida de la neurona entrada
        in = (x(k,:))';  
        % Entrada a la neurona intermedia
        m = v'*in;        
        % Salida de la neurona intermedia
        n = 1.0./(1+exp(-m));    % Sigmoidea 1
        %n = 2.0./(1+exp(-m)) - 1; % sigmoidea 2
        %n = exp(-m.^2);         % Gaussiana
        
        % Entrada a la neurona de salida
        out = w'*n;
        
        y(k,:) = out';
        er = out - (yb(k,:))';
        error(k,:) = er';
        dndm = n.*(1 - n);       % Sigmoidea 1
        %dndm = (1 - n.*n)/2;     % Sigmoidea 2
        %dndm = -2.0*(n.*m);     % Gaussiana
        dydw = n; 
        dJdw = 1*dJdw + dydw*er';     %Las derivadas se van acumulando
        dJdv = 1*dJdv + in*((w*er).*dndm)';    
        %w = w - eta*dJdw/nx;   
        %v = v - eta*dJdv/nx;      
    end
    %Entrenamiento patro al final actualiza
    w = w - eta*dJdw/nx;   
    v  = v - eta*dJdv/nx; 
    JJ = 0.5*sum(sum(error.*error));
    J(iter,1) = JJ;
end

%Guardar el valor de los pesos, intensidad de conexione
save pesoscaras ne ns nm v w  bias; 

figure(1);
plot(y(1,:),'or');   % Se grafica sin redondeo
hold on;
plot(yb(1,:),'*b');

figure(2);
plot(count,J);

