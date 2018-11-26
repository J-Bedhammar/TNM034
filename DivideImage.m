function [outputimg] = DivideImage( inputimg, lines)


dist = 0;
longestdist = 0;
for i = 1:length(lines)- 1
    dist = lines(i+1) - lines(i);
    if longestdist < dist
        longestdist = dist;
    end
end

[rows, cols] = size(inputimg);
fromrow = 1;
torow = rows;
temp = 1;
for i = 1: (length(lines)/5)
    torow = lines(5*i) + floor(longestdist/2);
    if(i == length(lines)/5)
       torow = rows;
    end
    outputimg{i} = inputimg(fromrow:torow, :);
    fromrow = lines(5*i) + floor(longestdist/2);
end
 
