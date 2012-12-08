function [Q,sv,bias_in_models,av] = CalculateReward(st,gama)
iteration = 10;
big_number = 100;
number_of_models = 7;
%bias_in_models = load('modelbias.m');
bias_in_models = [0.1,0.3,0.4,0.5,0.6,0.7,0.9];
%adj = load('adj.m');
adj = [1 1 0 1 0 0 0;1 0 0 1 0 0 0;0 0 0 0 0 1 0;1 1 0 0 0 1 0;0 0 0 0 0 1 1;0 0 1 1 1 0 1;0 0 0 0 1 1 0];
R = Reward(bias_in_models, adj,big_number);
Q = zeros(number_of_models,number_of_models);
Qsnap = zeros(number_of_models,number_of_models);
%st =  ceil(rand(1)*number_of_models)
ac = 1;
val = 0;
sv(1) = floor(st);
tot = 2;
for l = 1:iteration
	%if R(st,i) != big_number
			for j = 1:number_of_models
				Qsnap(st,j) = Q(st,j);
				val = gama*min(Q(j,:));
				Q(st,j) = R(st,j) + val;
			end
		Q;
		stinit = st;
		[val,ac] = min(Q(st,:))
		st = ac;
		if st == stinit
			Q(st,:) = Qsnap(st,:);
		end
		sv(tot) = floor(st);
		av(tot) = val;
		tot = tot + 1; 
		pause;
	%else 
	%	Q(i) = R(st,i);
	%end

end
sv
end
 
