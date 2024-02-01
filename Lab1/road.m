clear;
% Matris med alla givna värden, en rad per punkt
% X_a Y_a X_b Y_b L_a L_b
AB = [175 950 160 1008 60 45; 410 2400 381 2500 75 88; 675 1730 656 1760 42 57];

% Matris med punkterna, en rad per punkt
% X Y iter
P = zeros(5,3);
P(5, 1) = 1020;

% Funktionerna i en matris
f = @(x, y, i) [(x-AB(i,1))^2 + (y-AB(i,2))^2 - AB(i,5)^2; (x-AB(i,3))^2 + (y-AB(i,4))^2 - AB(i,6)^2];

% Jacobianen i en matris (derivera varje funkton med avseende på varje
% variabel)
J = @(x, y, i) [2*(x-AB(i,1)) 2*(y-AB(i,2)); 2*(x-AB(i,3)) 2*(y-AB(i,4))];

% Loop som ritar ut cirklarna för att hitta lämpliga gissningar
for i = 1:3
    hold on
    %axis equal
    th = 0:pi/50:2*pi;
    xunitA = AB(i,5) * cos(th) + AB(i,1);
    yunitA = AB(i,5) * sin(th) + AB(i,2);
    xunitB = AB(i,6) * cos(th) + AB(i,3);
    yunitB = AB(i,6) * sin(th) + AB(i,4);
    plot(xunitA, yunitA);
    plot(xunitB, yunitB);
    %hold off
end

% Stargissningar från grafen
xstart = [205 458 712];
ystart = [1002 2457 1749];

% Vald tolerans
tol = 1e-10;

% Loop för de tre punkterna
for i = 1:3
    iter = 0;
    x = xstart(i);
    y = ystart(i);
    hnorm = 1;
    % Newtons metod
    % h = -J\f
    while abs(hnorm) > tol
        h = -J(x,y,i)\f(x,y,i);
        x = x + h(1); y = y + h(2);
        hnorm = norm(h);
        iter = iter + 1;
    end
    % Samlar svaren i punktmatrisen (P)
    P(i+1,1) = x;
    P(i+1,2) = y;
    P(i+1,3) = iter;
end

% Fjärdegradspolynom
p4 = @(c, x) c(1) + c(2)*x + c(3)*x.^2 + c(4)*x.^3 + c(5)*x.^4;

% Alla koordinater från punktmatristen (P)
x = P(1:end, 1);
y = P(1:end, 2);

% Matrisen för vad varje x-värde blir upphöjt i 0, 1, ..., 4
A = [ones((size(x))), x, x.^2, x.^3, x.^4];
% A*c=y, Vilka c-värden uppfyller detta?
c = A\y;

% Ett spann av x-värden för att rita polynomet
xv = P(1,1):1:P(5,1);
% Spannet av y-värden från varje värde i x-spannet i polynomet, p4(xv)
yv = p4(c, xv);

% Printar punktmatrisen (P)
P

% Plottar polynomet
plot(xv, yv, "r--");
hold on
% Plottar punkterna
plot(x, y, "ro");
hold off