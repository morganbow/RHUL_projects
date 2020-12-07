% WRITE HERE YOUR FUNCTION FOR EXERCISE 9 
function [mostfreq,wfreq] = wordscount(n,w)
% The function returns the n most frequent words and the number of times w
% appears in the RedRidingHood text
red = char(importdata('RedRidingHood.txt'));
red = strrep(red,'-',' ');
red = split(red);
word_counter = struct('notarealword',0);
for i = 1:length(red)
  if (not(isfield(word_counter,red(i))))
      new_word = string(red(i));
      word_counter.(new_word) = 1;
  else
        old_word = string(red(i));
        word_counter.(old_word) = word_counter.(old_word) + 1;
  end
end
      
values = zeros(1,n);
mostfreq = cell(n,1);
uni = string(unique(red));
for i = 1:length(uni)
    if any(word_counter.(uni(i)) > values) 
        index = find(values==min(values));
        values(min(index)) = word_counter.(uni(i));
        mostfreq{min(index),1} = strcat(uni(i)+": ",string(word_counter.(uni(i))));
    end
end
wfreq = word_counter.(w);
end