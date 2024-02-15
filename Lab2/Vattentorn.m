clear
g = @(x, B) (exp(B * x) + 8) ./ (1 + (x / 5).^3);

f = @(x, B) (g(x, B).^2);
n = 1280;
a = 0;
b = 20;
B = 0.2;

T = pi*trapets(f,n,a,b, B);

n_k = zeros(10,1);

j = 2;
for i=1:10
    n_k(i,1) = j;
    j=j*2;
end

T_k = zeros(1,length(n_k));


for i=1:length(n_k)
    T_k(1,i) = pi*trapets(f,n_k(i),a,b,B);
end

test = abs(T - T_k);
semilogy(n_k, test);
xlabel('Number of subintervals (n)');
ylabel('Absolute Error');
title('Convergence Analysis');

tabellT = zeros(length(n_k), 4);
for i=1:length(n_k)
    tabellT(i,1) = n_k(i);
    tabellT(i,2) = T_k(i);
    tabellT(i,3) = abs(T-T_k(i));
    if i > 1
        tabellT(i,4) = tabellT(i-1,3)/tabellT(i,3);
    end
    
end

S = pi*simpsons(f,n,a,b, B);
n_k = zeros(10,1);

j = 2;
for i=1:10
    n_k(i,1) = j;
    j=j*2;
end

T_k = zeros(1,length(n_k));

for i=1:length(n_k)
    T_k(1,i) = pi*simpsons(f,n_k(i),a,b,B);
end

figure
testS = abs(S - T_k);
semilogy(n_k, testS);
xlabel('Number of subintervals (n)');
ylabel('Absolute Error');
title('Convergence Analysis');

tabellS = zeros(length(n_k), 4);
for i=1:length(n_k)
    tabellS(i,1) = n_k(i);
    tabellS(i,2) = T_k(i);
    tabellS(i,3) = abs(S-T_k(i));
    if i > 1
        tabellS(i,4) = tabellS(i-1,3)/tabellS(i,3);
    end
    
end


function T = trapets(f, n, a,b, B)
    h = (b - a) / n; % Beräknar steglängden
    x = a:h:b; % Skapar en vektor med x-värden från a till b med n intervall
    fx = f(x, B); % Beräknar funktionsvärdena för dessa x-värden
    %plot(x,fx)
    
    % Använd trapetsregeln för att beräkna integralen
    T = h * (sum(fx) - 0.5 * (fx(1) + fx(end)));
    

    %errT = abs(T-()
end

function S = simpsons(f, n, a, b, B)
    h = (b - a) / n; % Beräknar steglängden
    odd = 0;
    even = 0;
    for i=1: 2: n-1
        xi = a + (h * i);
        odd = odd + f(xi, B);
    end
    for i=2:2:n-2
        xi = a + (h * i);
        even = even + f(xi, B);
    end
        S = (h/3) * (f(a, B) + 4*odd + 2*even + f(b, B));

end

