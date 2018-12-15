function [classint] = LocalProj(labledim,notetemp,dispsetting,dist,noGclefNotesstaff)
% Author: Julius Kördel
% returns a int array , 0 = 4takt, 1 = 8takt o 2 = 16takt

inim = labledim;
notewidth = length(notetemp(1,:));

% Find and remove noteheads.
[labledim,x1,x2,y1,y2,noteheads,pos] = removeheadsinlocal(labledim,dist);

% Find the notes positions. 
[verim,verlines] = VerProj(labledim,0);
% Remove wrong peaks.
[verlines] = cleanverlines(verlines,notewidth);

%Images for debugging and visualization.
localrgb = cat(3, labledim, labledim, labledim);
localrgb1 = localrgb;
localrgb(:,verlines,1) = 255;
localrgb(:,verlines,2) = 0;
localrgb(:,verlines,3) = 0;


ydim = (size(labledim));
ydim= ydim(2);
classint = 4*ones(length(verlines),1);
% Posinclass corresponds to pos in output array
posinclass=0;
dispmatrix={};

% This loop determines the note value.
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
        if(isempty(peaks))
            peakedge = max(max(localedge));
            if(peakedge >10 )
                peaks = peakedge;
                [x,y]=find(localedge==peakedge);
                locals  = y;   
            end
         end  
        peaks(peaks < 2) = 0;
        maxpeak = max(max(peaks));
        remove = peaks<=maxpeak*0.5;
        peaks(remove) = [];
        locals(remove) = [];  
    else
        localrgb1(x1:x2,v:(vertop),1) = 0;
        localrgb1(x1:x2,v:(vertop),2) = 255;
        localrgb1(x1:x2,v:(vertop),3) = 0;    

        [staffim] = getstaffim(noGclefNotesstaff(x1:x2,v:(vertop)));
        localedge = sum(staffim,2);

        [peaks,locals] = findpeaks(localedge);
         if(isempty(peaks))
            peakedge = max(max(localedge));
            if(peakedge >10 )
                peaks = peakedge;
                [x,y]=find(localedge==peakedge);
                locals  = y;   
            end
         end 
         peaks(peaks < 2) = 0;
         maxpeak = max(max(peaks));
         remove = peaks<=maxpeak*0.6;
         peaks(remove) = [];
         locals(remove) = [];
    end


    temprgb= localrgb+localrgb1;

    % classification bussnies depending on the number of peaks found.
    if(length(peaks) == 0) %4del
        classint(posinclass) = 0; 
    elseif(length(peaks) == 1) % 8del 
        classint(posinclass) = 1;
    elseif(length(peaks) ==2) % 16del
        classint(posinclass) = 2;
    end
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
    imshow(inim)
    classint
    close all
end

end

