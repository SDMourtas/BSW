%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A 3-layer feed-forward neuronet model, trained by a BSW          %
%  algorithm. (version 1.0)                                         %
%                                                                   %
%  Developed in MATLAB R2025a                                       %
%                                                                   %
%  Author and programmer: R.T. Alqahtani, T.E. Simos,               %
%                         S.D. Mourtas, X.Cao, S.Li, V.N. Katsikis  %
%                                                                   %
%   e-Mail: tsimos.conf@gmail.com                                   %
%           vaskatsikis@econ.uoa.gr                                 %
%           spirmour@econ.uoa.gr                                    %
%                                                                   %
%   Main paper: R.T.Alqahtani, T.E.Simos, S.D.Mourtas, X.Cao, S.Li, %
%   V.N.Katsikis, "A Soft-Margin Neutrosophic-Logic Bio-Inspired    % 
%   WASD Neural Network for Human Activity Recognition in Assistive %
%   Technologies and Pattern Classification", (submitted)           %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

% Choose modeling problem (for x = 1 to 4)
x=1; 
[X_train,Y_train,X_test,Y_test,p,dmax]=problem(x);

%% Training
% Data Preprocessing
[X_N,X_min,X_max]=Normalization(X_train); % Normalization

% Neuronet model
b0=zeros(1,size(X_N,2));
tic;[W,Em,N,E,b,EE]=BSW(X_N,Y_train,p,dmax,b0);toc  % BWASD model
tic;[W2,Em2,N2,E2]=SW(X_N,Y_train,p,dmax);toc         % WASD model
tic;FineKNN_Model=FineKNN_Cl([X_train,Y_train]);toc     % Fine KNN model 
tic;FineTree_Model=FineTree_Cl([X_train,Y_train]);toc   % Tree: Fine Tree model 
tic;LinearSVM_Model=LinearSVM_Cl([X_train,Y_train]);toc % Linear SVM model 
tic;EBT_Model=EBT_Cl([X_train,Y_train]);toc             % Ensemble Bagged Trees model 
tic;KNB_Model=KNBayes_CL([X_train,Y_train]);toc         % Kernen Naive Bayes model 


%% Predict
pred_B=predictN(X_test,W,N,X_min,X_max,b);    % BWASD prediction
pred_S=predictN(X_test,W2,N2,X_min,X_max);       % WASD prediction
predKNN = FineKNN_Model.predictFcn(X_test);      % KNN prediction
predFT = FineTree_Model.predictFcn(X_test);      % FT prediction
predSVM = LinearSVM_Model.predictFcn(X_test);    % SVM prediction
predEBT = EBT_Model.predictFcn(X_test);          % EBT prediction
predKNB = KNB_Model.predictFcn(X_test);          % KNB prediction

% Error of test data 
pred_test=[pred_B,pred_S,predKNN,predFT,predSVM,predEBT,predKNB];
EPTe=error_pred(pred_test,Y_test); 
[h,pp] = McNemar_test(pred_test,Y_test);

%% Figures
Problem_figures(pred_test,Y_test,E,EE,Em,E2,Em2)
rng("default")