clearvars; clc;

img = [1 2 3; 4 5 6; -7 8 9; -1 -2 3]
%img = [1 2 3; 4 5 6; -7 8 9]

S = size(img);
n = numel(img);
k = [[-1 2]; [-3 -4]];

%%
disp('~~~~from conv2d:')
result_orig = conv2(img, k, 'valid')

%%
k_otf = psf2otf(k, S);

v2 = fft2(img).*k_otf; 
disp('~~~~from psf2otf:')
result_psf2otf = ifft2(v2)


%%
disp('~~~~from big matrix multiply:')
imgT = img';
imgVec = imgT(:);

kFilled = zeros(1, n);
kFilled(1:6) = [-4 -3 0 2 -1 0];

for m = 1:n
    kCirc(m, :) = circshift(kFilled, m-1);
end

result_time = kCirc * imgVec;
result_time = reshape(result_time, S(2), S(1))'



%%
kFilled = zeros(1, n);
kFilled(1:6) = [-1 2 0 -3 -4 0];

for m = 1:n
    kCirc(m, :) = circshift(kFilled, m-1);
end

disp('~~~~from big matrix DFT:')
kF = fft2((kCirc/n)); 
imgF = fft(imgVec);
result_fourier = flip(ifft(kF * imgF)); 
result_fourier = reshape(result_fourier, S(2), S(1))'