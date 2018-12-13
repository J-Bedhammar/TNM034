function [classint] = LocalProj(labledim,notetemp,dispsetting,dist,noGclefNotesstaff)
% returns a int , 0 = 4takt, 1 = 8takt o 2 = 16takt
%kan vara v�rt o ta bort noter innan man kollar p� denna bild
inim = labledim;
%[staffim] = getstaffim(labledim);
 
labledim  = inim;
notewidth = length(notetemp(1,:));
[labledim,x1,x2,y1,y2,noteheads,pos] = removeheadsinlocal(labledim,dist);
%[staffim2,x12,x22,y12,y22,noteheads2,pos2] = removeheadsinlocal(staffim,dist);
%x1  =x12;
%x2 = x22;


 
 

[verim, verlines] = VerProj(labledim,0);
oldver = verlines;
[verlines] = cleanverlines(verlines,notewidth);
%[verlines,labledim,skip] = hasnot(labledim,verlines,notetemp,dist);
im1  =labledim;
% if(skip)
%     verlines =[];
% end
% labledim  =staffim2;
localrgb = cat(3, labledim, labledim, labledim);
localrgb1 = localrgb;
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
    [staffim] = getstaffim(noGclefNotesstaff(x1:x2,verbot:v));

    localedge = sum(staffim,2);
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
    
    [staffim] = getstaffim(noGclefNotesstaff(x1:x2,v:(vertop)));
    localedge = sum(staffim,2);
 
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
oldclassint = classint;
if(length(classint) > 2)
    for i = 1:(length(classint))
        if(classint(i) == 4 )
            if(i == 1 && classint(i+1) ~= 4)
                classint(i) = classint(i+1);
            elseif(i == length(classint) && classint(i-1) ~=4)
                classint(i) = classint(i-1);
            else
                if( i ~= length(classint) && classint(i+1) == classint(i-1) )
                    classint(i) = classint(i-1);
                else
                    classint(i) = classint(i);
                end
            end
        end
    end
end
end




if(dispsetting == 1)
    figure
    imshow(im1)
  %  for i = 1:length(verlines)
   %     figure
    %    stem(dispmatrix{i})
    %end
    classint
    close all
end

end

