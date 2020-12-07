% CS 5810  -- Programming for data analysis 
%
%  Assignment 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 3


function conv = conversion(measure, values)
% Converts meters into feet or feet into meters.
if measure == 'f'
    conv = values * 0.3048;
elseif measure == 'm'
    conv = values * 3.2808;
else
    disp("You did not specify if the values are feet or meters correctly")
end
end
