% Program for training a dynamic neural network for modeling a nonlinear system 
% using the DBP algorithm. 
% The system has 1 input and 2 output signals.


clear;
clc;
close all;

% Generating input signal
st = [ 1 1 1 1 1 1 ];
zt = [ 0 0 0 0 0 0 ];
% u = [st st zt -st -st -0.2*st -0.4*st -0.6*st zt st 0.8*st 0.5*st st 0.2*st zt -st -st -st zt zt zt st st -st -st -st zt zt 0.25*st st 0.75*st st zt zt zt zt zt zt zt -st -st st st -st -st st 0.1*st 0.1*st st -st st -0.3*st 0.3*st st -st -st st st -st -st st st st -st -st -st st st st -st -st -st st st st st -st -st -st -st st st st st -st -st -st -st st st st st st -0.1*st -0.3*st -0.5*st -0.7*st -0.9*st 0.9*st 0.7*st 0.5*st 0.3*st 0.1*st -st -st -st -st -st st st st st st ];
u = [st st zt -st -st -st -st -st zt st st st st st zt -st -st -st zt zt zt st st -st -st -st zt zt st st st st zt zt zt zt zt zt zt -st -st st st -st -st st st st st -st st -st st st -st -st st st -st -st st st st -st -st -st st st st -st -st -st st st st st -st -st -st -st st st st st -st -st -st -st st st st st st -st -st -st -st -st st st st st st -st -st -st -st -st st st st st st ];
u = [-0.5*st -0.5*st zt 0.75*st 0.5*st st -0.3*st 0.3*st zt -st -st -0.6*st -0.4*st -0.2*st zt st st st zt zt zt st st st 0.25*st st zt zt -st -0.1*st -0.2*st -st zt zt ];

   nu = 700;
   nt = 0:1:(nu-1);
  fre = 4*0.0025;   % menor de 0.01  a  0.0025
  u = 1*sin(2*pi*fre*nt);

u = u';
nu = length(u);

% Generating outputs signals from the system to be modeled
z1(1,1) = 0.1;
z2(1,1) = 0.2;
for k = 1:nu
    z1(k+1,1) = 0.3*z1(k,1) - 0.4*z2(k,1);
    z2(k+1,1) = 0.4*z2(k,1) + 1*0.1*z1(k,1)*u(k,1) + 0.5*u(k,1); 
end
z1 = z1(1:nu) + 0.0*0.05*randn(nu,1) ;
z2 = z2(1:nu) + 0.0*0.05*randn(nu,1) ;
z = [ z1  z2 ];
% z(:,1) = zeros(nu,1); 
ndata = nu;
dataoutesc = z;

% Number of neurons (input, hidden and output layers)
ne = 3;    % No bias
nm = 30;   % nm = 10
ns = 2;

% Intializing coefficients v, w, sigmoid center and slope 
v = 0.1*randn(ne,nm);
w = 0.1*randn(nm,ns);
c = zeros(nm,1);
a = ones(nm,1);

load reddbp3;

% Introducing learning parameters
eta  = input('Introduce learning rate [v w]: ');
etac = input('Introduce learning rate [c: sigmoid center]: ');
etaa = input('Introduce learning rate [a: sigmoid slope]: ');
errormax = input('Introduce maximum value of error function (percentage %) : ');
errormax = errormax/100;
contmax = input('Introduce number of iteration steps: ');

% Training
outsum2 = sum(dataoutesc.^2);
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
   dJdw = 0;
   dJdv = 0;
   dJda = 0;
   dJdc = 0;
   dy1dw_t = zeros(nm,ns);        
   dy2dw_t = zeros(nm,ns);
   dy1dv_t = zeros(ne,nm);
   dy2dv_t = zeros(ne,nm);
   dy1dc_t = zeros(nm,1);
   dy2dc_t = zeros(nm,1);
   dy1da_t = zeros(nm,1);
   dy2da_t = zeros(nm,1);  
   dJdw_t  = zeros(nm,ns);
   dJdv_t  = zeros(ne,nm); 
   dJdc_t  = zeros(nm,1);
   dJda_t  = zeros(nm,1); 
   
   x = dataoutesc(1,:);   % Initial state
   x = x';
   for k = 1:ndata-1
      in_red = [ x
                 u(k,1) ];
      m = v'*in_red;
      n = 2.0./(1 + exp(-(m-c)./a)) - 1;    
%      n = m;        % Lineal
      out_red = w'*n;
      outputesc(k,:) = out_red';
     dndm = diag((1 - n.*n)./(2*a));  
%      dndm = diag(ones(nm,1));      % Lineal
      dy1dw_s = [ n   zeros(nm,1) ]; 
      dy2dw_s = [ zeros(nm,1)   n ]; 
      dy1dv_s = in_red*w(:,1)'*dndm;
      dy2dv_s = in_red*w(:,2)'*dndm;
      dy1dc_s = w(:,1) .* ((n.*n-1)./(2.0.*a));
      dy2dc_s = w(:,2) .* ((n.*n-1)./(2.0.*a));
      dy1da_s = w(:,1) .* ((n.*n-1).*(m-c)./(2*a.*a));
      dy2da_s = w(:,2) .* ((n.*n-1).*(m-c)./(2*a.*a));
      jacob = w'*dndm*(v(1:ne-1,:))';
      dy1dw_t = dy1dw_s + jacob(1,1).*dy1dw_t + jacob(1,2).*dy2dw_t;   
      dy2dw_t = dy2dw_s + jacob(2,1).*dy1dw_t + jacob(2,2).*dy2dw_t;   
      dy1dv_t  = dy1dv_s  + jacob(1,1).*dy1dv_t  + jacob(1,2).*dy2dv_t;   
      dy2dv_t  = dy2dv_s  + jacob(2,1).*dy1dv_t  + jacob(2,2).*dy2dv_t;  
      dy1dc_t  = dy1dc_s  + jacob(1,1).*dy1dc_t  + jacob(1,2).*dy2dc_t;   
      dy2dc_t  = dy2dc_s  + jacob(2,1).*dy1dc_t  + jacob(2,2).*dy2dc_t;
      dy1da_t  = dy1da_s  + jacob(1,1).*dy1da_t  + jacob(1,2).*dy2da_t;   
      dy2da_t  = dy2da_s  + jacob(2,1).*dy1da_t  + jacob(2,2).*dy2da_t;

      out_des = dataoutesc(k+1,:);
      out_des = out_des';
      er = (out_red - out_des);
      erJ = (out_red - out_des).^1;
      %      erJ = (abs(out_red - out_des)).^0.5 .* sign( out_red-out_des );  

      q1 = 1;    q2 = 1;       % Both variables are measured
      dJdw_t = dJdw_t + q1*erJ(1,1).*dy1dw_t + q2*erJ(2,1).*dy2dw_t;
      dJdv_t  = dJdv_t  + q1*erJ(1,1).*dy1dv_t  + q2*erJ(2,1).*dy2dv_t;
      dJdc_t  = dJdc_t  + q1*erJ(1,1).*dy1dc_t  + q2*erJ(2,1).*dy2dc_t;
      dJda_t  = dJda_t  + q1*erJ(1,1).*dy1da_t  + q2*erJ(2,1).*dy2da_t;
      ersum2 = ersum2 + er.^2;
      x = out_red;     % The output turns to be input in the next step
  end
      dJdw_t = dJdw_t/ndata;
      dJdv_t = dJdv_t/ndata;  
      dJdc_t = dJdc_t/ndata;
      dJda_t = dJda_t/ndata;
      dw = dJdw_t;
      dv = dJdv_t;
      dc = dJdc_t;
      da = dJda_t;
      w = w - eta*dw;
      v = v - eta*dv;
      c = c - etac*dc;
      a = a - etaa*da;
      dw_old = dw;
      dv_old = dv;
  ersum2total = sum(ersum2);
  cont = cont + 1;
  if ( rem(cont,1) == 0 )
      errorrel(cont/1,:) = sqrt(ersum2'./outsum2');
      errorreltotal(cont/1,1) = sqrt(ersum2total/outsum2total);
      erreltotal = errorreltotal(cont/1,1);
      cont;
      erreltotal    
  end
end  
nt = length(u);
dt = 0.01;
tt = 0:1:(nt-1);
tt = dt*tt';
tt1 = tt(1:nt-1,1);

figure(1);
title('Total Error Function');
plot(errorreltotal*100);
figure(2);
title('Error Function per Output');
plot(errorrel*100);
figure(3);
title('Desired Output (red) and Network Output (blue)');
plot(tt,z(:,1),'-r');
hold on;
plot(tt1,outputesc(:,1),'-b');
title('Output State Variable x1');
xlabel('Time [sec]');
axis([ 0 7 -0.6  0.6]);
figure(4);
title('Desired Output (red) and Network Output (blue)');
plot(tt,z(:,2),'-r');
hold on;
plot(tt1,outputesc(:,2),'-b');
title('Output State Variable x2');
xlabel('Time [sec]');
axis([ 0 7 -1  1]);
figure(5);
title('Input Signal');
plot(tt,u,'-b');
title('Input Signal u');
xlabel('Time [sec]');
axis([ 0 7 -1.2 1.2]);

% Saving: number of input, hidden and output neurons,  coefficients v and
% w, center c, and slope c
save reddbp3 ne nm ns v w c a;   

