function E=error_pred(XX,Y)

E{1,1}='MAE';
E{2,1}='TP';
E{3,1}='FP';
E{4,1}='TN';
E{5,1}='FN';
E{6,1}='Precision';
E{7,1}='Recal';
E{8,1}='Accuracy';
E{9,1}='F-score';

for i=2:size(XX,2)+1
X=XX(:,i-1);

E{9,i}=[];
R=X-Y; T=length(Y);
E{1,i}=sum(abs(R))/T; % MAE

Y2=find(Y==1); 
R2=sum(X(Y2)==1)/length(Y2); % TP: true positive
E{2,i}=R2; % MAE

R3=sum(X(Y2)==0)/length(Y2); % FP: false positive
E{3,i}=R3;

Y3=find(Y==0); 
E{4,i}=sum(X(Y3)==0)/length(Y3); % TN: true negative

R5=sum(X(Y3)==1)/length(Y3); % FN: false negative
E{5,i}=R5;

prec=R2/(R2+R3);
E{6,i}=prec;

rec=R2/(R2+R5);
E{7,i}=rec;

E{8,i}=sum(X==Y)/T; % accuracy

E{9,i}=2*prec*rec/(prec+rec); % F-score
end