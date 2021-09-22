function [ routeLength ] = RouteLength( graph, route )
% Name        : Route length (Determines the path length based on the given route)
% Application : Applicable for a graph consisting of N nodes
%               e.g.: graph = [x1, x2, x3, x4, ... , xN;
%                              y1, y2, y3, y4, ... , yN;
%                              ...                     ];
% Conditions  :    
% 
% INPUT
% graph       :   Matrix containing all nodes
% route       :   Vector containing a specific order of the graph indices
%
% OUTPUT
% routeLength :   Total length of the route
% 

% Check if the dimensions are equal:
if length(graph(1,:)) ~= length(route)
    msg = 'Graphenlaenge ist nicht gleich mit den Routenlaenge';
    error(msg)
end

routeLength = 0;
% Determine the total length based on the order of the route:
for i = 1:length(route)
    
    if i ~= length(route)
        routeLength = routeLength + ((graph(1,route(i+1)) - graph(1,route(i)))^2 + (graph(2,route(i+1)) - graph(2,route(i)))^2)^(1/2);
    else
        routeLength = routeLength + ((graph(1,route(1)) - graph(1,route(i)))^2 + (graph(2,route(1)) - graph(2,route(i)))^2)^(1/2);
    end
end


end

