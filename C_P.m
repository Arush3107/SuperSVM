n_classes = 4;
n_features = 8;
n_samples = 100;
D =   [randn(n_samples,n_features) randi(n_classes,n_samples,1)];%dataset
%D = readmatrix(train);
D_transformed = D;
for i = 1:n_samples
    D_transformed(i,1:end-1) = feature_transformation(D(i,1:end-1)); %
end
problem_data.n_classes = n_classes;
problem_data.data = D_transformed;
problem_data.data(1:4, end) = (1:4)';
%%
% for j = 1:n_features+1
%     T_i = operatorTi(D_transformed(:,j),n_classes,problem_data)
%     T_cache = [T_cache; T_i]
% end
x = randn((n_features+1)*n_classes,1);
%x = (1:(n_features+1)*n_classes)';
t = operatorTi(x,4,problem_data);
y = randn(n_classes,1);
adjt = adjoperatorTi(y,4,problem_data);

k_1 = x'*adjt;
k_2 = t'*y;
k_1 - k_2
%%
x = randn((n_features+1)*n_classes,1);
y = randn(n_samples*n_classes,1);
T = operatorT(x,problem_data);
adjT = adjoperatorT(y,problem_data);

k_1 = x'*adjT;
k_2 = T'*y;
k_1 - k_2

%%
cache = [];
for i = 1:50
    alfa_1 = 0.99*(norm(T)^2);
    alfa_2 = 0.99*(norm(T)^2);
    mu = 0.6*norm(x, inf);
    L = norm(x'*x);
    lambda = 1/L;
    v = x - alfa_1*adjoperatorT(y,problem_data);
    x_plus = proxg(v,lambda,mu);
    y_plus = y + alfa_2*operatorT((2*x_plus(:,1) - x),problem_data);
    r = rfactor(y_plus,problem_data);
    proj_data = y_plus + alfa_2*r;
    y_out = projection(proj_data,10);
    cache = [cache;norm([x;y] - [x_plus;y_plus])];
end
plot(cache);