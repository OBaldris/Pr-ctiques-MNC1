function[P]=matriulagrange(x,z)
n=length(x)-1;
m=length(z)-1;
for i=1:n+1
    den=x(i)-x; 
    den(i)=1;
    for k=1:m+1;
        num=z(k)-x; num(i)=1;
        P(k,i)=prod(num)/prod(den);
    end
end

