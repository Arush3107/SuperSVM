function T = operatorT(x, problem_data)
%OPERATORT
%
%
%

T = [];
for j = 1:size(problem_data.data,1)
    T = [T;operatorTi(x,j,problem_data)];
end    
