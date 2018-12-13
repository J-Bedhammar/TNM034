function [labledim,x1,x2,y1,y2,noteheads,pos] = removeheadsinlocal(labledim,dist)
[pos] =findNoteHeadCentroid(labledim);
% % 1 = y led i bild och 2 = yled i bild
% 

[pos] =findNoteHeadCentroid(labledim);
se  = strel('disk',floor(dist/2)-1);
noteheads=imopen(labledim,se);
noteheads(noteheads>1) =1;

ymid = floor(length(noteheads(1,:))/2);
xmid = floor(length(noteheads(:,1))/2);



if(pos(1)<xmid) %över halvan
    y1 = 1;
    y2 = ymid;
    x1 = xmid;
    x2 = length(noteheads(:,1));
    noteheads(xmid:end,:) = 0;

else
    y1 = ymid;
    y2 = length(noteheads(1,:));
    x1  =1;
    x2 = xmid;%length(noteheads(:,1));
    
    noteheads(1:xmid,:) = 0;
end

labledim = (labledim-noteheads);

labledim(labledim >0 ) =1;
labledim = labledim - noteheads;
end

