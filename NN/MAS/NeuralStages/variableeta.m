function [A] = variabeeta()
i = 0:0.05:1
X = floor(CheckStrategy(1,i,1000));
Y = floor(CheckStrategy(0.6,i,1000));
Z = floor(CheckStrategy(0.2,i,1000));
X = X';
Y=Y';
Z=Z';
A = [i',X,Y,Z]
end

