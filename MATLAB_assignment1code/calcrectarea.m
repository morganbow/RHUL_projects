% CS 5810  -- Programming for data analysis 
%
%  Assignment 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 2


function area = calcrectarea(l,w)
% Calculate the area of rectangles from their lengths and widths.
if numel(l) == numel(w)
    area = l .* w;
else
    disp("Error!")
    fprintf("You have given %d length values \n", numel(l))
    fprintf("And you have given %d width values \n", numel(w))
    disp("For the function to work please enter the same number of length values and width values\n")
end
end

