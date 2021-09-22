clc
clear All
format long 

%//////////////////////////////////////////////////
%// Variables for the Gradient based Algorithms: //
%// ============================================ //
%//////////////////////////////////////////////////

% Step size
h = 0.0001;
% Tolerance
tol = 0.0001;
% Absolut maximum number of iterations for the algorithm (termination criterion)
maxiter = 10.^5;
% Starting point x0
x0 = [-6; -3];
% Step size damping
d = 0.0001;
% Experience-Parameter for the variable step size 
sigma = 0.5;
% Experience-Parameter for the variable step size 
q = 0.6;
% Experience-Parameter 
delta = 0.5;
% Experience-Parameter 
ro = 0.9;



%////////////////////////////////////////////
%// Functions to test the Algorithms with: //
%// ====================================== //
%////////////////////////////////////////////

fun1 = TestFunctions.rosenbrock(x0);
fun2 = TestFunctions.himmelblau(x0);
fun4 = TestFunctions.normalMin(x0);
fun5 = TestFunctions.saddle(x0);
fun6 = TestFunctions.valley(x0);
fun7 = TestFunctions.towel(x0);
fun8 = TestFunctions.eggcrate(x0);
fun9 = TestFunctions.ackley(x0);



%////////////////////////////////////////
%// Gradient based Algorithms to Test: //
%// ================================== //
%////////////////////////////////////////

SGD(fun4, x0, h, d, tol, maxiter, true, range)
% GradientDescentVariable(fun3, x0, h, sigma, q, tol, maxiter, true, range)
% NewtonProcedure(fun7, x0, h, tol, maxiter, true, range)
% NewtonProcedureSubdued(fun7, x0, h, sigma, q, tol, maxiter, true, range)
% NewtonProcedureSimplified(fun7, x0, h, tol, maxiter, true, range)
% NewtonProcedureGlobal(fun4, x0, h, delta, ro, sigma, q, tol, maxiter, true, range)





