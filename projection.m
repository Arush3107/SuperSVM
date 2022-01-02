function proj = projection(y,a)

%%%PROJECTION on to a simplex L_1 ball.
%Inputs - 
%           y - vector
%           a - user input
%
v = y(1);
v_star = [];
rho = y(1) - a;

%Step 2
N = length(y) ;
for i = 2:N
    if y(i) > rho
        rho  = rho +(y(i)-rho)/(length(v)+1);
        if rho > y(i)-a
            v = [v;y(i)];
        else
            v_star = [v_star;v];
        end
            v = y(i);
            rho = y(i) - a;          
    end
end


%Step 3

if ~isempty(v_star)
    for j = 1:length(v_star)
        if v_star(j) > rho
            v = [v;v_star(j)];
            rho = rho+((v_star(j) - rho)/length(v));
        end            
    end
end
%Step 4

% Didn't understand the Do step implementation

keeprunning = true;
while keeprunning
    if isempty(v),break;end
    for c = 1:length(v)
        lenv = length(v);
        if v(c) <= rho
            v(c) = nan;
            rho = rho + (rho - y(c))/length(v);
        end            
    end
    v(isnan(v)) = [];
    newlenv = length(v);
    keeprunning = (newlenv ~= lenv);
end

%Step 5

tau = rho;
K = length(v);

%Step 6

proj = [];
for i = 1:length(y)
    proj = [proj;max(y(i) - tau, 0)];
end
end