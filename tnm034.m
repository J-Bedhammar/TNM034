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

% Convert image to binary and invert
BW = BinaryShift(im);

% Eliminate horizontal lines
[lines, BW1] = HorProjElimLines(BW);

% Get distance between lines i.e. height of noteheads
noteHeadHeight = LineDistance(lines);

% Scale notehead template 
template = ResizeTemplate(noteHeadHeight);

% Divide sheet to get array of staff lines
array = DivideImage(BW1, lines);

% Label the notes and get array of cut out notes in order
[noteArray,labeledImg] = getNotes(array);

% Get number of notes
nrOfNotes = size(noteArray, 2);

% Display labeled image
figure
imshow(labeledImg/nrOfNotes);
title("this");

% Get image with only noteheads
noteHeadImg = normxcorr2(template, labeledImg) > 0.45;

% Find noteheads by opening with disk
noteHeadImg2 = findNotes(BW1, noteHeadHeight);

% Display images of noteheads
figure
subplot(2,1,1)
imshow(noteHeadImg2);
title('noteheads from opening with disk element');
subplot(2,1,2)
imshow(noteHeadImg);
title('noteheads from template matching');

% label the noteheads
labeledNoteHeads = labelTemplateImage(noteHeadImg, labeledImg);

% Display image with labeled noteheads
figure
imshow(labeledNoteHeads/nrOfNotes);


strout = 'hello';

end

