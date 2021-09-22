function [ minimum ] = FireflyAlgorithm(fun, Nfireflies, intervalX, intervalY, alpha, gama, maxiter, plt)
% Name        :  Firefly Algorithm
% Application :  Is applicable for functions which are 2-D and of the Form: "fun = @(x) x(1)^2+x(2)^2"
% Conditions  :    
% 
% INPUT
% fun         :     Function which shall be optimized
% Nfireflies  :     Number of fireflies which shall be placed
%                   Das Intervall muss zur Funktion fun passen!
% intervalX   :     Interval along the X axis e.g.: (-2, 2) in which the minimum is searched for
% intervalY   :     Interval along the Y axis e.g.: (-2, 2) in which the minimum is searched for
% alpha       :     Parameter which defines how big the random movements of the fireflies shall be
% gama        :     Attractivity parameter 
% maxIter     :     Max number of Iterations (Termination criterion)
% plt         :     Plot-Command if true results will be plotted
%
% OUTPUT
% minimum     :     Vector with the coordinates (x1,y1) which is the local minimum 

% Initialization:

% Intervall
aX = intervalX(1);
bX = intervalX(2);
aY = intervalY(1);
bY = intervalY(2);

% Randomly generate locations for the fireflies
orte_x = (bX-aX).*rand(Nfireflies,1) + aX;
orte_y = (bY-aY).*rand(Nfireflies,1) + aY;
% Matrix which gives the number of fireflies and their their position 
% e.g.: [x1, x2, x3, x4, ... , xN;
%        y1, y2, y3, y4, ... , yN];
fireflies = zeros(2,Nfireflies);
fireflies(1,:) = orte_x;
fireflies(2,:) = orte_y;

[row,col] = size(fireflies);    
% In case the matrix is upside down:
if row > col
   fireflies = transpose(fireflies);
end
% Size of the firefly graph, col indicates the number of nodes, row the number of dimesnions
[row,col] = size(fireflies);


% Record of the locations of all fireflies in the course of the iterations:
xPosGW      = zeros(col,maxiter+1);
xPosGW(:,1) = fireflies(1,:);
yPosGW      = zeros(col,maxiter+1);
yPosGW(:,1) = fireflies(2,:);

% Prepare the function if plot is desired:
if plt
    x = intervalX(1):0.1:intervalX(2);
    y = intervalY(1):0.1:intervalY(2);
    [X,Y] = meshgrid(x,y);
    [n,m] = size(X);
    Z = zeros(n,m);
    
    % Loop for the Plot:
    for row = 1:n
        for  colum = 1:m
            v = [X(row,colum);Y(row,colum)];
            Z(row,colum) = fun(v);
        end
    end
end

%//////////////////////////////
%// START OF THE ITERATIONS: //
%// ======================== //
%//////////////////////////////

% Loop for the time steps:
for n = 1:maxiter
    
    % Loop for the fireflies:
    for firefly1 = 1:col
        
        % Vector in which the brightness of each firefly is written:
        helligkeit = zeros(1,col);
        % Vector containing the distance from firefly1 to all other fireflies:
        abstand = zeros(1,col);
        
        % Loop fo the fireflies:
        for firefly2 = 1:col
            
            % Distance from firefly1 to firefly2 is determined and stored:
            abstand(firefly2) = sqrt((xPosGW(firefly2,n)-xPosGW(firefly1,n))^2+(yPosGW(firefly2,n)-yPosGW(firefly1,n))^2);
            
            % Brightness of firefly2 at the place where it is at the moment:
            I0 = -feval(fun,[xPosGW(firefly2,n),yPosGW(firefly2,n)]);
            
            % Taking into account that the perceived brightness decreases with distance:
            helligkeit(firefly2) = I0 / (1 + gama * abstand(firefly2)^2);
            
        end
        
        % Determination of the brightest firefly:
        [maxGW, index] = max(helligkeit);
        
        % If firefly2 itself is the brightest, then it does not get a defined movement direction vector, otherwise
        if index ~= firefly1
            
            % Direction of movement:
            diffVektor = [xPosGW(index,n)-xPosGW(firefly1,n),yPosGW(index,n)-yPosGW(firefly1,n)];
            
            % Brightness ratio of the brightest firefly to firefly1:
            dHell = (helligkeit(index)-helligkeit(firefly1))/helligkeit(firefly1);
            
            % Starting function for the determination of the step size:
            d = dHell^2 / (1 + dHell^2);
            
        else
            diffVektor = [0 0];
            d   = 0;
        end
        
        % Movement:
        xPosGW(firefly1,n+1) = xPosGW(firefly1,n) + d * diffVektor(1) + alpha * 2 * (rand - 0.5);
        yPosGW(firefly1,n+1) = yPosGW(firefly1,n) + d * diffVektor(2) + alpha * 2 * (rand - 0.5);
        
    end
    
    
    xBest = xPosGW(index,n);
    yBest = yPosGW(index,n);
    
    minimum = [xBest; yBest];
    
    % If plot is desired:
    if plt
    
        xMean = mean(xPosGW(:,n));
        yMean = mean(yPosGW(:,n));
    
        figure (1)
                
        pcolor(X,Y,Z)
        shading flat
        hold on
        plot(xPosGW(:,n),yPosGW(:,n),'.y','MarkerSize',10)
        axis equal
        xlabel('x')
        ylabel('y')
        title(['iter = ' num2str(n) ', (x_{m},y_{m}) = (' num2str(xMean) ',' num2str(yMean) '), (x_{opt},y_{opt}) = (' num2str(xBest) ',' num2str(yBest) ')'])
        drawnow
        hold off
    end
%     pause(0.5)
end



end

