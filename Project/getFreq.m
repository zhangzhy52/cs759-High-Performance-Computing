function [f ] = getFreq( k, w )
%UNTITLED3 Summary of this function goes here
%   return pi_12
N = length(k);
tmp = eye(2);
for i = 1:N
    tmp =  tmp * getZ(k(i), w(i) );
end
f = tmp(1,2);
