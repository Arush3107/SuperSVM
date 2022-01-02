function d = dis_operator(x, test_data, problem_data)
%Discrimination function
%Inputs - 
%           x - predictor model vector
%           test_data - users test data
%           problem_data - Sample data with the given details from the user

d = [];
features = problem_data.n_features+1;
classes = problem_data.n_classes;
xreshaped = reshape(x,features,classes)';
for j = 1:size(test_data,1)
    [~,d(j,1)]  = max(xreshaped*[test_data(j,:)';1]);
end    
