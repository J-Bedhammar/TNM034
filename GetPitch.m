function [pitch] = GetPitch(noteheads, pitchlines)
% Author: Oliver Johansson

% Function information:
% Connects the correct pitch to a specific note


% Find the centroid in the notehead
Centroid = regionprops(noteheads, 'Centroid');

% get the closest stemrow
row = 10000;
for i = 1 : length(pitchlines(:,10))
    temp = abs(Centroid{2} - pitchlines(i,10));
    if temp < row
        row = temp;
    end
end

% find the closest pitch
nearest = 10000;
for j = 1 : length(pitchlines(row,i))
    temp = abs(Centroid{2} - pitchlines(row,i));
    if temp < nearest
        pitch = pitchlines(row,i);
    end
end

end

