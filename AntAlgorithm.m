function [ minRoute ] = AntAlgorithm(graph, ants, alpha, beta, gama, maxiter, plt)
% Name        : Ant Algorithm
% Application : Is applicable for a graph consisting of N nodes
%               e.g.: graph = [x1, x2, x3, x4, ... , xN;
%                              y1, y2, y3, y4, ... , yN];
% Conditions  : - The graph containing the nodes must not have nodes that occur twice!
%               - The number of Nodes must be equal to the number of ants!
% 
% INPUT
% graph       :     Matrix containing all nodes
% ants        :     Number of ants
% alpha       :     Weighting factor for the local pheromone concentration (alpha < 1)
% beta        :     Weighting factor for the local path length (beta < 1)
% gama        :     Coefficient for the pheromone decrease (gama << 1)
% maxiter     :     Maximum number of iterations for the algorithm
% plt         :     Plot command if true is plotted
%
% OUTPUT
% minRoute    :     vector with indices related to the given graph, indicating the order of 
%                   nodes used to create the minimum route length
% 

% Initialization:
[row,col] = size(graph);    
% In case the matrix is upside down:
if row > col
   graph = transpose(graph);
end
% Size of the graph, col indicates the number of nodes, row the number of dimesnions
[row,col] = size(graph);
minRouteLength = 100000000;
    
% Matrix indicating the concentration of pheromone on all lines:
pheromon = ones(col, col);      
pheromon = pheromon - diag(diag(pheromon));

% Matrix containing the length of each route:
laengen = zeros(col, col); 
for p = 1:col
   for s = 1:col
       if p ~= s
           % Fuer n-D noch anwendbar machen!
           laengen(p,s) = ((graph(1,p) - graph(1,s))^2 + (graph(2,p) - graph(2,s))^2)^(1/2);
       end
   end
end

% Here at the end of each time step iteration the route lengths are stored:
routenLaenge = zeros(ants,maxiter);
minRouteLengths = zeros(maxiter);

%//////////////////////////////
%// START OF THE ITERATIONS: //
%// ======================== //
%//////////////////////////////

tic
% Loop for the time steps:
% In each time step the ants must visit all col-1 nodes.!
for n = 1:maxiter
%     n
    % If number of ants and nodes is equal, one ant is placed at each node:
    if ants == col
        % Matrix routes indicating the starting point, the visited and the yet to be visited points of each ant: 
        
        % routen(:,:,1):
        % Tells which nodes have been visited (=1) and which have not been visited yet (=0).
        
        % routen(:,:2):
        % Indicates the order in which the ant traverses its route (indices).
        
        % routen(:,:3):
        % Tells in which node the respective ant is located (=1)
        
        routen = ones(col, col);
        routen = diag(diag(routen));
        for k = 1:col
            routen(k,1,2) = find(routen(k,:,1));
        end
        routen(:,:,3) = routen(:,:,1);

    % If the number of ants and nodes is not equal, the ants are set randomly.:
    else
        % Matrix that indicates the starting point, the visited points and the points still to be visited by each ant.: 

        % Positions of the ants
        % Kontrolle!!!
        routen(1,:) = randi([1 col],1, ants,'single');

    end
    
    % Pheromone decrease per time step:
    if n ~= 1
        pheromon = (1 - gama).*pheromon;
    end
    
    % loop that goes through all N - 1 nodes:
    for i = 1:col-1
        
        % Loop that goes through all ants:
        for a = 1:ants
            
            % Indices of the nodes not yet visited:
            knotenNichtBesucht = find(routen(a,:,1) == 0);
            % Indices of visited nodes:
            knotenBesucht = find(routen(a,:,1));
            % Indices of the current node:
            momentanKnoten = find(routen(a,:,3));
            
            % Initialization of the vector attractiveness
            attraktivitaet = [];
            attraktivitaet = zeros(1,length(knotenNichtBesucht));
            
            % Determination of attractivities/probabilities for each not yet visited node:
            for b = 1:length(knotenNichtBesucht)
                attraktivitaet(b) = ((pheromon(momentanKnoten,knotenNichtBesucht(b)))^(alpha)) * ((laengen(momentanKnoten,knotenNichtBesucht(b)))^(-beta));
            end
            sumAttraktiv = 0;
            for s = 1:length(attraktivitaet)
                sumAttraktiv = sumAttraktiv + attraktivitaet(s);
            end
            attraktivitaet = attraktivitaet./sumAttraktiv.* 100;
            attraktivitaet = round(attraktivitaet);
            
            % Creation of the 'probability' vector:
            % probVector is filled with a certain number of the unvisited nodes indices
            probVektor = [];
            for p = 1:length(attraktivitaet)
                if p == 1
                    probVektor = (ones(1,attraktivitaet(p)) * knotenNichtBesucht(p))';
                else
                    probVektor = [probVektor; (ones(1,attraktivitaet(p)) * knotenNichtBesucht(p))'];
                end
            end
            
            % Selection of the node to which the ant now goes:
            naechsterKnoten = datasample(probVektor, 1);         %Indice
            
            % Actuallization of the route:
            routen(a, naechsterKnoten, 1) = 1;
            routen(a, i + 1, 2) = naechsterKnoten;
            routen(a, naechsterKnoten, 3) = 1;
            routen(a, momentanKnoten, 3) = 0;
            
            % Actuallization of the pheromene:
            pheromon(i,naechsterKnoten) = pheromon(i,naechsterKnoten) + laengen(i,naechsterKnoten)^(-1);
            pheromon(naechsterKnoten,i) = pheromon(i,naechsterKnoten) + laengen(i,naechsterKnoten)^(-1);
            
            
        end
     
    end
    
    % Save all route lengths from this time step:
    for r = 1:ants
        routenLaenge(r,n) = RouteLength(graph, routen(r,:,2));
        % Determination of the minimum:
        if routenLaenge(r,n) < minRouteLength
            minRouteLength = routenLaenge(r,n);
            iteration = n;
            minRoute = routen(r,:,2);
        end
    end
    minRouteLengths(n) = min(routenLaenge(:,n));
    
end
toc

% If plot is desired:
if plt
    
    PlotFunctions.GraphPlots(graph, minRoute, minRouteLengths, iteration);

    
%     close all
%     
%     figure(1)
% 
%     plot(1:length(minRouteLengths),minRouteLengths)
%     xlabel('Iterations')
%     ylabel('Route Length')
%     grid on
%     box on
%     set(gca,'FontSize',14)
%     
%     % Best route from all iterations:
%     figure(2)
%     hold on
% 
%     % Plot the nodes:
%     for ii = 1:length(graph)
% 
%         plot(graph(1,ii),graph(2,ii),'+k','LineWidth',2)
% 
%     end
%     
% %     % Draw all routes from this time step:
% %     for aa = 1:ants
% % 
% %         for ii = 1:length(graph)
% %             if ii ~= length(graph)
% %                line([graph(1,routen(aa,ii,2)),graph(1,routen(aa,ii+1,2))],...
% %                     [graph(2,routen(aa,ii,2)),graph(2,routen(aa,ii+1,2))])
% %             else
% %                 line([graph(1,routen(aa,ii,2)),graph(1,routen(aa,1,2))],...
% %                     [graph(2,routen(aa,ii,2)),graph(2,routen(aa,1,2))])
% %             end
% %         end
% % 
% %     end
%     
%     % Draw the smallest route from this time step:
%     for ii = 1:length(graph)
%         if ii ~= length(graph)
%              line([graph(1,minRoute(ii)),graph(1,minRoute(ii+1))],...
%                  [graph(2,minRoute(ii)),graph(2,minRoute(ii+1))],...
%                  'Color','g','LineWidth',2)
%         else
%              line([graph(1,minRoute(ii)),graph(1,minRoute(1))],...
%                  [graph(2,minRoute(ii)),graph(2,minRoute(1))],...
%                  'Color','g','LineWidth',2)
%         end
%     end
%     
%     hold off
%     axis equal
%     grid on
%     box on
%     xlabel('x')
%     ylabel('y')
%     title(['n = ' num2str(iteration) ', Best route length = ' num2str(minRouteLength)])

end
    
minRoute
minRouteLength
iteration

end