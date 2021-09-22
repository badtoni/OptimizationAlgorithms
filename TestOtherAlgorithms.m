clc
clear All
format long 

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



%/////////////////////////////////////
%// Variables for other Algorithms: //
%// =============================== //
%/////////////////////////////////////

% Tolerance
tol = 0.0001;
% Absolut maximum number of iterations for the algorithm (termination criterion)
maxiter = 10.^5;
% Plotrange
range = 10;
% Variable alpha
alpha = 0.8;
% Variable beta
beta = 0.8;
% Variable gama
gama = 0.3;
% Startsimplex
startsimplex = [[-2;-1],[-5;-5],[-5;-8]];



%///////////////////////////////
%// Other Algorithms to Test: //
%// ========================= //
%///////////////////////////////

DownhillSimplexProcedure(fun4, startsimplex, alpha, beta, gama, tol, maxiter, true, range)





