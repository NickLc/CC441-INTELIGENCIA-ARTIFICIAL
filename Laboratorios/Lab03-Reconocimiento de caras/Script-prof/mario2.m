% Este programa lee imagenes en formato jpg
% y las pixelea para bajar su resolución y
% el tamaño de la matriz

clear all;
close all;
clc;

I1 = imread('cara3.jpg','jpg');
figure(1);
imshow(uint8(I1));
I2 = I1;
Iz = I1(:,:,2);
[nf nc] = size(Iz);
figure(2);
imshow(uint8(Iz));

for f = 1:nf
  Ifila = Iz(f,:);
  if(any(Ifila < 255)) 
      break;
  end
end
%nfc = 1800;
nfc = 1750;
Iz1 = Iz(f:nfc,:);
figure(3);
imshow(uint8(Iz1));

for c1 = 1:nc
   Icol = Iz1(:,c1);
   if(any(Icol < 255)) 
     break;
   end
end
Iz2 = Iz1(:,c1:nc);
figure(4);
imshow(uint8(Iz2));

[nc2 nf2] = size(Iz2);
for c2 = nc2:-1:1
   Icol = Iz2(:,c2);
   if(any(Icol < 240)) 
     break;
   end  
end
Iz3 = Iz2(:,1:c2);
figure(5);
imshow(uint8(Iz3));
[ff cc] = size(Iz3);
ff1  = 10*floor(ff/10);
cc1 = 10*floor(cc/10);

% Pixelamiento en cuadrados de 10x10
% Izz = Iz3(1:720,1:530);
ii = 1;
for i = 1:10:ff1
   jj = 1; 
   for j = 1:10:cc1 
      im = Iz3(i:i+9,j:j+9);
      im = sum(sum(im))/100; 
      Inueva10(ii,jj) = round(im); 
      jj = jj + 1;
   end
   ii = ii + 1;
end
figure(8);
imshow(uint8(Inueva10));

% Pixelamiento en cuadrados de 20x20
% Izz = Iz3(1:1640,1:1380);
% Izz = Iz3(1:720,1:520)

ff2  = 20*floor(ff/20);
cc2 = 20*floor(cc/20);
ii = 1;
for i = 1:20:ff2
   jj = 1; 
   for j = 1:20:cc2 
      im = Iz3(i:i+19,j:j+19);
      im = sum(sum(im))/400; 
      Inueva20(ii,jj) = round(im); 
      jj = jj + 1;
   end
   ii = ii + 1;
end
figure(9);
imshow(uint8(Inueva20));

I40 = Inueva20;
I40bn = 255*round(I40/255*0.85);
figure(13);
imshow(uint8(I40bn));
I41bn = 255*round(I40/255*0.90);
figure(14);
imshow(uint8(I41bn));
I42bn = 255*round(I40/255*0.95);
figure(15);
imshow(uint8(I42bn));


