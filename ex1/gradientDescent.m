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
    
    % create temp so that values are not overwritten.
    new_theta = theta;
   
    
    for j = 1:length(theta)
        % Compute the sum of the costs of the difference between
        % hypothesis and actual multiplied by the corresponding X(i,j).
        sumCosts = zeros(1);
        for i = 1:m
            % Increment sumCosts by the summand.
            sumCosts = sumCosts + (dot(theta, X(i,:)) - y(i)) * X(i,j);
        end
        
        % New theta value is updated.
        new_theta(j) = theta(j) - alpha * (1/m) * sumCosts(1);
    end
    
    % Set theta to be new_theta.
    theta = new_theta;

    



    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
