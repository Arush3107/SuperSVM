function r = rfactor(y,problem_data)

%%%RFACTOR calculation
%inputs -
%        y  - vector
%        problem data - data along with user inputs.
%Outputs -
%        r-factor or simply mu_l vector
%

r = problem_data.lambda.*ones(size(y,1),1)*problem_data.mu;
for i = 1:length(problem_data.data)
    idx = problem_data.n_classes*(i-1)+problem_data.data(i,end);
    r(idx) = 0;
end

end