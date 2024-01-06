% Ashna Khemani, MEAM1470 Thursday section
% Plotting points of f(x) = sin(x) over [0, 90]

x = linspace(0, 90, 9);
y = sind(x);

plot(x, y, 'bo-')
axis([0 90 0 1])