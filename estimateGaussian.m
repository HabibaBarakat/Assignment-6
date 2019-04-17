function [mu sigma] =estimateGaussian(X)


[m,n]=size(X);

mu = (sum(X)./m);
sigma=sum((X-(ones(m,1)*mu)).^2)./m;
sigma=sigma';
mu=mu';