function stabilite_syst(A)
    [Vecp, Valp] = eig(A); % Compute eigenvalues and eigenvectors

    State1 = 0; % Counter for positive real parts
    State2 = 0; % Counter for zero real parts
    n = length(A);
    Vp=zeros(n,1);

    % Check the real parts of the eigenvalues
    for i = 1:n
        Vp(i)=Valp(i, i);
        Re = real(Vp(i));
        if Re > 0
            State1 = State1 + 1;
        elseif Re == 0
            State2 = State2 + 1;
        end
    end

    % Determine the stability based on the eigenvalues
    if State1 == 0 && State2 == 0
        fprintf('Le système est stable et toutes les valeurs propres sont négatives.\n');
    elseif State1 == 0 && State2 ~= 0
        fprintf('Nous ne pouvons pas déterminer la stabilité du système, car il possède %d valeur(s) propre(s) nulle(s).\n', State2);
        fprintf('Le système possède %d valeur(s) propre(s) négative(s).\n', n - State2);
    else
        fprintf('Le système n est pas stable et possède %d valeur(s) propre(s) positive(s).\n', State1);
        fprintf('Le système possède %d valeur(s) propre(s) négative(s).\n', n - State2 - State1);
        fprintf('Le système possède %d valeur(s) propre(s) nulle(s).\n', State2);
    end
    
    damp(A)

end
