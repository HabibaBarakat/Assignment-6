function p =multivarianteGaussian(X,mu,sigma)


k=length(mu);

if(size(sigma,2)==1) || (size(sigma,1)==1)
    sigma=diag(sigma);
end

X=bsxfun(@minus,X,mu(:)');
p= ((2*pi)^(-k/2)*det(sigma)^(-0.5) )* exp(-0.5 * sum(bsxfun(@times,X * pinv(sigma),X),2));
    