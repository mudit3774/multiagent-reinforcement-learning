function [st] = varablegammatest()
n=1
for i = 0:0.05:1
[q,st(:,n),tran,st(:,n+1)] = test(1,6,i,1000);
n = n+2;
end

