function [im,lines] = VerProj(inimage,dispsetting)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im = inimage;
%returnimage= 1-im2bw(im) ; 
bw  = double(255 * im);
RGB = cat(3, bw, bw, bw);

x = sum(im,1);


%figure
 %    plot(x,1:size(im,2))
  %        title('Ver image')
     
[peaks,locals,widths] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');
dispvals1=[peaks,locals];
maxpeak = max(peaks);

threshhold = 0.4;
removelist = peaks<=maxpeak*threshhold;
peaks(removelist) = [];
locals(removelist) = [];
widths(removelist) = [];
%display(peaks)
%display(locals)

for v = 1:length(locals)
    bot = locals(v) - floor(widths(v)/2);
    
    if(bot < 1)
    bot = locals(v);
    end
    
    temp = bot : (locals(v) + ceil(widths(v)/2));
    im(:,temp) = 0;
    RGB(:,temp, 1) = 255;
    RGB(:,temp, 2) = 0;
    RGB(:,temp, 3) = 0;
    
    
end
lines = locals;
if(dispsetting==1)
 figure
  stem(dispvals1(:,2),dispvals1(:,1))
    figure 
 imshow(RGB)
end
end

