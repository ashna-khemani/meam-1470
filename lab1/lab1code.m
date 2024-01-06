% Group members: Ashna, Hannah, Kunwoo
% Lab 1: plots "PENN" in red and blue
px = [1 1 1.5 1.5 1];
py = [1 4 4 2.5 2.5];
ex = [2 2 2.5 2 2 2.5 2 2 2.5];
ey = [1 4 4 4 2.5 2.5 2.5 1 1];
nx = [3 3 3.5 3.5];
ny = [1 4 1 4];
mx = [4 4 4.5 4.5];
my = [1 4 1 4];
plot(px,py,'bo-',ex,ey,'bo-', nx, ny, 'ro-', mx, my, 'ro-')
axis([0 9 -1 15])