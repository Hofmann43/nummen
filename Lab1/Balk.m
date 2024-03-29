clear

% H-värde givet i uppgiften
H = 0.5;

% Utgånggissning
T_gissning = 4.5;
H_gissningar = [4, 5];

T = T_gissning;


iter1 = 0;

% Funktionen
y = @(t) 8.*exp(-t/2).*cos(3.*t);

% Skillnaden mellan H (sökt värde) och funktiones värde (nuvarande värde)
f = @(t) H - y(t);

% Derivastans definition
% f'(x) = lim_h->0 (f(x+h) - f(x)) / h
fd = @(x, h) (f(x+h) - f(x))/h;

% Derivatan av f()
% fd = @(t) 4*exp(-t/2)*cos(3*t)+24*exp(-t/2)*sin(3*t);

% Noggrannhet
tol = 1e-8;

% Newtons Metod ( r_n+1 = r_n - f(r_n)/fp(r_n) )
while abs(f(T)) > tol
    T = T - f(T)/fd(T, 1e-8);
    iter1 = iter1 + 1;
end
T
iter1

% Plottar för x=0 till x=10
x = 0:0.1:10;
% Den faktiska svängningen (givet i uppgifetn)
plot(x, y(x), "b", LineWidth=2)
hold on
% Linje föra att se att vårt värde för skärningen är korrekt
% och lämplig startgissning.
yline(H, "r--", LineWidth=2)
hold off

% b)
% Sekantmetoden 
g = @(h0, h1) h1 - f(h1) * (h1 - h0)/(f(h1) - f(h0));
h0 = 0; % h_n-1
h1 = H_gissningar(1); % h_n
h2 = H_gissningar(2); % h_n+1
iter2 = 0;

% Loopar genom sekantmetoden
while abs(h2 - h1) > tol
    h0 = h1;
    h1 = h2;
    h2 = g(h0, h1);
    iter2 = iter2 + 1;

end
T2 = h2
iter2

% Newtons metod är snabbare då den har en konverhensordning på 2
% medan Sekantmetoden har en konvergensorning på ca 1,62

% c)
% Beräknar maxitter för att få rätt längd på x-axeln. 
maxiter = max(iter1, iter2)+1;
% Skapar två kolumnvektorer med 0or.
t_dif1 = zeros(maxiter, 1);
t_dif2 = zeros(maxiter, 1);


T0 = T_gissning; % Startgisning på tiden.
T1 = 0; % Håller koll på skillanden i gissningar.

h0 = 0; % h_n-1
h1 = 4; %h_n
h2 = 5; %h_n+1

for i = 1:maxiter
    % Newtons metod
    T1 = T0 - f(T0)/fd(T0, 1e-9);
    % Sparar skillanden på gissningarna i kolumnvektorn.
    t_dif1(i) = abs(T0-T1);
    T0 = T1;
    
    h0 = h1;
    h1 = h2;
    % Kallar sekantmetoden.
    h2 = g(h0, h1);
    % Sparar skillanden på gissningarna i kolumnvektorn.
    t_dif2(i) = abs(h1-h2);
end
% Skapar rätt längd på x-axeln
x = 1:maxiter;
figure;
% Plottar Newtons metod.
semilogy(x, t_dif1(x), "r--s")
hold on
% Plottar Sekantmetoden.
plot(x, t_dif2(x), "b--o")
legend("Newtons metod", "Sekantmetoden")