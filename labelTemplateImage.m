function [labelTemplateImg] = labelTemplateImage(templateImage, labelImage) 
% author: Emma Weberyd
% takes in labeled image and an image on which template matching has been
% performed. Outputs template matched image with labels.

NUM = max(max(labelImage));
labelTemplateImg = zeros(size(labelImage));

[R,C] = size(labelImage);


for i = 1:NUM
    %noteImage = (labelImage == i); % take out single labeled note
    %imshow(noteImage/41);
    for r = 1:R
        for c = 1:C
            %if (templateImage(r,c) == 1 ) 
                if ( labelImage(r,c) == i) 
                    %i
                end
                %labelTemplateImg(r,c) = i;
           % end
        end
    end

    
end

end