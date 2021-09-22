function [ xFinal ] = NewtonProcedureGlobal( fun, x0, h, delta, ro, sigma, q, tol, maxiter, plt, range)
% Name        : Global Newton-Procedure
% Application : Is applicable for functions which are at least two times continuously differentiable at least two times
% Conditions  :    
% 
% INPUT
% fun       :   Function which shall be optimized
% x0        :   Starting position, can be n-Dimensional
% h         :   Step size
% delta     :   Experience-Parameter 
% ro        :   Experience-Parameter 
% sigma     :   Experience-Parameter for the variable step size 
%               0 <= sigma <= 1
% q         :   Experience-Parameter for the variable step size 
%               0 <= q <= 1
% tol       :   Tolerance (Termination criterion)
% maxIter   :   Max number of Iterations (Termination criterion)
% plt       :   Plot-Command if true results will be plotted
% range     :   Scalar which defines the plot range (-range:0.1:range)
%
% OUTPUT
% xFinal    :   Solution vector which contains the last determined point
% 

% Initialization:
counter = 1;
[row,col] = size(x0);
x = zeros(size(x0,1),maxiter);
x(:,counter) = x0;
dx = 10 * ones(size(x0));

tic
% Loop for the global newton procedure
while tol < norm(dx) && maxiter > counter
    
    dx = Hessian(fun, x(:,counter), h) \ -Gradient(fun, x(:,counter), h);
    
    if norm(dx) == 0 || sum(Gradient(fun, x(:,counter), h).* dx) > -delta*norm(dx)^(2+ro)
        dx = -Gradient(fun, x(:,counter), h);
    end
    
    alphaA = ArmijoStepsize( fun, h, x(:,counter), sigma, q, dx, maxiter );
    dx = dx * alphaA;
    x(:,counter+1) = x(:,counter) + dx;
    
    counter = counter + 1;

end
toc

xFinal = x(:,counter);

% Conditions for ploting the function/results:
if plt && row == 2

    PlotFunctions.FunctionPlots(fun, x, counter, range);
    
end

%  Termination criterion
if counter == maxiter
    counter
    xFinal
    tol
    Norm = norm(dx)
    error('Iterations have exceeded the maxiter value!')
else
    disp('Global newton procedure completed!')
    counter
    Norm = norm(dx)
end

end

