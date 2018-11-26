function [ outim ] = BinaryShift( im )
% Author: Oliver Johansson
%
% Function information:
% Converts the image into an inverted binary image

%find a threshold
level = graythresh(im);

BW = rgb2gray(im2uint8(im));
%create a binary image
%if imbinarize doesn't work use im2bw
BW = imbinarize(BW, (level + 0.05));


%inverted binary image
outim = imcomplement(BW);




