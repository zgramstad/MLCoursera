function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

for i = 1:m
    
    % Compute hypothesis function.
    htheta = sigmoid(dot(theta, X(i,:)));
    
    % Compute cost function.
    J = J + (-y(i) * log(htheta) - (1 - y(i)) * log(1 - htheta));
    
    % Compute gradient.
    for j = 1:length(grad)
        grad(j) = grad(j) + (1 / m) * (htheta - y(i)) * X(i,j);
    end
    
    
end

J = J / m;

% Regularize the gradient for j > 1.
for j = 2:length(grad)
    grad(j) = grad(j) + (lambda / m) * theta(j);
end

% Regularize the cost function.
sum = 0;
for j = 2:length(theta)
    sum = sum + (theta(j) ^ 2);
end

J = J + ((lambda / (2 * m)) * sum);


% =============================================================

end
