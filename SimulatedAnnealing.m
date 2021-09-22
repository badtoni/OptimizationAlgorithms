function [ x_best ] = SimulatedAnnealing(fun, x0, tol, intervalX, intervalY, T0, c, maxIter, maxTries, plt, range)
% Name:         Simulated Annealing Procedure
% Application:  Is only applicable for scalar Functions of the form "fun = @(x) x(1)^2+x(2)^2"
% Conditions:   - 
% 
% INPUT
% fun       :   Function which shall be optimized
% x0        :   Starting position, can be n-Dimensional
% tol       :   Tolerance (Termination criterion) 0 < tol << 1
% intervalX :   Interval along the X axis e.g.: (-2, 2) in which the minimum is searched
% intervalY :   Interval along the Y axis e.g.: (-2, 2) in which the minimum is searched
% T0        :   Starting Temperature
% c         :   Cooling parameter 0 < c < 1
% maxIter   :   Max number of Iterations (Termination criterion)
% maxTries  :   Maximum number of trials without improvement (Termination criterion)
% plt       :   Plot-Command if true results will be plotted
% range     :   Scalar which defines the plot range (-range:0.1:range)
% 
% OUTPUT
% x_best    :   Solution vector which contains the last determined point
% 

% Initialize count variables
counter = 1; % Iterations
counterV  = 0; % Trials whithout improvement;

% Temperature initialization
T(1)   = T0;

% Initializatioon of best current value
f_best = feval(fun,x0);
x_best = x0;

% Initialize function values along iteration path:
f(1)   = f_best;

% Initialize path
x(:,1) = x_best;

% Termination criterion
T_min = tol; % Minimal Temperature;

% Starting the iteration process:
while (T(counter) >= T_min && counterV < maxTries && counter < maxIter)
    
    % randomly select new point:
    phi_MC = 2 * pi * rand;
    r_MC   = abs(randn);
    x_test = x(:,counter) + [r_MC * cos(phi_MC);r_MC * sin(phi_MC)];
    
    % first check if the new point is in the allowed range:
    if (x_test(1) >= intervalX(1) && x_test(1) <= intervalX(2) && x_test(2) >= intervalY(1) && x_test(2) <= intervalY(2))
        
        f_test = feval(fun,x_test);
        
        if f_test < f_best
            
            % new point has smaller function value: accept!
            
            x(:,counter+1) = x_test;
            f(counter+1)   = f_test;
            f_best   = f_test;
            x_best   = x_test;
            
            % set counter for no improvement back to zero.
            counterV    = 0;
            
        else
            
            % no improvement. check if the worse function value is not accepted anyway
            p = exp(-(f_test - f(counter)) / T(counter));
            
            if p > rand
                
                x(:,counter+1) = x_test;
                f(counter+1)   = f_test;
                
            else
                
                % keep old point.
                
                x(:,counter+1) = x(:,counter);
                f(counter+1)   = f(counter);
                
                counterV = counterV + 1;
                
            end
            
            
        end
        
        T(counter+1) = T(counter) / (1 + c * T(counter));
        
        counter = counter + 1;
        
    end

end

% Conditions for ploting the function/results:
if plt
    
    x1 = -range:0.2:range;
    [X,Y] = meshgrid(x1,x1);
    [n,m] = size(X);
    Z = zeros(n,m);

    % Loop for the Plot:
    for row = 1:n
        for  colum = 1:m
            v = [X(row,colum);Y(row,colum)];
            Z(row,colum) = fun(v);

        end
    end
    
    close All;
    
    figure (1)
    surf(X,Y,Z)
    
    figure (2)
    contour(X,Y,Z,20)
    
    hold on

    plot(x(1,:),x(2,:),'.k')

    plot(x_best(1),x_best(2),'dg','LineWidth',2,'MarkerSize',10,'MarkerFaceColor','m')

    hold off

    grid on

    box on

    axis equal

    xlabel('x')
    ylabel('y')

    title(['x_{opt.} = (' num2str(x_best(1)) ',' num2str(x_best(2)) '), f(x_{opt}) = ' num2str(f_best)])

    legend('f(x_1,x_2)', [num2str(counter) ' Iterationen'], 'x_{opt}','Location','best')

    set(gca,'FontSize',14)
    
end

%  Termination criterion
if counter == maxIter
    counter
    x_best
    T_min
    T = T(counter)
    error('Iterations have exceeded the maxiter value!')
else
    disp('Simulated Annealing completed!')
    counter
    T = T(counter)
end

end

