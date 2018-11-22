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
    
    templateImage = templateImage(Rdiff/2+1:(Rt -Rdiff/2), Cdiff/2+1:(Ct -Cdiff/2));
end

labelTemplateImg = (templateImage.*labelImage)/NUM;


end