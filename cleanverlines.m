function [verlines] = cleanverlines(verlines,notewidth)
% Author: Julius Kördel
% Remove lines to close to eachother and noise. 
previousline = 0;
removelines = zeros(length(verlines));
for index = 1 : length(verlines)
    if(index ~=length(verlines))
        if(index == 1 )
            previousline = verlines(index);
        else
            distbetweenverlines = abs(previousline-verlines(index));
            if(distbetweenverlines < (notewidth*0.6))
                removelines(index) = 1;       
            else
                previousline = verlines(index); 
            end
        end
    end    
end
removelines = logical(removelines);

verlines(removelines) = [];
end

