%%part_2数据处理代码
clc
clear
close all
%% 
opengl software
set(0, 'DefaultFigureRenderer', 'painters');
%% 
save('MADDPG_3.mat', ...
    'accel_1','accel_2','dis_safe_1','dis_safe_2', ...
    'distance_1','distance_2','lateral_1','lateral_2','steer_1', ...
    'steer_2','v_ego_1','v_ego_2','v_lead','v_set','yaw_1','yaw_2');
%% 
save('DDPG_3.mat', ...
    'accel2_1','accel2_2','dis_safe2_1','dis_safe2_2', ...
    'distance2_1','distance2_2','lateral2_1','lateral2_2','steer2_1', ...
    'steer2_2','v_ego2_1','v_ego2_2','v_lead','v_set','yaw2_1','yaw2_2');
%% 
save('DQN_2.mat', ...
    'accel3_1','accel3_2','dis_safe3_1','dis_safe3_2', ...
    'distance3_1','distance3_2','lateral3_1','lateral3_2','steer3_1', ...
    'steer3_2','v_ego3_1','v_ego3_2','v_lead','v_set','yaw3_1','yaw3_2');
%% % 1. 平滑处理（移动平均）
ey = ey3;          % 想换就改成 ey1 / ey2 / ey3

window_size = 5000;            % 平滑窗口大小
smooth_range = 10000:60000;         % 只平滑 0~20000 区间（索引）

% 初始化平滑结果
ey_smoothed = ey;               % 先复制原始数据

% 对指定区间做移动平均平滑
ey_smoothed(smooth_range) = movmean(ey(smooth_range), window_size);

% 保存结果（你需要啥名字就自己赋值）
lateral3_1 = ey_smoothed;

% 画图
figure;

subplot(2,1,1);  % 原始数据
plot(ey, 'Color', "#e24a33", 'LineWidth', 1);
title('原始数据（含震荡）');
xlim([0, length(ey)]);
ylim([min(ey), max(ey)]);
box on;

subplot(2,1,2);  % 局部平滑后
plot(ey_smoothed, 'Color', "#4F84FF", 'LineWidth', 1);
title('0~20000 区间平滑后数据');
xlim([0, length(ey)]);
ylim([min(ey), max(ey)]);
box on;

sgtitle('局部平滑前后对比（仅 0~20000 区间）');

%% 


% 1. 平滑处理（移动平均）
window_size = 500;  % 窗口大小（可调，越大越平滑）
yaw1_smoothed = movmean(yaw1, window_size);  % 移动平均平滑

yaw_2 = yaw1_smoothed;
% 2. 绘制对比图
figure;
subplot(2,1,1);  % 上子图：原始数据
plot(yaw1, 'Color', "#e24a33", 'LineWidth', 1);
title('原始数据（含震荡）');
xlim([0, length(yaw1)]);
ylim([min(yaw1), max(yaw1)]);
box on;

subplot(2,1,2);  % 下子图：平滑后数据
plot(yaw1_smoothed, 'Color', "#4F84FF", 'LineWidth', 1);
title('移动平均平滑后数据');
xlim([0, length(yaw1)]);
ylim([min(yaw1), max(yaw1)]);
box on;

sgtitle('数据平滑前后对比（移动平均）');  % 总标题