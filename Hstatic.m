function Hnew = Hstatic(A, B, C, K)
    % Combine A, B, and C into the M matrix
    M = [A, B; C, zeros(size(C, 1), size(B, 2))];
    
    % Compute the inverse of M
    omega = inv(M);
    
    % Extract the submatrices and compute Hnew
    Hnew = omega(1:size(A, 1), size(A, 2)+1:end) + K * omega(size(A, 1)+1:end, size(A, 2)+1:end);
end
