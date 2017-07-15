function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
%% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%

% Recode y to be matrix Y where each column is all zeros except for one 1
% at index which corresponds to current value of y.

Y = zeros(size(y,1), num_labels);

for i=1:size(y,1)
    Y(i, y(i)) = 1;
end



% Compute h_theta.
X = [ones(m,1) X];

% Compute transitions to first layer.
Z1 = sigmoid(X * Theta1.');
Z1 = [ones(m, 1) Z1];

% Compute transition to output layer.
h_theta = sigmoid(Z1 * Theta2.');

% Compute all values of J_theta.
J_matrix = (-1 * Y .* log(h_theta)) - ((1 - Y) .* (log(1 - h_theta)));

% Sum all values and divide by m.
J = 1 / m * sum(sum(J_matrix));

% Regularization.

Theta1_sz = size(Theta1);
Theta2_sz = size(Theta2);

J = J + lambda / (2 * m) * (sum(sum(Theta1(:,2:Theta1_sz(2)).^2)) ...
    + sum(sum(Theta2(:,2:Theta2_sz(2)).^2)));


%% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%


for t = 1:m
    a_1 = X(t,:)';
    
    z_2 = Theta1 * a_1;
    
    a_2 = [1; sigmoid(z_2)];
    
    z_3 = Theta2 * a_2;
    
    a_3 = sigmoid(z_3);
    
    y_k = ([1:num_labels] == y(t))';
    delta_3 = a_3 - y_k;
    
    delta_2 = (Theta2' * delta_3);
    delta_2 = delta_2 .* [1; sigmoidGradient(z_2)];
    
    Theta1_grad = Theta1_grad + delta_2(2:end) * a_1';
    Theta2_grad = Theta2_grad + delta_3 * a_2';
    
    
end

size1 = size(Theta1_grad);
size2 = size(Theta2_grad);

Theta1_grad = 1 / m * (Theta1_grad + lambda * [zeros(size1(1),1) Theta1(:,2:size1(2))]);
Theta2_grad = 1 / m * (Theta2_grad + lambda * [zeros(size2(1),1) Theta2(:,2:size2(2))]);










%% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

%% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
