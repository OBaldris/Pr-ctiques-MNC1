%
close all
clear all

%a
z=(0:1/2000:1);  %creem el vector z de 2000 punts, entre el valor 0 i 1
fz = tanh(20.*sin(12.*z))+0.02.*exp(3.*z).*sin(300.*z);   %apliquem la funció a evaluar per totes les z 
im=1;
figure(im)
plot(z,fz)


%b
e=[];
im=im+1;
%definim un  bucle on la n parteix de 100 i va sumant 100 cada iteració.
%Aquest bucle un interpolació de la funció entre els valors 0 i 1, mitjançant la fórmula baricèntrica dels nodes donats per la distribució de Chebychev.
%Finalment, se'n calcula l'error fent la diferència entre la funció
%avaluada en 2000 punts i la interpolada, i es representa en una gràfica logarítmica
for n=(100:100:1000)            
    z=(0:1/2000:1);
    j=(0:1:n);   v=cos(j*pi/n);   x=0.5*(1+v);
    fx = tanh(20.*sin(12.*x))+(2./100).*exp(3.*x).*sin(300.*x);
    [ff]=barifun(x',fx',z');
    fz=tanh(20.*sin(12.*z))+(2./100).*exp(3.*z).*sin(300.*z);
    e=[e abs(ff-fz')];
    semilogy(z,e)
end


%c
n=100;
%creem el vector nmin on acumulem les n 
nmin=[];
%definim un bucle sota la condició de que el màxim d'error ha de ser 10^-6
while max(abs(e))>10^-6
    %definim un condicional que fagi que la n augmenti de 50 en 50 quan sigui inferior a 1000, i de 1 en 1 quan sigui superior, ja que sabem que el nombre mínim és superior a 1000.
    if n<1000
        n=n+50;
    else
        n=n+1;
    end
    %repetim el càlcul de l'error com en l'apartat b 
    z=(0:1/2000:1);
    j=(0:1:n);   v=cos(j*pi/n);   x=0.5*(1+v);
    fx = tanh(20.*sin(12.*x))+(2./100).*exp(3.*x).*sin(300.*x);
    [ff]=barifun(x',fx',z');
    fz=tanh(20.*sin(12.*z))+(2./100).*exp(3.*z).*sin(300.*z);
    e=[e abs(ff-fz')];
    %ampliem el vector nmin amb la n de cada iteració
    nmin=[nmin n];
end
nombre_minim_de_nodes = nmin(end)




















