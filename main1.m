clear all
close all
clc

% Define matrix values for 6 knots
a11_6 = -0.038006;
a12_6 = 0.89604;
a14_6 = 0.0014673;
a21_6 = 0.0017105;
a22_6 = -0.091676;
a24_6 = -0.0056095;
a34_6 = -3.0867;
b11_6 = -0.007542;
b12_6 = -0.022859;
b21_6 = 0.0017323;
b22_6 = -0.0022217;

% Define matrices A, B, C, and D for 6 knots
A_6knots = [a11_6, a12_6, 0, a14_6;
            a21_6, a22_6, 0, a24_6;
            1, 0, 0, a34_6;
            0, 1, 0, 0];

B_6knots = [b11_6, b12_6;
            b21_6, b22_6;
            0, 0;
            0, 0];

C_6knots = [0, 0, 1, 0;
            0, 0, 0, 1];

D_6knots = 0;

% Define matrix values for 30 knots
a11_30 = -0.19003;
a12_30 = 4.4802;
a14_30 = 0.0014673;
a21_30 = 0.0085526;
a22_30 = -0.45988;
a24_30 = -0.0056095;
a34_30 = -15.433;
b11_30 = -0.1855;
b12_30 = -0.57149;
b21_30 = 0.043308;
b22_30 = -0.055543;

% Define matrices A, B, C, and D for 30 knots
A_30knots = [a11_30, a12_30, 0, a14_30;
             a21_30, a22_30, 0, a24_30;
             1, 0, 0, a34_30;
             0, 1, 0, 0];

B_30knots = [b11_30, b12_30;
             b21_30, b22_30;
             0, 0;
             0, 0];

C_30knots = [0, 0, 1, 0;
             0, 0, 0, 1];

D_30knots = 0;

%%%%

M=1;
lambda1=-3/100;
lambda2=-3/80;
Lambda=[lambda1, lambda1*10, lambda2, lambda2*10 ];
V=[0, 0, 1 ,2 ; 1, 2, 0, 0];

% Create the state-space systems
sys_6knots = ss(A_6knots, B_6knots, C_6knots, D_6knots);
sys_30knots = ss(A_30knots, B_30knots, C_30knots, D_30knots);

[Vecp_6,Valp_6]=eig(A_6knots);
[Vecp_30,Valp_30]=eig(A_30knots);

%%%%coriger

[Vresult_6,K_6,H_6] = calcul_K_H(A_6knots, B_6knots, C_6knots, M,V, Lambda);
[Vecp_cor_6, Valp_cor_6]=eig(A_6knots-B_6knots*K_6);

[Vresult_30,K_30,H_30] = calcul_K_H(A_30knots, B_30knots, C_30knots, M,V, Lambda);
[Vecp_cor_30, Valp_cor_30]=eig(A_30knots-B_30knots*K_30);

A_cor_6knots=A_6knots-B_6knots*K_6;
B_cor_6knots=inv(Vresult_6)*B_6knots*H_6;
C_cor_6knots=C_6knots*Vresult_6;
D_cor_6knots=D_6knots;

A_cor_30knots=A_30knots-B_30knots*K_30;
B_cor_30knots=inv(Vresult_30)*B_30knots*H_30;
C_cor_30knots=C_30knots*Vresult_30;
D_cor_30knots=D_30knots;

sys_cor_6knots = ss(A_cor_6knots, B_cor_6knots, C_cor_6knots, D_cor_6knots);
sys_cor_30knots = ss(A_cor_30knots, B_cor_30knots, C_cor_30knots, D_cor_30knots);


%% 6 knots. 
% Check stability, controllability and observability for 6 knots
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n');
fprintf('%%%%%%%%%%%% Etude du système pour 6 knots %%%%%%%%%%%%.\n');
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n');

observabl_controlable(sys_6knots, A_6knots, 6);

stabilite_syst(A_6knots);

fprintf('répondre la question 3\n');

% Plot pole-zero maps for both systems
figure;
pzmap(sys_6knots);
title('Pole-Zero Map for 6 knots');
grid minor;

% Convert to transfer function and plot
FBO_6 = tf(sys_6knots);
fprintf('La fonction de transfert du système 6 knots :\n');
FBO_6


%% Alternatively, you can use step response
figure;
stepplot(FBO_6);
title('Step Response of the Transfer Function for 6 knots');
grid minor;

%commentaire
fprintf('Nous observons :\n');
fprintf('Les deux courbes du haut montrent que la position du sous-marin a un comportement linéaire car nous appliquons une tension en échelon.\n');
fprintf('Les deux courbes du bas montrent que l''angle du sous-marin est constant, car la position est linéaire.\n');

fprintf('répondre la question 5\n');
% Alternatively, you can use impulse response
figure;
impulse(FBO_6);
title('impulse Response of the Transfer Function for 6 knots');
grid minor;

%commentaire
fprintf('Nous observons :\n');
fprintf('Les deux courbes du haut montrent que la position du sous-marin suit un comportement en échelon, car nous appliquons une tension en impulsion.\n');
fprintf('Les deux courbes du bas montrent que l''angle du sous-marin oscille au début, puis tend vers 0. Cela s''explique par le fait que, une fois que le sous-marin atteint son niveau de mer souhaité, il se remet à plat.\n');

fprintf('répondre la question 5\n');

% Convert to transfer function and plot
FBO_cor_6 = tf(sys_cor_6knots);
fprintf('La fonction de transfert du système 6 knots :\n');
FBO_cor_6

%% Alternatively, you can use step response
figure;
stepplot(FBO_cor_6);
title('Step Response of the Transfer Function for 6 knots');
grid minor;

% Alternatively, you can use impulse response
figure;
impulse(FBO_cor_6);
title('impulse Response of the Transfer Function for 6 knots');
grid minor;



%% 30 knots.
% Check stability, controllability and observability for 30 knots
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n');
fprintf(' %%%%%%%%%%%% Etude du système pour 30 knots %%%%%%%%%%%%.\n');
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n');

observabl_controlable(sys_30knots, A_30knots, 30);

fprintf('répondre la question 3\n');

stabilite_syst(A_30knots);

% Plot pole-zero maps for both systems
figure;
pzmap(sys_30knots);
title('Pole-Zero Map for 30 knots');
grid minor;


% Convert to transfer function and plot
FBO_30 = tf(sys_30knots);
fprintf('La fonction de transfert du système 30 knots:\n');
FBO_30

% Alternatively, you can use step response
figure;
stepplot(FBO_30);
title('Step Response of the Transfer Function for 30 knots');
grid minor;

%commentaire
fprintf('Nous observons :\n');
fprintf('Les deux courbes du haut montrent que la position du sous-marin a un comportement linéaire car nous appliquons une tension en échelon.\n');
fprintf('Les deux courbes du bas montrent que l''angle du sous-marin est constant, car la position est linéaire.\n');

fprintf('répondre la question 5\n');
% Alternatively, you can use step response
figure;
impulse(FBO_30);
title('impulse Response of the Transfer Function for 30 knots');
grid minor;

fprintf('Nous observons :\n');
fprintf('Les deux courbes du haut montrent que la position du sous-marin suit un comportement en échelon, car nous appliquons une tension en impulsion.\n');
fprintf('Les deux courbes du bas montrent que l''angle du sous-marin oscille au début, puis tend vers 0. Cela s''explique par le fait que, une fois que le sous-marin atteint son niveau de mer souhaité, il se remet à plat.\n');
fprintf('répondre la question 5\n');


% Convert to transfer function and plot
FBO_cor_30 = tf(sys_cor_30knots);
fprintf('La fonction de transfert du système 6 knots :\n');
FBO_cor_30

%% Alternatively, you can use step response
figure;
stepplot(FBO_cor_30);
title('Step Response of the Transfer Function for 6 knots');
grid minor;

% Alternatively, you can use impulse response
figure;
impulse(FBO_cor_30);
title('impulse Response of the Transfer Function for 6 knots');
grid minor;

fprintf('répondre la question 4.1\n');
fprintf('répondre la question 5.1\n');
fprintf('C*V =\n');
fprintf('[ *, *, 0, 0; 0,0, *, *]');
fprintf('V =\n');
fprintf('[ *, *, *, *; *, *, *, *, *; *, *, 0, 0; 0,0, *, *]');
