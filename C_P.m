n_classes = 4;
n_features = 8;
n_samples = 100;
D =   [randn(n_samples,n_features) randi(n_classes,n_samples,1)];%dataset
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