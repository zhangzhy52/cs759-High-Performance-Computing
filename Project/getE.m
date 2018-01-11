function [ E ] = getE( k,w )
%UNTITLED Summary of this function goes here
%   This E matrix is used when changing the density
%k is a vector of k1,k2,kN
%w is the length
%return size: N * 1
N = length(k);
D = zeros(N,1);
for i =1 : N
    tmp = eye(2);
    for j = 1:i-1
        tmp = tmp * getZ(k(j), w(j));
    end
    tmp = tmp *  getH(k(i), w(i) );
    for j = i+1: N
        tmp = tmp * getZ(k(j) , w(j) );
    end
    D(i)  = tmp(1,2);
end

E = D./(-2 *sum(D));
