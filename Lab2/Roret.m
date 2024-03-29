% --- Uppgift 4 --- 
clear

Ti = 500; % Vätskans temperatur
Te = 20; % Luftens temperatur
T0 = Ti; % Randvärde 1 (Inre temperaturen)

% c)
% Givna värden i uppgiften
N = 10000;
alfa = 5;
k = 1;

T_old = 0;
T_new = 1;

while abs(T_new-T_old) > 1e-2 % Två decimalers noggrannhet
    T_old = T_new;
    T = temperatur(N, T0, Te, alfa, k);
    T_new = T(end);
    N = N*2;
end
N = N/2; % Dividera med två för att få det slutgiltiga N-värdet
T_new
% T_r i r = 2
T(N*1)

figure
i = 1:N; % Skapar en lista av i-värden
plot(linspace(1,2,length(T)),T(i), "r", LineWidth=2)
hold on
xline(1.7) % Grafisk lösning
title("Temperaturen i röret")
xlabel("Radie (le)")
ylabel("Temperatur (C)")
hold off


% d)
alfa = linspace(0,10,20);
T = zeros(length(alfa), 0);

for i=1:length(alfa) 
    vektor = temperatur(10000, T0, Te, alfa(i), k);
    T(i) = vektor(end);
end
T

figure
plot(alfa, T, "bo-",LineWidth=2);
title("T_N beroende av alfa")
xlabel("Värmeflödeskonstanten")
ylabel("Temperaturen i T_N")
hold off

function T = temperatur(N, T0, Te, alfa, k)

    h = 1/N; % Steglängden

    %i = 1:N; % Skapar en lista av i-värden

    ri = (1+h:h:1+N*h)'; % Inre punkter

    A = zeros(N); % Skapar en tom N*N matris

    % Första raden behandlas separat
    A(1,1:2) = [(-2*ri(1)/h^2) ri(1)/h^2 + 1/(2*h)];

    for ii=2:N-1
        % T_(i-1)
        A(ii,ii-1) = (ri(ii)/h^2 - 1/(2*h));
        % T_i
        A(ii,ii) = (-2*ri(ii))/h^2;
        % T_(i-1)
        A(ii,ii+1) = (ri(ii)/h^2 + 1/(2*h));
    end
    
    % Sista raden behandlas separat
    A(N,N-1:N) = [ri(N)/h^2 - 1/(2*h), (-ri(N)/h^2) - (ri(N)*alfa)/(h*k) - alfa/(2*k) + 1/(2*h)];

    A = sparse(A); % Sparar minne

    b = zeros(N,1); % Skapar en tom b-vektor

    % Randvillkåren
    b(1) = - T0 *(ri(1)/h^2 - 1/(2*h));
    b(N) = -Te*(ri(N)*alfa/(h*k) + alfa/(2*k));

    T = A\b; % A*T = b

end

