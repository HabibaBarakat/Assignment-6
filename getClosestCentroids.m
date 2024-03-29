%getClosestCentroids method will compute euclidean distance of every data point to each cluster centroid 
%and assign the data point to the one with lowest distance.


function indices = getClosestCentroids(X, centroids)
  K = size(centroids, 1);
  indices = zeros(size(X,1), 1);
  m = size(X,1);

   for i=1:m
     k = 1;
     min_dist = sum((X(i,:) - centroids(1,:)) .^ 2);
     for j=2:K
         dist = sum((X(i,:) - centroids(j,:)) .^ 2);
         if(dist < min_dist)
           min_dist = dist;
           k = j;
         end
     end
     indices(i) = k;
  end



% min_dist=0;
% for i=1:m
%     k = 1;
%     for j=2:k
%         distance = sum((X(i,:) - centroids(1,:)) .^ 2);
%         if(distance < min_dist)
%           min_dist = distance;
%           k=j;
%         end  
%      end
%      indices(i) = k; 
% end
end