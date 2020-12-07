% WRITE HERE YOUR SCRIPT FOR EXERCISE 7   
% A while loop to find an approximation of e to 4dp
n = 0;
approx = 0;
while ((exp(1) - approx) >= 0.0001)
    approx = approx + (1/factorial(n));
    n = n + 1;
end

fprintf("The built in value of e is: %.8f \n", exp(1));
fprintf("The approximation of e to 4dp when n = %d is: %.4f \n", n, approx);