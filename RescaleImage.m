function [outImg, outDist, newLines] = RescaleImage(img, dist, lines)
%Author: Oliver Johansson

%Function description: 
%Resize the image and assignes new values to staff lines and distance
%between lines

%img is supposed to be the binary imag  WITH the lines. 
%dist is the distance between the lines

[rows, cols] = size(img);

%check if the size of the image is correct
if dist ~= 11
%calculates the scale to resize the image with    
scale = 11/dist;

%resize the image
scaledImg = imresize(img, scale);

%redo the horizontal projection to get the new data on the lines.
[outImg,newLines]=HorProj(scaledImg,0);

%set the new line distance
outDist = LineDistance(newLines);

else
% If the size of the image is correct it keeps the same data as before
outImg = img;
outDist = dist;
newLines = lines;
end

end

