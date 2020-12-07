% WRITE HERE YOUR FUNCTION FOR EXERCISE 4 
function finalchars = buildrandomstrings(n)
% When n>0 a cell array of length n with an additional random character
% added to the end of each cell is created. When n<0 a cell array of length
% |n| is created with each cell having one less character on the end of it.
if n > 0
    finalchars = cell(1,n);
    letters = '';
    for i = 1:n
        letter = char(randi([97,122],1,1));
        letters = strcat(letters,letter);
        finalchars{i} = letters;
    end
elseif n < 0
    finalchars = cell(1,n*-1);
    letters = '';
    for i = 1:n*-1
        letter = char(randi([97,122],1,1));
        letters = strcat(letters,letter);
        finalchars{i} = letters;
    end
    finalchars = flip(finalchars);
end
end
