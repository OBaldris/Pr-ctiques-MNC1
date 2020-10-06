   %%Pràctica 3 - Oriol Baldrís

%%13.Mètode de Newton

func = @(x) x^2-4*x*sin(x)+(2*sin(x))^2-3*x %%funció a analitzar
tol = 10^-10    %%tolerància final
it = 0          %%contador d'iteracions        
itmax = 100     %%límit d'iteracions
x1 = 3          %%x inicial
xk = [x1]       %%creació del vector xk on s'ubiquen les diverses xk
fxk = [func(x1)]%%càlcul de la funció en x
dx = 10^-8      %%èpsilon per calcular la derivada
tolk = 10       %%tolerància inicial
while (tolk>tol) & (it<itmax)
    %%inici de bucle on es calcula xk
    dfk = (func(xk(end)+dx)-func(xk(end)))/dx;%%derivada de xk
    xk1 = xk(end)-fxk(end)/dfk;               %%càlcul de la nova xk
    fxk1 = func(xk1);                         %%càlcul funció en xk
    xk = [xk xk1];                            %%addició de la nova xk 
    fxk = [fxk fxk1];                         %%addició de la nova fxk 
    it = it+1                                 %%contador d'iteracions
    tolk = abs(xk(end)-xk(end-1))             %%càlcul nova tolerància
end

arrel= xk(end)   