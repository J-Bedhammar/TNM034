function [labelTemplateImg] = labelTemplateImage(template, labelImage) 
% author: Emma Weberyd
% takes in labeled image and an image on which template matching has been
% performed. Outputs template matched image with labels.

% Get image with only noteheads
noteHead = imresize(template,0.7);
templateImage = normxcorr2(noteHead, labelImage) > 0.6;

figure
imshow(templateImage);

[Rt,Ct] = size(templateImage);
[R,C] = size(labelImage);

if(R ~= Rt || C ~= Ct)
    Rdiff = Rt - R;
    Cdiff = Ct - C;
    
    templateImage = templateImage(Rdiff/2+1:(Rt -Rdiff/2), Cdiff/2+1:(Ct -Cdiff/2));
end

labelTemplateImg = (templateImage.*labelImage);


end