clearvars; clc;

img = [1 2 3; 4 5 6; -7 8 9; -1 -2 3]
S = size(img);
k = [[-1 2]; [-3 -4]]

%%
disp('~~~~from conv2d:')
conv2(img, k, 'valid')



%%
k_otf = psf2otf(k, S);

v2 = fft2(img).*k_otf; 
disp('~~~~from psf2otf:')
ifft2(v2)



%%
disp('~~~~from big matrix multiply:')
imgT = img';
imgVec = imgT(:);

kFilled = [-1 2 0 -3 -4 0 0 0 0 0 0 0];

for m = 1:12
    kCirc(m, :) = circshift(kFilled, m-1);
end

res = kCirc * imgVec;
res = reshape(res, [3, 4])'



%%
kFilled = [-1 2 0 -3 -4 0 0 0 0 0 0 0];

for m = 1:12
    kCirc(m, :) = circshift(kFilled, m-1);
end

kCirc

disp('~~~~from big matrix DFT:')
kF = fft2((kCirc/12)) %is nxn, only as n entries
imgF = fft(imgVec) % 1D vectorized image.
res = flip(ifft(kF * imgF)); 
res = reshape(res, [3, 4])'

fId = fopen('kFreal.txt', 'w');
fprintf(fId,'%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f  \n',real(kF));
fId = fopen('kFimag.txt', 'w');
fprintf(fId,'%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f %2.2f  \n',imag(kF));