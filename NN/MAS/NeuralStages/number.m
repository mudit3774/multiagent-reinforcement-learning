function number(mat)
count = 0;
for i = 1:2:size(mat)(1,2)
for j = 2:size(mat)(1,1)
if mat(j,i) != mat(j-1,i)
	count=count+1; 
end
end
count
count = 0;
end
end

