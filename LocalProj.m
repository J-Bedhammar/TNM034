function [classint] = LocalProj(labledim,notetemp,dispsetting,dist)
% returns a int , 0 = 4takt, 1 = 8takt o 2 = 16takt
%kan vara värt o ta bort noter innan man kollar på denna bild
inim = labledim;
% rotation  = HoughTransform(labledim);
% labledim = ImageRotation(labledim,rotation);


notewidth = length(notetemp(1,:));


[pos] =findNoteHeadCentroid(labledim);
% % 1 = y led i bild och 2 = yled i bild
% 
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
% labledim = labledim - noteheads;


[verim, verlines] = VerProj(labledim,0);
oldver = verlines;
[verlines] = cleanverlines(verlines,notewidth);
%[verlines,labledim,skip] = hasnot(labledim,verlines,notetemp,dist);
im1  =labledim;
% if(skip)
%     verlines =[];
% end
localrgb = cat(3, labledim, labledim, labledim);
localrgb1 = cat(3, labledim, labledim, labledim);
localrgb(:,verlines,1) = 255;
localrgb(:,verlines,2) = 0;
localrgb(:,verlines,3) = 0;

ydim =  (size(labledim));
ydim= ydim(2);

classint = 4*ones(length(verlines),1);
posinclass=0;
dispmatrix={};

for v = verlines
    posinclass = posinclass+1 ;
    if(v+floor(notewidth/2) <ydim)
        vertop =(v+floor(notewidth/2));
    else
        vertop = ydim;
    end
if(floor(notewidth/2)<v)
verbot = (v-floor(notewidth/2));
else
    verbot = v;
end
if(v == verlines(end) && v ~= verlines(1))
    localrgb1(x1:x2,verbot:v,1) = 0;
    localrgb1(x1:x2,verbot:v,2) = 255;
    localrgb1(x1:x2,verbot:v,3) = 0;
    
    localedge = sum(labledim(x1:x2,verbot:(v)),2);
    [peaks,locals] = findpeaks(localedge);
    peaks(peaks < 3) = 0;
    maxpeak = max(max(peaks));
    remove = peaks<=maxpeak*0.5;
    peaks(remove) = [];
    locals(remove) = [];
    dispmatrix{posinclass} = [peaks,locals];    
else
    localrgb1(x1:x2,v:(vertop),1) = 0;
    localrgb1(x1:x2,v:(vertop),2) = 255;
    localrgb1(x1:x2,v:(vertop),3) = 0;    
    
    localedge = sum(labledim(x1:x2,(v):(vertop)),2);
 
    [peaks,locals] = findpeaks(localedge);
    peaks(peaks < 3) = 0;
     maxpeak = max(max(peaks));
     remove = peaks<=maxpeak*0.6;
     peaks(remove) = [];
     locals(remove) = [];
     dispmatrix{posinclass} = [peaks,locals];
end
%figure
%stem(peaks,locals);


temprgb= localrgb+localrgb1;

% classification bussnies
if(length(peaks) == 0) %4del
    classint(posinclass) = 0; 
elseif(length(peaks) == 1) % 8del 
    classint(posinclass) = 1;
elseif(length(peaks) ==2) % 16del
    classint(posinclass) = 2;
end



end


if(dispsetting == 1)
    figure
    imshow(im1)
    for i = 1:length(verlines)
        figure
        stem(dispmatrix{i})
    end
    classint
    close all
end

end

