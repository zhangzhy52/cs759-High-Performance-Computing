function [ x ] = proj( z )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x = zeros(length(z), 1);

for i =1:length(z)
    if z(i) > 0
        x(i) = z(i);
    else
        x(i) = 0;
    end
end

