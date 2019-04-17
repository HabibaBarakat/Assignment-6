function [theta, Js] = GradientDescent(X, y, theta, alpha,m)
   
    flag=true;
    k=1;
    q=0;
    Js(k) = ComputeCost(X, y, theta,m);
    while flag==true

        alpha=alpha*1;
        theta=theta-(alpha/m)*X'*(X*theta-y);
        k=k+1;     
        Js(k) = ComputeCost(X, y, theta,m);
        if Js(k-1)-Js(k)<0 %break or minimize alpha as the error is becoming bigger
           break
        end 
        q=(Js(k-1)-Js(k))./Js(k-1);
if q <.000001; %stopping condition as we assume that it is converged
    flag=false;
end
    end
    
 
end