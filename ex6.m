clc
%--------------------------------PART 1:Principal component analysis------------------------------------------
 ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
   'MissingValue',0,'ReadSize',18000);
 T = read(ds);
 X=T{:,4:21};  %all rows, 4:21 columns
[rows,columns]=size(X); %18000x18


%  x1=bedrooms(:,1);
%  x2=bathrooms(:,1);
%  x3=sqft_living(:,1);
%  x4=sqft_lot(:,1);
%  x5=floors(:,1);
%  x6=waterfront(:,1);
%  x7=view1(:,1);
%  x8=condition(:,1);
%  x9=grade(:,1);
%  x10=sqft_above(:,1);
%  x11=sqft_basement(:,1);
%  x12=yr_built(:,1);
%  x13=yr_renovated(:,1);
%  x14=zipcode(:,1);
%  x15=lat(:,1);
%  x16=long(:,1);
%  x17=sqft_living15(:,1);
%  x18=sqft_lot15(:,1);
%  
%  X = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18]




Corr_x = corr(X);
x_cov=cov(X);
[U S V] =  svd(x_cov);
diagS= diag(S);   %diagonal of S (eigenvalues)

sumM=0;  % sum of the 18 eigenvalues
for m=1:18
    sumM=sumM+diagS(m);
end    

sumK=0;
for k=1:18          %finding optimum minimum k
    sumK=sumK+diagS(k);
        alpha= 1-(sumK/sumM);
        if (alpha <= 0.001)
            alpha
            opt_k=k;
           break   
        end
end
opt_k
R= U(:,1:opt_k)' * (X)';  %reduced data
A= R' * U(1:opt_k,1:opt_k)';   %approximate data
[a,b]=size(A);

% result=0;  %Calculating the error
% for i=1:18
%     sub= A(i)-R(i);
%     result=result+sub;
% end
%error= result/18;

error=1/18 * sum(A-R');

%Linear regression
%-------------------

theta = zeros(b, 1); 
Y=T{:,3};
m=length(Y);
alpha = 0.01;       % Learning Rate

% Run Gradient Descent
[Theta, Js] = GradientDescent(A, Y, theta, alpha,m);
J = ComputeCost(A, Y, Theta,rows);

%--------------------------------PART 2: K-means clustering----------------------------


for K = 1:15
    centroids = initCentroids(X, K);
 for iter = 1:10 
     idx = getClosestCentroids(X , centroids);
     centroids = computeCentroids(X , idx , K);
     for i=1:1:m
              J_cost(1,i) =  sum(X(i,:) - centroids(idx(i,1),:))^2;
     end
         J = (1/m)*sum(J_cost);
         if(iter == 1 )
            J_min = J;
             centroids_min = centroids;
             itr_min = iter;
         else
             if(J_min > J)
                 J_min = J;
                 centroids_min = centroids;
                 
                itr_min = iter;
             end
         end    
 end
JJ(1,K) = J_min;
end

plot(JJ)

centroids = initCentroids(R',opt_k);
for m=1:max_iterations
  indices = getClosestCentroids(R', centroids);         %assign points to centroids(each point belongs to which cluster)
  centroids = computeCentroids(R', indices, opt_k) ;       %find new centroids
end
%-------------------------------PART 3: Anomaly-----------------------------------------

MEAN=mean(X);
STD=std(X);
% covx=cov(X);
% PROBABILITY=mvnpdf(X,MEAN,covx);
% epsilon=10^-100;
% result=zeros(m,1);
% 
% l=find(PROBABILITY<epsilon); %give me all indeces of data les than epsilon
%  for i=1:length(l)
%      index=l(i);
%      result(index)=1;
%  end    


 

 for s=1:18000
 for i=1:18
     ff(s,i)=normpdf(X(s,i),MEAN(i),STD(i));
     
     
 end 
 prodect(s)=prod(ff(s,:));
 end
 
 counter=0;
for v=1:18000
    if prodect(v)>10^-30 || prodect(v)<10^-50
  
        counter=counter+1;
    end
end
counter
% [mu , sigma] = estimateGaussian(X);
% p= multivarianteGaussian(X,mu,sigma);



            