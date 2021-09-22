function out = normalMin(x)
% Normal minimum Function, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vektor x hat nicht die korrekte Anzahl von Elementen!');
end

out = @(x)x(1)^2+2*x(2)^2-2*x(1)+x(2)+1;

end