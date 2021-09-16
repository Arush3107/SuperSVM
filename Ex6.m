% Mininise (1/2)x'Qx+q'x+c + mu||x||_1%
%f(x) = (1/2)x'Qx+q'x+c%
%g(x) = mu||x||_1%
%proxf(x) = (I+λQ)^−1*(x−λq) 
%proxg(x) = [v−λμ]+−[−v−λμ]+%
%% Metadata
m = 100;
n = 20;
rm = randn(m,n);
p = 0.1;
Q = rm'*rm + p*eye(n);
q = randn(n,1);
mu = 1;%norm(Q'*q, inf);

%%
tic;

tolerance = 1e-8;
residual_cache = [];
x0 = zeros(n,1);
u0 = zeros(n,1);
v = zeros(n,1);
z0 = zeros(n,1);
L = norm(Q'*Q);
lambda = 0.99/L;
x = x0;
u = u0;
z = z0;
for k = 1:5000
    x = z - u;
    s = ADMM_proxf(n,x,lambda,Q,q);
    v = v + u;
    t = proximal(v, lambda, mu);
    u_new = u + s - t;
    residual = norm(u_new - u, inf);
    u = u_new;
    residual_cache = [residual_cache; residual];
    if residual<tolerance, break; end
end
x
semilogy(residual_cache);

ylabel("Residual difference");
xlabel("Iterations");
legend("Difference between successive iterations");
toc;