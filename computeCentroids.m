%re-compute the cluster centroids. For this purpose we will compute the mean of all the data points 
%in each cluster and assign the calculated mean as new centroid of the cluster.


function centroids = computeCentroids(X, idx, K)

  [m , n] = size(X);
  centroids = zeros(K, n);
  
  for i=1:K
    xi = X(idx==i,:);
    total = size(xi,1);
    centroids(i, :) = (1/total) * sum(xi);
    %centroids(i, :) = (1/ck) * [sum(xi(:,1)) sum(xi(:,2))];
  end
end