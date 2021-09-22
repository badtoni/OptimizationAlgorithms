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



%/////////////////////////////////////////////////
%// Variables for the Metaheuristic Algorithms: //
%// =========================================== //
%/////////////////////////////////////////////////

% Tolerance
tol = 0.0001;
% Absolut maximum number of iterations for the algorithm (termination criterion)
maxiter = 10.^5;
% Maximum number of trials without improvement (termination criterion)
maxTries = 10.^4;
% Starting point x0
x0 = [-6; -3];
% Plotrange
range = 10;
% Cooling parameter 
c = 0.9999;    %0.01;
% Start Temperatur T0
T0 = 1;
% Parameter which defines how big the random movements of the fireflies shall be
alpha = 0.8; %0.3 %1.5;
% Attractivity parameter
gama = 0.3; %0.6 %0.075;
% Number of Fireflies to be set
fireflies = 200;
% Interval in which to search for the minimum
intervalX = [-8,8];
intervalY = [-8,8];



%////////////////////////////////////////////////////////////
%// On Functions applied Metaheuristic Algorithms to Test: //
%// ====================================================== //
%////////////////////////////////////////////////////////////

FireflyAlgorithm(fun2, fireflies, intervalX, intervalY, alpha, gama, maxiter, true)
% SimulatedAnnealing(fun9, x0, tol, intervalX, intervalY, T0, c, maxiter, maxTries, true, range)



