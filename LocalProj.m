function [classint] = LocalProj(labledim,notetemp,dispsetting)
% returns a int , 0 = 4takt, 1 = 8takt o 2 = 16takt
%kan vara värt o ta bort noter innan man kollar på denna bild
notewidth = length(notetemp(1,:));

divfilt = [-1 0 1 ; -2 0 2 ; -1 0 1];
filtered = conv2( divfilt,labledim);
e = edge(labledim);


removelist  = e < 1;
e(removelist) = [];

im1  =labledim;
[verim, verlines] = VerProj(labledim,0);
localrgb = cat(3, labledim, labledim, labledim);

localrgb1 = cat(3, labledim, labledim, labledim);
localrgb(:,verlines,1) = 255;
localrgb(:,verlines,2) = 0;
localrgb(:,verlines,3) = 0;

ydim =  (size(labledim));
ydim= ydim(2);
verlines;

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
    localrgb1(:,verbot:v,1) = 0;
    localrgb1(:,verbot:v,2) = 255;
    localrgb1(:,verbot:v,3) = 0;
    
    localedge = sum(labledim(:,verbot:(v-2)),2);

[peaks,locals] = findpeaks(localedge);
dispmatrix{posinclass} = [peaks,locals];    
else
    localrgb1(:,v:(vertop),1) = 0;
    localrgb1(:,v:(vertop),2) = 255;
    localrgb1(:,v:(vertop),3) = 0;    
    
    localedge = sum(labledim(:,(v+2):(vertop)),2);

    [peaks,locals] = findpeaks(localedge);
    
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
end

end

