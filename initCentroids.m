%initCentroids method defined will return K random indices from X as centroids.
%randperm method will randomly reorder the indices of the dataset (X).


function centroids = initCentroids(X, K)
    randidx = randperm(size(X,1)); %get random place from all the data
    centroids = X(randidx(1:K), :);   %3x18
  end