function [out] = LineDistance(lines)
% Author: Oliver Johansson
%
%Function information:
%calculates the mean distance between the lines
total = 0;
l = 0;
while length(lines)> l
    for i = l +1:l +4
        total = total + abs(lines(i+1) - lines(i));
    end
    l = l + 5;
end

out = total/(length(lines) - 1);