for i = 5:5:100
ErrorIterations(:,i/5) = neural(10,1,2,i,1);
endfor
for i = 0.1:0.2:2
Errorlambda(:,i/5) = neural(10,i,2,25,1);
endfor
for i = 5:5:25
ErrordVal(:,i/5) = neural(i,1,2,25,1);
endfor
