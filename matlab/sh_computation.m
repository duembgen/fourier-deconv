

% Created by Zahra Sadeghipoor on 10/29/2014
% All rights reserved for EPFL.
% compute the sharpness of the image using the method descried in "The blur effect: perception
%  and estimation with a new no-reference perceptual blur metric


function sharpness = sh_computation(image)

% it is assumed that the image is gray-scale.

% blurring the image in both directions 
Hv = fspecial('Gaussian',[1 2*3*1+1],1); Hh = Hv';
Bver = imfilter(image,Hv,'symmetric');
Bhor = imfilter(image,Hh,'symmetric');

% computing the edges of the original image and its blurred version in both
% directions
Hdiffv = [1 -1]; Hdiffh = Hdiffv';
D_Fver = abs(imfilter(image,Hdiffv,'symmetric')); D_Fhor = abs(imfilter(image,Hdiffh,'symmetric'));
D_Bver = abs(imfilter(Bver,Hdiffv,'symmetric')); D_Bhor = abs(imfilter(Bhor,Hdiffh,'symmetric'));

Vver = D_Fver - D_Bver; Vver(Vver < 0) = 0;
Vhor = D_Fhor - D_Bhor; Vhor(Vhor < 0) = 0;

s_Fver = sum(D_Fver(:));
s_Fhor = sum(D_Fhor(:));
s_Vver = sum(Vver(:));
s_Vhor = sum(Vhor(:));

b_Fver = (s_Fver - s_Vver) / s_Fver;
b_Fhor = (s_Fhor - s_Vhor) / s_Fhor;

blur = max(b_Fver,b_Fhor);

sharpness = 1 - blur;

