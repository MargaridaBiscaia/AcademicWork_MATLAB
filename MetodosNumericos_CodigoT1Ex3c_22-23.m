clc; close; clear;
% data 
f = @(x,y) 8*cos(x-y).*sin(x-y);
u = @(x,y) cos(x-y).*sin(x-y); 
h_values = [0.1, 0.05, 0.025];
errors = zeros(size(h_values));

for k = 1:length(h_values)
    h = h_values(k);
    N = 1/h -1;
    [x,y] = meshgrid(0:h:1,0:h:1);
    % compute numerical solution
    U = MDF(f,u,h);
    % compute error
    Uex = u(x,y); % exat solution
    e = h*norm(Uex-U);
    errors(k) = e;
end
% print errors and order
disp('       h      |         Erro       ');
disp('_____________________________________');
for k = 1:length(h_values)
    fprintf('  %10.5f  |   %1.15f\n', h_values(k), errors(k)); 
end
ordem = log(errors(2)/errors(3))/log(h_values(2)/h_values(3));
disp('_________________________________________________');
fprintf(' Ordem de Convergência |       %d        \n', ordem);
