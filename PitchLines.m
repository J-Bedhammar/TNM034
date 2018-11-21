function [ output ] = PitchLines( inputLines )
% Author: Jennifer Bedhammar
% Last edit: 2018-11-21

% Check that input lines consists of 5 lines?
if (mod(length(inputLines), 5 ~= 0 ))
    error('Wrong number of lines')
end

% Variables
nrPitches = 20;                          % G1 - E4
rows = length(inputLines) / 5;           % Number of rows
pitchLines = zeros(rows,nrPitches);
firstLine = 1;
dist = inputLines(2)-inputLines(1);      % OBS! dist based on two lines only

% Save y-values of every pitch in matrix
for i = 1:rows
    nextPitch = 0;
    for j = 1:nrPitches
       pitchLines(i,j) = inputLines(firstLine) + (6.5*dist) - nextPitch;
       nextPitch = nextPitch + (dist/2);
    end
    firstLine = firstLine + 5;
end

% return matrix 
output = pitchLines;

end

