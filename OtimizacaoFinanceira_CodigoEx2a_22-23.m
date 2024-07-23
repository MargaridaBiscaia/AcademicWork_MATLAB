%Exercício 2(a)
f=@(x,y) 4*x.^2 + 3*y.^2 + 2*x.*y - 6*x - 4*y + 3;
g=@(x) 1 - 3*x;
h=@(x) 1-x;

x=linspace(0,1,100);
[x, y]=meshgrid(x,x);

Z=f(x,y);
contour(x,y,Z,175)

hold on
fplot(g, [0 1/3], 'r')
hold on
fplot(h, [0 1], 'b')
hold off