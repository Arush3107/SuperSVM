function adjT_i = adjoperatorTi(y, i, problem_data)
%ADJOPERATORTI
%
%
%

 phi_u_i = problem_data.data(i,1:end-1)'; % row vector till penultimate column is because we need not to consider the calsses of the data
 psi_u_i = [phi_u_i;1];
 z_i = problem_data.data(i,end); % class
 m = size(problem_data.data,2)-1;
 k = problem_data.n_classes;
 adjT_i = zeros((m+1)*k,1);
 sum_y = 0;
 for j  = [1:z_i-1 z_i+1:k]
     adjT_i(((j-1)*(m+1) + 1):(j*(m+1))) = y(j)*psi_u_i;
     sum_y = sum_y + y(j);
 end
 adjT_i(((z_i-1)*(m+1) + 1):(z_i*(m+1))) = -sum_y*psi_u_i;