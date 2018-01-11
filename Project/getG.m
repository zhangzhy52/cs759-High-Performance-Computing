function [ G ] = getG( k,w )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% the derivative of width
a = sin(k*w);
b = cos(k*w);

G = [ -k*a, - b
    k*k *b, -k*a];
    
end