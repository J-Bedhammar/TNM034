%% TNM034 OMR Project
% Authors: Emma Weberyd, Jennifer Bedhammar, Julius K�rdel, Oliver
% Johansson.
% Last edit: 2018-11-09

%% Clear all, clc
clear all;
close all;
clc;

% Load testimage
path = fullfile('Images_Training', 'im3s.jpg'); % 3,5
testImage = imread(path);

% Call function
output = tnm034(testImage)

%% Show image
figure();
imshow(testImage);

