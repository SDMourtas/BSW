function [x_N,x_min,x_max]=Normalization(x,x_min,x_max)
% function for normalization
if nargin==1
    x_min=min(x);x_max=max(x);
else
    [row,col]=find(isnan(x));
    x(row,col)=0;
end

x_N=(x-x_min)./(4*x_max-4*x_min)-0.5;

[row,col]=find(isnan(x_N));
x_N(row,col)=-0.5;