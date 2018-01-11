function [ Fmu,FOmega ] = fmuOmegaVector( k,w ,mu,T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(k);
Fmu = zeros(1,N);
tmpOmega = zeros(1,N);
for i =1 : N
    tmp = eye(2);
    for j = 1:i-1
        tmp = tmp * getZ(k(j), w(j));
    end
    tmp = tmp *  getH(k(i), w(i) );
    for j = i+1: N
        tmp = tmp * getZ(k(j) , w(j) );
    end
    Fmu(i)  = tmp(1,2)* k(i)/2/mu(i);
    tmpOmega(i) = tmp(1,2) * sqrt(mu(i)/T);
end
FOmega = sum(tmpOmega);

end

