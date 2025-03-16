function logw = mylog(x);
[m,n,k] = size(x);
x(find(x<1e-300)) = 1e-300;
x(find(x>=1e300)) = 1e300;
logw = log(x);
