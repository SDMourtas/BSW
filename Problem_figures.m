function Problem_figures(pred,Y_test,E,EE,Em,E2,Em2)
[k,ind]=sort(Y_test); pr=pred(:,1); k_pr=pr(ind); k_def=find(k==1);

figure
b1=k_def(1)-1;      % actual false, "0"
b3=sum(k_pr(1:b1)); % predicted true, "1", in comparison with the actual false
b2=b1-b3;           % predicted false, "0", in comparison with the actual false
b4=sum(k);          % actual true, "1"
b5=sum(k_pr(b1+1:end)); % predicted true, "1", in comparison with the actual true
b6=b4-b5;           % predicted false, "0", in comparison with the actual true
b = [b1 b2 b3; b4 b5 b6];
Bar = bar([1 2], b);
for i = 1:numel(Bar)
    xtips = Bar(i).XEndPoints; 
    ytips = Bar(i).YEndPoints; 
    labels = string(Bar(i).YData); 
    text(xtips, ytips, labels, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
end
box on
Bar(1).FaceColor = [0.3010 0.7450 0.9330];
Bar(2).FaceColor = [0.4940 0.1840 0.5560];
ylabel('Testing Set Samples')
xlabel('Classification')
xticklabels({'True','False'})
legend('Actual Clasiffication','Correct Predictions','Incorrect Predictions')

figure
semilogy(1:length(E),E,'Color',[0.4940 0.1840 0.5560])
hold on
semilogy(1:length(E2),E2,'-.','Color',[0.3010 0.7450 0.9330])
plot(find(E==Em),Em,'.','Color',[0.9290 0.6940 0.1250],...
    'MarkerSize',16)
plot(find(E2==Em2),Em2,'.','Color',[0.9290 0.6940 0.1250],...
    'MarkerSize',16)
xlabel('Hidden Layer Iterations');ylabel('MAE %');xlim([1 length(E)])
legend('BSW','SW','Minimum Points')
hold off

figure
semilogy(1:length(EE),EE,'Color',[0.4940 0.1840 0.5560])
hold on
plot(find(EE==Em),Em,'.','Color',[0.9290 0.6940 0.1250],...
    'MarkerSize',16)
xlabel('BAS Iterations');ylabel('MAE %');xlim([1 length(EE)])
legend('BSW','Min Point')
hold off

figure
n=size(pred,2); cor=zeros(n,1); incor=cor;
for i=1:n
test_results=pred(:,i)==Y_test; 
len=length(test_results); cor(i)=sum(test_results); incor(i)=len-cor(i);
end
b = [cor, incor];
Bar = bar(1:n, b);
for i = 1:numel(Bar)
    xtips = Bar(i).XEndPoints; 
    ytips = Bar(i).YEndPoints; 
    labels = string(Bar(i).YData);     
    text(xtips, ytips, labels, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
end
set(Bar(1), 'FaceColor', [0.4940 0.1840 0.5560]);
set(Bar(2), 'FaceColor', [0.9290 0.6940 0.1250]);
box on;
ylabel('Testing Set Samples')
xlabel('Classification Results')
xticklabels({'BSW','SW','KNN','FT','SVM','EBT','KNB'})
legend('Correct','Incorrect')