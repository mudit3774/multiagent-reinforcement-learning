function [Theta1,Theta2,pred] = neuralV (dVal, lambdaVal, hidden_layer_multiplier, iteration, marker_size)

d = dVal;

input_layer_size  = 1*d;  % 20x20 Input Images of Digits
hidden_layer_size = floor(hidden_layer_multiplier*input_layer_size);   % 25 hidden units
num_labels = 1;          

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

load('sv');
#l = load('new1.csv');
l = final;
#g = [l(:,18:20),l(:,22:24)];
g = l(:,17);
f = zeros(size(g,1),1*d);
for j = 1:size(f,1)
day = j;
for i = 1:d
for k = 1:1
f(j,k+((i-1)*1)) = g(day,k);
if day<(size(f,1)-d)  
day++;
end;
end;
end;
end;

X = f(1:(end-d),:);
X = X;
size(X)

Test = floor(0.60*size(X,1));
Validation = floor(0.80*size(f,1));

XTrain = X(1:Test,:);
XValidation = X(Test+1:Validation,:);
XTest = X(Validation+1:end,:);
mTrain = size(XTrain, 1);
mValidation = size(XValidation, 1);
mTest = size(XTest,1);

y = l(d+1:end,17);
y = y;
size(y)
plot(y);
hold on;
grid('on')
ylabel('Normalised Index Value')
title('Normalised Values of from 0 to 1')
box('off')
legend('Normalised Values') 
print('Normalised.png')
hold off;


#y = f(d+1:end,2);
yTrain = y(1:Test,1);
yValidation = y(Test+1:Validation,1);
yTest = y(Validation+1:end,:);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

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
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', iteration);

%  You should also try different values of lambda
lambda = lambdaVal;

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
%pause;


%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

pred = predict(Theta1, Theta2, X);

#pred = pred .* 5389.7; %Mulyiply by the range (scaling factor)
#pred = pred .+ 922.70;

#y = y .* 5389.7;
#y = y .+ 922.70;

plot(1:Test,pred(1:Test,1),'y',"markersize",5);
hold on;
size(Test+1:size(y,1))
size(pred(Test+1:end,1))
plot((Test+1:size(y,1))',pred(Test+1:end,1),'b',"markersize",5);
%plot(Validation+1:size(y,1),pred(Validation+1:end,1),'g',"markersize",5);
plot(y,'r',"markersize",marker_size);

overall_corr = corr(pred,y)
train_corr = corr(pred(1:Test,1),yTrain)

test_corr = corr(pred(Test+1:end,1),y(Test+1:end,1))
corr(pred(Test+1:Validation,1),yValidation);
corr(pred(Validation+1:end,1),yTest);

aa = sum(pred);
bb = sum(y);
overall_err = (aa-bb)/(mTrain+mValidation+mTest)

aa = sum(pred(1:Test,1));
bb = sum(y(1:Test,1));
Train_err = (aa-bb)/(mTrain)

aa = sum(pred(Test+1:end,1));
bb = sum(y(Test+1:end,1));
Testing_err = (aa-bb)/(mValidation+mTest)

RMSE = sum((((pred - y).^2).^(0.5)))/(mTest+mValidation+mTrain)

JOverAll = (1/(2*(mTest+mValidation+mTrain)))*(sum((pred - y).^2))
JTesting = (1/(2*(mValidation+mTest)))*(sum((pred(Test+1:end,1) - y(Test+1:end,1)).^2))
JTrain = (1/(2*mTrain))*(sum((pred(1:Test,1) - yTrain).^2))
%JValidation = (1/(2*mValidation))*(sum((pred(Test+1:Validation,1) - yValidation).^2));
JTest = (1/(2*mTest))*(sum((pred(Validation+1:end,1) - yTest).^2));
JValidation =1;
%JTrainA = (1/mTrain)*(sum(pred(1:Test,1) - yTrain));
%JValidationA = (1/mValidation)*(sum(pred(Test+1:Validation,1) - yValidation));
%JTestA = (1/mTest)*(sum(pred(Validation+1:end,1) - yTest));

%JTrainP = (1/mTrain)*(sum(((pred(1:Test,1) - yTrain)./yTrain)));
%JValidationP = (1/mValidation)*(sum(((pred(Test+1:Validation,1) - yValidation)./yValidation)));
%JTestP = (1/mTest)*(sum(((pred(Validation+1:end,1) - yTest)./yTest)));


JErr(1,1) = JTrain;
JErr(1,2) = JValidation;
JErr(1,3) = JTest;
JErr(1,4) = (aa-bb)/(mTrain+mValidation+mTest);

%JErr(1,4) = JTrainA;
%JErr(1,5) = JValidationA;
%JErr(1,6) = JTestA;

%JErr(1,7) = JTrainP*100;
%JErr(1,8) = JValidationP*100;
%JErr(1,9) = JTestP*100;

grid('on')
ylabel('Index Value')
title('Comparison between actual and predicted values (Overall)')
box('off')
legend('Predicted Value (Training Set)', 'Predicted Value (Test)', 'Actual Value') 
print('Overlay.png')
hold off;

plot(Test+1:size(y,1),pred(Test+1:end,1),'b',"markersize",5);
hold on;
plot(Test+1:size(y,1),y(Test+1:size(y,1)),'r',"markersize",marker_size);
grid('on')
ylabel('Index Value')
title('Comparison between actual and predicted values (Test Set)')
box('off')
legend('Predicted Values (Test Set)', 'Actual Values (Test Set)') 
print('Test.png')
hold off;

plot(1:Test,pred(1:Test,1),'b',"markersize",5);
hold on;
plot(y(1:Test),'r',"markersize",marker_size);
grid('on')
ylabel('Index Value')
title('Comparison between actual and predicted (Training Set)')
box('off')
legend('Predicted Value (Training Set)', 'Predicted Value (Test)', 'Actual Value') 
print('Train.png')
hold off;

end;
