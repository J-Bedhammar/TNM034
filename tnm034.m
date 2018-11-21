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

%figure 
%imshow(BW1);

% get array of staff lines
array = DivideImage(BW1, lines);
[noteArray,reImage] = getNotes(array);

figure
imshow(reImage(:,1));
%imshow(reImage == 4);

dist = LineDistance(lines);

template = ResizeTemplate(dist);

%Get values between 1 and 0 depending on the template
%need to get the y-value to get the pitch
C = normxcorr2(template, reImage);
C = C>0.2;
figure
imshow(C)


strout = 'hello';

end

