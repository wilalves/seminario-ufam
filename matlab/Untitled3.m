close all; clc; clear;

%e = imread('14-10-55 121.png');
%k = imread('\BD\ARTERY_TRANSVERSAL\Ultrasonix_train\negative\tepny_pric_neg-165.jpg');

 k = imread('imagem.jfif');
%k=rgb2gray(e);
[n,m] = size(k);
 
b =  [1 1 1;1 1 1;1 1 1];

%algoritmo de dilatacion


[n,m] = size(k); %Asigno los valores en n y m el tam�o de la matriz
[t,u] = size(b); %Asigno los valores en t y y el tam�o de la matriz del elemento estructurante
dilatacion=zeros(size(k)); % creo una matriz con misma dimencion y rellenada de 0

origen = round((t/2));%obtener el origen de la matriz del elemento [origen,origen]

max=0;
conj1=0;
conj2=0;
for i=2:n-1
 for j=2:m-1  
  dilatacion(i,j)=k(i,j);
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
            if(b(q,z)>max)
               max = b(q,z);
           end
       end            
   end
   
   dilatacion(conj1-2,conj2-2) = max;
    max=0;
   %Morfologia Dilatacion funcion con el elemento estructurante
end
end

SES = strel('square',10);
%SE = strel('line', 3,0)
SE = strel('diamond', 10)

BW2 = imdilate(k,SE);
BW0 = imdilate(k,SES);

%dilatacions=zeros(size(k));
%b=rgb2gray(a);

%dilatacions = imdilate(k,b);

subplot(2,2,1); imshow(mat2gray(dilatacion));
title('Dilatacion de la matriz k');
subplot(2,2,2); imshow(k);
title('Original matriz k');
subplot(2,2,3); imshow(BW2);
title('Metodo imdilate MatLab matriz BW2');
subplot(2,2,4); imshow(BW0);
title('Metodo ELEMENTO others');