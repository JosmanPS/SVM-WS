function alpha = SVM_subproblem(alpha, ...
                                Y, ...
                                Q, ...
                                C, ...
                                B, ...
                                N, ...
                                tol);

%
%
%

%
% Construct the subproblem
%
H = Q(B, B);
Q_BN = Q(B, N);
f = (Q_BN * alpha(N) - 1)';

%
% Solve the QP problem
%
beq = - alpha(N)' * Y(N);
alpha_B = alpha(B);
n = length(alpha_B);
e = ones(n, 1);
options = optimoptions('quadprog',...
    'Algorithm','interior-point-convex','Display','off');
alpha_B = quadprog(H, f, [], [], Y(B)', ...
                   beq, 0*e, C*e, alpha_B, options);

alpha(B) = alpha_B;
