function [q,st,tran,av] = test(eta,st,gama,days)
[q,st,b,av] = CalculateReward(st,gama);

for i = 1:10
tran(i) = floor(CheckStrategy(b(st(i)),eta,days));
end
l=1;
k=1; 
for i = tran
for j = 1:i
yv(l) = st(k);
l = l+1;
end
k = k+1;
end
plot(1:sum(tran),yv,'r')
hold on;
xlabel('Lifetime');
ylabel('State');
title('Time Spend by the agent in each state \eta = 0.5');
print('g2.png')
end
