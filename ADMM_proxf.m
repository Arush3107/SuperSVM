function ADMMprox = ADMM_proxf(n, x, lambda, Q, q)
ADMMprox = ((eye(n) + lambda*Q)\(x - lambda*q));
