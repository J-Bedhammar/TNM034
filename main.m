%% TNM034 OMR Project
% Authors: Emma Weberyd, Jennifer Bedhammar, Julius Kördel, Oliver
% Johansson.
% Last edit: 2018-11-09

%% Clear all, clc
clear all;
clc;

%% Load testimage
path = fullfile('Images_Training', 'im10c.jpg');
testImage = imread(path);

%% Call function
output = tnm034(testImage);