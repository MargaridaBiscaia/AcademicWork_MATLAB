%Exercício 5
clc;clear;
f=@(r) (1/2)*sqrt((5*r.^2) - 18*r + 17);
[a, b] = fplot(f, [9/5, 17/9]);

g=@(r) (1/5)*sqrt((11*r.^2) - 36*r + 34);
[c, d] = fplot(g, [17/9, 29/8]);

h=@(r) sqrt((3*r.^2) - 20*r + 35);
[e, f] = fplot(h, [29/8, 4]);

x=linspace(0.4,0.8);
t=(sqrt(822)/8)*x + 0.25; %Rácio de Sharpe e rf

hold on
plot(b,a)
plot(d,c)
plot(f,e)
plot(x,t);
plot((sqrt(822)/61), (118/61), '.', 'MarkerSize',12); %Risco e Retorno
hold off
