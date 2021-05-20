% Mininise (1/2)||Ax-b||^2 + mu||x||_1%
%f(x) = (1/2)||Ax-b||^2%
%g(x) = mu||x||_1%
%grad(x) = A'(Ax-b)%
%proxg(x) = [v−λμ]+−[−v−λμ]+%
%% Metadata
m = 200;
n = 30;
A = randn(m,n);
b = ones(m,1);
mu = 0.9*norm(A'*b, inf);

%%
tic;

tolerance = 10^-16;
residual_cache = [];
x0 = zeros(n,1);
L = norm(A'*A);
lambda = 1/L;
x = x0;
for k = 1:5000
    v = x - lambda * gradf(x, A, b);
    x_new = proxg(v, lambda, mu);
    residual = norm(x_new - x, inf);
    residual_cache = [residual_cache; residual];
    x = x_new;
    if residual<tolerance, break; end
    %x = x_new;
end
x
semilogy(residual_cache);
xlabel('iterations');
toc;