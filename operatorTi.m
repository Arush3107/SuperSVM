function t_i = operatorTi(x, i, problem_data)
%OPERATORTI
%
%
% Input arguments: 
% x                 Input vector, x = (x1, x2,...,xK)
% i                 index of sample (i goes from 1 upto L)
% problem_data      Sample data with the given details from the user
    phi_u_i = (problem_data.data(i,1:end-1))'; % row vector till penultimate column is because we need not to consider the calsses of the data
    psi_u_i = [phi_u_i;1];
    z_i = problem_data.data(i,end); % class
    m = size(problem_data.data,2)-1; 
    k = problem_data.n_classes;
    if size(x) ~= [(m+1)*k,1],error("x has wrong dimensions");end
    x_z_i =  x(((z_i-1)*(m+1) + 1):(z_i*(m+1))); 
    t_i = zeros(k(1,1),1);
     for j = 1:k
         t_i(j,1) = psi_u_i'*(x(((j-1)*(m+1) + 1):(j*(m+1))) - x_z_i);
    end
end