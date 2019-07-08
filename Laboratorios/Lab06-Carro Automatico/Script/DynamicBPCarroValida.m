% Validation of a trained neural network for driving a car.
% The car starts for arbitraty initial positions and must achieve the final desired position.
% The neural network was trained so that the car achieves the desired position:
% x*=0, phi* = pi/2.

clear;
clc;
close all;

zzz = 1;

while(zzz < 5)
  
  ymax = 9;

  xini = input('Initial coordinate x [-10 10] : ');
  yini = input('Initial coordinate y [0 20]   : ');
  phiini = input('Initial inclination phi (degrees -90<>270) : ');
  phiini = phiini*pi/180;
  xast = input('Desired x coordinate: ');

  x_ini = [ xini         % x coordinate
              yini         % y coordinate
              phiini ];    % Phi angle
         
  ne = 2;    % No bias
  nm = 50;
  ns = 1;

  load redcarro8;

   r = 0.01;
   L = 2;
   R = 20;
   deltamax = 45;       % Maximum steering anle 
   umax = tan(deltamax*pi/180);   
   
   x = x_ini;
   k = 1;
  %   fiast = pi/2;
   fiast = pi/4;
  % tandeltaast = L/R; 
   tandeltaast = 0;
  
  while( x(2,1) < ymax )
    xast = (x(1,1) + x(2,1))/2;
    %      xast = 20 + R*(x(1,1)-20) / sqrt((20-x(1,1))*(20-x(1,1)) + x(2,1)*x(2,1));
    %     fiast = atan2(20-x(1,1),x(2,1));
     
    in_red = [ x(1,1) - xast
                    x(3,1) - fiast ];
    m = v'*in_red;
    n = 2.0./(1 + exp(-(m-c)./a)) - 1;  
    out_red = w'*n;
    if( out_red > umax)
        %out_red
        out_red = umax;
    elseif(out_red < -umax )
        out_red
        out_red = -umax;
    end    
    u(k,1) = out_red' + tandeltaast;
    posX(k,1) = x(1,1);
    posY(k,1) = x(2,1);
    phi(k,1)  = x(3,1);

    x(1,1) = x(1,1) + r*cos(x(3,1));
    x(2,1) = x(2,1) + r*sin(x(3,1));
    x(3,1) = x(3,1) - r/L*u(k,1);
    k = k + 1;
    
  end
     
  npx = length(posX);
  figure(1);
  axis([ -20 20 0 30 ]); 
  hold on;
  xx1 = [ -20  -20  -1.5  -1.5  -20 ];
  yy1 = [  28   30    30   28    28 ];
  fill(xx1,yy1,[ .8 .8 .8 ]); 
  xx2 = [ 1.5  1.5  20  20  1.5 ];
  yy2 = [  28   30    30   28    28 ];
  fill(xx2,yy2,[ .8 .8 .8 ]);   
  xlabel('Coordinate X');
  ylabel('Coordinate Y');
  title('Robot Trajectory');
  %   grid;
  box on;
  for k = 1:35:npx
    if(zzz == 1) 
       plot(posX(k,1),posY(k,1),'ob','Linewidth',3);
    elseif(zzz == 2) 
       plot(posX(k,1),posY(k,1),'og','Linewidth',3);
    elseif(zzz == 3) 
       plot(posX(k,1),posY(k,1),'om','Linewidth',3); 
    elseif(zzz == 4) 
       plot(posX(k,1),posY(k,1),'oc','Linewidth',3);        
    end
    pause(0.001);
  end   
  grid;
     
 delta = atan(u) * 180/pi;
 figure(2);
 plot(delta);
 grid;
 title('Steering Angle');
 xlabel('Time (sec)');
 ylabel('Degrees');
 
 zzz = zzz + 1;
 
end