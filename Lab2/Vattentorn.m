clear
g = @(x,B) (exp(B * x) + 8) ./ (1 + (x / 5).^3);

f = @(x) (g(x,B).^2);
B = 0.2;
n = 1280;
a = 0;
b = 20;
T = trapets(f,n,[a b]);


function T = trapets(f, n, limits)
    a = limits(1); % Undre gränsen
    b = limits(2); % Övre gränsen
    h = (b - a) / n; % Beräknar steglängden
    x = a:h:b; % Skapar en vektor med x-värden från a till b med n intervall
    fx = f(x); % Beräknar funktionsvärdena för dessa x-värden
    
    % Använd trapetsregeln för att beräkna integralen
    T = pi*(h * (sum(fx) - 0.5 * (fx(1) + fx(end))));
    
    
end

function T1 = simpsons(f, n, limits)
     a = limits(1); % Undre gränsen
    b = limits(2); % Övre gränsen
    h = (b - a) / n; % Beräknar steglängden
    x = a:h:b; % Skapar en vektor med x-värden från a till b med n intervall
    fx = f(x); % Beräknar funktionsvärdena för dessa x-värden

    T1 = 
end
    
