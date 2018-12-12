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

%rotate image
OMR = im;
rotation  = HoughTransform(OMR);
OMR = ImageRotation(OMR,rotation);

% Convert image to binary and invert
BW = BinaryShift(OMR);

beams = FillBeams(BW);

% Eliminate horizontal lines
%[lines, BW1] = HorProjElimLines(BW);
[imwithoutstaffs,staffs]=HorProj(BW,0); %set 0 = 1 to display
BW1 = imwithoutstaffs;
lines = staffs;
nostaffnbeams = beams + BW1;


% Get distance between lines i.e. height of noteheads
noteHeadHeight = LineDistance(lines);

% remove gclef
BW1 = RemoveGclef(nostaffnbeams, noteHeadHeight);

figure
imshow(BW1);
% Scale notehead template 
template = ResizeTemplate(noteHeadHeight);
% Erase any sheet title text 
if (staffs(1) - floor(4*noteHeadHeight) > 0)
    nostaffnbeams = nostaffnbeams((staffs(1) - floor(4*noteHeadHeight)):end, :);
end
% Divide sheet to get array of staff lines
array = DivideImage(nostaffnbeams, lines);




% Label the notes and get array of cut out notes in order
[noteArray,labeledImg] = getNotes(array);

[rensadnote , labels] = NoteClassification(noteArray,template);

dist =LineDistance(lines);
rensadnote2  = notetype(rensadnote,labeledImg,labels,template,dist);

% nrofobjects = length(noteArray(1,:))
% size(labeledImg)
% [notetype] = LocalProj(labeledImg,template,nrofobjects);
 notetypearray = [];
 antalceller = cellfun('length' , rensadnote2(2,:));
% mysum = sum(antalceller);
 antalceller = length(antalceller);
 for c = 1: antalceller

     notetypearray = [notetypearray ;rensadnote2{2,c}];
 end
% Get number of notes
nrOfNotes = size(noteArray, 2);

% Display labeled image
% figure
% imshow(labeledImg/nrOfNotes);
% title("this");

% Get image with only noteheads
noteHeadImg = normxcorr2(template, labeledImg) > 0.45;

% Find noteheads by opening with disk
noteHeadImg2 = findNotes(nostaffnbeams, noteHeadHeight);

% Display images of noteheads
% figure
% subplot(2,1,1)
% imshow(noteHeadImg2);
% title('noteheads from opening with disk element');
% subplot(2,1,2)
% imshow(noteHeadImg);
% title('noteheads from template matching');

% label the noteheads
labeledNoteHeads = labelTemplateImage(template, labeledImg);

% Display image with labeled noteheads
figure
imshow(labeledNoteHeads);
ClearNotes = ClarifyNoteHeads(labeledNoteHeads, noteHeadImg2);


pitchlines = PitchLines(lines);

strout = GetPitch(labeledNoteHeads, pitchlines,notetypearray);
%strout = "";

end

