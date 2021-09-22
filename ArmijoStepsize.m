function [ alphaA ] = ArmijoStepsize( fun, h, xk, sigma, q, d, maxiter )
% Name:         Armijo Step size
% Application:  Is used to compute the perfect step size of the next
%               gradient descent iteration
% Conditions:   - 
% 
% INPUT
% fun       :   Function which shall be optimized
% h         :   Step size
% x0        :   Position of the last iteration, can be n-Dimensional
% sigma     :   Experience-Parameter for the variable step size 
%               0 <= sigma <= 1
% q         :   Experience-Parameter for the variable step size 
%               0 <= q <= 1
% d         :   The Negativ Gradient
% maxiter   :   Max number of Iterations (Termination criterion)
%  
% OUTPUT
% alphaA    :  Perfect step size alphaA
% 

% Initialization:
alpha = 1;
ArmijoCounter = 1;

xad = fun(xk + alpha * d);
xsa = fun(xk) + sigma * sum(Gradient(fun, xk, h).* d) * alpha;

while xad > xsa && maxiter > ArmijoCounter
    
    alpha = q * alpha;

    xad = fun(xk + alpha * d);
    xsa = fun(xk) + sigma * sum(Gradient(fun, xk, h).* d) * alpha;
    
    ArmijoCounter = ArmijoCounter + 1;
    
end

%  Termination criterion
if ArmijoCounter == maxiter
     ArmijoCounter
     error('Iterationen haben den maxiter Wert ueberschritten!')
end
 
alphaA = alpha;

end

