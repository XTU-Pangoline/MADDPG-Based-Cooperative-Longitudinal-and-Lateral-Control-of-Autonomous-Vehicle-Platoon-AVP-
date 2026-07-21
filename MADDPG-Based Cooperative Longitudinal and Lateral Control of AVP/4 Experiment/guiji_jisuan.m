syms x

% 定义分段函数
y1 = -sqrt(50^2 - (x - 10)^2) + 50;


% 计算导数
dy1 = diff(y1, x);

% 计算连接点处的函数值和导数值
y_40 = subs(y1, x, 40);
dy1_40 = subs(dy1, x, 40);
syms  a b
y2 = sqrt(50^2 - (x - a)^2) + b;
dy2 = diff(y2, x);

y2_40 = subs(y2, x, 40);
dy2_40 = subs(dy2, x, 40);
%a = solve(dy2_40==0.75,a) % b + (2500 - (a - 40).^2).^(1/2) == 10
%b = solve(y2_40==10,b) % (2*a - 80)/(2*(2500 - (a - 40).^2).^(1/2)) == 0.75
[a,b] = solve(y2_40==10,dy2_40==0.75,a,b)
%% 
syms  x a b
y1 = sqrt((100/3)^2 - (x - 0)^2) - (100/3);
dy1 = diff(y1, x);
y1_20 = subs(y1, x, 20);
dy1_20 = subs(dy1, x, 20);

y2 = -sqrt(100^2 - (x - a)^2) + b;
dy2 = diff(y2, x);

y2_20 = subs(y2, x, 20);
dy2_20 = subs(dy2, x, 20);

[a,b] = solve(y2_20==y1_20,dy2_20==dy1_20,a,b)
%% 
syms  x a b
y1 = sqrt(20^2 - (x - 27)^2) - 10;
dy1 = diff(y1, x);

mid = 33;

y11 = subs(y1, x, mid);
dy11 = subs(dy1, x, mid);

y2 = -sqrt(a - (x - 43)^2) + b;
dy2 = diff(y2, x);

y22 = subs(y2, x, mid);
dy22 = subs(dy2, x, mid);
[a,b] = solve(y22==y11, dy22==dy11, a, b)
%% 
syms  x a b
y1 = -sqrt(50^2 - (x - 65)^2) + 25.6364;
dy1 = diff(y1, x);
y1_70 = subs(y1, x, 70);
dy1_70 = subs(dy1, x, 70);

y2 = a*x + b;
dy2 = diff(y2, x);

y2_70 = subs(y2, x, 70);
dy2_70 = subs(dy2, x, 70);
[a,b] = solve(y2_70==y1_70, dy2_70==dy1_70, a, b)