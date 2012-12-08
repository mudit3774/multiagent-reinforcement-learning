function confid()

n = 100;
c = rand(1,n); 
stk = ones(1,n).*n;
cost = 100;
money = 1000*stk.*cost;
buy_order = zeros(1,n);
sell_order = zeros(1,n);
buy_num = zeros(1,n);
sell_num = zeros(1,n);
buy_price = ones(1,n)*10000;
sell_price = ones(1,n)*-10000;
hold = ones(1,n);
learning_rate = rand(1,n); 
index(1,1) = 1000;
pred = ones(1,n).*cost;

bc = 1;
sc = 1;

cnt = 1;

for j = 1:1000
buy_order = zeros(1,n);
sell_order = zeros(1,n);
buy_num = zeros(1,n);
sell_num = zeros(1,n);
buy_price = ones(1,n)*10000;
sell_price = ones(1,n)*-10000;
pred = pred/pred;
pred = pred.*cost;
pred = pred+(rand(1,n).-0.5);
for i = 1:n
	if (money(1,i) <= 0||stk(1,i)<=0)
		continue;
	end
	if (pred(1,i)-cost) > 0
		buy_order(1,i) = i;
		buy_price(1,i) = pred(1,i);		
		bc = bc+1;
	else
		sell_order(1,i) = i;
		sell_num(1,i) = floor(c(1,i)*stk(1,i));
	%	if sell_num(1,sc) > stk(1,i)
	%		sell_num(1,sc)
	%		stk(1,i)
	%		c(1,i)
	%		pause
	%	end
		sell_price(1,i) = pred(1,i);
		sc = sc+1;
	end
end
bc = 1;
sc = 1;

[sellval,sellind] = max(sell_price);
[buyval,buyind] = min(buy_price);

%sellind = sell_order(1,sellind);
%buyind = buy_order(1,buyind);

if rand(1) > 0.5
	cost = buyval;
else
	cost = sellval;
end

volume = 0;

if buyind!=0 && sellind!=0

%sell_price(1,sellind)
%buy_price(1,buyind)

buy_num(1,buyind) = min(floor(c(1,buyind)*stk(1,buyind)),floor(money(1,buyind)/cost));

volume = min(sell_num(1,sellind),stk(1,sellind));
stk(1,sellind)
stk(1,buyind) = stk(1,buyind) + volume;
stk(1,sellind) = stk(1,sellind) - volume;
if stk(1,sellind) < 0
%	cost
%	c(1,sellind)
	sell_num(1,sellind)
	buy_num(1,buyind)
	volume
	pause
end
money(1,buyind) = money(1,buyind) - volume*cost;
money(1,sellind) = money(1,sellind) + volume*cost;
vol(cnt) = volume;
index(cnt) = cost;
cnt = cnt+1;

end

buy_order = zeros(1,n);
sell_order = zeros(1,n);
cost;


end
index;
plot(index);
print('ind.png');
%plot(vol);
%sprint('vol.png');
min(money)
max(money)
sum(money)
sum(stk)
min(stk)
max(stk)
%plot(money)
%print('money.png');
%plot(c,'r')
%plot(stk,'g');
%print('stk.png');
end


