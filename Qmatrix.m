function Q=Qmatrix(Xz,M,G,D)
% function for calculating the matrix Q

d=length(D); Q=zeros(G,M*d); 
for i=1:d
    r=Xz.^D(i);
    Q(:,M*(i-1)+1:M*i)=r./(1+exp(-r)); % Type: power Swish 
end