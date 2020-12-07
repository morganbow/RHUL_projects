% WRITE HERE YOUR SCRIPT FOR EXERCISE 7 
% A while loop to find an approximation of e to 4dp
n=2;
while ((1/exp(1)) - (1-(1/n))^n >= 0.0001)
    n = n + 1;
end
e_approx = (1-(1/n))^-n;
fprintf("The built in value of e is: %.8f \n", exp(1));
fprintf("The approximation of e to 4dp when n = %d is: %.4f \n", n, e_approx);