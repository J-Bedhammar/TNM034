function [im] = VerProj(inimage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im = inimage;
%returnimage= 1-im2bw(im) ; 

x = sum(im,1);

figure
     plot(x,1:size(im,2))
          title('Ver image')
     
[peaks,locals,widths] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');
maxpeak = max(peaks);

threshhold = 0.4;
removelist = peaks<=maxpeak*threshhold;
peaks(removelist) = [];
locals(removelist) = [];
widths(removelist) = [];
%display(peaks)
%display(locals)

for v = 1:length(locals)
  
    
    temp = (locals(v)-floor(widths(v)/2)) : (locals(v) + ceil(widths(v)/2));
    im(:,temp) = 0;
end
    
end

