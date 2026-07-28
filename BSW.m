function [W,Em,N,E,b,EE]=BSW(X,Y,p,dmax,b)
% function for finding the optimal hidden-layer neurons weights of the
% neuronet
tmax=15;dt=5;delta=5;eta_delta=0.95;eta_d=0.95;
% Initialization
N=[]; % the neurons number of the hidden layer (i.e., hidneurons)
Em=inf; E=zeros(dmax,1);
[G,M]=size(X); %b=rand(1,M);
G1=round(p*G); % size of data fitting
G2=G-G1; % size of data validation

for d=0:dmax-1

    Em2=inf; E2=zeros(tmax,1); N2=N; b2=b;
    for t=0:tmax-1
        r=rands(1,M); r=r/(eps+norm(r));
        xr=b+dt*r; xl=b-dt*r;
        Er=fitness(X,Y,xr,M,G,[N2;d],G1,G2);
        El=fitness(X,Y,xl,M,G,[N2;d],G1,G2);
        x=b+delta*r*sign(Er-El);
        Ev=fitness(X,Y,x,M,G,[N2;d],G1,G2);
        E2(t+1)=Ev;
        if Ev<Em2
            Em2=E2(t+1);N2=[N;d];b2=x;
        end
        delta=eta_delta*delta;
        dt=eta_d*dt+0.001;
    end

    E(d+1)=Em2;
    if E(d+1)<Em
        Em=E(d+1);N=N2;b=b2;EE=E2;
    end
end

% output
Q=Qmatrix(X.*b,M,G,N);
W=pinv(Q)*Y; 