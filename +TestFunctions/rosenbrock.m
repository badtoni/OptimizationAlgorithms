function out = rosenbrock(x)
% Rosenbrock-Function, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vector x has not the correct dimensions!');
end

out = @(x)100*(x(2)-x(1).^2).^2+(1-x(1)).^2;

end