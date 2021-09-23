% Simulation of camera noise: Poisson noise + Readout (Gaussian) +
% Bit quantization to show illustrations at different light levels.

clc;
close all;

% Read the original image and convert it to datatype double
g = im2double(imread('cameraman.tif'));

% Display the original image
figure('Name','Cameraman - Original'), imagesc(g); title('Cameraman - Original');
colormap(gray); colorbar;
axis image; axis equal;

% Define and initialize a matrix of image or sensor dimensions storing the probabilities of detecting photon
% corresponding to each pixel if there were only one photon to be incident
% on the sensor
probability_matrix = g ./ (sum(sum(g))); 

% Initialize total number of photon count that will be used to generate the
% image
N = 1e6 ;

% Matrix storing expected or mean no. of photons detected at each pixel for a given
% value of N
n = N * probability_matrix ;

% Matrix storing a Poisson realization for the original image for a given value of N
g_Poisson = poissrnd(n);

% Display the generated Poisson realization for the original image
figure('Name','Cameraman - A Poisson Realization'), imagesc(g_Poisson); 
colormap(gray); colorbar; 
title('Cameraman - A Poisson realization with' + " " + N + " " + 'photon counts');
axis image; axis equal;

% Next step is to add read-out noise to the Poisson realization ==
% photon-count matrix.
% From:
% MATLAB documentation: 
% (https://in.mathworks.com/help/matlab/math/random-numbers-with-specific-mean-and-variance.html):
% The randn function returns a sample of random numbers
% from a normal distribution with mean 0 and variance 1.
% The general theory of random variables states that if x is a random variable whose mean is μ_x and
% variance is σ^2_x, then the random variable, y, defined by y=ax+b,where a and b are constants, has 
% mean μ_y = a μ_x + b and variance σ^2_y = a^2 σ^2_x. You can apply this concept to get a sample of 
% normally distributed random numbers with mean 500 and variance 25.

rms_read_noise = 0.9;
standard_deviation = rms_read_noise;

% Matrix (of image or sensor dimensions) storing the read-out noise realization 
% corresponding to every pixel for given rms read-out noise 
read_noise = standard_deviation .* randn(size(g));

%mean(mean(read_noise))
%std2(read_noise)


% Add read-noise to the generated Poisson realization for the original image
g_Poisson_read = g_Poisson + read_noise ;
%g_Poisson_read

% Display the generated-and-then-read Poisson realization for the original image
figure('Name','Cameraman - A Poisson Realization + Read noise '), imagesc(g_Poisson_read); 
colormap(gray); colorbar; 
title('A Poisson realization for' + " " + N + " " + 'photons' + ' & rms read noise of '  +  rms_read_noise + ' e^-');
axis image; axis equal;

quant_bits = 8;
quant_levels = 2^quant_bits ;

quant_g_Poisson_read = floor( ( g_Poisson_read ./ max(g_Poisson_read) ) .* quant_levels );

% Display the generated-and-then-read-and-then-quantized Poisson realization for the original image
figure('Name','Cameraman - A Quantized (Poisson Realization + Read noise) '), imagesc(quant_g_Poisson_read); 
colormap(gray); colorbar; 
title('A Quantized Poisson realization for' + " " + N + " " + 'photons' + ' & rms read noise of '  +  rms_read_noise + ' e^-');
axis image; axis equal;