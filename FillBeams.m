function [out] = FillBeams(img)
% Author: Oliver Johansson
%
%Function information:
%Defines the beams in the image

% F� ut beams
V = [4,20];
SE = strel('rectangle', V);

Beams = imopen(img,SE);

out =  Beams;

end

