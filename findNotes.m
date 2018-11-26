function noteheads = findNotes(Img, dist)
% Author: Emma Weberyd
% Img is a binary image without staff lines
% Noteheads is a binary image with only the note heads of the quarter and 8th
% notes.

se = strel('disk', floor(dist/2)-1); % creates structuring element
noteheads = imopen(Img,se);

end