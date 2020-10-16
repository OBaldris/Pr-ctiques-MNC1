%%pràctica 5

clear all
close all

%a
x=[];
n=4;
j=(0:n);
x=-1+2*j/n;

z=[];
m=100;
k=(0:m);
z=-1+2*k/m;

P=zeros(m+1,n+1);

for i=1:n+1
    den=x(i)-x; 
    den(i)=1;
    for k=1:m+1;
        num=z(k)-x; 
        num(i)=1;
        P(k,i)=prod(num)/prod(den);
    end
end



%b
%per un sol cal
n=3;
x=-1+2*(0:n)/n;
m=100;          
z=-1+2*(0:m)/m;             
P=matriulagrange(x,z);

        
in=1;       
figure(in);
plot(z,P(:,1),'color','k')
hold on
plot(z,P(:,2),'color','r')
hold on
plot(z,P(:,3),'color','m')
hold on
plot(z,P(:,4))
hold on
plot(x,0,'o')
grid on

%per tots els casos
for n=[3,6,9]
    x=-1+2*(0:n)/n;         
    [P]=matriulagrange(x,z);
    in=in+1;    
    figure(in);             
    plot(z,P,'color','k')
    hold on
    n_string=['n=' num2str(n)];
    title(n_string)
end

hold off


%%*c*
%un sol n
n=8;        
m=100;
x=-1+2*(0:n)/n;
z=-1+2*(0:m)/m;

P=matriulagrange(x,z);
l=sum(abs(P),2);

in=in+1;
figure(in)
plot(z,l)
hold on


%per tots els casos
in=in+1;
figure(in)
in2=0;
for n=[8,16,24,32]
    x=-1+2*(0:n)/n;
    [P]=matriulagrange(x,z);
    l=sum(abs(P),2);
    in2=in2+1;
    subplot(2,2,in2);
    plot(z,l,'color', 'k')
    hold on
    n_string=['n='];
end



%*d*
in=in+1;
figure(in);
m=200;
z=-1+2*(0:m)/m;
epsilon=[];

for n=4:2:60
    x=-1+2*(0:n)/n;
    P=matriulagrange(x,z);
    fx=exp(x);
    fz=P*fx';
    epsilon=[epsilon max(abs(fz-exp(z)'))];
end

n=(4:2:60);
semilogy(n,epsilon)
hold on 
semilogy(n,eps*2.^n./(n.*log10(n)),'color','r')


%%cridar a una funció













