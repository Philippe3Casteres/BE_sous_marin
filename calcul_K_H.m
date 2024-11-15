function [K, H] = calcul_K_H(A, B, C, M, Lambda)

m = length(Lambda); % Get the number of elements in Lambda (row vector)
V = inv(C); % Compute the inverse of C

% Initialize matrices
w = zeros(size(M, 1), m); % Initialize w to store M * z results as a matrix
CVep = zeros(size(C, 1), m); % To store C * Vecp values

for i = 1:m
    Vecp = V(:, i); % Get the i-th column of V
    Nnew = N(A, B, Lambda(i)); % Compute N(A, B, Lambda(i))
    
    % Check if Nnew is invertible
    if rank(Nnew) < size(Nnew, 1)
        error('Matrix Nnew is singular and cannot be inverted.');
    end
    
    z = inv(Nnew) * Vecp; % Compute z
    w(i,:) = M * z; % Store the vector result in the i-th column of w
    CVep(i,:) = C * Vecp; % Store C * Vecp in the i-th column of CVep
end

% Calculate K and H
K = w.'* inv(CVep); % Use the pseudo-inverse for safety in case CVep is singular
H = pinv(B) * V; % Use pseudo-inverse to avoid issues if B is singular

end