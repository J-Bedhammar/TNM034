function [noteArray] = getNotes(staffLineArray)
% Author: Emma Weberyd
% Takes in the staff and outputs all the music elements in an array where the
% notes are grabbed left to right, and top to bottom.

% staffLineArray: array of images that each represent one staff line going
% from top to bottom of the page. They need to be separated since the
% labeling will pic up notes in the wrong order if the image is kept as a
% whole.
% noteArray: an array of the music information in the image.


[L,NUM] = bwlabel(staffLineArray);

for i = 1:NUM 
    [r,c] = find(L == i);
    r = sort(r);
    c = sort(c);
    rows = r(1):r(end);
    cols = c(1):c(end);
    noteArray{i} = L(rows,cols);
end


end