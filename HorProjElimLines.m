function [im] = HorProjElimLines(inimage)
% Emma Weberyd
% deletes staff lines, only where there isn't any horizontal activity
im = inimage;

x = sum(im,2);
figure
     plot(x,1:size(im,1))
     title('Hor image')
     
[peaks,locals] = findpeaks(x);
maxpeak = max(peaks);

removelist = peaks<=maxpeak*0.8;
peaks(removelist) = [];
locals(removelist) = [];

[rows, cols] = size(im);

for ln = 1:length(locals)
    locals(ln)
    for pt = 1:cols
        if im(locals(ln)-2, pt) == 0 || im(locals(ln)+2, pt) == 0
            im(locals(ln)-1:locals(ln)+1,pt) = 0;
        end
    end
end

%%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
end