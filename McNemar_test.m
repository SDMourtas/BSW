function  [h,p,e1,e2]=McNemar_test(P,Y)
% null hypothes: the predicted class labels P1 and P2 have equal accuracy
% for predicting the true class labels Y.
% h = 1 indicates to reject the null hypothesis at the 5% significance level. 
% h = 0 indicates to not reject the null hypothesis at 5% level.
% A result is said to be statistically significant if it allows us to 
% reject the null hypothesis (i.e. h = 1).
% Smaller p-values (typically <= 0.05) are taken as stronger evidence 
% against the null hypothesis.

z=size(P,2); h=zeros(z); p=h; e1=h; e2=h;
for i=1:z
    for j=1:z
[h(i,j),p(i,j),e1(i,j),e2(i,j)] = testcholdout(P(:,i),P(:,j),Y);
    end
end

