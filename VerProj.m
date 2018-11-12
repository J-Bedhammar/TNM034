function [im] = VerProj(inimage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im = inimage;
%returnimage= 1-im2bw(im) ; 

x = sum(im,1);

figure
     plot(x,1:size(im,2))
          title('Ver image')
     
[peaks,locals] = findpeaks(x);
maxpeak = max(peaks);

threshhold = 0.8;
removelist = peaks<=maxpeak*threshhold;
peaks(removelist) = [];
locals(removelist) = [];

%display(peaks)
%display(locals)
for v = locals
    im(:,v) = 0;
end
    
end

