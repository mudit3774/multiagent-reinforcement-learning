%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     sigmoidGradient.m
%     randInitializeWeights.m
%     nnCostFunction.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

d = 10;

%% Setup the parameters you will use for this exercise
input_layer_size  = 3*d;  % 20x20 Input Images of Digits
hidden_layer_size = 2*input_layer_size;   % 25 hidden units
num_labels = 1;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

l = load('new1.csv');
g = l(:,4:6);
f = zeros(size(g,1),3*d);
for j = 1:size(f,1)
day = j;
for i = 1:d
for k = 1:3
f(j,k+((i-1)*3)) = g(day,k);
if day<(size(f,1)-d)  
day++;
end;
end;
end;
end;

Test = floor(0.60*size(f,1));
Validation = floor(0.80*size(f,1));

X = f;
XTrain = X(1:Test,:);
XValidation = X(Test+1:Validation,:);
XTest = X(Validation+1:end,:);
mTrain = size(XTrain, 1);
mValidation = size(XValidation, 1);
mTest = size(XTest,1);

y = f(:,2);
yTrain = y(1:Test,1);
yValidation = y(Test+1:Validation,1);
yTest = y(Validation+1:end,:);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 6: Initializing Pameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies digits. You will start by
%  implementing a function to initialize the weights of the neural network
%  (randInitializeWeights.m)

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% =================== Part 8: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 100);

%  You should also try different values of lambda
lambda = 2;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, XTrain, yTrain, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

pred = predict(Theta1, Theta2, X);

plot(pred,'g');
hold on;
plot(y,'r');
cor(pred,y)
cor(pred(1:Test,1),yTrain)
cor(pred(Test+1:Validation,1),yValidation)
cor(pred(Validation+1:end,1),yTest)

Jtrain = (1/(2*mTrain))*(sum((pred(1:Test,1) - yTrain).^2))
JValidation = (1/(2*mValidation))*(sum((pred(Test+1:Validation,1) - yValidation).^2))
JTest = (1/(2*mTest))*(sum((pred(Validation+1:end,1) - yTest).^2))


