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

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));


m = size(X, 1);

J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));


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

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
