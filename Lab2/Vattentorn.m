clear
g = @(x) (exp(0.2 * x) + 8) ./ (1 + (x / 5).^3);

f = @(x) (g(x).^2);
n = 1280;
a = 0;
b = 20;
T = trapets(f,n,a,b);
S = simpsons(f,n,a,b);



function T = trapets(f, n, a,b)
    h = (b - a) / n; % Beräknar steglängden
    x = a:h:b; % Skapar en vektor med x-värden från a till b med n intervall
    fx = f(x); % Beräknar funktionsvärdena för dessa x-värden
    
    % Använd trapetsregeln för att beräkna integralen
    T = pi*(h * (sum(fx) - 0.5 * (fx(1) + fx(end))));
    
    
end

function S = simpsons(f, n, a, b)
    h = (b - a) / n; % Beräknar steglängden
    odd = 0;
    even = 0;
    for i=1: 2: n-1
        xi = a + (h * i);
        odd = odd + f(xi);
    end
    for i=2:2:n-2
        xi = a + (h * i);
        even = even + f(xi);
    end
        S = pi*((h/3) * (f(a) + 4*odd + 2*even + f(b)));

end





    
