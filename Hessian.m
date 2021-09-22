function [ Df ] = Hessian( f, x, h)
% Determines the Hessian matrix of the given function f
% 
% INPUT:
% f         :   Function which shall be optimized
% x         :   Starting position, can be n-Dimensional
% h         :   Step size
% 
% OUTPUT:
% Df : Hessian Matrix with the second derivatives after each variable

% Initialization:
[n,m] = size(x);
mx = max(n,m);
Df = zeros(mx,mx);

for i = 1:mx
    for j = 1:mx
        
        if i == j
            a1 = x;
            a2 = x;
            a1(i) = a1(i) + h;
            a2(i) = a2(i) - h;
            Df(i,j) = (f(a1) - 2*f(x) + f(a2)) / h^2;
        else
            a1 = x;
            a2 = x;
            a3 = x;
            a1(i) = a1(i) + h;
            a2(j) = a2(j) + h;
            a3(i) = a3(i) + h;
            a3(j) = a3(j) + h;
            Df(i,j) = (f(a3') - f(a2') - f(a1) + f(x)) / h^2;
        end
        
    end
end


