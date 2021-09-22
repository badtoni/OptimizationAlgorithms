function [ df ] = Gradient( f, x, h)
% Computes the Gradient of the given function f with the Forward discretization 1st order
% 
% INPUT:
% f         :   Function which shall be optimized
% x         :   Starting position, can be n-Dimensional
% h         :   Step size
% 
% OUTPUT:
% df        :   The computed Gradient

% Initialization:
[n,m] = size(x);
df = zeros(n,m);

for i = 1:n
    
    p1 = x;
    p1(i) = p1(i) + h;
    df(i) = (f(p1) - f(x)) / h;

end

end