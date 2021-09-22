function [ xFinal ] = SGD( fun, x0, h, alpha, tol, maxiter, plt, range )
% Name:         Stochastic Gradient Descent
% Application:  Is only applicable for scalar Functions of the form "fun = @(x) x(1)^2+x(2)^2"
% Conditions:  - The given toleranz must be less or equal to the step size!
%              - 
% 
% INPUT
% fun       :   Function which shall be optimized
% x0        :   Starting position, can be n-Dimensional
% h         :   Step size
% alpha     :   Learning rate
% tol       :   Tolerance (Termination criterion)
% maxIter   :   Max number of Iterations (Termination criterion)
% plt       :   Plot-Command if true results will be plotted
% range     :   Scalar which defines the plot range (-range:0.1:range)
% 
% OUTPUT
% xFinal      :   Solution vector which contains the last determined point
% 

% Initialization:
counter = 1;
[row,col] = size(x0);

% matrix    :  Solution matrix containing all iteration steps
matrix = zeros(size(x0,1),maxiter);
matrix(:,counter) = x0;

d = -StochasticGradient(fun, x0, h);

tic
% Loop for the gradient descent procedure
while tol < norm(d) && maxiter > counter
        
  matrix(:,counter+1) = matrix(:,counter) + alpha * d;
  d = -StochasticGradient(fun, matrix(:,counter+1), h);
  counter = counter + 1;
  
end
toc

xFinal = matrix(:,counter);


% Conditions for ploting the function/results:
if plt && row == 2

    PlotFunctions.FunctionPlots(fun, matrix, counter, range);
    
end


%  Termination criterion
if counter == maxiter
    counter
    xFinal
    tol
    Norm = norm(d)
    error('Iterations have exceeded the maxiter value!')
else
    disp('SGD completed!')
    counter
    Norm = norm(d)
end
    
end