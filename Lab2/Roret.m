T_i = 450; % Vätskans temperatur
T_e = 20; % Luftens temperatur

N = 4;

r0 = 1; % Randpunkt 1 (Inre radien)
rN1 = 2; % Randpunkt 2 (Yttre radien)

T0 = T_i; % Randvärde 1 (Inre temperaturen)
TN1 = 

h = (rN1-r0)/(N+1); % Steglängden
ri = [r0+h:h:TN1-h]; % Inre punkter

