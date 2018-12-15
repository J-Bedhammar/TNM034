function [newTemplate] = ResizeTemplate(dist)
% Author: Oliver Johansson
%
%Function information:
%creates and resizes the template depending on the distance between the lines

path = fullfile('templates', 'Nothuvud.png');
template = imread(path);
template = rgb2gray(template);

newTemplate = imresize(template, [dist, dist * (315/144)]);

end

