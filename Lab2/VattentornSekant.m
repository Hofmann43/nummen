clear
% Följande kurva beskriver konturen av ett vattentorn (0 <= x <= 20)
y = @(x, B) (exp(B * x) + 8) ./ (1 + (x / 5).^3);
f = @(x, B) (y(x, B).^2);

a = 0;
b = 20;
N = 320;

% Funktionen där ett B-värde ska hittas så att g(B) = 0
g = @(B) (pi*integral(@(x) f(x, B), a, b)-3376);

% Startgissningar
B0 = 0;
B1 = 0.5;
B = 0.4;

i = 0;
% Iterera tills skillnaden har minst två identiska decimaler
while abs(B-B1) > 1e-4
    B0 = B1;
    B1 = B;
    B = B1-g(B1)*(B1-B0)/(g(B1)-g(B0));

    i = i+1;
    Btabell(i, 1) = B1;
end

figure
plot((1:size(Btabell)),Btabell, "r-o")
xlabel("Iterationer")
ylabel("Svar")
title("Sekantmetoden")

% Skriv ut resultatet
B







    
    
    
    