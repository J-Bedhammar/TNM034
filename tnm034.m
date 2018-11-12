function [ strout ] = tnm034( im )
% Authors: Emma Weberyd, Jennifer Bedhammar, Julius K�rdel, Oliver
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
BW = BinaryShift(im);
BW1 = HorProj(BW);
figure
imshow(BW1);

BW2 = MorphOperation(BW1);

figure
imshow(BW2);
strout = 'hello';

end

