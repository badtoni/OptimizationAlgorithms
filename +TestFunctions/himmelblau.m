function out = himmelblau(x)
% Himmelblau-Funktion, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vector x has not the correct dimensions!');
end

out = @(x)(x(1).^2+x(2)-11).^2+(x(1)+x(2).^2-7).^2;

end