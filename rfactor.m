function r = rfactor(y,problem_data)

%%%RFACTOR calculation
%
%
%
%

r = ones(size(y,1),1)*problem_data.mu;
for i = 1:length(problem_data.data)
    idx = problem_data.n_classes*(i-1)+problem_data.data(i,end);
    r(idx) = 0;
end

end