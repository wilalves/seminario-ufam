close all; clc; clear;

%tepny_pric_neg-165
%14-08-29 012.png
%k = imread('\BD\ARTERY_TRANSVERSAL\Ultrasonix_train\negative\tepny_pric_neg-165.jpg');
k = imread('imagem2.jfif');
 
%k=rgb2gray(e);
[n,m] = size(k);
 
b =   [1     1     1; %Definimos el elemento estructurante
       1     1     1;
       1     1     1];

%algoritmo de dilatacion

[n,m] = size(k); %Asigno los valores en n y m el tam�o de la matriz
[t,u] = size(b); %Asigno los valores en t y y el tam�o de la matriz del elemento estructurante
erocion=zeros(size(k)); % creo una matriz con misma dimencion y rellenada de 0

origen = round((t/2));%obtener el origen de la matriz del elemento [origen,origen]

min=256;
conj1=0;
conj2=0;
for i=2:n-1
 for j=2:m-1  
  erocion(i,j)=k(i,j);
   %Rellenar el elemento estructurante b
  conj1= (i-1);
   for q=1:t
       conj2= (j-1);
       for z=1:u
             b(q,z) = k(conj1,conj2);
           conj2 = conj2 + 1;
         end
       conj1 = conj1 + 1;
   end
   
   for q=1:t    
       for z=1:u          
            if(b(q,z)<min)
               min = b(q,z);
           end
       end
   end

   erocion(conj1-2,conj2-2) = min;
    
    min=255;
   %Morfologia Dilatacion funcion con el elemento estructurante   
end
end

SES = strel('square',10);
%SE = strel('line', 3,0)
SE = strel('diamond', 10)

BW2 = imerode(k,SE);
BW0 = imerode(k,SES);

subplot(2,2,1); imshow(BW0);
title('Metodo imerode MatLab matriz k');
subplot(2,2,2); imshow(mat2gray(erocion));
title('Erosicion con algoritmo aplicado de la matriz k');

subplot(2,2,3); imshow(k);
title('Original matriz k');

subplot(2,2,4); imshow(BW2);
title('Metodo ELEMENTO others');