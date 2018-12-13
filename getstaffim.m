function [staffim] = getstaffim(labledim)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

testvar = labledim;
testvar = testvar(testvar >0);
if(size(testvar) > 5 )
    rotation  = HoughTransform(labledim,'notes');
    staffim = ImageRotation(labledim , rotation);
   
else
    staffim = labledim;
end
end

