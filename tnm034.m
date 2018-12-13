function [ strout ] = tnm034( im )
% Authors: Emma Weberyd, Jennifer Bedhammar, Julius Kördel, Oliver
% Johansson.
% Last edit: 2018-12-12

% Function information:
% Im: Input image of captured sheet music. Im should be in double format,
% normalized to the interval [0,1]
% Strout: The resulting character string of the detected notes. The string
% must follow a pre-defined format. Pitch G2-E4. 
% Quarter notes (crotchets) uppercase letters. 
% Eight notes (quavers) lowercase letters.

%rotate image
OMR = im;
rotation  = HoughTransform(OMR,'image');
OMR = ImageRotation(OMR,rotation);

% Convert image to binary and invert
BW = BinaryShift(OMR);

beams = FillBeams(BW);

% Eliminate horizontal lines
[imwithoutstaffs,staffs]=HorProj(BW,0); %set 0 = 1 to display
BW1 = imwithoutstaffs;
lines = staffs;
nostaffnbeams = beams + BW1;

% Get distance between lines i.e. height of noteheads
noteHeadHeight = LineDistance(lines);

% remove gclef
noGclefNotes = RemoveGclef(BW1, noteHeadHeight);
noGclefNotesstaff = RemoveGclef(nostaffnbeams, noteHeadHeight);

% Scale notehead template 
template = ResizeTemplate(noteHeadHeight);

% Erase any sheet title text 
if (staffs(1) - floor(4*noteHeadHeight) > 0)
    noGclefNotes(1:(staffs(1) - floor(4*noteHeadHeight)), :) = 0;
    noGclefNotesstaff(1:(staffs(1) - floor(4*noteHeadHeight)), :) = 0;
end

% Divide sheet to get array of staff lines
array = DivideImage(noGclefNotes, lines);

% Label the notes and get array of cut out notes in order
[noteArray,labeledImg] = getNotes(array);
[rensadnote , labels] = NoteClassification(noteArray,template);

% Classify notes
rensadnote2  = notetype(rensadnote,labeledImg,labels,template,noteHeadHeight,noGclefNotesstaff);


% Find noteheads by opening with disk


noteHeadImg2 = findNotes(noGclefNotes, noteHeadHeight);

% Label the noteheads
labeledNoteHeads = labelTemplateImage(template, labeledImg);

%Clarify the noteheads
ClearNotes = ClarifyNoteHeads(labeledNoteHeads, noteHeadImg2);

%Find all possible pitches
pitchlines = PitchLines(lines);

%find corresponding pitch to note and print out
strout = GetPitch(ClearNotes, pitchlines,rensadnote2);


end

