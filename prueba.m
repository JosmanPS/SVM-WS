X = csvread('data_test.csv', 1, 1);

Y = X(:, 3);
X = X(:, 1:2);

alpha = SVM_WS(X, Y, 1000, 5, 1e-4, 100);
