function pic = equildist(c,lambda,mu)

    pic = ((factorial(c)^-1)*(lambda/mu)^c) ...
        ./sum((factorial(0:c).^-1).*(lambda/mu).^(0:c));

end