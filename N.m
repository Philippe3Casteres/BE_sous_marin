function N1 = N(A, B, lambda)
    [n, ~] = size(A); % Get the number of rows and columns of A
    N1 = -inv(lambda * eye(n) - A) * B; % Calculate the result
end
