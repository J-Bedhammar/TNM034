function [ out ] = NoteClassification( noteArray, template )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

templateSize = size(template);
gclef = double(rgb2gray(imread('templates/gclef.png')));
gSum = sum(sum(gclef/max(max(gclef))));

notes = noteArray;
relevantNotes = {};

index = 1;

for i = 1:length(noteArray)
    noteSize = size(notes{i});
    
    if( noteSize(1) > (templateSize(1)*2) && noteSize(2) > (templateSize(2)*0.5) ) 
        
        %relevantNotes(index) = max(max(notes{i}));
        relevantNotes{index} = notes{i};
        index = index + 1;
    
        %figure
        %imshow(notes{i})
        
    end
    

end

out = relevantNotes;

end



