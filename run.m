clc;
clear;
close all;
sparce_cache = [];
D = readmatrix("seed.csv");
u = rmmissing(readmatrix("seedtest.csv"));
cls = readmatrix("seedclasses.csv");
D_transformed = rmmissing(D);
n_classes = unique(D_transformed(:,end),'stable');
problem_data.n_features = width(D_transformed)-1;
problem_data.n_samples = height(D_transformed);
problem_data.n_classes = length(n_classes);
problem_data.data = D_transformed;
for i = 3.4:0.1:3.9
problem_data.lambda = i;
problem_data.mu = 0.005;
mdl = fitcdiscr(problem_data.data(:,1:end-1),problem_data.data(:,end));
[x,~,error,cache] = svm_trainer(problem_data,1e-4);
assert(error < 1e-3);
sparce = sparcity(x);
discr = dis_operator(x,u,problem_data);
sparce_cache = [sparce_cache;sparce];
figure;
cm = confusionchart(cls,discr);
figure;
semilogy(cache);
ylabel("tolerance");
xlabel("Iterations");
legend("tolerance levels.");
end
figure;
plot(1:0.2:2,sparce_cache)
xlabel("lambda");
ylabel("Sparse level");
