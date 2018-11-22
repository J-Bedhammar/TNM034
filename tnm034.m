function [ strout ] = tnm034( im )
% Authors: Emma Weberyd, Jennifer Bedhammar, Julius Kördel, Oliver
% Johansson.
% Last edit: 2018-11-09

% Function information:
% Im: Input image of captured sheet music. Im should be in double format,
% normalized to the interval [0,1]
% Strout: The resulting character string of the detected notes. The string
% must follow a pre-defined format. Pitch G2-E4. 
% Quarter notes (crotchets) uppercase letters. 
% Eight notes (quavers) lowercase letters.

OMR = im;
BW = BinaryShift(OMR);

[lines, BW1] = HorProjElimLines(BW);

dist = LineDistance(lines);

template = ResizeTemplate(dist);

% get array of staff lines
array = DivideImage(BW1, lines);
[noteArray,reImage] = getNotes(array);

size(reImage)

C = normxcorr2(template, reImage);
size(C)

figure
imshow(reImage/41);
title("this");

C = C>0.4;

figure
imshow(C);

D = labelTemplateImage(C, reImage);
figure
imshow(D);

strout = 'hello';

end

