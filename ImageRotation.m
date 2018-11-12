function [filled, cropped] = ImageRotation( image, rotation)
% Author: Jennifer Bedhammar
% Last edit: 2018-11-12

% NOT PRECISE! Rotation too high. 

rotatedImage = imrotate(image,rotation, 'bilinear', 'crop');
imageSize = size(rotatedImage);

blackBorder = size(rotatedImage) * (1-rotation);

xBorder = ceil(blackBorder(1) * cos(rotation));
yBorder = ceil(blackBorder(2) * sin(rotation));

% FILL BORDERS ------------------------------------------
filled = rotatedImage;
filled(1:yBorder,:,:) = 255;
filled(:,1:xBorder,:) = 255;
filled(imageSize(1)-yBorder:imageSize(1),:,:) = 255;
filled(:,imageSize(2)-xBorder:imageSize(2),:) = 255;

% CROP BORDERS ------------------------------------------
rect = [xBorder yBorder imageSize(2)-2*xBorder imageSize(1)-2*yBorder];
cropped = imcrop(rotatedImage, rect);


end

