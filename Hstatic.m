function Hnew = Hstatic(A, B, C, K)
    % Combine A, B, and C into the M matrix
    M = [A, B; C, zeros(size(C, 1), size(B, 2))];
    
    % Compute the inverse of M
    omega = inv(M);
    
    % Extract the submatrices and compute Hnew
    Hnew = omega(5:6, 5:6) + K * omega(1:4, 5:6);
end
