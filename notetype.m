function [rensadnote2] = notetype(rensadnote,labeledImg,labels,template)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
bw  = double(255 * labeledImg);
RGB = cat(3, bw, bw, bw);

for i = 1:length(rensadnote)
 %[ri,ci] = find(rensadnote{1,i} == noteArray{})
        [r, c] = find(rensadnote{1,i});
        [ri, ci] = find(labeledImg == labels(3));
%         RGB(r,c,1) =255;
%         RGB(r,c,2) =0;
%         RGB(r,c,3) =0;
%         l = floor(length(template(1,:))/4);
         rt1  =(min(r)):(max(r));
         ct1 = (min(c)):(max(c));
        if(length(rt1) > 3 && length(ct1)>3)
            noteclass = LocalProj(rensadnote{1,i},template,0);
            rensadnote{2,i} = noteclass;
        end
    
end
rensadnote2 = rensadnote;
end

