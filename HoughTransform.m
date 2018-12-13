function [ rotation ] = HoughTransform( im , rotationType )
% Authors: Jennifer Bedhammar
% Last edit: 2018-12-12

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

% PRE_PROCESSING --------------------------------------------
% Create binary image with spec. threshold for max information
BW = im;

if ( size(im,3) == 3 )
    BW = imbinarize(im, 0.9);
    BW = rgb2gray(im2uint8(BW));
    BW = imcomplement(BW);
end


% Dilate to improve line detection
SE = strel('line', 2, 15);
BW = imdilate(BW, SE);

% HOUGH -------------------------------------------------------
[H,theta,rho] = hough(BW);

numpeaks = 10;

peaks  = houghpeaks(H,numpeaks,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,theta,rho,peaks,'FillGap',5,'MinLength',7);

% PLOT LINES ------------------------------------------
%figure, imshow(im), hold on
max_len = 0;

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

    % Plot beginnings and ends of lines
    %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
        indexLongest = k;
        
        % Rotation for notes/beams
        if( abs(lines(k).theta) > 15)
            indexNote = k;
        end
    end
end

%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');


% SET ROTATION ANGLE ---------------------------

% Different rotation for image vs notes
if ( rotationType == 'image')
    rotationAngle = lines(indexLongest).theta;
elseif ( rotationType == 'notes' )
    if(indexNote)                               
        rotationAngle = lines(indexNote).theta;
    else
        rotationAngle = 90;
    end
end

% Get rotation
if( rotationAngle < 0)
    rotation = rotationAngle+90;
else
    rotation = rotationAngle-90;
end
  
    
    
% PRINT HOUGH ----------------------------------
% imshow(H,[],'XData',theta,'YData',rho,...
%            'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% ----------------------------------------------


end

