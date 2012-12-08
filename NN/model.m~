function model(Theta1,Theta2)

%[Theta1,Theta2] = neural(10,1,2,50,1);

i = rand(1,30);
b = normrnd(0,1,1,100);

for j = 1:100
if b(1,j) > mean(b)
	b(1,j) = b(1,j) - 20;
end
end

kurt = kurtosis(b)
skew = skewness(b)

if abs(min(b)) > abs(max(b))
b = b./abs(min(b));
else
b = b./abs(max(b));
end

for j = 1:100
for k = 1:30
p(j,k) = i(1,k)+i(1,k)*b(1,j);
end
end

for j = 1:30
val(1,j) = mean(p(:,j));
end;

core = corr(val,i)

plot(val)
hold on
plot(i,'r')
print('Useless.png')
hold off

for j = 1:100
pred(j,1) = predict(Theta1, Theta2, p(j,:));
end

actual = predict(Theta1, Theta2, i)

hold on
plot(pred)

MeanPred = mean(pred)

end;

