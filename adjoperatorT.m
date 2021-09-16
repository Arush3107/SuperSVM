function adjT = adjoperatorT(y, problem_data)
%ADJOPERATORT
%
%

adjT = 0;
k = problem_data.n_classes;
for j = 1:size(problem_data.data,1)
    adjT = adjT + adjoperatorTi(y((j-1)*k + 1:j*k),j,problem_data);
end