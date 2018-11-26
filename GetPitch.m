function [out] = GetPitch(noteheads, pitchlines)
% % Author: Oliver Johansson
% 
% % Function information:
% % Connects the correct pitch to a specific note
% 
% % Find the centroid in the notehead
Centroid = regionprops(noteheads, 'Centroid');
Centroid = struct2cell(Centroid);
Centroid = cell2mat(Centroid);

% get the closest stemrow
neardist = 10000;
for i = 1 : length(pitchlines(:,10))
    temp = abs(Centroid(2) - pitchlines(i,10));
    if temp < neardist
        row = i;
        neardist = temp;
    end
end

% find the closest pitch
nearest = 10000;
for j = 1 : length(pitchlines(row,:))
    temp = abs(Centroid(2) - pitchlines(row,j));
    if temp < nearest
        pitch = j;
        nearest = temp;
    end
end
% % 
pitchstring = ["G1" "A1" "B1" "C2" "D2" "E2" "F2" "G2" "A2" "B2" "C3" "D3" "E3" "F3" "G3" "A3" "B3" "C4" "D4" "E4"];

% 
out = pitchstring(j);
%end

