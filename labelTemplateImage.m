function [labelTemplateImg] = labelTemplateImage(templateImage, labelImage) 
% author: Emma Weberyd
% takes in labeled image and an image on which template matching has been
% performed. Outputs template matched image with labels.

NUM = max(max(labelImage));

[Rt,Ct] = size(templateImage);
[R,C] = size(labelImage);

if(R ~= Rt || C ~= Ct)
    Rdiff = Rt - R;
    Cdiff = Ct - C;
    
    templateImage = templateImage(Rdiff/2:(Rt -Rdiff/2), Cdiff/2:(Ct -Cdiff/2));
end

labelTemplateImg = zeros(size(labelImage));


for i = 1:NUM
    %noteImage = (labelImage == i); % take out single labeled note
    %imshow(noteImage/41);
    for r = 1:R
        for c = 1:C
            if (templateImage(r,c) == 1 && labelImage(r,c) == i) 
                    labelTemplateImg(r,c) = i;
            end
        end
    end
end

end