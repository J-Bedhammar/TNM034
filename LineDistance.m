function [out] = LineDistance(lines)
% Author: Oliver Johansson
%
%Function information:
%calculates the mean distance between the lines
total = 0;
nrOfGaps = 0;
l = 1;
while length(lines)> l
    for i = l :l +3
        total = total + abs(lines(i+1) - lines(i));
        nrOfGaps = nrOfGaps + 1;
    end
    l = l + 5;
end

out = total/(nrOfGaps);