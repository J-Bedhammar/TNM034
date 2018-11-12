function [outim] = MorphOperation(input)
% Morphs the image to thin out the thickest lines and remove the rest.
out1 = bwmorph(input, 'dilate');
out2 = bwmorph(out1, 'bridge');
outim = bwmorph(out2, 'erode');

% outim = bwmorph(input, 'close');
end

