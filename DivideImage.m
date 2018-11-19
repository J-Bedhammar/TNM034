function [outputimg] = DivideImage( inputimg, lines)


dist = 0;
longestdist = 0;
for i = 1:length(lines)- 1
    dist = lines(i+1) - lines(i);
    if longestdist < dist
        longestdist = dist;
    end
end

fromrow = 1;
for i = 1: (length(lines)/5 - 1)
    outputimg{i} = inputimg(fromrow:lines(5*i) + floor(longestdist/2), :);
    fromrow = lines(5*i) + floor(longestdist/2);
    print("hello");
end
 
