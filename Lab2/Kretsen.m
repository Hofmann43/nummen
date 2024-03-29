clear


% Dämpad svängning
L = 2;
C = 0.5;
R = 1;

% Tidspann
tspan = [0, 20];

% Initialvärden
Y0 = [1; 0];

% Löser ekvatioen
[TOUT_dampad,YOUT_dampad] = ode45(@(t, Y) odesyst(Y, L, R, C), tspan, Y0);

% Plotta lösningen
figure;
plot(TOUT_dampad, YOUT_dampad(:,1), 'b');
hold on;

% Odämpad svängning
R = 0;

% Löser ekvatioen
[TOUT_odampad,YOUT_odampad] = ode45(@(t, Y) odesyst(Y, L, R, C), tspan, Y0);

% Plotta lösningen
plot(TOUT_odampad, YOUT_odampad(:,1), 'r');
hold off;


% Startvärden
T = 40;
R = 1;
tspan = [0, 40];
n_values = [40,80,160,320];

t_list = linspace(0, T); 
figure;

% Loop över olika n-värden
for j = 1:length(n_values)
    N = n_values(j);
    h = T/N; % Stegläng
    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde

    % Skapa vektorer
    yVec = zeros(N+1, 2); 
    tVec = linspace(0, T, N+1)';
    yVec(1,:) = Y0';
    
    dY = 0;
    % Eulers metod frammåt
    for i = 1:N
        dY = odesyst(Y, L, R, C); % Beräkna derivatan
        Y = Y + h * dY; % Uppdatera Y
        yVec(i+1,:) = Y; % Spara nya Y

    end
    [TOUT_dampad,YOUT_dampad] = ode45(@(t, Y) odesyst(Y, L, R, C), tspan, Y0);
    subplot(2, 2, j);
    plot(TOUT_dampad, YOUT_dampad(:,1), 'b', 'DisplayName', 'ODE45');
    hold on;
    plot(tVec, yVec(:,1), 'r--', 'DisplayName', sprintf('Euler N=%d', N));
    hold off;
    title(sprintf('Lösning med N = %d', N));
    legend show;
    
end

function dY = odesyst(Y, L, R, C)
    % Laddningen
    q = Y(1);
    % Strömmen
    i = Y(2);
    
    % Differential equations system
    dq = i;
    di = -(R/L)*i - (1/(L*C))*q;
    
    % En lista med strömmen och laddningen som ode45 använder
    dY = [dq; di];
end

