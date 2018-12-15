function [out] = FillBeams(img)
% Author: Oliver Johansson
%
%Function information:
%Creates an image of only the beams

% Få ut beams
V = [4,20];
SE = strel('rectangle', V);

Beams = imopen(img,SE);

out =  Beams;

end

