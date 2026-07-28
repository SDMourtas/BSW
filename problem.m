function [X_train,Y_train,X_test,Y_test,p,dmax]=problem(xx)
% Input and preparation of the training and testing data for the NN model
warning off
if xx<3
    if exist('X_train.txt', 'file') == 0
        unzip('train.zip'); unzip('test.zip');
    end
    X_tr=readtable('X_train','ReadVariableNames',false,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
    Y_tr=readtable('y_train','ReadVariableNames',false,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
    X_te=readtable('X_test','ReadVariableNames',false,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
    Y_te=readtable('y_test','ReadVariableNames',false,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
    if xx==1
        a=1; b=6; % Example 1: WALKING vs LAYING
    elseif xx==2
        a=2; b=3; % Example 2: WALKING_UPSTAIRS vs WALKING_DOWNSTAIRS
    end

    q1=find(Y_tr{:,:}==a); q2=find(Y_tr{:,:}==b);
    X_train=X_tr{[q1;q2],:}; Y_train=Y_tr{[q1;q2],:}; 
    Y_train(Y_train==a)=0; Y_train(Y_train==b)=1;
    c=length(Y_train); train_row=[1:2:c 2:2:c-1];
    X_train=X_train(train_row,:); Y_train=Y_train(train_row);

    q1=find(Y_te{:,:}==a); q2=find(Y_te{:,:}==b);
    X_test=X_te{[q1;q2],:};  Y_test=Y_te{[q1;q2],:}; 
    Y_test(Y_test==a)=0; Y_test(Y_test==b)=1;

elseif xx>2 || xx<5
    filename='data';  % Examples 3 and 4: BAC and TSLA
    T=readtable(filename,'ReadVariableNames',true,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
    T=T(:,xx-1);
    T.Properties.VariableNames={'close'};

    % remove rows which include Nan in their columns
    col=1;
    [row,~]=find(isnan(T{:,col}));
    row=unique(row);q=1:size(T,1);q(row)=[];T=T(q,:);

    index = rsindex(T);
    M=15; H=size(T,1); tot=H-M+1; Q=zeros(tot,M);
    for i=1:tot
        Q(i,:)=T{i:i+M-1,:};
    end
    D = index{M:end,:};
    D(D<50)=0;D(D>=50)=1;

    % training-testing data
    train_row=1:2:tot; test_row=2:2:tot-1;
    X_train=Q(train_row,:); Y_train=D(train_row);
    X_test=Q(test_row,:); Y_test=D(test_row);

else
    fprintf('Error: No valid problem number.\n')
    return
end

p=0.8;   % cross validation percentage split
dmax=10; % maximum number of hidden-layer
rng(0); for k = 1:200; rands(1, size(X_train,2));end