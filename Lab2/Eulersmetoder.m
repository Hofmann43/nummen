clear
% Definiera funktionen och exakt lösning
f = @(t,y) sin(3*t) - 2*y;
y_exact = @(t) (93/65)*exp(-2*t) - (3/13)*cos(3*t) + (2/13)*sin(3*t);

% Startvärden
T = 80;
Y0 = 1.2;
n_values = [50,100,400,800];

figure;
subIdx = 1;
t_list = linspace(0, T); 


 errorsFE = zeros(length(n_values),1);
 errorsBE = zeros(length(n_values),1);

 h_values = zeros(length(n_values),1);

% Loop över olika n-värden
for j = 1:length(n_values)
    N = n_values(j);
    h = T/N; % Steglängd
    h_values(j) = h; % sparar h
    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde

    % Skapa vektorer
    yVecFE = zeros(N+1, 1); 
    yVecBE = zeros(N+1, 1);
    tVec = linspace(0, T, N+1)';
    yVecFE(1) = Y0;
    yVecBE(1) = Y0;


    % Eulers metod frammåt
    for i = 1:N
        Y = Y + h * f(t, Y); 
        yVecFE(i+1) = Y; 
        t = t + h; 
    end

    Y = Y0; % Återställ Y till startvärde för varje N
    t = 0; % Återställ t till startvärde

    %Eulers metod bakåt
    for i = 1:N
        t_next = t + h; 
        % Implicit formel för Y
        Y = (Y + h * sin(3*t_next)) / (1 + 2*h);
        yVecBE(i+1) = Y; 
        t = t_next; 
    end
   
    
    % Beräkna felet vid t = T och sparar i en vecktor
    errorsFE(j) = abs(y_exact(T) - yVecFE(end));
    errorsBE(j) = abs(y_exact(T) - yVecBE(end));
    

    % plottar alla 4 N med den exakta lösningen
    subplot(2, 2, subIdx);
    plot(t_list, y_exact(t_list), 'k-', 'LineWidth', 2); % exakt lösning
    hold on;
    % Plot Euler-lösningar
    plot(tVec, yVecFE,'DisplayName', sprintf('N=%d', N));
    plot(tVec, yVecBE,'DisplayName', sprintf('N=%d', N));
    hold on;
    
    % Design
    title(sprintf('N=%d', N));
    xlabel('t');
    ylabel('y(t)');
    legend('Exakt lösning', 'Framåt-Euler', 'Bakat-Euler');
    subIdx = subIdx + 1;
end


%title('Euler-lösningar och exakt lösning');
%xlabel('t');
%ylabel('y(t)');
%legend ("show")
%hold off;

% Plottar felet för både framåt och bakåt
figure;
loglog(h_values, errorsFE, '-o','Color', 'b');
hold on;
loglog(h_values, errorsBE, '-o','Color', 'r');

% design
title('Fel vid t = T som funktion av steglängden h');
xlabel('Steglängd h');
ylabel('Fel vid t = T');



