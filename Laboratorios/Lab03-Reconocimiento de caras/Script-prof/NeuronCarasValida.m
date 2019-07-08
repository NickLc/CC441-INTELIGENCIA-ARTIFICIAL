
clear;
clc;
close all;

cara = [ 0 0 0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 
 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 
 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 
 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 
 0 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 
 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 
 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 
 0 0 0 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 0 0 
 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 
 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 
 0 0 0 1 0 1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 
 0 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 
 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 
 0 0 0 1 1 0 0 0 1 1 1 1 1 0 0 0 1 0 0 0 
 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 
 0 0 0 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 0 
 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 
 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 
 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 
 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];



 [nf nc] = size(cara);
x(1,:) = cara(1,:);
for k = 2:nf
    x = [ x  cara(k,:) ];
end
[ nxf nxc ] = size(x);
nx = nxf;

% ne = nxc;
% ns = 4;
load pesoscaras;    % Carga nm v w bias
if(bias == 1)
   ne = ne +1;
   x = [ x ones(nx,1) ];   
end

in = x';
m = v'*in;
n = 1.0./(1+exp(-m));    % Sigmoidea 1
%n = 2.0./(1+exp(-m)) - 1; % sigmoidea 2
%n = exp(-m.^2);         % Gaussiana
out = w'*n;
y = out;

[maxy k] = max(y);
if(k == 1)
    disp('La Cara es 1');
elseif(k == 2)
    disp('La Cara es 2');
elseif(k == 3)
    disp('La Cara es 3');
elseif(k == 4)
    disp('La Cara es 4')
end

figure(1);
axis([ 0 nc  0  nf  ])
hold on;
for i = 1:nc
   for j = 1:nf
       if(cara(i,j) == 1)
           plot(j,(nf-i+1),'*b');
       end
   
   end
end

