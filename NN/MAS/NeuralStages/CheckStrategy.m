function [tran] = CheckStrategy(e,learning_rate,days)
lambda = 14; % ideally vary from 10 to 20
tran = -log2(e*learning_rate);
tran = (tran/lambda)*days;
end

