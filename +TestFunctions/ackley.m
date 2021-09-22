function out = ackley(x)
% Ackley-Funktion, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vector x has not the correct dimensions!');
end

out = @(x)-20.*exp(-0.2.*sqrt(0.5.*(x(1).^2+x(2).^2)))-exp(0.5.*(cos(2.*pi.*x(1))+cos(2.*pi.*x(2))))+20+exp(1);

end