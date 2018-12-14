function [noteArray, reImage] = getNotes(staffLineArray)
% Author: Emma Weberyd
% Takes in the staff and outputs all the music elements in an array where the
% notes are grabbed left to right, and top to bottom.

% staffLineArray: array of images that each represent one staff line going
% from top to bottom of the page. They need to be separated since the
% labeling will pic up notes in the wrong order if the image is kept as a
% whole.
% noteArray: an array of the labeled music information in the image.
% reImage: an image that is put together again from staffLineArray but with
% labeled information. 

arrayIndex = 1;

for j = 1:length(staffLineArray)
    
    [L,NUM] = bwlabel(staffLineArray{j});
    L2 = zeros(size(L,1), size(L,2));
    
    for i = 1:NUM 
        [r,c] = find(L == i);
        r = sort(r);
        c = sort(c);
        rows = r(1):r(end);
        cols = c(1):c(end);
        mask = (L==i);
        L2 = L2 + mask.*arrayIndex;
        noteArray{arrayIndex} = mask(rows,cols)*arrayIndex;
        arrayIndex = arrayIndex+1; 
    end
    
    if(j==1)
        reImage = L2;
    else
        reImage = [reImage; L2];
    end
    
end

end