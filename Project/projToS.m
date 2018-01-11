function [ x ] = projToS( g )
N = length(g);
x = zeros(N,1);
u = sort(g,'descend');
for k =1 :N
    if (sum(u(1:k)) - 1) /k > u(k)
        break
    end
end
K = k -1;

t =  (sum(u(1:K)) - 1)/K;

for i = 1: N
    x(i) = max( g(i)- t,0);
end





