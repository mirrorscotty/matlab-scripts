function [out] = rdelstudent(X, e)
% Studentized deleted residuals
% This function is probably wrong.

% m is the number of parameters (two for linear)
% n is the number of data points
[n, m] = size(X);

H = X*inv(X'*X)*X';

for i=1:length(e)
    sum2resid = 0;
    for j=1:length(e)
        if(i==j)
            continue;
        end
        sum2resid = sum2resid + e(i)^2;
    end
    sigma = sqrt(1/(n-m-1)*sum2resid);
    
    out(i) = e(i)/(sigma*sqrt(1-H(i,i)));
end
