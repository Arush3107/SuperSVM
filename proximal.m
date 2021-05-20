function prox_lg = proximal(v, lambda, mu)
prox_lg = max(0, v - lambda*mu) - max(0, -v - lambda*mu);