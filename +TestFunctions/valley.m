function out = valley(x)
% Valley-Funktion, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vector x has not the correct dimensions!');
end

out = @(x)(x(1)-2)^2+4*(x(2)-3)^2;

end