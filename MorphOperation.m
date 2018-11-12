function [outim] = MorphOperation(input)
% Morphs the image to thin out the thickest lines and remove the rest.


outim = bwmorph(input, 'erode');

% outim = bwmorph(input, 'close');
end

