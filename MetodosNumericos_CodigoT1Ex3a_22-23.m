clc; close; clear;
% data, boundary conditions and mesh grid
f = @(x,y) 8*cos(x-y).*sin(x-y);
u = @(x,y) cos(x-y).*sin(x-y); 
h = 0.05; N = 1/h -1;
[x,y] = meshgrid(0:h:1,0:h:1);
% plot the solution
U = MDF(f,u,h);
surf(x,y,U), title(['FD solution: N = ',num2str(N)])
