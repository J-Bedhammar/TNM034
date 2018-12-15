function [im,staffs] = HorProj(ininimage,display)
% author: Julius Kördel
% takes in an musical sheet as an image and determine the stafflines for 
% that sheet. It does this through the horizontal projection and sorting and 
% removing noise , duppletts.  
% im is a image with only the stafflines in and staffs are the locations of
% the stafflines. 

maxofpeaks = 0;
Bestangle = 0;
inimage=ininimage;
inimage = bwmorph(inimage,'close');
h = fspecial('sobel');
inimage = imfilter(inimage,h);

% adjust the rotation of the image for better projection.
for i = -1:0.01:1
    im = imrotate(inimage,i,'bicubic','crop');
    x = sum(im,2);
    [ofpeaks] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');
    sumval = max(sum(ofpeaks(:,:)));
    if(sumval> maxofpeaks)
        maxofpeaks=sumval;
        Bestangle= i;
    end
end

im = imrotate(ininimage,Bestangle,'bicubic','crop');
x = sum(im,2);
[peaks,locals,widths] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');

% Saved for display later. 
dispvals1 = [peaks,locals];

mediandifference = median(diff(locals));
indToRemove = zeros(length(peaks));

% find "overlapping" peaks
for peakInd = 1:length(peaks)-1
    if (locals(peakInd+1)-locals(peakInd) < mediandifference/2 )
        if (peaks(peakInd) < peaks(peakInd+1))
            indToRemove(peakInd) = 1;
        elseif( peaks(peakInd)>peaks(peakInd+1))
             indToRemove(peakInd+1) = 1 ; 
        end
    end
end 
% remove the overlapped peaks
indToRemove = logical(indToRemove);
locals(indToRemove) = [];
peaks(indToRemove) = [];
widths(indToRemove) = [];
dispvals2 = [peaks,locals];

% remove noise depending the higest peak
maxpeak  = max(max(peaks));
removelist = peaks<=maxpeak*0.45;
peaks(removelist) = [];
locals(removelist) = [];
widths(removelist) = [];
dispvals3 = [peaks,locals];
medianwidth = median(widths);

% For debugging and displaying 
bw  = double(255 * im);
RGB = cat(3, bw, bw, bw);

% Declear vars for the loop
[rows,colm] = size(im); 
staffs= [];
index = 1;
staffcounter = 0;
localstaff = zeros(5,1);
peakstaff = zeros(5,1);
count = 0;
removeset = [];
from = 1 ; 
localcopy = locals;
mediandifference = median(diff(locals));

% Make sure each staff only contains 5 lines.
for index = 1: length(locals)-1
     if(min(peakstaff) < peaks(index))
        peakstaff(1,1) = peaks(index);
        localstaff(1,1) = locals(index);
        
        %sort
        localstaff  = sort(localstaff);
        peakstaff = sort(peakstaff);
        staffcounter = staffcounter +1; 
     end

    if( (abs(locals(index+1)-locals(index)) > 5*mediandifference || locals(index+1) == locals(end)))
        count = count +1;
        for i = from: index
            if(ismember(peaks(i),peakstaff))
                
            else
                localcopy(i) = -1;
            end
        end
        
        zerocounter = 0;
        for j = 1:length(localstaff)
        if(localstaff(j) == 0)
            zerocounter  =zerocounter+1;
        end
        end
        if(zerocounter == 0)
            from = index+1; 
            staffs = cat(1, staffs, localstaff);
            staffcounter=staffcounter + 1;
            localstaff = zeros(5,1);
            peakstaff = zeros(5,1);
        end
    end
end

removeset = localcopy < 0;
locals(removeset) = [];
peaks(removeset) = [];
dispvals4 = [peaks,locals];


% Give some padding for the stafflines. 
 staffs = zeros(size(im));
    for v = 1:length(locals)
        floored  = locals(v)-floor(medianwidth/2 +1);
        cieled = (locals(v) + ceil(medianwidth/2 + 1));
        temp = (floored) : cieled;
        staffs(temp,:) = 1;
        for i = 2: colm-1
            for t = temp
                % Only remove if it dont destroy a note.
                if (im(t-1,i) == 0  || im(t+1,i)== 0)
                    RGB(t,i,1) = 255;
                    RGB(t,i,2) = 0;
                    RGB(t,i,3) = 0;
                     im(t,i) = 0;
                end
                
            end
        end    
    end

staffs = locals;    
if(display == 1)
   
    figure
    stem(dispvals1(:,2),dispvals1(:,1))
    figure
    stem(dispvals2(:,2),dispvals2(:,1))
    figure
    stem(dispvals3(:,2),dispvals3(:,1))
    figure
    stem(dispvals4(:,2),dispvals3(:,1))
    
    figure
    imshow(RGB)
end