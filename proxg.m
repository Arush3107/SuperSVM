function prox_lg = proxg(v, lambda, mu)
prox_lg = max(0, v - lambda*mu) - max(0, -v - lambda*mu);