%% TNM034 OMR Project

% Load testimage
path = fullfile('Images_Training', 'Le_1_Example.jpg');
testImage = imread(path);

%% Call function
output = tnm034( image );