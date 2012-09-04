NumAgents = 100;
Features = 10;
TickCount = 100;
NumBias = 5;
ConversionFactor = 1;
BaseValue=100;
A = zeros(Features,1);		
C = zeros(Features,1);		
W = ones(Features,1);
w_k = ones(Features,NumAgents);
a_k = ones(Features,NumAgents);
c_k = ones(Features,NumAgents);
aPlusc_k = zeros(Features,NumAgents);
b_kt = zeros(Features,NumBias,NumAgents);
P = zeros(NumAgents,1);
PW = ones(NumAgents,1);
Index = zeros(TickCount,1);
for j=1:TickCount
	I = zeros(Features,1);
	for i=1:Features
		I(i)=rand(1);
	end;
	for i=1:NumAgents
	%Update a, w and c
		for k = 1:Features
			if a(k,i)>=A(k)
				a(k,i)=1;
			
			else
				a(k,i)=0;
			end;
		end;
		for k = 1:Features
			if c(k,i)>=C(k)
				c(k,i)=1;
			
			else
				c(k,i)=0;
			end;
		end;
		for k = 1:Features
			if a(k,i)==0||c(k,i)==0
				aPlusc(k,i)=0;
			
			else
				aPlusc(k,i)=1;
			end;
		end;
		for k = 1:Features
			w(k,i)*aPlusc(k,i);
		end;
		P(i)=I'*w(:,i);
		P(i)=P(i)/Features;
		P(i)=P(i)*PW(i);
	end;
	if rand(1)<0.5
		BaseValue=BaseValue-sum(P)/NumAgents;
	else
		BaseValue=BaseValue+sum(P)/NumAgents;
	end;
	Index(j,i)=BaseValue;
end;
YL = [80,120];
plot(Index);
ylim(YL);

