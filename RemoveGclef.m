function [out] = RemoveGclef(img, dist)
%Author: Oliver Johansson
%
%Function information:
%Finds the horzontal position of all the g-clefs and crops the image to
%remove them

V = [10,2];
SE = strel('rectangle', V);

notestem = imopen(img,SE);

newImg = bwmorph((img - notestem), 'erode');

[vericalImg, verticalLines] = VerProj(newImg, 0);

[n m] = size(img);

out = img(1:n,(verticalLines(1) + 2*dist):m);
end

