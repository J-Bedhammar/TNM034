function [labledim,x1,x2,y1,y2,noteheads,pos] = removeheadsinlocal(labledim,dist)
% Author: Julius Kördel
% The notevalue classification becomse better if noteheads are removed
% Sometimes notes can be matched inside a beam.

%Find first notehead in image
[pos] =findNoteHeadCentroid(labledim);

%Find alla matches for noteheads in the image
se  = strel('disk',floor(dist/2)-1);
noteheads=imopen(labledim,se);
noteheads(noteheads>1) =1;


ymid = floor(length(noteheads(1,:))/2);
xmid = floor(length(noteheads(:,1))/2);

%Remove matched noteheads but only in right half
if(pos(1)<xmid) 
    y1 = 1;
    y2 = ymid;
    x1 = xmid;
    x2 = length(noteheads(:,1));
    noteheads(xmid:end,:) = 0;

else
    y1 = ymid;
    y2 = length(noteheads(1,:));
    x1  =1;
    x2 = xmid;
    noteheads(1:xmid,:) = 0;
end

%remove noteheads from the image 
%labledim = (labledim-noteheads);
labledim(labledim >0 ) =1;
labledim = labledim - noteheads;
end

