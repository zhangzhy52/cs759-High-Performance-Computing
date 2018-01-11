function [ Fw ] = fwVector( k,w )
%UNTITLED Summary of this function goes here
%   Fw is dF/dw
%k is a vector of k1,k2,kN
%w is the length
%return size: 1 * N
N = length(k);
Fw = zeros(1,N);
for i =1 : N
    tmp = eye(2);
    for j = 1:i-1
        tmp = tmp * getZ(k(j), w(j));
    end
    tmp = tmp *  getG(k(i), w(i) );
    for j = i+1: N
        tmp = tmp * getZ(k(j) , w(j) );
    end
    Fw(i)  = tmp(1,2);
end


end

