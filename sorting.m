function s=sorting(y)

%%%%
%
%
%
%

tow = [];
a = 2;
u = sort(y,'descend');
k = size(u,1)/2 + 2;
for i=1:size(u,1)
    c = (u(i) - a)/k;
    if c >= u(k)
        K = i;
    end
end

for j = 1:K
    tow(j,1) = (u(j)-a)/K;
end

for z = 1:size(y,1)
    s(z,1) = max(y(z)-tow(z),0);
end

end