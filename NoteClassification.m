function [ cell, labels ] = NoteClassification( noteArray, template )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

noteHead = imresize(template,0.5);
templateSize = size(noteHead);

notes = noteArray;
relevantNotes = {};

index = 1;

for i = 1:length(noteArray)
    noteSize = size(notes{i});
    
    percentageDone = ceil((i/length(noteArray)) * 100);
    
    if (noteSize(1) >= templateSize(1) && noteSize(2) >= templateSize(2) )
        match = normxcorr2(noteHead, notes{i}) > 0.65;
        
        if max(max(match)) > 0
            relevantNotes{1,index} = notes{i};
            labelArray(1,index) = min(max(notes{i}));
            index = index + 1;
%             figure
%             imshow(notes{i})
        end

    end

    
end

cell = relevantNotes;
labels = labelArray;

end



