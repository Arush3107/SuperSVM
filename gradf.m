function df = gradf(x, A, b)
df = A'*(A*x-b);