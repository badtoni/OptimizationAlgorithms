function [ conf_opt ] = SimulatedAnnealingForGraph(graph, c, maxTries, maxKick, maxIter, plt)
% Name        : Simulated Annealing-Algorithm for the approximate solution of the 
%               Traveling Salesman problem additionally with temperature increase
% Application : Is applicable for a graph consisting of N nodes
%               z.B.: graph = [x1, x2, x3, x4, ... , xN;
%                              y1, y2, y3, y4, ... , yN];
% Conditions  : - The graph containing the nodes must not have nodes that occur twice!
% 
% INPUT
% graph     :   Matrix containing all nodes
% c         :   Cooling parameter (ca 0.9999)
% maxTries  :   Maximum number of trials without improvement (termination criterion)
% maxKick   :   Maximum number of failed attempts until kick (temperature increase)
% maxIter   :   Absolut maximum number of iterations for the algorithm (termination criterion)
% plt       :   Plot command if true is plotted
% 
% OUTPUT
% conf_opt  :   vector with indices related to the given graph, indicating the order of 
%               nodes used to create the minimum route length
% 

% Initialization:
[row,col] = size(graph);    
% In case the matrix is the wrong way round:
if row > col
   graph = transpose(graph);
end
% Size of the graph, col indicates the number of places, row the number of dimesnions
[row,col] = size(graph);

% Number of places
nOrte = col;
% Start order
S0      = randperm(nOrte); % Random permutation of the first N natural numbers

% Length of the start order
f(1)    = RouteLength(graph,S0);
f_opt   = f(1);

% Current optimal configuration (initially unknown, strong configuration)
conf_opt   = S0;

% Initialize cooling parameter
T(1)    = 0.5*f(1);

% 3 counting variables are needed
counterV = 0;       % Counter which counts the number of unsuccessful iterations (for abort!)
counter  = 2;       % Counter which counts the absolute number of successful iterations
counterK = 0;       % Counter which counts the number of iterations since the last kick resp. last improvement.

tic
while counterV < maxTries
    
    dum = randperm(nOrte);
    k1  = dum(1);
    k2  = dum(2);
    % k1 and k2 are swapped against each other
    
    % Generate the test configuration:
    S_test     = conf_opt;
    S_test(k2) = conf_opt(k1);
    S_test(k1) = conf_opt(k2);
    
    % Calculation of the path length of the test configuration
    f_test = RouteLength(graph,S_test);
    
    if f_test < f(counter-1) % Improvement
        
        % Accept the new configuration
        conf_opt      = S_test;
        f(counter) = f_test;
        f_opt      = f_test;
        
        % Set counter for no improvement back to zero
        counterV  = 0;
        counterK  = 0;
        
    else % No improvement
        
        % Accept the new (not better) configuration with certain probability
        
        p = exp(-((f_test)-f(counter-1)) / T(counter-1));
        
        if p > rand
            
            % Accept the new configuration
            conf_opt      = S_test;
            f(counter) = f_test;
            
        else
        
            % Configuration remains the old one
            f(counter) = f(counter-1);
            
            % Increment counter for no improvement
            counterV = counterV +1;
            counterK = counterK +1;
            
        end
        
    end
    
    if counterK < maxKick
    
        T(counter) = c * T(counter-1);
        
    else
        % Temperature increase
        T(counter) = 20 * T(counter-1);
        
        counterK  = 0;
        
    end
    
    % Increment counter for the number of iterations made
    counter = counter +1;
    
    % Absolute termination condition
    if counter > maxIter
        break
    end
    
end
toc

% If plot is desired:
if plt
    
    PlotFunctions.GraphPlots(graph, conf_opt, f, counter);

end

conf_opt
RouteLength(graph,conf_opt)

end

