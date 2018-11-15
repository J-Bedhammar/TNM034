function [im] = HorProj(inimage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im = inimage;

x = sum(im,2);
figure
     plot(x,1:size(im,1))
     title('Hor image')
     
[peaks,locals,widths] = findpeaks(x,'Annotate','extents','WidthReference','halfheight');
maxpeak = max(peaks);

removelist = peaks<=maxpeak*0.5;
peaks(removelist) = [];
locals(removelist) = [];
widths(removelist) = [];
 [rows,colm] = size(im);
for v = 1:length(locals)
  
    floored  =locals(v)-floor(widths(v)/2);
    cieled = (locals(v) + ceil(widths(v)/2));
    temp = (floored) : cieled;
    for i = 1:colm-1
        
        if (im(floored,i)== 0 || im(cieled,i+1) == 0)
        im(temp,i) = 0;
        end
    end
end

%%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
end
%% 
%for v = 1:length(locals)
  
 %   floored  =locals(v)-floor(widths(v)/2);
  %  cieled = (locals(v) + ceil(widths(v)/2));
   % temp = (floored) : cieled;
    %im(temp,i) = 0;

%end

