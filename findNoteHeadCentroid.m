function centroid = findNoteHeadCentroid(note) 
% Author: Emma Weberyd
% not is one isolated note
% centroid is a vector with row value first and col value second.

[rn, ~] = size(note);
mask1 = (note(floor(rn/2), :) == 0);
mask = mask1;
for k = 1:rn-1
    mask = [mask; mask1];
end
note = mask.*note;
L = bwlabel(note);
[lr,lc] = find(L == 1);
centroid = [median(lr) median(lc)];

end