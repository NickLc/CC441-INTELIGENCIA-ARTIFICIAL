% Programa de entrenamiento de redes neuronales para 
% reconocer anomalias cardiacas


clear;
clc;
close all;

% Datos de la red
% ---------------
   load ecgred;
   
   
% Lectura de datos
% -----------------
%load ECGdata;
load ECGVilla;
k1 = 395;
k2 = 996;

ruido = menu('Validando con ruido de:','Baja intensidad','Mediana intensidad','Alta intensidad');

if(ruido == 1)
  datainput(1,:) = (yy1r1(k1:k2,1))'/kfact1;
  datainput(2,:) = (yy2r1(k1:k2,1))'/kfact2;
  datainput(3,:) = (yy3r1(k1:k2,1))'/kfact3;
  datainput(4,:) = (yy4r1(k1:k2,1))'/kfact4;
  datainput(5,:) = (yy5r1(k1:k2,1))'/kfact5;
elseif(ruido == 2)
  datainput(1,:) = (yy1r2(k1:k2,1))'/kfact1;
  datainput(2,:) = (yy2r2(k1:k2,1))'/kfact2;
  datainput(3,:) = (yy3r2(k1:k2,1))'/kfact3;
  datainput(4,:) = (yy4r2(k1:k2,1))'/kfact4;
  datainput(5,:) = (yy5r2(k1:k2,1))'/kfact5;
elseif(ruido == 3)  
  datainput(1,:) = (yy1r3(k1:k2,1))'/kfact1;
  datainput(2,:) = (yy2r3(k1:k2,1))'/kfact2;
  datainput(3,:) = (yy3r3(k1:k2,1))'/kfact3;
  datainput(4,:) = (yy4r3(k1:k2,1))'/kfact4;
  datainput(5,:) = (yy5r3(k1:k2,1))'/kfact5; 
end

datainput = datainput + 0.16*randn(5,602);


dataoutput = [ 1  0  0  0  0
               0  1  0  0  0  
               0  0  1  0  0
               0  0  0  1  0
               0  0  0  0  1 ];
            
ndata = 5;

disp('  ');
disp('Resultados de la lectura del archivo con data');
disp('  ');
disp([' Numero de entradas : ',num2str(ne)]);
disp([' Numero de salidas  : ',num2str(ns)]);
disp([' Numero de paquetes de datos entrada-salida: ',num2str(ndata)]);
disp('  ');


if(bias == 1) 
   datainput = [ datainput ones(ndata,1) ];   
end

for k = 1:ndata
      x = datainput(k,:);
      x = x';
      m = v'*x; 
%      n = exp((-(m-c).^2)./a);
     n = 2.0./(1+ exp(-(m-c)./a)) - 1;     
      y = w'*n;
      output(k,:) = y';
      for kx = 1:ns
         [maxout km] = max(output(k,:));   
         outputmax(k,:)  = zeros(1,ns);  
         outputmax(k,km) = 1;       
     end
end

figure(1);
  subplot(5,1,1);  plot(time,yy1); axis([ 0 7 -10 10]);
  subplot(5,1,2);  plot(time,yy2); axis([ 0 7 -10 10]);
  subplot(5,1,3);  plot(time,yy3); axis([ 0 7 -10 10]);
  subplot(5,1,4);  plot(time,yy4); axis([ 0 7 -10 10]);
  subplot(5,1,5);  plot(time,yy5); axis([ 0 7 -10 10]);

figure(2);
if(ruido == 1)
  subplot(5,1,1);  plot(time,yy1r1); axis([ 0 7 -10 10]);
  subplot(5,1,2);  plot(time,yy2r1); axis([ 0 7 -10 10]);
  subplot(5,1,3);  plot(time,yy3r1); axis([ 0 7 -10 10]);
  subplot(5,1,4);  plot(time,yy4r1); axis([ 0 7 -10 10]);
  subplot(5,1,5);  plot(time,yy5r1); axis([ 0 7 -10 10]);
elseif(ruido == 2)
  subplot(5,1,1);  plot(time,yy1r2); axis([ 0 7 -10 10]);
  subplot(5,1,2);  plot(time,yy2r2); axis([ 0 7 -10 10]);
  subplot(5,1,3);  plot(time,yy3r2); axis([ 0 7 -10 10]);
  subplot(5,1,4);  plot(time,yy4r2); axis([ 0 7 -10 10]);
  subplot(5,1,5);  plot(time,yy5r2); axis([ 0 7 -10 10]);
elseif(ruido == 3)
  subplot(5,1,1);  plot(time,yy1r3); axis([ 0 7 -10 10]);
  subplot(5,1,2);  plot(time,yy2r3); axis([ 0 7 -10 10]);
  subplot(5,1,3);  plot(time,yy3r3); axis([ 0 7 -10 10]);
  subplot(5,1,4);  plot(time,yy4r3); axis([ 0 7 -10 10]);
  subplot(5,1,5);  plot(time,yy5r3); axis([ 0 7 -10 10]);  
end
for k = 1:ns
  figure(k+2);
  plot(dataoutput(k,:),'or','Linewidth',2);
  hold on;
  plot(outputmax(k,:),'*b','Linewidth',2);
end






