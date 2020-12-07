% CS 5810  -- Programming for data analysis 
%
%  Assignment 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 4


function vec = evenodd(n)
% This function will create a vector of length n and then it will find all
% the even values of the vector that are at odd positions.
v = randi([1,30],1,n);
v = v(1:2:n);
vec = v(rem(v,2) == 0);
end
