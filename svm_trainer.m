function [x,y,error,cache] = svm_trainer(problem_data,tolerance)
cache = [];
classes = problem_data.n_classes;
x = randn((problem_data.n_features+1)*classes,1);
y = zeros(length(problem_data.data)*classes,1);
size_x = (problem_data.n_features+1)*classes;
opT = @(z) operatorT(z,problem_data);
opAdjT = @(z) adjoperatorT(z,problem_data);
normT = sqrt(max(abs(eigs(@(z)opAdjT(opT(z)),size_x))));
alpha_1 = (0.99/normT); %arbitary
alpha_2 = (0.95/normT);
tol = tolerance;
lambda = problem_data.lambda;
tic
mu = problem_data.mu;
for i = 1:100000
    v = x - alpha_1*adjoperatorT(y,problem_data);
    x_plus = proxg(v,lambda*alpha_1,mu);
    y_plus = y + alpha_2*operatorT((2*x_plus - x),problem_data);
    r = rfactor(y_plus,problem_data);
    proj_data = y_plus + alpha_2*r;
    y_out = projection(proj_data,2);
    error = norm([x;y] - [x_plus;y_plus])/max(1,norm([x;y]));
    cache = [cache;error];
    x = x_plus;
    y = y_plus;
    if error<tol,break; end
end
elapsetime = toc;
end