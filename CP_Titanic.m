%D =   [randn(n_samples,n_features) randi(n_classes,n_samples,1)];%dataset
clc;
close all;
%opts = detectImportOptions("train.csv");
D = readmatrix("train.csv");
D_transformed = rmmissing(D);
%D_transformed(find(sum(isnan(D_transformed),2)>0),:) = [];
n_classes = unique(D_transformed(:,end),'stable');
n_features = width(D_transformed)-1;
n_samples = height(D_transformed);
%D_transformed(:,2) = [];
problem_data.n_classes = length(n_classes);
problem_data.data = D_transformed;
%problem_data.class = 5;
%problem_data.data(1:4, end) = (1:4)';
%%
% for j = 1:n_features+1
%     T_i = operatorTi(D_transformed(:,j),n_classes,problem_data)
%     T_cache = [T_cache; T_i]
%  end
% m = size(D_transformed);
% x = randn((m(1,1)+1)*m(1,2),1);
%
% x = (1:(n_features+1)*n_classes)';
% t = operatorTi(x,4,problem_data);
% y = randn(n_classes,1);
% adjt = adjoperatorTi(y,4,problem_data);
%
% k_1 = x'*adjt;
% k_2 = t'*y;
% k_1 - k_2
%%
x = randn((n_features+1)*3,1);
y = randn(n_samples*3,1);
T = operatorT(x,problem_data);
adjT = adjoperatorT(y,problem_data);

k_1 = x'*adjT;
k_2 = T'*y;
k_1 - k_2

%%
cache = [];
ziny = [];

m = size(D_transformed);
classes = size(n_classes);
%x = randn((m(1,2))*classes(:,1),1);
x = ones((m(1,2))*classes(:,1),1);
T = operatorT(x,problem_data);
T(isnan(T)) = [0];
y = ones((m(1,1))*classes(:,1),1);
normT = sqrt(max(abs(eigs(@(z)adjoperatorT(operatorT(z,problem_data),problem_data),15))));
alfa_1 = (0.95/normT); %arbitary
alfa_2 = (0.95/normT);
dmu = 0:0.1:10;
tol = 1e-3;
%testing with multiple mu values
tic
for j = 1:length(dmu)
    mu = dmu(1,j);
    problem_data.mu = mu;
    for i = 1:5000
        v = x - alfa_1*adjoperatorT(y,problem_data);
        x_plus = proxg(v,alfa_1,mu);
        y_plus = y + alfa_2*operatorT((2*x_plus - x),problem_data);
        r = rfactor(y_plus,problem_data);
        proj_data = y_plus + alfa_2*r;
        y_out = projection(proj_data,2);
        error = norm([x;y] - [x_plus;y_plus])/max(1,norm([x;y]));
        cache(i,j) = error;
        x = x_plus;
        y = y_plus;
        if error<tol,break; end
    end
    elapsetime = toc;
    sparsity = (sum(~x_plus(:))/length(x_plus))*100;
    ziny = [ziny;sparsity];if sparsity > 99,break;end
end
%%
figure;
semilogy(abs(cache));
hold on;
figure;
plot(dmu(1:length(ziny)),ziny);
hold on;