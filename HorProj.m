function [im,staffs] = HorProj(ininimage,display)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%im = inimage;
maxofpeaks = 0;
Bestangle = 0;
inimage=ininimage;
inimage = bwmorph(inimage,'close');
h = fspecial('sobel');
inimage = imfilter(inimage,h);


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
dispvals1 = [peaks,locals];


 mediandifference = median(diff(locals));
 indToRemove = zeros(length(peaks));
for peakInd = 1:length(peaks)-1
    % if dx<medBarW/2
    if (locals(peakInd+1)-locals(peakInd) < mediandifference/2 )%|| locals(peakInd+1) -locals(peakInd) >mediandifference*3)
        if (peaks(peakInd) < peaks(peakInd+1))
          indToRemove(peakInd) = 1;
        elseif( peaks(peakInd)>peaks(peakInd+1))
             indToRemove(peakInd+1) = 1 ; 
        end
       
        
    end
end 
indToRemove = logical(indToRemove);

locals(indToRemove) = [];
peaks(indToRemove) = [];
widths(indToRemove) = [];
dispvals2 = [peaks,locals];

% % 
  maxpeak  = max(max(peaks));
  removelist = peaks<=maxpeak*0.45; % remove noise
  peaks(removelist) = [];
  locals(removelist) = [];
  widths(removelist) = [];
  medianwidth = median(widths);
bw  = double(255 * im);
RGB = cat(3, bw, bw, bw);
 [rows,colm] = size(im);
 
staffs= [];
index = 1;
staffcounter = 0;
localstaff = zeros(5,1);
peakstaff = zeros(5,1);
count = 0;
removeset = [];
from = 1 ; 
stoping = 1;
counter = 1;
localcopy = locals;
mediandifference = median(diff(locals));
for index = 1: length(locals)-1
     if(min(peakstaff) < peaks(index))% && locals(index+1) - locals(index) < (mediandifference+2))% && locals(index+1) - locals(index) > meandiff )
     %if( locals(index+1) - locals(index+0) < meandiff && locals(index+2) - locals(index+1) < meandiff && locals(index+3) - locals(index+2) < meandiff &&  locals(index+4) - locals(index+3) < meandiff )   
        peakstaff(1,1) = peaks(index);
        localstaff(1,1) = locals(index);
        %sort
        localstaff  = sort(localstaff);
        peakstaff = sort(peakstaff);
        staffcounter = staffcounter +1; 
     end

    if( (abs(locals(index+1)-locals(index)) > 5*mediandifference || locals(index+1) == locals(end)))
        count = count +1;
        %index
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
dispvals3 = [peaks,locals];



 staffs = zeros(size(im));
    for v = 1:length(locals)
        floored  = locals(v)-floor(medianwidth/2 +1);
        cieled = (locals(v) + ceil(medianwidth/2 + 1));
        temp = (floored) : cieled;
        staffs(temp,:) = 1;
        for i = 2: colm-1
            for t = temp
                
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
    imshow(RGB)
end