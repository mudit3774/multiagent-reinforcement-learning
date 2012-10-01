NumAgents = 100;
NumFeatures = 10;
TickCount = 5;
NumBias = 5;
ConversionFactor = 1;
BaseValue = 100;
A = zeros(NumFeatures,1);		
C = zeros(NumFeatures,1);		
W = ones(NumFeatures,1);
w_k = zeros(NumFeatures,NumAgents);
wBase_k = ones(NumFeatures,NumAgents);
a_k = ones(NumFeatures,NumAgents);
c_k = ones(NumFeatures,NumAgents);
aPlusc_k = zeros(NumFeatures,NumAgents);
b_ki = zeros(NumFeatures,NumBias,NumAgents);
P = zeros(NumAgents,1);
PW = ones(NumAgents,1);
Index = zeros(TickCount,1);
for j=1:TickCount
	I = zeros(NumFeatures,1);
	for i=1:NumFeatures
		I(i)=rand(1);
	end;
	for i=1:NumAgents
	%Update a, w and c
		for k = 1:NumFeatures
			if a_k(k,i)>=A(k)
				a_k(k,i)=1;
			else
				a_k(k,i)=0;
			end;
		end;
		for k = 1:NumFeatures
			if c_k(k,i)>=C(k)
				c_k(k,i)=1;
			
			else
				c_k(k,i)=0;
			end;
		end;
		for k = 1:NumFeatures
			if a_k(k,i)==0||c_k(k,i)==0
				aPlusc_k(k,i)=0;
			else
				aPlusc_k(k,i)=1;
			end;
		end;
		for k = 1:NumBias
			for l = 1:NumFeatures
				w_k(l,i) = w_k(l,i)+b_ki(l,k,i);
			end; 		
		end;
		w_k(:,i) = w_k(:,i) + wBase_k(:,i); 		
		for k = 1:NumFeatures
			w_k(k,i)*aPlusc_k(k,i);
		end;
		P(i)=I'*w_k(:,i);
		P(i)=P(i)/NumFeatures;
		P(i)=P(i)*PW(i);
	end;
	if rand(1)<0.5
		BaseValue=BaseValue-(sum(P)/NumAgents)*ConversionFactor;
	else
		BaseValue=BaseValue+(sum(P)/NumAgents)*ConversionFactor;
	end;
	Index(j,i)=BaseValue;
end;
YL = [40,160];
plot(Index);
ylim(YL);

