% WRITE HERE YOUR FUNCTION FOR EXERCISE 5 
function areas = calctrianglearea(x)
% Calculating the area of triangles given by 2D co-ordinate points.
n = length(x);
m = floor(n/3);
extras = x(:,(m*3)+1:n);
x = x(:,1:(m*3));
x = reshape(x,[2,3,m]);
distance12 = reshape((((x(1,1,:)-x(1,2,:)).^2 + (x(2,1,:)-x(2,2,:)).^2).^0.5),[1,m]);
distance13 = reshape((((x(1,1,:)-x(1,3,:)).^2 + (x(2,1,:)-x(2,3,:)).^2).^0.5),[1,m]);
distance23 = reshape((((x(1,2,:)-x(1,3,:)).^2 + (x(2,2,:)-x(2,3,:)).^2).^0.5),[1,m]);
distances = [distance12;distance13;distance23];
s = sum(distances)/2;
areas = (s.*(s-distances(1,:)).*(s-distances(2,:)).*(s-distances(3,:))).^0.5;
fprintf("%d areas have been calculated \n", m)
if not(isempty(extras))
    disp("The co-ordinates that were not used are:")
    disp(extras)
end
end
