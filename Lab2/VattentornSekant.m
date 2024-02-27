clear
y = @(x, B) (exp(B * x) + 8) ./ (1 + (x / 5).^3);
f = @(x, B) (y(x, B).^2);
g = @(B) (pi*integral(@(x) f(x, B), 0, 20)-1500);

B0 = 0.25;
B1 = 0.3;
B = 0;

while abs(g(B)) > 10e-2
    B1 = B-g(B)*(B-B0)/(g(B)-g(B0));
    B0 = B;
    B = B1;
end
B





    
    
    
    