%%part_2绘图代码FV2
clc
clear 
clf
close all
%% 
%切换工况1 2 3
condition_number = 1; 

% 使用 sprintf 函数根据工况编号动态生成文件名
dqn_filename = sprintf('DQN_%d.mat', condition_number);
ddpg_filename = sprintf('DDPG_%d.mat', condition_number);
maddpg_filename = sprintf('MADDPG_%d.mat', condition_number);
% 加载文件
load(dqn_filename);
load(ddpg_filename);
load(maddpg_filename);
%% 
a1 = accel_2;
a2 = accel2_2;
a3 = accel3_2;
v1 = v_ego_2;
v2 = v_ego2_2;
v3 = v_ego3_2;
d1 = distance_2;
d2 = distance2_2;
d3 = distance3_2;
sd1 = dis_safe_1;
sd2 = dis_safe2_1;
sd3 = dis_safe3_1;
% ed1 = d1 - sd1;
% ed2 = d2 - sd2;
% ed3 = d3 - sd3;
ed1 = sd1 - d1;
ed2 = sd2 - d2;
ed3 = sd3 - d3;
ey1 = lateral_2;
ey2 = lateral2_2;
ey3 = lateral3_2;
yaw1 = yaw_2;
yaw2 = yaw2_2;
yaw3 = yaw3_2;
%% 
figure(1);  % 速度
set(gcf,'Position',[131,710,600,251],'Renderer', 'painters'); %小论文大小为[131,710,600,150]
v2 = smooth(v2, 1000, 'moving');
v3 = smooth(v3, 1000, 'moving');
% yline(1.5, '--', 'Color', "#434343", 'LineWidth', 1.5);
hold on;
plot(v_lead, '-', 'Color', "#fee7b3", 'LineWidth', 2);
plot(v3, '-', 'Color', "#4461ad", 'LineWidth', 2);
plot(v2, '-', 'Color', "#89cfa9", 'LineWidth', 2);
plot(v1, '-', 'Color', "#f56b3f", 'LineWidth', 2);

n = length(v1);  % 获取v1数据长度（60000）
mark_indices = linspace(1, n, 10);  % 生成1到60000的10个均匀索引（含首尾）
mark_indices = round(mark_indices);  % 索引需为整数，四舍五入
plot(mark_indices, v1(mark_indices), 'd', ...  'd'表示菱形标记
     'Color', "#e24a33", ...  标记颜色与曲线一致
     'MarkerSize', 8, ...    标记大小
     'MarkerEdgeColor', 'w', ...  标记边缘颜色（黑色，可选）
     'MarkerFaceColor', "#e24a33");  

hold off;
set(gca,'XTickLabel', {},'FontName','Times New Roman','FontSize',15,'FontWeight','bold', LineWidth=1.3);
box on;
xlim([0,60000]);
ylim([0.5,1.5]);

%% 
figure(2);  % 距离
set(gcf,'Position',[131,565,600,251],'Renderer', 'painters');
ed2 = smooth(ed2, 5000, 'moving');
ed3 = smooth(ed3, 1000, 'moving');
hold on;
plot(ed3, '-', 'Color', "#4461ad", 'LineWidth', 2);
plot(ed2, '-', 'Color', "#89cfa9", 'LineWidth', 2);
plot(ed1, '-', 'Color', "#f56b3f", 'LineWidth', 2);
yline(0, '--', 'Color', "#434343", 'LineWidth', 1.5);
box on;
n = length(ed1);  % 获取v1数据长度（60000）
mark_indices = linspace(1, n, 10);  % 生成1到60000的10个均匀索引（含首尾）
mark_indices = round(mark_indices);  % 索引需为整数，四舍五入
plot(mark_indices, ed1(mark_indices), 'd', ...  'd'表示菱形标记
     'Color', "#e24a33", ...  标记颜色与曲线一致
     'MarkerSize', 8, ...    标记大小
     'MarkerEdgeColor', 'w', ...  标记边缘颜色（黑色，可选）
     'MarkerFaceColor', "#e24a33");  
hold off;
set(gca,'XTickLabel', {},'FontName','Times New Roman','FontSize',15,'FontWeight','bold', LineWidth=1.3);

xlim([0,60000]);
ylim([-0.2,1.2]);
%% 
figure(3);  % 横向误差
set(gcf,'Position',[131,325,600,251],'Renderer', 'painters');

hold on;
plot(ey3, '-', 'Color', "#4461ad", 'LineWidth', 2);
plot(ey2, '-', 'Color', "#89cfa9", 'LineWidth', 2);
plot(ey1, '-', 'Color', "#f56b3f", 'LineWidth', 2);
yline(0, '--', 'Color', "#434343", 'LineWidth', 1.5);
box on;

n = length(ey1);  % 获取v1数据长度（60000）
mark_indices = linspace(1, n, 10);  % 生成1到60000的10个均匀索引（含首尾）
mark_indices = round(mark_indices);  % 索引需为整数，四舍五入
plot(mark_indices, ey1(mark_indices), 'd', ...  'd'表示菱形标记
     'Color', "#e24a33", ...  标记颜色与曲线一致
     'MarkerSize', 8, ...    标记大小
     'MarkerEdgeColor', 'w', ...  标记边缘颜色（黑色，可选）
     'MarkerFaceColor', "#e24a33");  
hold off;
set(gca,'XTickLabel', {},'FontName','Times New Roman','FontSize',15,'FontWeight','bold', LineWidth=1.3);
ylim([-0.1,0.06]);
xlim([0,60000]);
%% 
figure(4);  % 航向角误差
set(gcf,'Position',[131,75,600,251],'Renderer', 'painters');

hold on;
plot(yaw3, '-', 'Color', "#4461ad", 'LineWidth', 2);
plot(yaw2, '-', 'Color', "#89cfa9", 'LineWidth', 2);
plot(yaw1, '-', 'Color', "#f56b3f", 'LineWidth', 2);
yline(0, '--', 'Color', "#434343", 'LineWidth', 1.5);
box on;

n = length(yaw1);  % 获取v1数据长度（60000）
mark_indices = linspace(1, n, 10);  % 生成1到60000的10个均匀索引（含首尾）
mark_indices = round(mark_indices);  % 索引需为整数，四舍五入
plot(mark_indices, yaw1(mark_indices), 'd', ...  'd'表示菱形标记
     'Color', "#e24a33", ...  标记颜色与曲线一致
     'MarkerSize', 8, ...    标记大小
     'MarkerEdgeColor', 'w', ...  标记边缘颜色（黑色，可选）
     'MarkerFaceColor', "#e24a33");  
hold off;
set(gca,'XTickLabel', {},'FontName','Times New Roman','FontSize',15,'FontWeight','bold', LineWidth=1.3);
ylim([-0.1,0.1]);
xlim([0,60000]);
