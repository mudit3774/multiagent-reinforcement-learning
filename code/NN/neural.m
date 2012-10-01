function JErr = neural (dVal, lambdaVal, hidden_layer_multiplier, iteration, marker_size)

d = dVal;

input_layer_size  = 3*d;  
hidden_layer_size = floor(hidden_layer_multiplier*input_layer_size);  
num_labels = 1;          

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

X = f(1:(end-d),:);

Test = floor(0.60*size(X,1));
Validation = floor(0.80*size(f,1));

XTrain = X(1:Test,:);
XValidation = X(Test+1:Validation,:);
XTest = X(Validation+1:end,:);
mTrain = size(XTrain, 1);
mValidation = size(XValidation, 1);
mTest = size(XTest,1);

y = f(d+1:end,2);
yTrain = y(1:Test,1);
yValidation = y(Test+1:Validation,1);
yTest = y(Validation+1:end,:);


fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

fprintf('\nTraining Neural Network... \n')

options = optimset('MaxIter', iteration);


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

pred = predict(Theta1, Theta2, X);

pred = pred .* 5389.7;
pred = pred .+ 922.70;

y = y .* 5389.7;
y = y .+ 922.70;

plot(1:Test,pred(1:Test,1),'y',"markersize",5);
hold on;
plot(Test+1:Validation,pred(Test+1:Validation,1),'b',"markersize",5);
plot(Validation+1:size(y,1),pred(Validation+1:end,1),'g',"markersize",5);
plot(y,'r',"markersize",marker_size);
cor(pred,y);
cor(pred(1:Test,1),yTrain);
cor(pred(Test+1:Validation,1),yValidation);
cor(pred(Validation+1:end,1),yTest);

aa = sum(pred)
bb = sum(y)
aa-bb
(aa-bb)/(mTrain+mValidation+mTest)

JTrain = (1/(2*mTrain))*(sum((pred(1:Test,1) - yTrain).^2));
JValidation = (1/(2*mValidation))*(sum((pred(Test+1:Validation,1) - yValidation).^2));
JTest = (1/(2*mTest))*(sum((pred(Validation+1:end,1) - yTest).^2));

JTrainA = (1/mTrain)*(sum(pred(1:Test,1) - yTrain));
JValidationA = (1/mValidation)*(sum(pred(Test+1:Validation,1) - yValidation));
JTestA = (1/mTest)*(sum(pred(Validation+1:end,1) - yTest));

JTrainP = (1/mTrain)*(sum(((pred(1:Test,1) - yTrain)./yTrain)));
JValidationP = (1/mValidation)*(sum(((pred(Test+1:Validation,1) - yValidation)./yValidation)));
JTestP = (1/mTest)*(sum(((pred(Validation+1:end,1) - yTest)./yTest)));


JErr(1,1) = JTrain;
JErr(1,2) = JValidation;
JErr(1,3) = JTest;

JErr(1,4) = JTrainA;
JErr(1,5) = JValidationA;
JErr(1,6) = JTestA;

JErr(1,7) = JTrainP*100;
JErr(1,8) = JValidationP*100;
JErr(1,9) = JTestP*100;

grid('on')
ylabel('Index Value')
title('Comparison between actual and predicted values from 1st September 2002 to 1st September 2012')
box('off')
legend('Predicted Value (Training Set)', 'Predicted Value (Validation Set)', 'Predicted Value (Test Set)','Actual Value') 
print('Graph.eps')

end;
