% WRITE HERE YOUR FUNCTION FOR EXERCISE 2 
function word = uniqueword(x)
% Add integers to the end of a string starting at 1, first time the
% function is called and increasing to 5. After 5 an error message appears.
persistent digit
if isempty(digit)
    digit = 1;
    word = strcat(x, string(digit));
    digit = digit + 1;
elseif digit<=5
    word = strcat(x, string(digit));
    digit = digit + 1;
else
  error('5 words have already been created')  
end
end