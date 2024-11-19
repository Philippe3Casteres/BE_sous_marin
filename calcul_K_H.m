function  [Result,K,H] = calcul_K_H(A, B, C, M,V, Lambda)

m = length(Lambda); % Get the number of elements in Lambda (row vector)

% Initialize matrices
Vresult = zeros(size(M, 1), m); % Initialize w to store M * z results as a matrix
w = zeros(2, m); % Initialize w to store M * z results as a matrix

for i = 1:m
    Nnew = N(A, B, M, Lambda(i)); % Compute N(A, B, Lambda(i))
    Ntronc = Nnew(3:4,:);
    z= Ntronc' * inv(Ntronc * Ntronc') * V(:,i); % Compute z
    Vresult(i,:) = Nnew * z; % Store the vector result in the i-th column of w 
    w(:,i) = M * z; % Store the vector result in the i-th column of w
end

Result=Vresult';

UB = inv(Result)*B ;
h1 = 1;
h3 = -UB(1,1)/UB(1,2);
h2 = 1;
h4 = -UB(4,1)/UB(4,2);

H = [h1, h2; h3, h4];

K = w * inv(Result);

end