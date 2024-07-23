% Parameters
Smax = 40; % Maximal stock price (usualy considered Smax = 4*K)
K = 10; % Strike price
r = 0.1; % Risk-free rate
sigma = 0.4; % Volatility
T = 0.25; % Time to maturity (in years)

N = 200; % Number of stock price steps
M = 2000; % Number of time steps
h = Smax/(N+1); % Step size in the stock price direction
dt = (T-0)/M; % Step size in the time direction

% Initialize the stock price and option value matrices
S = zeros(N+2, 1);
VC = zeros(N+2, M+1); % call option
VP = zeros(N+2, M+1); % put option

% Set the initial conditions
S(:,1) = linspace(0,Smax,N+2);
VC(:,1) = max(S-K, 0); % for a call option
VP(:,1) = max(K-S, 0); % for a put option

% Set the boundary conditions
% for a call option
VC(1, :) = 0;
VC(N+2, :) = Smax - K*exp(-r*(0:M)*dt) ;
% for a put option
VP(1, :) = K*exp(-r*(0:M)*dt);
VP(N+2, :) = 0;

% Compute the option values at each time step
for j = 2:M+1
    for i = 2:N+1
        VC(i, j) = (1-r*dt)*VC(i,j-1) + dt*(0.5*sigma^2*(S(i)^2)*(1/h^2)*(VC(i+1,j-1)-2*VC(i,j-1)+VC(i-1,j-1)) + r*S(i)*(VC(i+1,j-1)-VC(i-1,j-1))/(2*h));
        VP(i, j) = (1-r*dt)*VP(i,j-1) + dt*(0.5*sigma^2*(S(i)^2)*(1/h^2)*(VP(i+1,j-1)-2*VP(i,j-1)+VP(i-1,j-1)) + r*S(i)*(VP(i+1,j-1)-VP(i-1,j-1))/(2*h));
    end
end

% Calculate the exact solution at each time step
t = (0:M)*dt;
d1 = (log(S(:)/K) + (r + 0.5*sigma^2)*t) ./ (sigma*sqrt(t));
d2 = d1 - sigma*sqrt(t);
VCexact = S(:).*normcdf(d1) - K*exp(-r*t).*normcdf(d2);
VPexact = K*exp(-r*t).*normcdf(-d2) - S(:).*normcdf(-d1);

% Plot the option value at maturity
figure(1)
plot(S, VC(:,M+1),'LineWidth',1,'Color','b');
hold on;
plot(S, VCexact(:,M+1),'--','LineWidth',1,'Color','r');
hold off;
xlabel('Stock Price');
ylabel('Option Value');
title('Call Option Value at Maturity');
legend('Aproximate solution','Exact solution');
figure(2)
plot(S, VP(:,M+1),'LineWidth',1,'Color','b');
hold on;
plot(S, VPexact(:,M+1),'--','LineWidth',1,'Color','r');
hold off;
xlabel('Stock Price');
ylabel('Option Value');
title('Put Option Value at Maturity');
legend('Aproximate solution','Exact solution');
figure(3)
s = surf(t, S, VC);
s.EdgeColor = 'none';
title('Call Option Value');
xlabel('Time');
ylabel('Stock Price');
zlabel('Option Value');
figure(4)
s = surf(t, S, VP);
s.EdgeColor = 'none';
title('Put Option Value');
xlabel('Time');
ylabel('Stock Price');
zlabel('Option Value');



