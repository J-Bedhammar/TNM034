function [classint] = LocalProj(labledim,notetemp)
% returns a int , 0 = 4takt, 1 = 8takt o 2 = 16takt
%kan vara värt o ta bort noter innan man kollar på denna bild
notewidth = length(notetemp(1,:));

divfilt = [-1 0 1 ; -2 0 2 ; -1 0 1];
filtered = conv2( divfilt,labledim);
e = edge(labledim);

removelist  = e < 1;
e(removelist) = [];


imshow(labledim)
[verim, verlines] = VerProj(labledim,0);
localrgb = cat(3, labledim, labledim, labledim);

localrgb1 = cat(3, labledim, labledim, labledim);
localrgb(:,verlines,1) = 255;
localrgb(:,verlines,2) = 0;
localrgb(:,verlines,3) = 0;

ydim =  (size(labledim));
ydim= ydim(2);
verlines
for v = verlines
    
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
    localrgb1(:,verbot:v,1) = 0;
    localrgb1(:,verbot:v,2) = 255;
    localrgb1(:,verbot:v,3) = 0;
    
    localedge = sum(labledim(:,verbot:(v-2)),2);

[peaks,locals] = findpeaks(localedge);
    
else
    localrgb1(:,v:(vertop),1) = 0;
    localrgb1(:,v:(vertop),2) = 255;
    localrgb1(:,v:(vertop),3) = 0;    
    
    localedge = sum(labledim(:,(v+2):(vertop)),2);

    [peaks,locals] = findpeaks(localedge);

end
figure
stem(peaks,locals);

end
temprgb= localrgb+localrgb1;

classint = 4;
close all
% classification bussnies
if(length(peaks) == 0)
    classint = 0;
elseif(length(peaks) == 1) 
    classint = 1;
elseif(length(peaks) ==2)
    classint = 2;
end

    
end

