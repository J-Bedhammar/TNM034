function [rensadnote2] = notetype(rensadnote,labeledImg,labels,template,dist,noGclefNotesstaff)
% Author: Julius Kördel
% This is the function that decide the notevalues for all notes. 
% It need a images without stafflines. 1 where beams have not been added 
%afterwards and one that beams have been added. first 1 for deciding note
%positions and the latst 1 for decidinge its value. 

for i = 1:length(rensadnote)
    [ri, ci] = find(labeledImg == labels(i));
     rt1  =(min(ri)):(max(ri));
     ct1 = (min(ci)):(max(ci));
     if(length(rt1) > 3 && length(ct1)>3)
         if(max(rt1)>length(noGclefNotesstaff(:,1)))
            rt1(rt1 > length(noGclefNotesstaff(:,1))) = [];
         end
         if(max(ct1)>length(noGclefNotesstaff(1,:)) )
            ct1(ct1 > length(noGclefNotesstaff(1,:))) = [];
         end
      
        noteclass = LocalProj(rensadnote{1,i},template,0,dist,noGclefNotesstaff(rt1,ct1));
        rensadnote{2,i} = noteclass;
     end
end
rensadnote2 = rensadnote;
end

