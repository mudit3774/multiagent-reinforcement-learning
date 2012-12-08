function R = Reward(bias_in_models,adj,big_number)

number_of_models = size(bias_in_models)(1,2);
R = ones(number_of_models,number_of_models);
diagonal = diag(bias_in_models);
R = adj*diagonal

for i = 1:number_of_models
for j = 1:number_of_models
if R(i,j) == 0
	R(i,j) = big_number;
end
end
end

end
 
