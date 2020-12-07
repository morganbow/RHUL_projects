% WRITE HERE YOUR FUNCTION FOR EXERCISE 6 
function results = mytemperature(a,b)
% Converts Fahrenheit to Celsius in the range sepcified in the input.
range = [a,b];
F = min(range):max(range);
C = (F-32)*5/9;
results = [F',C'];
displaymatrix(results);
end


