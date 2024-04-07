function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

    h = X * theta;
    errors_vector = h - y;
    theta_change = alpha*(X' * errors_vector)/m;
    theta = theta - theta_change;
    
##    J = computeCost(X, y, theta);
##    temp1 = theta(1,1) - alpha*J;
##    temp2 = theta(2,1) - alpha*J;
##    theta(1,1) = temp1;
##    theta(2,1) = temp2;
##    
##    theta = theta - alpha*J

##    %computes the sum
##    J = 0;
##    for i=1:m,
##      J = J + ((theta(1,1)*X(i,1) + (theta(2,1)*X(i,2)) - y(i))) * X(i,1);
##    end;
##
##    %computes the division
##    J = J/m;
##    
##    temp1 = theta(1,1) - alpha*J;
##    
##    J = 0;
##    for i=1:m,
##      J = J + ((theta(1,1)*X(i,1) + (theta(2,1)*X(i,2)) - y(i))) * X(i,2);
##    end;
##
##    %computes the division
##    J = J/m;
##    temp2 = theta(2,1) - alpha*J;
##    
##    theta(1,1) = temp1;
##    theta(2,1) = temp2;

    %fprintf('this is computecost: %f\n', computeCost(X, y, theta));

    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
