function [x,y,error,cache] = svm_trainer(problem_data,tolerance)
% svm_trainer
% Inputs - problem data and accepted level of tolerance
% This function is where the training data is analysed and 
% classification model is developed
% Output - x_n,y,present error and cache

cache = [];
classes = problem_data.n_classes;
x = randn((problem_data.n_features+1)*classes,1);
y = zeros(length(problem_data.data)*classes,1);
size_x = (problem_data.n_features+1)*classes;
opT = @(z) operatorT(z,problem_data);
opAdjT = @(z) adjoperatorT(z,problem_data);
normT = sqrt(max(abs(eigs(@(z)opAdjT(opT(z)),size_x)))); %norm of T
alpha_1 = (0.99/normT); %arbitary
alpha_2 = (0.95/normT); %arbitary
tol = tolerance;
lambda = problem_data.lambda;
mu = problem_data.mu;
tic
for i = 1:50000
    v = x - alpha_1*adjoperatorT(y,problem_data);
    x_plus = proxg(v,lambda*alpha_1,mu); %proximal of v
    y_plus = y + alpha_2*operatorT((2*x_plus - x),problem_data);
    r = rfactor(y_plus,problem_data);
    proj_data = y_plus + alpha_2*r;
    y_out = projection(proj_data,2); %Projection of y
    error = norm([x;y] - [x_plus;y_plus])/max(1,norm([x;y]));
    cache = [cache;error];
    x = x_plus;
    y = y_plus;
    if error<tol,break; end %termination condition
end
elapsetime = toc;
end