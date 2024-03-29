clear
% Euler framåt stabilitet: y'=-λy, y(0)=1, => h<2/λ

% Definiera funktionen och exakt lösning
f = @(t,y) sin(3*t) - 2*y;
y_exact = @(t) (93/65)*exp(-2*t) - (3/13)*cos(3*t) + (2/13)*sin(3*t);

% Startvärden
T = 8;
Y0 = 1.2;
n_values = [50,100,200,400];


errorsFE = zeros(length(n_values),1);
errorsBE = zeros(length(n_values),1);

h_values = zeros(length(n_values),1);

yVecFE = zeros(n_values(end), 4); 
yVecBE = zeros(n_values(end), 4);

figure
% Loop över olika n-värden
for j = 1:length(n_values)
    N = n_values(j);
    h = T/N; % Steglängd
    h_values(j) = h; % sparar h
    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde



    % Skapa vektorer

    tVec = linspace(0, T, N+1)';
    yVecFE(1, j) = Y0;
    yVecBE(1, j) = Y0;


    % Eulers metod frammåt
    for i = 1:N
        Y = Y + h * f(t, Y); 
        yVecFE(i+1, j) = Y; 
        t = t + h; 
    end

    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde

    %Eulers metod bakåt
    for i = 1:N
        t_next = t + h; 
        % Implicit formel för Y
        Y = (Y + h * sin(3*t_next)) / (1 + 2*h);
        yVecBE(i+1, j) = Y; 
        t = t_next; 
    end
   
    
    % Beräkna felet vid t = T och sparar i en vecktor
    errorsFE(j) = abs(y_exact(T) - yVecFE(N+1, j));
    errorsBE(j) = abs(y_exact(T) - yVecBE(N+1, j));
    
    plot(tVec, yVecFE(1:size(tVec),j),'DisplayName', sprintf('N=%d (framåt)',N))
    plot(tVec, yVecBE(1:size(tVec),j),'DisplayName', sprintf('N=%d (bakåt)',N))
    hold on
end
plot(tVec, y_exact(tVec),'k-','DisplayName','Exakt lösning',LineWidth=2)
title('Euler-lösningar och exakt lösning');
xlabel('t');
ylabel('y(t)');
legend ("show")
hold off;

% Plottar felet för Framår-Euler
figure;
loglog(h_values', errorsFE', '-o','Color', 'b');
hold off;

% design
title('Fel vid t = T som funktion av steglängden h (Framåt-Euler)');
xlabel('Steglängd h');
ylabel('Fel vid t = T');

% Plottar felet för Bakåt-Eueler
figure
loglog(h_values', errorsBE', '-o','Color', 'r');
hold off

% design
title('Fel vid t = T som funktion av steglängden h (Bakåt-Euler)');
xlabel('Steglängd h');
ylabel('Fel vid t = T');


% --- e & f ---

% Startvärden
T = 80;
Y0 = 1.2;
n_values = [50,100,400,800];

h_values = zeros(length(n_values),1);

yVecFE = zeros(n_values(end), 4); 
yVecBE = zeros(n_values(end), 4);

figure
subIdx = 1;
% Loop över olika n-värden
for j = 1:length(n_values)
    N = n_values(j);
    h = T/N; % Steglängd
    h_values(j) = h; % sparar h
    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde



    % Skapa vektorer

    tVec = linspace(0, T, N+1)';
    yVecFE(1, j) = Y0;
    yVecBE(1, j) = Y0;


    % Eulers metod frammåt
    for i = 1:N
        Y = Y + h * f(t, Y); 
        yVecFE(i+1, j) = Y; 
        t = t + h; 
    end

    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde

    %Eulers metod bakåt
    for i = 1:N
        t_next = t + h; 
        % Implicit formel för Y
        Y = (Y + h * sin(3*t_next)) / (1 + 2*h);
        yVecBE(i+1, j) = Y; 
        t = t_next; 
    end
   
    subplot(2,2, subIdx);
    plot(tVec, y_exact(tVec),'k-',LineWidth=2);
    hold on

    % Design
    title(sprintf('N=%d', N));
    xlabel('t')
    ylabel('y(t)')
    legend('Exakt lösning', 'Framåt Euler', 'Bakåt Euler')
    subIdx = subIdx + 1;

    plot(tVec, yVecFE(1:size(tVec),j),'DisplayName', sprintf('N=%d (framåt)', N));
    plot(tVec, yVecBE(1:size(tVec),j),'DisplayName', sprintf('N=%d (bakåt)', N));
end

