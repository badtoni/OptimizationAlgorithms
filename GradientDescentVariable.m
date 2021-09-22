function [xFinal] = GradientDescentVariable (fun, x0, h, sigma, q, tol, maxiter, plt, range)
% Name:         Gradient descent with variable step size
% Application:  Is only applicable for scalar Functions of the form "fun = @(x) x(1)^2+x(2)^2"
% Conditions:   - The given toleranz must be less or equal to the step size!
%               - 
% 
% INPUT
% fun       :   Function which shall be optimized
% x0        :   Starting position, can be n-Dimensional
% h         :   Step size
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

% Controll:
if sigma < 0 || sigma > 1
     error('Parameter sigma: '+sigma+' liegt nicht zwischen 0 und 1!')
end
if q < 0 || q > 1
     error('Parameter q: '+q+' liegt nicht zwischen 0 und 1!')
end

% Initialization:
counter = 1;
[row,col] = size(x0);

% matrix    :  Solution matrix containing all iteration steps
matrix = zeros(size(x0,1),maxiter);
matrix(:,counter) = x0;
alphaA = 1;
d = -Gradient(fun, x0, h);

tic
% Loop for the gradient descent procedure
while tol < norm(alphaA * d) && maxiter > counter
  
  alphaA = ArmijoStepsize( fun, h, matrix(:,counter), sigma, q, d, maxiter);
  
  matrix(:,counter+1) = matrix(:,counter) + alphaA * d;
  d = -Gradient(fun, matrix(:,counter+1), h);
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
    Norm = norm(alphaA * d)
    error('Iterations have exceeded the maxiter value!')
else
    disp('Gradient descent completed!')
    counter
    Norm = norm(alphaA * d)
end
    
end
