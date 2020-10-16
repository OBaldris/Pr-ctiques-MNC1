%%Pràctica 4 Oriol Baldrís
clear all
close all

%%a: representació de paràbola, perfil i la seva diferència
x=[0:0.1:200]; %valor on x està definit
v0=37; %velocitat inicial
al=67.5*pi/180; %angle de tir, passat a radiants
a=0.15;
b=0.04;
%definim les funcions de la paràbola, el perfil i la diferencia entre els dos i expresem gràficament les funcions
ypar=((v0*sin(al))/(v0*cos(al)))*x-4.905*(x.^2/(v0*cos(al)).^2); 
figure(1)
plot(x,ypar)
yper=a*x.^2.*exp(-b*x);
figure(2)
plot(x,yper)
f=ypar-yper;
figure(3)
plot(x,f)
%%


%%b Càlcul de la intersecció per mitjà del mètode de Newton
param=[v0,al]; %definim els dos paràmetres
[f]=resta(x,param); %cridem la funció de la resta de parabola i perfil
x1=15; %punt incicial des d'on es farà el Newton
itmax=1000; %nombre màxim d'iteracions del Newton
tol=1e-10; %tolerància del Newton
%cridem la funció del mètode de Newton, aplicada a la funció resta i als inputs definits avans
[xk,fxk,it] = newton(x1,tol,itmax,@resta,param);
puntinterseccio=xk(end)
%%

%%c Representació de l'abast i de l'error
%abast:
%creem el vector it, que són els valors enters entre 1 i 11 
it=[1:1:11]; 
figure(4)
plot(it,xk)
%error
%creem el vector xkv, que és la diferència entre un vector, on el valor de l'arrel és repetit tantes vegades com iteracions, i el vector xk, que són els diversos valors de x a cada iteració. Per tant el vector resultat és l'error a cada iteració.
xkv = abs(transpose(xk(end)+zeros(11,1))-xk);
figure(5)
plot(it,xkv)
%%


%%d
%creem el vector epsilonk, que és les posicions intermitges de xkv.  No es pot agafar tot el vector xkv, ja que els valors a l'inici i al final varien de l'ordre de convergència, i fa que aquest no es pugui trobar epsilonk=xkv(3:end-3); Creem epsilonk1, on cada posició d'aquest vector es la següent de epsilonk (representa k+1)
epsilonk = xkv(3:end-3);
epsilonk1 = xkv(4:end-2);
%Apliquem la funció de regressió lineal. L'output a és l'ordre de convergència.
[r,a,b]=reg_lin(log10(abs(epsilonk)),log10(abs(epsilonk1)));
ordreconvergencia=a
figure(6)
plot(log(abs(epsilonk)), log(abs(epsilonk1)))
%%


%%e
%Definim tres vector buit corresponents a les arrels x, el nombre d'iteracions del Newton per cada angle i l'angle emparat a cada iteració. S'aniràn omplit del valor corresponent a cada iteració.
xks=[];
numit=[];
alphas=[];
%Es crea la variable pic, que permetrà trobar l'angle mínim
pic=50;
angleminim = 0;
%Es defineix un bucle per tots els valor entre 5 i 80 graus(passats a  radiants,amb una diferència de 0.001 entre si
for alpha0 = 5.*pi/180:0.001:80.*pi/180;
    %el valor incicial x per el Newton serà 10 quan l'angle estigui entre 5 i 50, i serà equivalent a l'arrel xk(end) trobada a la l'iteració anterior quan l'angle sigui superior. D'aquesta forma, ens assegurem que sempre troba l'arrel corresponent al punt d'impacte
    if alpha0<50.*pi/180;
        x1=10;
    else
        x1=xk(end);
    end
    %apliquem el Newton 
    param=[v0 alpha0];
    [F]=resta(xks,param);
    tol=1.000e-10;
    itmax=100;
    [xk,fxk,it] = newton(x1,tol,itmax,@resta,param);
    %modifiquem els vectors xks, alphas i numit, afegint-hi l'arrel trobada, l'angle utilitzat i el nombre d'iteracions respectivament, per a cada iteració.
    xks=[xks xk(end)];
    alphas=[alphas alpha0];
    numit=[numit it] ;
    %per tal de trobar l'angle mínim per tal de que el tir parabolic pael pic del perfil, s'agafa el valor "pic", i es defineix com a angle mínim a l'angle que permeti que es sobrepassi. Quan això succeeix, es canvia el valor de pic per un de molt alt, de tal forma que no es torni a complir el condicional i l'angle obtingut sigui el primer en  complir-ho. 
    if xk(end) > pic
        angleminim=alpha0
        pic = 1000;
    end
end
figure(7)
plot(alphas,xks)
figure(8)
plot(alphas,numit)

%%iii
%{
La irregularitat que presenta la funció prop de l'angle mínim fa referència al nombre d'iteracions necessaries per trobar l'arrel. Prop d'aquest valor, la funció es pràcticament plana, i per tal està molt mal condicionada per troar-ne les arrels. Comprovem que el major nombre d'iteracions es troba a l'angle mínim, mostrant que dins el vector de les iteracions, el component més gran correspon a l'angle mínim, tret del vector de angles.
%}
[itlim, i]=max(numit);
alphas(i);



%{
Annex: Funcions

1.Newton:
function [xk,fxk,it]=newton(x1,tol,itmax,fun,param)
xk=[x1];
it=0;
tolk=1000;
fxk=[fun(x1,param)];
dx=1e-8;
while (it<itmax) && (tolk>tol)
    dfk=(fun(xk(end)+dx,param)-fun(xk(end),param))/dx;
    xk1=xk(end)-fxk(end)./dfk;
    fxk1=fun(xk1,param);
    xk=[xk xk1];
    fxk=[fxk fxk1];
    it=it+1;
    tolk=abs(xk(end)-xk(end-1));
end

2.Resta de paràbola i perfil
function [f] = resta(x,param)
v0=param(1);
al=param(2);
a=0.15;
b=0.04;
ypar=((v0*sin(al))/(v0*cos(al)))*x-4.905*(x.^2/(v0*cos(al)).^2);
yper=a*x.^2.*exp(-b*x);
f=ypar-yper;
end
%}
