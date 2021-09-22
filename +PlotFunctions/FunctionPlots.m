function [ ] = FunctionPlots( fun, matrix, counter, range )
% Creates a 3D plot, a countour plot with tha iteration steps and a bar plot with the iterations step length
% 
% Input:
% fun       : Scalar Function of R^n -> R
% matrix    : Solution matrix containing all iteration steps
% counter   : Number of iterations required
% range     : Scalar which defines the plot range (-range:0.1:range)
% bar       : Bar Plot-Command if true results will be plotted
% 
% Output: None

xFinal = matrix(:,counter);

x1 = -range:0.1:range;
[X,Y] = meshgrid(x1,x1);
[n,m] = size(X);
Z = zeros(n,m);

% Loop for the plot:
for row = 1:n
    for  colum = 1:m

        v = [X(row,colum);Y(row,colum)];
        Z(row,colum) = fun(v);

    end
end

close All;

% Plot the function in 3D
figure (1)
surf(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')

% Plot the function countours and the iterations the algorithm computed
figure (2)
contour(X,Y,Z,20)

hold on
plot(matrix(1,1:(counter-1)),matrix(2,1:(counter-1)),'-og')
plot(matrix(1,counter-1:counter),matrix(2,counter-1:counter),'-or')
hold off

grid on
box on
axis equal
ylim([-range range])
xlim([-range range])

xlabel('x')
ylabel('y')

title(['x_{opt.} = (' num2str(xFinal(1)) ',' num2str(xFinal(2)) '), f(x_{opt}) = ' num2str(fun(xFinal))])

legend('f(x_1,x_2)', [num2str(counter) ' Iterations'], 'x_{opt}','Location','best')

set(gca,'FontSize',14)


% Plot the distance which each iteration step took
lengths = zeros(counter-1,1);
for i = 2:counter
    lengths(i) = ((matrix(1,i-1)-matrix(1,i))^2+(matrix(2,i-1)-matrix(2,i))^2)^0.5;
end
figure (3)
bar(lengths)
% m = max(lengths);
% ylim([0 m])
xlabel('Iterations')
ylabel('Distance')


end

