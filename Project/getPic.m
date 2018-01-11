function [ Y ] = getPic( mu,w ,T,freq)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

close all

syms f
k =  2 *pi * f *sqrt(mu /T);
z = getFreq(k,w);

Y = new_getRoot(z,0,freq);

f = 0:0.01:2*Y(2);
plot(f,eval(z));
hold on;
plot ([0,2*Y(2)],[0,0],'r');

end

