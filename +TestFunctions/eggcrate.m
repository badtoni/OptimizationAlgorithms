function out = eggcrate(x)
% Eggcrate-Funktion, is used to test algorithms!

[row,col] = size(x);
if (row > 2 || row <= 1) && col ~= 1
    error('The Vector x has not the correct dimensions!');
end

out = @(x)x(1).^2+x(2).^2+25.*(sin(x(1)).^2)+25.*(sin(x(2)).^2);

end