function [ df ] = StochasticGradient( f, x, h )
% Computes the stochastic Gradient of the given function f
% 
% Input:
% f : Scalar Function of R^n -> R
% x : Position at which the funstion shall be differentiated
% h : Step size
% 
% Output:
% df : The computed Gradient

% Initialization:
[n,m] = size(x);
df = zeros(n,m);

% Randomly select a vector indice for which the Gradient shall be computed
indices = linspace(1,n,n);
randIndice = randsample(indices, 1);

% Compute the Gradient for one element
p1 = x;
p1(randIndice) = p1(randIndice) + h;
df(randIndice) = (f(p1) - f(x)) / h;

end