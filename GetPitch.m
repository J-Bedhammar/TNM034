function [str] = GetPitch(noteheads, pitchlines,notetype)
% Author: Oliver Johansson

% Function information:
% Connects the correct pitch to a specific note
currow = 1;
str = ' ';
index = 1;
for i = 1: size(noteheads)
    [L,NUM] = bwlabel(noteheads == i);
    if NUM ~= 0
        typeofnote = cell2mat(notetype(2,index));
        index = index + 1;
    end
    for j = 1:NUM 
        singleNote =(L == j);

        % Find the centroid in the notehead
        Centroid = regionprops(singleNote, 'Centroid');
        Centroid = struct2cell(Centroid);
        Centroid = cell2mat(Centroid);

        % Get the closest stemrow
        neardist = 10000;
        for n = 1 : length(pitchlines(:,10))
            temp = abs(Centroid(2) - pitchlines(n,10));
            if temp < neardist
                row = n;
                neardist = temp;
            end
        end
        
        %check if its a new row
        if currow ~= row
            str = strcat(str,"n");
            currow = row;
        end

        % Find the closest pitch
        nearest = 10000;
        for m = 1 : length(pitchlines(row,:))
            temp = abs(Centroid(2) - pitchlines(row,m));
            if temp < nearest
                pitch = m;
                nearest = temp;
            end
        end
        
        % check if it is quarter note or eight notes
        pitchstring1 = ["G1" "A1" "B1" "C2" "D2" "E2" "F2" "G2" "A2" "B2" "C3" "D3" "E3" "F3" "G3" "A3" "B3" "C4" "D4" "E4"];
        pitchstring2 = ["g1" "a1" "b1" "c2" "d2" "e2" "f2" "g2" "a2" "b2" "c3" "d3" "e3" "f3" "g3" "a3" "b3" "c4" "d4" "e4"];
        
        if typeofnote(1,j) == 0
            str = strcat(str,pitchstring1(pitch));
        elseif typeofnote(1,j) == 1
            str = strcat(str,pitchstring2(pitch));
        elseif typeofnote(1,j) < 1
            %sixteenth note, nothing happens
        else
            str = strcat(str,pitchstring1(pitch));
        end
    end
end
end