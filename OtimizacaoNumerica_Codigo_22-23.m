%% Exercício 1
a = 0; b = 3;
xx = a:0.1:b; % x em [a,b]

% definir as funções f e g
f = @(x) (x-1).^2;
g1 = @(u,v,x) (f(a)-v)/(a-u)*(x-a) + f(a);
g2 = @(u,v,x) (f(b)-v)/(b-u)*(x-b) + f(b);

figure(1)
u = 1.9; v = 0.5;
xx1 = a:0.1:u; % x em [a,u]
xx2 = u:0.1:b; % x em [u,b]
hold on
plot(xx,f(xx),'k',xx1,g1(u,v,xx1),xx2,g2(u,v,xx2))
scatter(u,v,10,'k','filled')
legend('f(x)','g1(x)','g2(x)');
text(u, v, '(u,v)', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12);
title('Representação do problema (P)');
hold off

%% Exercício 3
% definir a função objetivo
f1 = @(t,u,v) (f(t) - g1(u,v,t)).^2;
f2 = @(t,u,v) (f(t) - g2(u,v,t)).^2;

fObj = @(x) integral(@(t) f1(t,x(1),x(2)), a, x(1)) + integral(@(t) f2(t,x(1),x(2)), x(1), b); % x = [x(1), x(2)]

% calcular a solução ótima
x0 = [a + (b-a)/3, 0]; % ponto inicial
[xOpt1, fOpt1, exitFlag, output] = fminsearch(fObj, x0) % Nelder-Mead
[xOpt2, fOpt2, exitFlag, output] = fminunc(fObj, x0) % Quasi-Newton

figure(2)
hold on
plot(xx,f(xx),'k')
plot([a xOpt1(1)], [f(a) xOpt1(2)], [xOpt1(1) b], [xOpt1(2) f(b)])
legend('f(x)','g1(x)','g2(x)');
title('Solução do problema (P)');
hold off

%% Exercício 6
[xOpt3, fOpt3, exitFlag, output] = fmincon(fObj, x0, [], [], [], [], [], [], @(x) constrains(f,x)) % interior-point
options = optimoptions('fmincon','Algorithm','sqp');
[xOpt4, fOpt4, exitFlag, output] = fmincon(fObj, x0, [], [], [], [], [], [], @(x) constrains(f,x), options) % sequencial-programming

figure(3)
hold on
plot(xx,f(xx),'k')
plot([a xOpt3(1)], [f(a) xOpt3(2)], [xOpt3(1) b], [xOpt3(2) f(b)])
legend('f(x)','g1(x)','g2(x)');
title('Solução do problema (P2)');
hold off

%% Exercício 7
lambda = -2:0.1:2;

% definir lagrangeano(x, lambda)
lagrangeano = @(x, lambda) fObj(x) - lambda*(x(2)-f(x(1)));

% definir função dual (calcula o ínfimo através da função auxiliar)
Ld = @(lambda) infLag(lambda,lagrangeano,x0);

LdVec = zeros(1, length(lambda));
for i = 1:length(lambda)
    LdVec(i) = Ld(lambda(i)); % função dual para lambda em [-2,2]
end

% evitar os posíveis valores -infinito
minDual = LdVec > -10000;

figure(4)
plot(lambda(minDual), LdVec(minDual),'k')
title('Função Dual');

%% Exercício 8
maxLd = -100000;
% solução ótima do dual
for i = 1:length(lambda)
    if LdVec(i) >= maxLd
        maxLd =  LdVec(i);
        lambdaOtimo = lambda(i);
    end
end

fprintf("(lambda*, Ld(lambda*)) = (%f, %f) \n", lambdaOtimo, maxLd)

%% Funções auxiliares
% função para calcular as restrições do exercício 6
function [c,ceq] = constrains(f,x)
c = f(x(1)) - x(2);
ceq = []; 
end

% função para obter a solução ótima da funcão dual do exercício 7
function valor = infLag(lambda,lagrangeano,x0)
    [~, valor] = fminsearch(@(x) lagrangeano(x, lambda), x0); 
end




