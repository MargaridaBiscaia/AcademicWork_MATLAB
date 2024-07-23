% Parameter B
B = [1, 2, 3];
% Parameter A
A = 1;
% Initial conditions
y0 = [0, 1];  % u0 = 0; v0 = 1;
% Time
tspan = [0, 30];

for k = 1:length(B)
    % System of differential equations
    f = @(t, y) [A + y(1)^2*y(2) - (B(k) + 1)*y(1); B(k)*y(1) - y(1)^2*y(2)];
    % Solution using ode45
    [t, y] = ode45(f, tspan, y0);
    % Solutions for u and v
    u = y(:, 1); v = y(:, 2);
    % Plots
    subplot(3, 1, k);
    plot(t, u, 'b-', t, v, 'r-');
    legend('u', 'v');
    xlabel('Time');
    title(['B = ', num2str(B(k))]);
end

