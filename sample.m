clc;
clear;
tolerance = 10^-14;
x = zeros(20,1);
Q = rand(20);
q = rand(20,1);
lambda = rand(1);
num = 20;
for t = 1:length(num)
    x=inv(1+lambda*Q)*(x-lambda*q);
end    