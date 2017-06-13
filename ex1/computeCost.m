function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

[nrowsX, ] = size(X);

% foreach row in X
for i = 1:nrowsX
    % dot product with theta
    h_theta = dot(theta, X(i,:));
    % subtract y and square
    sq_diff = (h_theta - y(i))^2;
    % add to J
    J = J + sq_diff(1);
end

% divide by 2m
J =  J / (2*m);


% =========================================================================

end
