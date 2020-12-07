% WRITE HERE YOUR FUNCTION FOR EXERCISE 3 
function [] = mysin(n,m)
% Reutrn 2 sin plots with the number of points specifies in the input. The
% style of the plot is picked from two menu functions.
x1 = 0:(2*pi)/(n-1):2*pi;
x2 = 0:(2*pi)/(m-1):2*pi;
y1 = sin(x1);
y2 = sin(x2);
tiledlayout(2,1)

choice1 = menu("Choose a colour", "red", "blue", "green");
choice2 = menu("Choose a point style", "circle", "star");
colour = ['r','b','g'];
style = ['o','*'];

nexttile
plot(x1,y1,strcat(colour(choice1),'-',style(choice2)))
title(string(n) + ' Points')
grid on 

nexttile
plot(x2,y2,strcat(colour(choice1),'-',style(choice2)))
title(string(m) + ' Points')
grid on 
end