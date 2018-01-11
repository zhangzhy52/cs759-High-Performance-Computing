function [ E ] = getAnotherE( k,w )
%UNTITLED Summary of this function goes here
%   This E matrix is used when changing the width.
%k is a vector of k1,k2,kN
%w is the length
N = length(k);
D = zeros(N,1);
AnotherD = zeros(N,1);
for i =1 : N
    tmp = eye(2);
    for j = 1:i-1
        tmp = tmp * getZ(k(j), w(j));
    end
    tmp = tmp *  getG(k(i), w(i) );
    for j = i+1: N
        tmp = tmp * getZ(k(j) , w(j) );
    end
    AnotherD(i)  = tmp(1,2);
end

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


E = AnotherD./(-1 *sum(D));

