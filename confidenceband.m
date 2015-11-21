function data = confidenceband(x, y, yp, alpha, pm)

n = length(x);

SSy = sum((y-mean(y)).^2);
SSx = sum((x-mean(x)).^2);

steyx = sqrt(1/(n-2) * (SSy - sum((x-mean(x)).*(y-mean(y)))^2/SSx));
%steyx = std(y);
tcrit = abs(tinv(alpha/2, n-2));

for i=1:length(x)
    stderr = steyx * sqrt(1/n + (x(i) - mean(x))^2/SSx);
    if(pm)
        data(i) = yp(i) + tcrit*stderr;
    else
        data(i) = yp(i) - tcrit*stderr;
    end
end
