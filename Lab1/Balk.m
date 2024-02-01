clear

% H-värde givet i uppgiften
H = 2.8464405473;

% Utgånggissning
T0 = 2;
T1 = 0;

iter1 = 0;

% Funktionen
y = @(t) 8.*exp(-t/2).*cos(3.*t);

% Skillnaden mellan H (sökt värde) och funktiones värde (nuvarande värde)
f = @(t) H - y(t);

% Derivatan av f()
fd = @(t) 4*exp(-t/2)*cos(3*t)+24*exp(-t/2)*sin(3*t);

% Noggrannhet
tol = 1e-8;

% Newtons Metod ( r_n+1 = r_n - f(r_n)/fp(r_n) )
while abs(f(T0)) > tol
    T1 = T0 - f(T0)/fd(T0);
    iter1 = iter1 + 1;
    T0 = T1;
end
T = T1
iter1

% Plottar för x=0 till x=10
x = 0:0.1:10;
%plot(x, y(x), "b", LineWidth=2)
%hold on
%yline(H, "r--", LineWidth=2)
%hold off

% b)
g = @(h0, h1) h1 - f(h1) * (h1 - h0)/(f(h1) - f(h0));
h0 = 0;
h1 = 1.5;
h2 = 2;
iter2 = 0;

while abs(h2 - h1) > marg
    h0 = h1;
    h1 = h2;
    h2 = g(h0, h1);
    iter2 = iter2 + 1;

end
T2 = h2
iter2

% c)
maxiter = max(iter1, iter2);
t_dif1 = zeros(maxiter, 1);
t_dif2 = zeros(maxiter, 1);

T0 = 2;
T1 = 0;
h0 = 0;
h1 = 1.5;
h2 = 2;

for i = 1:maxiter
    T1 = T0 - f(T0)/fd(T0);
    t_dif1(i) = abs(T0-T1);
    T0 = T1;
    
    h0 = h1;
    h1 = h2;
    h2 = g(h0, h1);
    t_dif2(i) = abs(h1-h2);
end

x = 1:maxiter;
figure;
semilogy(x, t_dif1(x), "r--s")
hold on
semilogy(x, t_dif2(x), "b--o")