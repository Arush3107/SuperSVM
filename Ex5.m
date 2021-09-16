% Mininise (1/2)x'Qx+q'x+c + mu||x||_1%
%f(x) = (1/2)x'Qx+q'x+c%
%g(x) = mu||x||_1%
%grad(x) = Qx+q%
%proxg(x) = [v−λμ]+−[−v−λμ]+%
%% Metadata
m = 100;
n = 20;
rm = randn(m,n);
p = 0.1;
Q = rm'*rm + p*eye(n);
q = randn(n,1);
mu = 1;%0.6*norm(Q'*q, inf);

%%
tic;

tolerance = 1e-8;
residual_cache = [];
x0 = zeros(n,1);
L = norm(Q'*Q);
lambda = 1/L;
x = x0;
for k = 1:5000
    v = x - lambda*gradlq(x, Q, q);
    x_new = proximal(v, lambda, mu);
    residual = norm(x_new - x, inf);
    x = x_new;
    residual_cache = [residual_cache; residual];
    if residual<tolerance, break; end
end
x
semilogy(residual_cache);
xlabel('iterations');
toc;