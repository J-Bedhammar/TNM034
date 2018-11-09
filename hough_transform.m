function [ output ] = hough_transform( BW_image )
% Hough:
%   H: Hough transform matrix
%   Theta and Rho: Arrays of theta and rho values over which hough generates the
%   Hough transform matrix. (degrees)
% Houghpeaks:
%   Locates peaks in H
%   numpeaks: scalar value that specifies max number of peaks to identify.
%   If you omit numpeaks, it defaults to 1.
% Houghlines:
%   Extracts line segments in the BW_image associated with particular bins
%   in a Hough transform. 
%   Theta and Rho: arrays from hough
%   peaks: matrix returned from houghpeaks. Contains row and column
%   coordinates of the Hough transform bins to use in searching for line
%   segments.

[H, theta, rho] = hough(BW_image);

imshow(H)

peaks = houghpeaks(H, numpeaks);
lines = houghlines(BW_image, theta, rho, peaks);

output = lines;


end

