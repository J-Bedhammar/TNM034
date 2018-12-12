function [ clearedNoteArray, labels ] = NoteClassification( noteArray, template )
% Author: Jennifer Bedhammar
% Last edit: 2018-12-12
% INPUTS: 
% noteArray: cell array with all found "notes", contains some trash
% template: notehead template to compare with
% Function information:
% Goes through all notes and clears out irrelevant signs and letters.
% OUTPUT: cell array of relevant notes and an array of their labels.

noteHead = imresize(template,0.55);
templateSize = size(noteHead);

notes = noteArray;
relevantNotes = {};

index = 1;

% Go through all "notes" in noteArray
for i = 1:length(notes)
    noteSize = size(notes{i});
    
    % If smaller than a notehead(resized) is considered irrelevant
    if (noteSize(1) >= templateSize(1) && noteSize(2) >= templateSize(2) )
        match = normxcorr2(noteHead, notes{i}) > 0.60; % Find noteheads
        
        % Check if match with notehead
        if (max(max(match)) > 0)  % If notehead, save in output arrays
           relevantNotes{1,index} = notes{i};
           mostFreqLabel = nonzeros(notes{i});
           labelArray(1,index) = mode(mode(mostFreqLabel,2));
           index = index + 1;
           
%            figure
%            imshow(notes{i})
        end
        
    end 
end
    

% Output
clearedNoteArray = relevantNotes;
labels = labelArray;

end




% OLD G-CLEF CODE ----------------------------------

% gClefCenter = rgb2gray(imread('templates/gclef_center.png'));
% gClefCenter2 = rgb2gray(imread('templates/gclef_center2.png'));
% gClefCenter3 = rgb2gray(imread('templates/gclef_center3.png'));
% gCenterSize = size(gClefCenter);
% gCenterSize2 = size(gClefCenter2);
% gCenterSize3 = size(gClefCenter3);

% IF GCLEF SKIP -------------------------------------
% 
% % Top -----------
% if ( noteSize(1) >= gCenterSize2(1) && noteSize(2) >= gCenterSize2(2) )
%     gMatch2 = normxcorr2(gClefCenter2, notes{i}) > 0.50;
%     if( max(max(gMatch2)) > 0)
%         %figure
%         %imshow(notes{i})
%         continue;
%     end
% end
% 
% % Center ----------
% if ( noteSize(1) >= gCenterSize(1) && noteSize(2) >= gCenterSize(2) )
%     gMatch = normxcorr2(gClefCenter, notes{i}) > 0.35;                 
%     if( max(max(gMatch)) > 0)
%         %figure
%         %imshow(notes{i})
%         continue;
%     end
% end
% 
% % Tail ----------
% if ( noteSize(1) >= gCenterSize3(1) && noteSize(2) >= gCenterSize3(2) )
%     gMatch3 = normxcorr2(gClefCenter3, notes{i}) > 0.75;                
%     if( max(max(gMatch3)) > 0)
%         %figure
%         %imshow(notes{i})
%         continue;
%     end
% end
% 
% % ------------------------------------------------

