function [out] = rstudent(X, e)
% Studentized residuals
% X - Design matrix
% e - vector of residuals.

% m is the number of parameters (two for linear)
% n is the number of data points
[n, m] = size(X);

sum2resid = 0;
for i=1:length(e)
    sum2resid = sum2resid + e(i)^2;
end

H = X*inv(X'*X)*X';
sigma = sqrt(1/(n-m)*sum2resid);

for i=1:length(e)
    out(i) = e(i)/(sigma*sqrt(1-H(i,i)));
end
