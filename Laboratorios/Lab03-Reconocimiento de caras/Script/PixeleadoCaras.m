% Este programa lee imagenes en formato jpg
% y las pixelea para bajar su resolución y
% el tamaño de la matriz

clear all;
close all;
clc;

I1 = imread('Imagenes/cara8Modificada.jpg','jpg'); #Carga imagen
figure(1); #muestra
imshow(uint8(I1)); #parsea a numeros 0 -255
I2 = I1;   #obs
Iz = I1(:,:,2);  #contraste
%En caso la conversio no se pueda realizar cambiar el 2 por 1

[nf nc] = size(Iz);
%figure(2);
%imshow(uint8(Iz)); 


%========================================================
%                Recorte de cara por arriba
%========================================================

%                Foto               Foto recoratada
%     1  - x x x x x x x x x       
%          x x x x x x x x x       
%     f  - x x x x x x x x x   =>  x x x x x x x x x  -> Inicio de la cabeza
%     f  - x x x x x x x x x   =>  x x x x x x x x x  -> Inicio de la cabeza
%          x x x x x x x x x       x x x x x x x x x
%          x x x x x x x x x       x x x x x x x x x
%          x x x x x x x x x       x x x x x x x x x
%    nf    x x x x x x x x x       x x x x x x x x x
%========================================================

% ------------- Leyendo horizontalmente-------------
for f = 1:nf
  Ifila = Iz(f,:);
 %Revisa si tiene alguna mancha, diferente de blanca
 %Esto ocurre cuando llega a la cabeza 
  if(any(Ifila < 255)) 
      break;
  end
end

%========================================================
%                Recorte de cara por abajo
%========================================================

%nfc = 1800;  1750
% Cambiar este valor para cada foto
k = 2.8
%Cuando k es mas pequeño se corta más - k generalmente(entre 1 y 3)
nfc = nf - nf/k;        % Recorte del cuello
Iz1 = Iz(f:nfc, :);
% nf representa toda la cara, y nf/k representa una porcion a cortar
% nfc refresenta la cara cortada.


%========================================================
%                Foto               Foto recoratada
%     1  - x x x x x x x x x          x x x x x x x x x ->inicio de la cabeza
%          x x x x x x x x x   => f - x x x x x x x x x
%          x x x x x x x x x          x x x x x x x x x
%          x x x x x x x x x          x x x x x x x x x
%    nfc - x x x x x x x x x          x x x x x x x x x -> inicio quijada
%          x x x x x x x x x
%     nf - x x x x x x x x x
%========================================================

%La parte del cuello para abajo lo podemos encontrar con la suguiente linea
%Iz1 = Iz(nfc:nf,:);   % se las filas de f a nfc
% Nostrar la foto recortada
%figure(3);
%imshow(uint8(Iz1));

%=========================x===============================
%             Recorte de cara por la izquierda
%========================================================

%-------------- Leyendo por columanas ----------------
for c1 = 1:nc
   Icol = Iz1(:,c1);
   if(any(Icol < 255)) 
     break;
   end
end

Iz2 = Iz1(:,c1:nc);   # Recorta por la izquierda
%figure(4);
%imshow(uint8(Iz2)); 
[nc2 nf2] = size(Iz2);

%========================================================
%             Recorte de cara por la derecha
%========================================================

%-------------- Leyendo por columanas ----------------
for c2 = nc2:-1:1
   Icol = Iz2(:,c2);
   if(any(Icol < 240)) 
     break;
   end  
%-------------- Leyendo por columanas 
end
Iz3 = Iz2(:,1:c2);
%figure(5);
%imshow(uint8(Iz3));
[ff cc] = size(Iz3);
ff
cc
%============================================================
%                        Pixeleado 
%============================================================

% sacar un promedio de un conjunto de pixeles y poner un solo pixel
%              pc
%      x x x x x x x x x
%      x x x x x x x x x
%  pf  x x x x x x x x x      =>     x
%      x x x x x x x x x
%      x x x x x x x x x

%============================================================
% Dimension de los pixeles a reducir, depende del tamaño de la foto

% Tamaño final de la foto
tfinal_f = 50
tfinal_c = 50 
pf = floor(ff/tfinal_f);    
pc = floor(cc/tfinal_c);

ff3 = pf*floor(ff/pf);  % floor() redondea a un entero
cc3 = pc*floor(cc/pc);

% Pixelamiento en rectagulos de pf x pc
ii = 1;
for i = 1:pf:ff3
   jj = 1; 
   for j = 1:pc:cc3 
      im = Iz3(i:i+pf-1,j:j+pc-1);
      im = sum(sum(im))/(pf*pc);
      Inueva(ii,jj) = round(im); 
      jj = jj + 1;
   end
   ii = ii + 1;
end

I40 = Inueva;
I40bn = 255*round(I40/255*0.85);
%figure(13);
%imshow(uint8(I40bn));
I41bn = 255*round(I40/255*0.90);
%figure(14);
%imshow(uint8(I41bn));
I42bn = 255*round(I40/255*0.95);
figure(15);
imshow(uint8(I42bn));
[nf1 nf2] = size(I42bn);

% Para el entrenamiento se necesita que las fotos tengan 
% el mismo numero de pixeles columnas

% Quitamos las columnas restantes para que la foto tenga el tamaño de la foto final
%resto_c = nfc - tfinal_c

I_final = I42bn(1:tfinal_f, 1:tfinal_c);
[nfinalf nfinalc] = size(I_final);

% Guardar las imagenes pixeleadas
size(I_final)
%Poner el nombre del archivo de salida
save -ascii cara8Modificadapx I_final;
