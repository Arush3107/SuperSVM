%% Initialize
clc;
clear;
close all;
sparce_cache = [];
%% Read Data
D = readmatrix("inputCsvFile");
u = rmmissing(readmatrix("testData"));
cls = readmatrix("actualClasses");
D_transformed = rmmissing(D);
n_classes = unique(D_transformed(:,end),'stable');
problem_data.n_features = width(D_transformed)-1; %Problem data has all the incoming data
problem_data.n_samples = height(D_transformed);
problem_data.n_classes = length(n_classes);
problem_data.data = D_transformed;
problem_data.lambda = 1; %Sparsity regulator
problem_data.mu = 0.005;
%% Main
[x,~,error,cache] = svm_trainer(problem_data,1e-4); %Training Model
assert(error < 1e-3);
discr = dis_operator(x,u,problem_data); %Predictor function
figure;
cm = confusionchart(cls,discr); %Confusion chart