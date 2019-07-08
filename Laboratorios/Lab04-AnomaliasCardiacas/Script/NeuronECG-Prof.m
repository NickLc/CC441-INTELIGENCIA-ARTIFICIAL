
% Programa de entrenamiento de redes neuronales para 
% reconocer anomalias cardiacas


clear;
clc;
close all;

% Lectura de datos
% -----------------
load ECGVilla;
k1 = 395;
k2 = 996;
kfact1 = max(yy1);
kfact2 = max(yy2);
kfact3 = max(yy3);
kfact4 = max(yy4);
kfact5 = max(yy5);
datainput(1,:) = (yy1(k1:k2,1))'/kfact1;
datainput(2,:) = (yy2(k1:k2,1))'/kfact2;
datainput(3,:) = (yy3(k1:k2,1))'/kfact3;
datainput(4,:) = (yy4(k1:k2,1))'/kfact4;
datainput(5,:) = (yy5(k1:k2,1))'/kfact5;
dataoutput = [ 1  0  0  0  0
                      0  1  0  0  0  
                      0  0  1  0  0
                      0  0  0  1  0
                      0  0  0  0  1 ];
            
ne = k2-k1+1;   % Numero de entradas
ns = 5;         % Numero de salidas
ndata = 5;      % Numero de paquetes entrada - salida      
        
disp('  ');
disp('Resultados de la lectura del archivo con data');
disp('  ');
disp([' Numero de entradas : ',num2str(ne)]);
disp([' Numero de salidas  : ',num2str(ns)]);
disp([' Numero de paquetes de datos entrada-salida: ',num2str(ndata)]);
disp('  ');


% Datos de la red
% ---------------
datosred = menu('Los datos de la red (pesos, bias)',...
                'Se leeran desde un archivo',...
                'Seran generados automaticamente');

if(datosred == 1) 
   load ecgred;
   
elseif(datosred == 2)
   nm = input('Introducir numero de neuronas en capa intermedia : '); 
   rbias =  menu('Considera neurona bias','Si','No');
   if(rbias == 1) 
      bias = 1;
   elseif(rbias == 2)
      bias = 0;
   end
 
   ne = ne + bias;        % ne se aumenta en 1 si se considera bias. Bias solo en la capa de entrada
   v = 0.2*randn(ne,nm);
   w = 0.2*randn(nm,ns); 
   c = zeros(nm,1);
   a = ones(nm,1);
end

if(bias == 1) 
   datainput = [ datainput ones(ndata,1) ];   
end

eta  = input('Introducir ratio de aprendizaje : ');
etaa = input('Introducir ratio de aprendizaje de exponente a : ');
etac = input('Introducir ratio de aprendizaje del centro c : ');

errormax = input('Introducir el valor maximo del error (%) : ');
errormax = errormax/100;
contmax = input('Introducir el maximo numero de etapas de aprendizaje : ');

outsum2 = sum(dataoutput.^2);
outsum2 = outsum2';
outsum2total = sum(outsum2);

cont = 1;
erreltotal = 1;
   dw_old = 0;  
   dv_old = 0;
   da_old = 0;
   dc_old = 0;
   

while( (erreltotal > errormax) & (cont < contmax) ) 
   ersum2 = zeros(ns,1);
   dw = zeros(nm,ns);
   dv = zeros(ne,nm);
   dc = zeros(nm,1);
   da = zeros(nm,1);
   
   for k = 1:ndata
      x = datainput(k,:);
      x = x';
      m = v'*x; 
%      n = exp((-(m-c).^2)./a);
      n = 2.0./(1+exp(-(m-c)./a)) - 1;     
      y = w'*n;
      output(k,:) = y';
      yd = dataoutput(k,:);
      yd = yd';
      er = (y - yd);
      erdJ = (y - yd);
      dJdw = n*erdJ';
      dJdv = x * ((w*erdJ).* ((1.0-n.*n)./2.0))';  
%      dJdv = x * ((w*erdJ).* (-2.0*n.*(m-c)./a))';  
       dJda = (w*erdJ).*( (n.*((m-c).^2))./(a.^2));
       dJdc = (w*erdJ).*(2.0.*n.*(m-c)./a);
       ersum2 = ersum2 + er.^2;
       dw = dw + dJdw;
       dv = dv + dJdv;
       da = da + dJda;     
       dc = dc + dJdc;
%        w = w - eta*dw;
%        v = v - eta*dv;
%       a = a - etaa*da;
%       c = c - etac*dc;
       dw_old = dw;
       dv_old = dv;
%       da_old = da;
%       dc_old = dc;
   end
       w = w - eta*dw/ndata;
       v = v - eta*dv/ndata;
       a = a - etaa*da/ndata;
       c = c - etac*dc/ndata;  
   
   ersum2total = sum(ersum2);
   if ( rem(cont,1) == 0 )
      errorrel(cont/1,:) = sqrt(ersum2'./outsum2');
      errorreltotal(cont/1,1) = sqrt(ersum2total/outsum2total);
      erreltotal = errorreltotal(cont/1,1) * 100
   end
   cont = cont + 1;  
end  

figure(1);
plot(errorreltotal*100);
figure(2);
plot(errorrel*100);


% Graficos
% --------
for k = 1:ns
  figure(k+2);
  plot(dataoutput(:,k),'or','Linewidth',2);
  hold on;
  plot(output(:,k),'*b','Linewidth',2);
end

save ecgred v w ne nm ns bias c a kfact1 kfact2 kfact3 kfact4 kfact5;





