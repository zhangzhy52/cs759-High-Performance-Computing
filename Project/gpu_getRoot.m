function [final_f ] = gpu_getRoot( fun,a,b)
% a is the start point, b is the end point

F = matlabFunction(fun);

N = 500;
start_pts = gpuArray.linspace(a,b,N);
final_f = [];
for i=1:numel(start_pts)-1
    try
        final_f(end+1) = fzero(F,[start_pts(i),start_pts(i+1)]);
    end
end