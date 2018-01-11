function [ H ] = getH( k,w )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a = sin(k*w);
b = cos(k*w);

H = [ -w*a, a/k/k-w*b/k;
    a + k*w*b, -w*a];
    
end

