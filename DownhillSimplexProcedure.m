function [ schwerpunkt ] = DownhillSimplexProcedure(fun, startsimplex, alpha, beta, gamma, tol, maxiter, plt, range)
% Name        :    Downhill-Simplex Procedure from Nelder and Mead
% Application :    Can be used for any function (it does not have to be differentiable).
% Conditions  :     - Procedure has not been tested for 4-D or higher dimensions!
% 
% INPUT
% fun         :     Function which shall be optimized
% startsimplex:     Matrix containing the three first starting points
%                   startsimplex = [[x1;y1],[x2;y2],[x3;y3]]
% alpha       :     Experience-Parameter (ca 1)
% gamma       :     Experience-Paramete (ca 1.5)
% beta        :     Experience-Parameter (ca 0.3)
% tol         :     Tolerance (Termination criterion)
% maxiter     :     Max number of Iterations (Termination criterion)
% plt         :     Plot-Command if true results will be plotted
% range       :     Scalar that specifies the plot range: -range:0.5:range
%
% OUTPUT
% schwerpunkt :     Solution vector containing the last determined point
% 

% Startsimplex
simplex(:,:,1) = startsimplex; % The third dimension for the iteration steps

% Count variable
counter = 1;

% Termination criterion
abr = 1;

% Start of the iterations:
while abr > tol && counter <= maxiter

    % Calculation of the function values at all vertices:
    eckpunkt1 = [simplex(1,1,counter),simplex(2,1,counter)];
    eckpunkt2 = [simplex(1,2,counter),simplex(2,2,counter)];
    eckpunkt3 = [simplex(1,3,counter),simplex(2,3,counter)];
    funktionswerte = [fun(eckpunkt1);...
                      fun(eckpunkt2);...
                      fun(eckpunkt3)];

    % TEsting the termination criterion:
    meanf          = mean(funktionswerte);
    abr            = norm(funktionswerte-meanf.*[1;1;1],2);
    
    % Sorting the indices of the vertices in ascending order of the function values:
    sortierte      = sortrows([funktionswerte,[1;2;3]]);
    % In the first column of "sortierte" are the function values and in the second column the indes of the corner point
    
    % Calculate the centroid of all vertices without the worst one:
    schwerpunkt    = (1/2)*(simplex(:,sortierte(1,2),counter) + ...
        simplex(:,sortierte(2,2),counter));

    % Calculate the reflected point:
    reflektiert    = schwerpunkt + ...
        alpha*(schwerpunkt - simplex(:,sortierte(3,2),counter));
    
    % Function value at the reflected point:
    f_reflektiert  = fun(reflektiert);

    % Case distinction:
    if f_reflektiert < sortierte(1,1)
        % The function value f_r is smaller than the one at xi_1
        
%         disp(['i = ' num2str(counter) ': Expansion?'])

        expandiert   = schwerpunkt + beta*(reflektiert - schwerpunkt);

        f_expandiert = fun(expandiert);

        if f_expandiert < f_reflektiert

            simplex(:,:,counter+1) = [simplex(:,sortierte(1,2),counter),...
                simplex(:,sortierte(2,2),counter),expandiert];
            
%             disp(['        : Expansion!'])

        else

            simplex(:,:,counter+1) = [simplex(:,sortierte(1,2),counter),...
                simplex(:,sortierte(2,2),counter),reflektiert];
            
%             disp(['i =        : Reflektion!'])

        end

    elseif f_reflektiert <= sortierte(2,1)
        % The function value at xi_r is larger than that at xi_1 but smaller than the function value at xi_n
        
%         disp(['i = ' num2str(counter) ': Reflektion!'])

        simplex(:,:,counter+1) = [simplex(:,sortierte(1,2),counter),...
            simplex(:,sortierte(2,2),counter),reflektiert];

    else
        % The function value f_r is greater than that at xi_n
        
        if f_reflektiert <= sortierte(3,1)
            % The function value is smaller than that at xi_(n+1)

            kontrahiert = schwerpunkt + gamma*(reflektiert - schwerpunkt);

        else
            % The function value is greater than that at xi_(n+1)

            kontrahiert = schwerpunkt + ...
                gamma*(simplex(:,sortierte(3,2),counter) - schwerpunkt);

        end

        f_kontrahiert = fun(kontrahiert);

        if f_kontrahiert < min(max(funktionswerte),f_reflektiert)
            
%             disp(['i = ' num2str(counter) ': Kontraktion (1)!'])

            simplex(:,:,counter+1) = [simplex(:,sortierte(1,2),counter),...
                simplex(:,sortierte(2,2),counter),kontrahiert];

        else
            
%             disp(['i = ' num2str(counter) ': Kontraktion (2)!'])

            simplex(:,:,counter+1) = [simplex(:,sortierte(1,2),counter),...
                0.5*(simplex(:,sortierte(1,2),counter)+simplex(:,sortierte(2,2),counter)),...
                0.5*(simplex(:,sortierte(1,2),counter)+simplex(:,sortierte(3,2),counter))];

        end

    end

    counter = counter+1;
    
end

% Condition that function is plotted:
if plt
    
    x1 = -range:0.5:range;
    x2 = -range:0.5:range;
    [X,Y] = meshgrid(x1,x2);
    [n,m] = size(X);
    Z = zeros(n,m);

    % Loop for the plot:
    for row = 1:n
        for  colum = 1:m

            v = [X(row,colum);Y(row,colum)];
            Z(row,colum) = fun(v);

        end
    end
    
    figure(1)

%     contour(X,Y,Z,51,'LineWidth',2)
    contour(X,Y,Z,20)

    
    hold on

    for p = 1:size(simplex,3)

        plotsimplex = [simplex(:,:,p),simplex(:,1,p)];

        line(plotsimplex(1,:),plotsimplex(2,:),'LineWidth',2,'Color','k')

    end

    hold off

    axis equal

    grid on
    box on

    xlabel('x')

    ylabel('y')
    
    title(['x_{opt.} = (' num2str(schwerpunkt(1)) ',' num2str(schwerpunkt(2)) '), f(x_{opt}) = ' num2str(fun(schwerpunkt))])

    legend('f(x_1,x_2)', [num2str(counter) ' Iterations'], 'x_{opt}','Location','best')

    set(gca,'FontSize',14)
    
end

%  Termination criterion
if counter == maxiter
    counter
    schwerpunkt
    tol
    abr
    error('Iterations have exceeded the maxiter value!')
else
    disp('Downhil Simplex procedure completed!')
    counter
    abr
end

end

