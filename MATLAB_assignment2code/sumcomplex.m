% WRITE HERE YOUR FUNCTION FOR EXERCISE 8 
function [structure, sumselect] = sumcomplex(R,I,S)
% Return a structure of the inputted imaginary numbers and a sum of the S
% indexed imaginary numbers.
if length(R) ~= length(I)
    error("real and imaginary vector lengths differ")
elseif max(S) > length(R)
    error("The array S has a value that is too large")
else
    structure = struct('real',[],'img',[]);
    for i = flip(1:length(R))
        structure(i) = struct('real',R(i),'img',I(i));
    end
    sum_array = [sum(R(S)), sum(I(S))];
    sumselect = string(sum_array(1)) + ' + ' + string(sum_array(2)) + 'i';
end



