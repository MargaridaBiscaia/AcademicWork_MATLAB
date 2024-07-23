%Exercício 3
f=@(x,y) 4*x.^2 + 3*y.^2 + 2*x.*y - 6*x - 4*y + 3;
g=@(x) 1 - 3*x;
h=@(x) 1 - x;
z=@(x) 1/8*x + 3/8;

x=linspace(0,1,100);
[x, y]=meshgrid(x,x);

Z=f(x,y);
contour(x,y,Z,175)

hold on
fplot(g, [0 1/3], 'r')
fplot(h, [0 1], 'b')
fplot(h, [5/9 3/5],'k','LineWidth',2)
fplot(z, [0 5/9],'k', 'LineWidth',2)

plot(3/5,2/5,'.', 'Markersize', 20, 'Color','k')
plot(5/9,4/9,'.', 'Markersize', 20, 'Color','k')
plot(0,3/8,'.', 'Markersize', 20, 'Color','k')
plot(0,0,'.', 'Markersize', 20, 'Color','k')

hold off