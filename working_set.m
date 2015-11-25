function [ B, gap ] = working_set(alpha, ...
                                  Y, ...
                                  Yg, ...
                                  C, ...
                                  n_pairs, ...
                                  tol)

%
%
%

%
% Create index
%
error_C = C - alpha;

I_1 = find(Y > 0 & error_C > tol);
I_2 = find(Y < 0 & alpha > tol);
I = union(I_1, I_2);

J_1 = find(Y > 0 & alpha > tol);
J_2 = find(Y < 0 & error_C > tol);
J = union(J_1, J_2);

%
% Most violating pairs
% Keerti and Gilbert (2002)
%
B_1 = Yg(I);
[~, order_I] = sort(B_1, 'descend');
I = I(order_I);
B_2 = Yg(J);
[~, order_J] = sort(B_2);
J = J(order_J);

%
% Select the pairs
%
n = min(length(I), length(J));
n = min(n, n_pairs);
B = union(I(1:n), J(1:n));

%
% Optimality criterion
%
gap = Yg(I(1)) - Yg(J(1));
gap = abs(gap);
