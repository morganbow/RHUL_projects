% CS 5810  -- Programming for data analysis 
%
%  Assignment 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your code for exercises 1, 5, 6
% The templates for functions for exercises 2, 3 and 4 are provided in separate files.
%


%% ================== Exercise 1 ==================


% Plotting the sales of two seperate divisions of the ABC Corporation.
load salesfigs.dat
divA = salesfigs(1,:);
divB = salesfigs(2,:);
x = 1:4;
hold on
plot(x,divA, 'ko')
plot(x,divB, 'k*')
legend('Division A','Division B')
xlabel("Quarter")
ylabel("Sales(billions$)")
title("ABC Corporation Sales:2013")



%% ================== Exercise 5 ==================


% Plotting unifrom distributed points and normal distributred points.
xlim([-10 40])
ylim([-5 40])
hold on
grid on
umax = 35;
umin = 20;
uni = (umax-umin).*rand(2,1000) + umin;
plot(sqr(1,:),sqr(2,:), 'r*')
nmaxx = 3;
nmaxy = 5;
xnorm = randn(1,1000) + nmaxx;
ynorm = randn(1,1000) + nmaxy;
plot(xnorm,ynorm, 'b*')

%% ================== Exercise 6 ==================


% A plot of randomly distributed points, where the points that are positive
% in all 3 dimensions are norlamized to have unit length.
d1 = randn(1,10000);
d2 = randn(1,10000);
d3 = randn(1,10000);
matrix = [d1;d2;d3];
logid1 = d1 > 0;
logid2 = d2 > 0;
logid3 = d3 > 0;
sumlogi = logid1 + logid2 + logid3;
ind = sumlogi==3;
matind = [ind;ind;ind];
matrix = matrix(matind);
points = numel(matrix)/3;
matrix = reshape(matrix,3,points);
matrix = normalize(matrix,'norm');
scatter3(matrix(1,:),matrix(2,:),matrix(3,:), 'r*')




