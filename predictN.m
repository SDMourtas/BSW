function Y=predictN(X,W,N,X_min,X_max,b)
% function for predicting
fis = readfis('NLC');

x_N=Normalization(X,X_min,X_max);
M=size(x_N,2);

if nargin==5
    b=1;
end
Q=Qmatrix(x_N.*b,M,size(X,1),N);
Y_N=Q*W; 

neutrosophic_outputs = evalfis(fis, Y_N);

T = neutrosophic_outputs(:, 1); % Truth
I = neutrosophic_outputs(:, 2); % Indeterminacy
F = neutrosophic_outputs(:, 3); % Falsity

Y = (I <= T) .* (T >= F);