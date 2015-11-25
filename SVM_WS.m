function [ alpha ] = SVM_WS(X, ...
                            Y, ...
                            C, ...
                            n_pairs, ...
                            tol, ...
                            maxiter)

% -----------------------------------------------------
%
%     SVM with Working Set Selection
%
% -----------------------------------------------------

%
% INITIAL VALUES
%
[n, m] = size(X);
alpha = sparse(n, 1);
all_index = (1:n)';
sv_index = (alpha > tol);
n_sv = 0;
Q = diag(Y) * X * X' * diag(Y);
F = sum(alpha) - 0.5 * alpha' * Q * alpha;
g = ones(n, 1);
gY = g .* Y;
iter = 0;

%
% INITIAL WORKING SET
%
[B, gap] = working_set(alpha, Y, gY, C, n_pairs, tol);
N = setdiff(all_index, B);

fprintf(' iter        F          #SV        gap    \n');
fprintf('-------------------------------------------- \n');
fprintf(' %4i    %1.7e    %4i    %1.4e \n', ...
        iter, F, n_sv, gap);

%
% WHILE not optim
%
while gap > tol && iter < maxiter

    %
    % Solve subproblem
    %
    alpha = SVM_subproblem(alpha, Y, Q, C, B, N, tol);

    %
    % Update
    %
    sv_index = (alpha > tol);
    n_sv = full(sum(sv_index));
    F = sum(alpha) - 0.5 * alpha' * Q * alpha;
    g = 1 - Q * alpha;
    gY = g .* Y;

    iter = iter + 1;

    % 
    % WORKING SET
    %
    [B, gap] = working_set(alpha, Y, gY, C, n_pairs, tol);
    N = setdiff(all_index, B);

    fprintf(' %4i    %1.7e    %4i    %1.4e \n', ...
            iter, F, n_sv, gap);

end

end