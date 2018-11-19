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
temp = DivideImage(BW1,lines);

length(temp)

for i = 1:length(temp)
    figure();
    imshow(temp{i});
end

dist = LineDistance(lines);

template = ResizeTemplate(dist);

C = normxcorr2(template, BW1);

figure
imshow(C>0.5)
figure
imshow(BW1);

% get array of staff lines
array = DivideImage(BW1, lines);
noteArray = getNotes(array);
figure
imshow(noteArray{1});
figure
imshow(noteArray{2});
figure
imshow(noteArray{3});
%BW2 = MorphOperation(BW1);

strout = 'hello';

end

