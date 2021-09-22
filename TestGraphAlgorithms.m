clc
clear "All";
format long; 

%/////////////////////////////////////////////////
%// Variables for the Metaheuristic Algorithms: //
%// =========================================== //
%/////////////////////////////////////////////////

% Absolut maximum number of iterations for the algorithms (termination criterion)
maxiter = 10.^5;
% Maximum number of trials without improvement (termination criterion)
maxTries = 10.^4;
% Maximum number of failed attempts until kick (temperature increase)
maxKick = 5000;
% Cooling parameter 
c = 0.9999;    %0.01;
% Weighting factor for the local pheromone concentration 
alpha = 0.8; %0.3 %1.5;
% Weighting factor for the local path length 
beta = 0.8; %0.3
% Coefficient for the pheromone decrease 
gama = 0.3; %0.6 %0.075;
% Number of ants
ants = 20;

% Randomly generate coordinates for the graph
orte_x = (b-a).*rand(ants,1) + a;
orte_y = (b-a).*rand(ants,1) + a;
aGraph = zeros(2,ants);
aGraph(1,:) = orte_x;
aGraph(2,:) = orte_y;



%/////////////////////////////////////////////////////
%// Graph applied Metaheuristic Algorithms to Test: //
%// =============================================== //
%/////////////////////////////////////////////////////

% AntAlgorithm(aGraph, ants, alpha, beta, gama, maxiter, true);
SimulatedAnnealingForGraph(aGraph, c, maxTries, maxKick, maxiter, true);






