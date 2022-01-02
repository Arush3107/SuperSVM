function prox_lg = proxg(v, lambda, mu)
%%% Proximal function
%Inputs -
%         v - input vector
%         lambda
%         mu
%Output - 
%         proximal of v

prox_lg = max(0, v - lambda*mu) - max(0, -v - lambda*mu);
