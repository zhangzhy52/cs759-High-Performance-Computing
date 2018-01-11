function [ Y ] = getZeros( mu, w ,T, freq )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
close all;
syms  f

pi = 3.1415926;
k  = 2 *pi * f *sqrt(mu/T);
n = length(mu);

%
%w = zeros(n,1);
%w(:) = totalLength./n;

zzy = getFreq(k,w);


Y = new_getRoot(zzy,0,freq);

f = 0:0.01:2*Y(n-1);
plot(f,eval(zzy));
hold on;
plot ([0,2*Y(n-1)],[0,0],'r');
end



