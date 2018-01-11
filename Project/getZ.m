function [ Z ] = getZ( k,w )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a = sin(k*w);
b = cos(k*w);
Z = [b, - a/k;
     k*a,  b];

end

