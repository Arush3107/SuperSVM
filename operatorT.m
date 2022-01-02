function T = operatorT(x, problem_data)
%OPERATORT
%Inputs - 
%           x - input vector
%           problem_data      Sample data with the given details from the user

T = [];
for j = 1:size(problem_data.data,1)
    T = [T;operatorTi(x,j,problem_data)];
end    
