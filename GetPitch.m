function [str] = GetPitch(noteheads, pitchlines)
% Author: Oliver Johansson

% Function information:
% Connects the correct pitch to a specific note

str = ' ';
for i = 1: size(noteheads)
    [L,NUM] = bwlabel(noteheads == i);
    for j = 1:NUM 
        singleNote =(L == j);

        % Find the centroid in the notehead
        Centroid = regionprops(singleNote, 'Centroid');
        Centroid = struct2cell(Centroid);
        Centroid = cell2mat(Centroid);

        % Get the closest stemrow
        neardist = 10000;
        for i = 1 : length(pitchlines(:,10))
            temp = abs(Centroid(2) - pitchlines(i,10));
            if temp < neardist
                row = i;
                neardist = temp;
            end
        end

        % Find the closest pitch
        nearest = 10000;
        for j = 1 : length(pitchlines(row,:))
            temp = abs(Centroid(2) - pitchlines(row,j));
            if temp < nearest
                pitch = j;
                nearest = temp;
            end
        end

        % check if it is quarter note or eight notes
        
        % -------------------------------INSERT CODE HERE--------------------------------------------------------------------------
        pitchstring1 = ["G1" "A1" "B1" "C2" "D2" "E2" "F2" "G2" "A2" "B2" "C3" "D3" "E3" "F3" "G3" "A3" "B3" "C4" "D4" "E4"];

        pitchstring2 = ["g1" "a1" "b1" "c2" "d2" "e2" "f2" "g2" "a2" "b2" "c3" "d3" "e3" "f3" "g3" "a3" "b3" "c4" "d4" "e4"];

        str = strcat(str,pitchstring1(pitch));
    end
end
end