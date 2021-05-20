clc;
clear;
n = 3000;
A = randn(n,n);
c = 0.4;
Q = A'*A + c*eye(n);
q = randn(n,1);
lambda = 1;

Proximal_gradient = @(x) ((eye(n) + lambda*Q)\(x - lambda*q));

x = zeros(n,1);
tolerance = 10^-11;
tic;
for k = 1:100
    x_new = Proximal_gradient(x);
    residual = norm(x  - x_new, inf)
    x = x_new;
    if residual<tolerance, break; end
end
toc;















%x_star = -Q\q;
%norm(x_star - x, inf)