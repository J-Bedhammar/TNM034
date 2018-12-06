function [Irot] = ImageRotation( OMR, rotation)
% Author: Jennifer Bedhammar
% Last edit: 2018-11-12

% NOT PRECISE! Rotation too high. 
Irot = imrotate(OMR,rotation);
Mrot = ~imrotate(true(size(OMR)),rotation);
Irot(Mrot&~imclearborder(Mrot)) = 255;