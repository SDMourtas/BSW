function Ev=fitness(X,Y,b,M,G,N,G1,G2)
% fitness function

% WDD Method
Q=Qmatrix(X.*b,M,G,N);
W=pinv(Q(1:G1,:))*Y(1:G1); 
Ev=100/G2*sum(abs(Q(G1+1:G,:)*W-Y(G1+1:G))); % MAE