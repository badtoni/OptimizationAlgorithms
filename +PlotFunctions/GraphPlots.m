function [ ] = GraphPlots( graph, conf_opt, lengths, counter )
% Creates a Graph plot with the optimal route, a plot with the minimal
% computed route length per time step (iteration)
% 
% Input:
% graph       :     Matrix containing all nodes
% conf_opt    :     Vector with indices related to the given graph, indicating the order of 
%                   nodes used to create the minimum route length
% lengths     :     Vector with the computed lengths per iteration
% counter     :     Number of iterations required
% 
% Output: None

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

close All;

figure(1)

% Plot the computed route lengths per iteration
plot(1:length(lengths),lengths)
xlabel('Iterations')
ylabel('Route Length')
grid on
box on
set(gca,'FontSize',14)

figure(2)

hold on

% Plot the graph points
for ii = 1:nOrte

    plot(graph(1,ii),graph(2,ii),'+k','LineWidth',2)

end

% Plot the optimal route
for ii = 1:nOrte-1

    line([graph(1,conf_opt(ii)),graph(1,conf_opt(ii+1))],[graph(2,conf_opt(ii)),graph(2,conf_opt(ii+1))],...
        'LineWidth',2,'Color','g')

end

line([graph(1,conf_opt(nOrte)),graph(1,conf_opt(1))],[graph(2,conf_opt(nOrte)),graph(2,conf_opt(1))],...
    'LineWidth',2,'Color','g')

hold off
axis equal
grid on
box on
xlabel('x')
ylabel('y')
title(['n = ' num2str(counter) ', Best route length = ' num2str(RouteLength(graph,conf_opt))])

end

