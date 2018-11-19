function [im,staffs] = HorProj(ininimage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%im = inimage;
maxofpeaks = 0;
Bestangle = 0;
inimage=ininimage;
for i = -0.1:0.001:0.1
    im = imrotate(inimage,i,'bicubic','crop');
    x = sum(im,2);
    [ofpeaks] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');
    sumval = max(sum(ofpeaks(:,:)));
    if(sumval> maxofpeaks)
        maxofpeaks=sumval;
        Bestangle= i;
    end
end
im = imrotate(inimage,Bestangle,'bicubic','crop');
x = sum(im,2);
[peaks,locals,widths] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');

 medianwidth = median(widths);
indToRemove = zeros(length(peaks));
for peakInd = 1:length(peaks)-1
    % if dx<medBarW/2
    if (locals(peakInd+1)-locals(peakInd) < medianwidth/2)
        if (peaks(peakInd)< peaks(peakInd+1)|| peaks(peakInd)>peaks(peakInd+1))
          indToRemove(peakInd) = 1;
        end 
    end
end 
indToRemove = logical(indToRemove);
locals(indToRemove) = [];
peaks(indToRemove) = [];
widths(indToRemove) = [];

maxpeak  = max(peaks);
removelist = peaks<=maxpeak*0.6;
peaks(removelist) = [];
locals(removelist) = [];
widths(removelist) = [];
medianwidth = median(widths);
%RGB = cat(3, im, im, im);
[rows,colm] = size(im);
staffs = zeros(size(im));
for v = 1:length(locals)
      floored  = locals(v)-floor(medianwidth/2);
    cieled = (locals(v) + ceil(medianwidth/2));
    temp = (floored) : cieled;
    staffs(temp,:) = 1;
    for i = 2: colm-1
        for t = temp
            
            if (im(t-1,i) == 0 || im(t+1,i)==0)
                 %RGB(t,i,1) = 255;
                 %RGB(t,i,2) = 0;
                 %RGB(t,i,3) = 0;
                 im(t,i) = 0;
             %       im(temp,i) = 0;
            end
            
        end
    end    %RGB(temp,:,1) = 255;
end
%% plotsection 
% figure
%     plot(x,1:size(im,1))
%     title('Hor image')
%figure
%stem(locals,peaks,'b')


