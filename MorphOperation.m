function [outim] = MorphOperation(input)
% Morphs the image to fill space within the notes and make them more smoth

%Dilates the image to decrease the space within the notes
out1 = bwmorph(input, 'dilate');

%Fill small spaces within the notes if there are any left
out2 = bwmorph(out1, 'bridge');

%Erodes the image to make the notes smoother and increase intentional
%holes, such as half notes
outim = bwmorph(out2, 'erode');
end

