function noteHeadImg = ClarifyNoteHeads(templateMatchHeads,openingHeads)
% author: EW
% In the positions where white pixels overlap in both images, keep
% the whole object from openingHeads 
[TL,TNUM] = bwlabel(templateMatchHeads);
[OL,ONUM] = bwlabel(openingHeads);
noteHeadImg = openingHeads;

for o = 1:ONUM
    % part in openingHeads
    part = (OL == o);
    temp = part.*templateMatchHeads;
    if max(temp) == 0 % if templateMatchHeads and part don't intersect
        noteHeadImg(part) = 0;
    
    end
end

end