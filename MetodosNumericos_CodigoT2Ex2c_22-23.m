a = 0; b = 1; T = 30;
N = 60; h = (b-a)/(N+1); x = (a:h:b)'; % space mesh
M = 10000; dt = (T-0)/M; Time = (0:dt:T); % time mesh
r = dt/(h*h); % CFL number
alpha = 1/50;
u0 = @(x) 1 + sin(2*pi*x); % initial condition
E = ones(N,1);
K = spdiags([-E 2*E -E],-1:1, N, N);

S = zeros(N,1);
Q = zeros(N,1);
S(1) = -1;
Q(N) = -1;

% Necessary matrices
U = zeros(N + 2, M + 1);
V = zeros(N + 2, M + 1);
Ui = zeros(N,M + 1);
Vi = zeros(N,M + 1);

I = speye(N); A = [zeros(N,1) I zeros(N,1)] - alpha*r*[S K Q];
U(:,1) = u0(x); % initial condition
V(:,1) = 3*ones(N+2,1); % initial condition
Ui(:,1) = U(2:N+1,1);
Vi(:,1) = V(2:N+1,1);

i = 1;
for t=dt:dt:T
    Ui(:,i + 1) = A*U(:,i) + dt*(Ui(:,i).^2.*Vi(:,i) - 4*Ui(:,i) + ones(N,1));
    Vi(:,i + 1) = A*V(:,i) + dt*(3*Ui(:,i) - Ui(:,i).^2.*Vi(:,i));
    U(:,i + 1) = [1; Ui(:,i + 1); 1];
    V(:,i + 1) = [3; Vi(:,i + 1); 3];
    i = i + 1;
end

% Plots
subplot(2, 1, 1);
s = surf(Time,x, U)
s.EdgeColor = 'none';
title('U')

subplot(2, 1, 2);
s = surf(Time,x, V)
s.EdgeColor = 'none';
title('V')
