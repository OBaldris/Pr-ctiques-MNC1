function [ff]=barifun(x,fx,z)
n = length(x); 
ff = 0*z; 
num = ff ; 
den = ff ;
s = (-1).^[0:n-1]';
sn = s.*[fx(1)/2; 
fx(2:end-1); 
fx(end)/2];
sd = [s(1)/2; s(2:end-1); s(end)/2];

for ii = 1:length(num)
num = ((z(ii) - x).^(-1))'*sn;
den = ((z(ii) - x).^(-1))'*sd;
ff(ii) = num/den;
end

