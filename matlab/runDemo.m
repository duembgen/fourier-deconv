%% April 2018
%% Authors: Majed El Helou, Frederike Dumbgen

% In section *A* we illustrate the 2D convolution with both the matrix
% multiplication setup and in the Fourier domain

% In section *B* we illustrate convex optimization solutions
% The example is a guided non-blind deblurring
clearvars; clc; close all;

%% *A*
% Convolve the following: R = k*N
% First we select a data matrix N and a kernel k (horizontal gradient here)
s = 4;
N = magic(s);
k = [-1 1];

% 1- With standard convolution:
Rconv = conv2(N, flip(k, 2), 'valid');

% 2- With matrix multiplication:
K = gallery('circul', [k zeros(1, s^2-2)] );
n = reshape(N', [s^2, 1]); %row by row vectorization

Rmult = vec2mat(K*n, s);

% 3- With the Fourier domain:
k_flipped = [1 -1];
Kf        = psf2otf(k_flipped, [s, s]);
Nf        = fft2(N);

Rf = Kf .* Nf;
Rfourier = ifft2(Rf);

% Comparing results:
fprintf(' Part A\nWith valid convolution we obtain: ');
Rconv
disp('With large matrix multiplication: ');
Rmult'
disp('With the Fourier transform operation: ');
Rfourier
fprintf('** all valid entries are equivalent \n (the last column is nonvalid in this example) **\n');

%% *B*

clearvars;

% Read the NIR image to be deblurred, and the RGB guide
N_b = im2double(imread('../input/nir_blurry.tiff'));
RGB = im2double(imread('../input/rgb.tiff'));
% For simplicity we only use the color luminance
Y = mean(RGB,3);
% Rescale
Y = Y./max(Y(:));
N_b = N_b./max(N_b(:));

figure; subplot 121; imshow(N_b); title('Out-of-focus NIR image');
subplot 122; imshow(RGB); title('Color guide');

% We run a blur estimation algorithm, with the strong assumption of a
% constant blur across the image, and that the blur is Gaussian
% We obtain an estimate of sigma = 0.394

%%%% blur kernel %%%%
sigma = 0.394;
b = fspecial('Gaussian',ceil(2*3*sigma+1),sigma);
lambda = 1.0;

%%%% gradient kernels %%%%
f1 = [-1 1];
f2 = f1';

%%%% color guides %%%%
y1 = conv2(Y, f1, 'same');
y2 = conv2(Y, f2, 'same');

% Fourier domain optimization solution:

tic; 

f1F = psf2otf(f1, size(Y));
f2F = psf2otf(f2, size(Y));

y1F = psf2otf(y1, size(Y));
y2F = psf2otf(y2, size(Y));

bF   = psf2otf(b, size(Y));
N_bF = psf2otf(N_b, size(Y));

% EQ (15)
I_x = conj(f1F) .* y1F + conj(f2F) .* y2F + conj(bF) .* N_bF;
C   = lambda .* (abs(f1F).^2 + abs(f2F).^2 + abs(bF).^2) + eps;

NF = I_x ./ C ;
N = abs(fftshift(ifft2(NF)));

timeTotal = toc;

% Comparing results:
sh_b = sh_computation(N_b);
sh_d = sh_computation(N);

figure; subplot 121; imshow(N_b); title(['Out-of-focus NIR image, sharpness = ' num2str(sh_b)]);
subplot 122; imshow(N); title(['Deblurred NIR image, sharpness = ' num2str(sh_d)]);

figure; subplot 121; imshow(N_b(500:900, 650:1200)); title(['Out-of-focus CROP']);
subplot 122; imshow(N(500:900, 650:1200)); title(['Deblurred CROP']);


fprintf(['\n Part B\nTotal time for all the set up and solving the optimization:\n' num2str(timeTotal) ' sec\n']);







