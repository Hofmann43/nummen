clear

% --- Uppgift 1 ---

% Följande kurva beskriver konturen av ett vattentorn (0 <= x <= 20)
y = @(x, B) (exp(B * x) + 8) ./ (1 + (x / 5).^3);
f = @(x, B) (y(x, B).^2);

% Antal steg
n = 1280;
% Undre integrationsgräns
a = 0;
% Övre integrationsgräns
b = 20;
% Beta-värde
Beta = 0.2;

% Approximation med trapetsregeln
T = pi*trapets(f,n,a,b, Beta);

% Steglista som dubblas, ger halva steglängden
n_k = zeros(10,1);
j = 2;
for i=1:10
    n_k(i,1) = j;
    j=j*2;
end

% Aproximationer med trapetsregeln där steglängden halveras
T_k = zeros(1,length(n_k));
for i=1:length(n_k)
    T_k(1,i) = pi*trapets(f,n_k(i),a,b,Beta);
end

% Tabell för approximationerna där steglängden halveras
% Antal steg | Aprox. | Fel jämfört med 1280 steg | Nogrannhetsordning log((e_h)/(e_h/2))/log(2)
tabellT = zeros(length(n_k), 4);
for i=1:length(n_k)
    tabellT(i,1) = n_k(i); % Stegen
    tabellT(i,2) = T_k(i); % Svaren
    tabellT(i,3) = abs(T-T_k(i)); % Felet
    if i > 1
        tabellT(i,4) = log(tabellT(i-1,3)/tabellT(i,3))/log(2); % Ordningen
    end 
end

% Plottar felet
figure
semilogy(n_k, tabellT(1:end,3), "r");
xlabel('Steg');
ylabel('Felet');
title('Trapetsregeln: fel');
hold off


% Approximation med simpsons metod
S = pi*simpsons(f,n,a,b, Beta);

% Aproximationer med simpsons metod där steglängden halveras
S_k = zeros(1,length(n_k));
for i=1:length(n_k)
    S_k(1,i) = pi*simpsons(f,n_k(i),a,b,Beta);
end

% Tabell för approximationerna där steglängden halveras
% Antal steg | Aprox. | Fel jämfört med 1280 steg | Nogrannhetsordning log((e_h)/(e_h/2))/log(2)
tabellS = zeros(length(n_k), 4);
for i=1:length(n_k)
    tabellS(i,1) = n_k(i); % Stegen
    tabellS(i,2) = S_k(i); % Svaren
    tabellS(i,3) = abs(S-S_k(i)); % Felet
    if i > 1
        tabellS(i,4) = log(tabellS(i-1,3)/tabellS(i,3))/log(2); % Ordningen
    end
end

% Plottar felet
figure
semilogy(tabellS(1:end,1), tabellS(1:end,3), "b");
xlabel('Steg');
ylabel('Felet');
title('Simpsons metod: fel');
hold off

% Rita tornet
figure
x = (0:10)';
y = f(x, Beta);
fi = 0:2*pi/100:2*pi;

X = x*ones(size(fi));
Y = y*cos(fi);
Z = y*sin(fi);
mesh(X,Y,Z)
hold off

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
