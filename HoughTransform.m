function [ rotation ] = HoughTransform( im, BW )
% Authors: Jennifer Bedhammar
% Last edit: 2018-11-12

% Function information:
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

[H,theta,rho] = hough(BW);

numpeaks = 5;

peaks  = houghpeaks(H,numpeaks,'threshold',ceil(0.6*max(H(:))));
lines = houghlines(BW,theta,rho,peaks,'FillGap',5,'MinLength',7);

% PLOT LINES ------------------------------------------
figure, imshow(im), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% SET ROTATION ANGLE ---------------------------
maxTheta = max([lines(:).theta]);

if( maxTheta == -90)
    rotation = 0;
else
    rotation = maxTheta/-90

    
% PRINT HOUGH ----------------------------------
% imshow(H,[],'XData',theta,'YData',rho,...
%            'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% ----------------------------------------------


end

