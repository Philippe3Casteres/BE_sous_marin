function observabl_controlable(sys_knots, A_knots, speed)
    % Check controllability and observability
    contro = ctrb(sys_knots);
    obser = obsv(sys_knots);
    controlable = rank(contro);
    observable = rank(obser);
    
    % Display the ranks of the controllability and observability matrices
    fprintf('Le rang de la matrice contrôlable pour %d knots est : %d\n', speed, controlable);
    fprintf('Le rang de la matrice observable pour %d knots est : %d\n', speed, observable);
    
    % Check if the system is both controllable and observable
    if controlable == size(A_knots, 1) && observable == size(A_knots, 1)
        fprintf('Le système pour %d knots est observable et contrôlable.\n', speed);
    else
        fprintf('Le système pour %d knots n est pas observable ou contrôlable.\n', speed);
    end
end

