clear
load STHLMARLANDA2023.mat

% T(t) = c_1 + c_2t + A_0sin(wt) + A_1cos(wt);
% Där A_0 = c_3cos(wt_s), och A_1 = -c_3sin(wt_s)

% Periodtiden ett år (givet)
w = 2*pi/(365*24);

% Numret på timmen (x-axeln)
t = (1:size(Td))';

% Matrisen från funktionen
A = [ones(size(t)), t, sin(w*t), cos(w*t)];

% A[]*c-> = Td->
c = A\Td;

% Plockar vi ut konstanterna ur c
c1 = c(1); % Ungefärlig medeltemp över tid.
c2 = c(2); % Representerar långsiktig minskning/ ökning.
A0 = c(3);
A1 = c(4);

% Funktionen given i uppgiften
T = @(c, t) c(1) + c(2)*t + A0*sin(w*t) + A1*cos(w*t);

% Ränkar ut faktiska c3(amplituden) & ts(fasförskjutning) (från A0 & A1)
c3 = sqrt(A0^2 + A1^2); % Hittar genom trigettan som tar bort cos och sin.
ts = acos(A0/c3)/w; % Använder c3 för att hitta ts
ts_test = asin(-1*A1/c3)/w; % Ger ett annat svar av någon anledning

% Plottar den faktiska temperaturen.
plot(t, Td)
hold on
% Plottar temperaturen från vår funktion (T(c,t))
plot(t, T(c, t),"r", LineWidth=1.5)
hold off

% Residualen (skillnaden mellan väntat värde och funktionens värde) och
% dess norm
r = Td - T(c,t);
r_norm = norm(r, 2)

% Om trenden är positiv eller negativ
sign(c2)