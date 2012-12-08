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
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
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
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

sum = 0;
Del1 = Theta1_grad; 
Del2 = Theta2_grad;

for i = 1:size(X,1)
	a1 = X(i,:);
	a1 = [1,a1];
	z2 = Theta1*a1';
	a2 = sigmoid(z2);
	a2 = [1;a2];
	z3 = Theta2*a2;
	a3 = sigmoid(z3);
	hLog1 = log(a3);
	hLog2 = log(1-a3);
	yVec = y(i);
	sum = sum - (yVec*hLog1 + (1-yVec)*hLog2);
	yVec =yVec';	
	del3 = a3 - yVec;
	%size(Theta2)
	%size(del3)
	del2 = (Theta2'*del3)(2:end).*sigmoidGradient(z2);
	%del2 = del2(2:end);
	
	Del1 = Del1 + del2*a1;
	Del2 = Del2 + del3*a2';
end;
J = (1/m)*sum;
Theta1_grad = (1/m)*Del1; 
Theta2_grad = (1/m)*Del2; 

reg = 0;
regG1 = 0;
regG2 = 0;

for j = 1:hidden_layer_size
for k = 2:input_layer_size+1
reg = reg + Theta1(j,k)^2;
end;
end;

for j = 1:num_labels
for k = 2:hidden_layer_size+1
reg = reg + Theta2(j,k)^2;
end;
end;

for i = 1:hidden_layer_size
for j = 2:input_layer_size+1
regG1 = regG1 + Theta1(i,j);
end;
end;

for i = 1:num_labels
for j = 2:hidden_layer_size+1
regG2 = regG2 + Theta2(i,j);
end;
end;

reg = (lambda/(2*m))*reg;

regG1 = (lambda/m)*regG1;
regG2 = (lambda/m)*regG2;

J = J + reg;

Theta1_grad = Theta1_grad + regG1;
Theta2_grad = Theta2_grad + regG2;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
