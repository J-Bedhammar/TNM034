function [ cell, labels ] = NoteClassification( noteArray, template )
% Author: Jennifer Bedhammar
% Last edit: 2018-11-29
% INPUTS: 
% noteArray: cell array with all found "notes", contains some trash
% template: notehead template to compare with
% Function information:
% Goes through all notes and clears out irrelevant signs and letters.
% OUTPUT: cell array of relevant notes and an array of their labels.

noteHead = imresize(template,0.5);
templateSize = size(noteHead);

gClefCenter = rgb2gray(imread("templates/gclef_center.png"));
gCenterSize = size(gClefCenter);

notes = noteArray;
relevantNotes = {};

index = 1;

% Go through all "notes" in noteArray
for i = 1:length(notes)
    noteSize = size(notes{i});
    
    % If smaller than a notehead(resized) is considered irrelevant
    if (noteSize(1) >= templateSize(1) && noteSize(2) >= templateSize(2) )
        match = normxcorr2(noteHead, notes{i}) > 0.65; % Find noteheads
        
        if ( noteSize(1) >= gCenterSize(1) && noteSize(2) >= gCenterSize(2) )
            gMatch = normxcorr2(gClefCenter, notes{i}) > 0.35;
            if( max(max(gMatch)) > 0)
                continue;
            end
        end
        if max(max(match)) > 0  % If notehead save in output arrays
            relevantNotes{1,index} = notes{i};
            labelArray(1,index) = min(max(notes{i}));
            index = index + 1;
%           figure
%           imshow(notes{i})
        end
        
    end

    
end

% Output
cell = relevantNotes;
labels = labelArray;

end



