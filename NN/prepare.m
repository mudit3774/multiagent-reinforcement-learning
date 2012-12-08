function prepare(file)
initial = load(strcat(file,".csv"));
s = size(initial);
st = 265;
en = s(1,1);

# price;weekly avg (price);5-week average(price);52-week avegage(price);volume;weekly avg (volume);5-week average(volume);52-week average(volume);%change in price;%change in volume 

final = zeros((en-st),32);

# Copying volume and stock price

for i = st:en

	final(i+1-st,1) = initial(i,1);
	final(i+1-st,5) = initial(i,2);

# 1 - Week average

	final(i+1-st,2) = mean(initial(i-5:i-1,1));
	final(i+1-st,6) = mean(initial(i-5:i-1,2));
# 5 - Week average

	final(i+1-st,3) = mean(initial(i-25:i-1,1));
	final(i+1-st,7) = mean(initial(i-25:i-1,2));

# 52 - Week Average

	final(i+1-st,4) = mean(initial(i-260:i-1,1));
	final(i+1-st,8) = mean(initial(i-260:i-1,2));

# % changes 

	final(i+1-st,9) = ((initial(i-1,1) - initial(i-2,1))/initial(i-1,1))*100;
	final(i+1-st,10) = ((initial(i-1,2) - initial(i-2,2))/initial(i-1,2))*100;
end

for i = 3:en-st

# % change in 1 Week

	final(i-2,11) = ((final(i-1,2) - final(i-2,2))/final(i-1,2))*100;
	final(i-2,14) = ((final(i-1,6) - final(i-2,6))/final(i-1,6))*100;

# % change in 5 Week

	final(i-2,12) = ((final(i-1,3) - final(i-2,3))/final(i-1,3))*100;
	final(i-2,15) = ((final(i-1,7) - final(i-2,7))/final(i-1,7))*100;

# % change in 52 Week

	final(i-2,13) = ((final(i-1,4) - final(i-2,4))/final(i-1,4))*100;
	final(i-2,16) = ((final(i-1,8) - final(i-2,8))/final(i-1,8))*100;
end

avg = mean(final(:,1:16));
div = max(abs(final(:,1:16).-avg));
final(:,17:32) = ((final(:,1:16).-avg)./div);
div(1)
a = 10

for i = 1:en-st
for j = 17:24
if final(i,j) < 0
	final(i,j) = 0.5 - final(i,j)/2;
else
	final(i,j) = 0.5 + final(i,j)/2;
end
end

sv = genvarname (strcat(file))

mkdir LT
cd LT 

save sv final

plot(final(:,1));
hold on
plot(final(:,2),'r');
grid('on')
ylabel('Value (in Rs.)')
xlabel('Day')
title(strcat("Actual Price and 1 week moving average (",file,")"))
box('off')
legend('Price (in Rs.)', '1-week moving average (in Rs.)') 
print('one.png')
hold off;

plot(final(:,1));
hold on
plot(final(:,3),'r');
grid('on')
ylabel('Value (in Rs.)')
title(strcat("Actual Price and 5 week moving average (",file,")"))
box('off')
legend('Price (in Rs.)', '5-week moving average (in Rs.)') 
print('five.png')
hold off;

plot(final(:,1));
hold on
plot(final(:,4),'r');
grid('on')
ylabel('Value (in Rs.)')
title(strcat("Actual Price and 52 week moving average (",file,")"))
box('off')
legend('Price (in Rs.)', '52-week moving average (in Rs.)') 
print('fiftytwo.png')
hold off;

plot(final(:,5));
hold on
plot(final(:,6),'r');
grid('on')
ylabel('Value')
title(strcat("Traded Volume and 1 week moving average (",file,")"))
box('off')
legend('Volume', '1-week moving average') 
print('oneV.png')
hold off;

plot(final(:,5));
hold on
plot(final(:,7),'r');
grid('on')
ylabel('Value')
title(strcat("Traded Volume and 5 week moving average (",file,")"))
box('off')
legend('Volume', '5-week moving average') 
print('fiveV.png')
hold off;

plot(final(:,5));
hold on
plot(final(:,8),'r');
grid('on')
ylabel('Value')
title(strcat("Traded Volume and 52 week moving average (",file,")"))
box('off')
legend('Traded Volume', '52-week moving average') 
print('fiftytwoV.png')
hold off;

# % change

plot(final(:,9));
hold on
plot((final(:,13).*50),'r');
grid('on')
ylabel('%')
title(strcat("Percentage change in Volume and Price  (",file,")"))
box('off')
legend('Price', 'Volume') 
print('perVP.png')
hold off

plot(final(:,1));
hold on
plot(final(:,2),'r');
plot(final(:,3),'g');
plot(final(:,4),'y');
grid('on')
ylabel('Value (in Rs.)')
xlabel('Day')
title(strcat("Price  (",file,")"))
box('off')
legend('Price', '1-week Moving Average', '5-week Moving Average', '52-week Moving Average') 
print('CombineP.png')
hold off

plot(final(:,5));
hold on
plot(final(:,6),'r');
plot(final(:,7),'g');
plot(final(:,8),'y');
grid('on')
ylabel('Value')
title(strcat("Volume(",file,")"))
box('off')
legend('Volume', '1-week Moving Average', '5-week Moving Average', '52-week Moving Average') 
print('CombineV.png')
hold off

cd ..

end
