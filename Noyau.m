function R=Noyau(Lambda, A, B)
[n, ~] = size(A);
Q=[Lambda*eye(n)-A, B];
R = null(Q);
end