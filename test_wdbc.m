[T,test,ntrain,ntest] = wdbc('wdbc.data',30,0.0,1);

[n_row, n_col] = size(T);
n_atr = 30;
X = T(1:n_row,2:n_atr+1);
X = scale(X);
% Reetiquetamos los valores que tenían 0
ind = T(:,1) ~= 1;
T(ind,1) = -1;
y = T(:, 1);

mu = 1.0e3;     % ... penalizacion para el termino lineal
TOL = 1.0e-4;   % ... tolerancia para la brecha de dualidad promedio

alpha = SVM_WS(X, y, mu, 20, TOL, inf);