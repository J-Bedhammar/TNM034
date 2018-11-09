function [ outim ] = BinaryShift( im )
% Function information:
% Converts the image into an inverted binary image

%find a threshold
level = graythresh(im);

%BW = testImage < level;

%create a binary image
BW = imbinarize(im, (level + 0.05));
BW = rgb2gray(im2uint8(BW));


%inverted binary image
outim = imcomplement(BW);

imshow(outim);
