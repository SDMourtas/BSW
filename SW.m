function [W,Em,N,E]=SW(X,Y,p,dmax)
% function for finding the optimal hidden-layer neurons weights of the
% neuronet

% Initialization
N=[]; % the neurons number of the hidden layer (i.e., hidneurons)
Em=inf; E=zeros(dmax+1,1);
[G,M]=size(X);
G1=round(p*G); % size of data fitting
G2=G-G1; % size of data validation

for d=0:dmax
    % WDD Method
    Q=Qmatrix(X,M,G,[N;d]);
    W=pinv(Q(1:G1,:))*Y(1:G1);
    Ev=100/G2*sum(abs(Q(G1+1:G,:)*W-Y(G1+1:G))); % MAE
    E(d+1)=Ev;
    if E(d+1)<Em
        Em=E(d+1);N=[N;d];
    end
end

% output
Q=Qmatrix(X,M,G,N);
W=pinv(Q)*Y; 