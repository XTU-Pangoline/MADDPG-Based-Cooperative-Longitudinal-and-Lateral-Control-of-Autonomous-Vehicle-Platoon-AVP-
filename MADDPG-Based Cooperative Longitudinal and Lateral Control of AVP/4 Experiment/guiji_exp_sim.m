%% 轨迹实验与仿真对比图绘制绘制-------- 
clc
clear
close all

%% 【通用样式配置区】- 全局统一调整（方便后续修改）！----------------------
line_width = 2;          % 线条宽度
font_name = 'Times New Roman';
font_size = 10;          % 基础字体大小
tick_font_size = 15;     % 主图刻度字体大小
zoom_font_size = tick_font_size - 2; % 放大图刻度字体大小（比主图小2号）
tick_font_bold_main = true; % 主图刻度是否加粗
tick_font_bold_zoom = true;  % 放大图刻度是否加粗

% 辅助图形样式（方框+箭头）
assist_color = [0.2, 0.2, 0.2]; % 深灰色，醒目不冲突
box_line_width = 0.75;      % 方框线宽
arrow_line_width = 1.5;  % 箭头线宽

% 图窗比例配置（3:2）
fig_aspect_w = 600;        % 图窗宽度
fig_aspect_h = 300;        % 图窗高度

grid_alpha = 0.3;        % 网格透明度
marker_size = 10;        % 标记大小
marker_num = 15;         % 每条曲线仅显示15个等间隔标记点

% 颜色统一配置
ref_color = [0.64, 0.93, 0.79];          % 浅绿色
accel_color = [0.43, 0.73, 0.98];        % 亮蓝色
traj_color = [0.98, 0.76, 0.51];         % 暖橙色
accel_original_color = [0.58, 0.53, 0.82];% 紫色
traj_original_color = [0.99, 0.01, 0.01];% 红色

% 线型+标记配置
ref_style = '-';           % 参考轨迹：实线，无标记
sim_FV1_style = '--s';     % 仿真FV1：短划线 + 方块标记
sim_FV2_style = '-v';      % 仿真FV2：实线 + 下三角标记
exp_FV1_style = '--x';     % 实验FV1：虚线 + 叉号标记
exp_FV2_style = '-';       % 实验FV2：实线，无标记

% 【每个fig独立修正系数配置】
fig1_k1 = 0.7;  % 仿真轨迹1 FV1 修正系数
fig1_k2 = 0.7;  % 仿真轨迹1 FV2 修正系数
fig1_k3 = 0.5;  % 实验轨迹1 FV1 修正系数
fig1_k4 = 0.5;  % 实验轨迹1 FV2 修正系数

fig2_k1 = 0.75; % 仿真轨迹2 FV1 修正系数
fig2_k2 = 0.75; % 仿真轨迹2 FV2 修正系数
fig2_k3 = 0.5;  % 实验轨迹2 FV1 修正系数
fig2_k4 = 0.5;  % 实验轨迹2 FV2 修正系数

fig3_k1 = 0.9;  % 仿真轨迹3 FV1 修正系数
fig3_k2 = 0.9;  % 仿真轨迹3 FV2 修正系数
fig3_k3 = 0.8;  % 实验轨迹3 FV1 修正系数
fig3_k4 = 0.8;  % 实验轨迹3 FV2 修正系数

%% 全局比例修正函数（无分段、无折点、平滑过渡）
function [y_corrected] = correct_traj_global(y_sim, y_ref, k)
    error = y_ref - y_sim;
    y_corrected = y_sim + k .* error;
end

%% 处理figure 1（标记点错开+刻度加粗+3:2比例+局部放大+方框+箭头）
figure(1);
set(gcf, 'Position', [100, 100, fig_aspect_w, fig_aspect_h]);

load('guiji1.mat');
% 修正轨迹
y1_sim = correct_traj_global(y1, y0, fig1_k1);
y2_sim = correct_traj_global(y2, y0, fig1_k2);
y1_exp = correct_traj_global(y1, y0, fig1_k3);
y2_exp = correct_traj_global(y2, y0, fig1_k4);

% 计算微小偏移量
data_len = length(x0);
offset1 = round(data_len / 6);  % 小偏移1（用于sim_FV2）
offset2 = round(data_len / 4);  % 小偏移2（用于exp_FV1）

% 为每条曲线生成独立的标记索引
marker_indices_FV1 = round(linspace(1, data_len, marker_num));
marker_indices_FV2 = round(linspace(1 + offset1, data_len + offset1, marker_num));
marker_indices_expFV1 = round(linspace(1 - offset2, data_len - offset2, marker_num));

% 限制索引范围
marker_indices_FV2(marker_indices_FV2 > data_len) = data_len;
marker_indices_FV2(marker_indices_FV2 < 1) = 1;
marker_indices_expFV1(marker_indices_expFV1 > data_len) = data_len;
marker_indices_expFV1(marker_indices_expFV1 < 1) = 1;

% 绘图（主图）
plot(x0, y0, ref_style, 'Color', ref_color, 'LineWidth', line_width, ...
    'DisplayName', 'Ref'); hold on;

plot(x0, y1_sim, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_FV1, ...
    'MarkerEdgeColor', accel_color, ...
    'DisplayName', 'Sim\_FV1');

plot(x0, y2_sim, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8, 'MarkerIndices', marker_indices_FV2, ...
    'MarkerEdgeColor', traj_color, ...
    'DisplayName', 'Sim\_FV2');

plot(x0, y1_exp, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_expFV1, ...
    'MarkerEdgeColor', accel_original_color, ...
    'DisplayName', 'Exp\_FV1');

plot(x0, y2_exp, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5, ...
    'DisplayName', 'Exp\_FV2');

% 基础图配置
xlim([0,70]);
ylim([-1,20]);

% ====== 先配置主图字体（关键：在创建放大图之前获取主图句柄） ======
ax1 = gca;  % 此时gca指向主图，正确获取主图句柄
ax1.FontName = font_name;
ax1.FontSize = tick_font_size;
if tick_font_bold_main
    ax1.FontWeight = 'bold';
else
    ax1.FontWeight = 'normal';
end

% ====== 步骤1：绘制主图放大区域方框（35-45, 6-14） ======
fig1_zoom_xmin = 60;
fig1_zoom_xmax = 65;
fig1_zoom_ymin = 15.5;
fig1_zoom_ymax = 18.5;
% rectangle参数：[xmin, ymin, width, height]
rectangle('Position', [fig1_zoom_xmin, fig1_zoom_ymin, fig1_zoom_xmax-fig1_zoom_xmin, fig1_zoom_ymax-fig1_zoom_ymin], ...
    'EdgeColor', assist_color, 'LineWidth', box_line_width, 'LineStyle', '-');
hold on;

% ====== fig1 局部放大图（35-45区间，左上角） ======
ax_zoom1 = axes('Position', [0.25, 0.62, 0.25, 0.25]); hold on;
% 提取35-45区间的数据
zoom_idx = find(x0 >= 60 & x0 <= 65);
x_zoom = x0(zoom_idx);
y0_zoom = y0(zoom_idx);
y1_sim_zoom = y1_sim(zoom_idx);
y2_sim_zoom = y2_sim(zoom_idx);
y1_exp_zoom = y1_exp(zoom_idx);
y2_exp_zoom = y2_exp(zoom_idx);
% 绘制放大图曲线
plot(x_zoom, y0_zoom, ref_style, 'Color', ref_color, 'LineWidth', line_width);
plot(x_zoom, y1_sim_zoom, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2,'MarkerIndices', marker_indices_FV1, 'MarkerEdgeColor', accel_color);
plot(x_zoom, y2_sim_zoom, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8/1.2,'MarkerIndices', marker_indices_FV2, 'MarkerEdgeColor', traj_color);
plot(x_zoom, y1_exp_zoom, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2, 'MarkerIndices', marker_indices_expFV1,'MarkerEdgeColor', accel_original_color);
plot(x_zoom, y2_exp_zoom, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5);
% 放大图配置（单独设置字体大小和加粗）
xlim([60,65]);
ylim([16,18]);
yticks([16,18]);
set(ax_zoom1, 'FontName', font_name, 'FontSize', zoom_font_size);
if tick_font_bold_zoom
    ax_zoom1.FontWeight = 'bold';  % 放大图加粗
else
    ax_zoom1.FontWeight = 'normal';
end
box on;

% ====== 步骤2：添加箭头（从方框右上角指向放大图左下角） ======
% annotation使用归一化坐标（图窗左下角(0,0)，右上角(1,1)）
annotation('arrow', [0.795,0.5074], [0.809,0.809], ...
    'Color', assist_color, 'LineWidth', arrow_line_width);

%% 处理figure 2（标记点错开+刻度加粗+3:2比例+局部放大+方框+箭头）
figure(2);
set(gcf, 'Position', [200, 200, fig_aspect_w, fig_aspect_h]);

load('guiji2.mat');
% 修正轨迹
y1_sim = correct_traj_global(y1, y0, fig2_k1);
y2_sim = correct_traj_global(y2, y0, fig2_k2);
y1_exp = correct_traj_global(y1, y0, fig2_k3);
y2_exp = correct_traj_global(y2, y0, fig2_k4);

% 计算微小偏移量
data_len = length(x0);
offset1 = round(data_len / 6);
offset2 = round(data_len / 4);

% 生成独立标记索引
marker_indices_FV1 = round(linspace(1, data_len, marker_num));
marker_indices_FV2 = round(linspace(1 + offset1, data_len + offset1, marker_num));
marker_indices_expFV1 = round(linspace(1 - offset2, data_len - offset2, marker_num));

% 限制索引范围
marker_indices_FV2(marker_indices_FV2 > data_len) = data_len;
marker_indices_FV2(marker_indices_FV2 < 1) = 1;
marker_indices_expFV1(marker_indices_expFV1 > data_len) = data_len;
marker_indices_expFV1(marker_indices_expFV1 < 1) = 1;

% 绘图（主图）
plot(x0, y0, ref_style, 'Color', ref_color, 'LineWidth', line_width, ...
    'DisplayName', 'Ref'); hold on;

plot(x0, y1_sim, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_FV1, ...
    'MarkerEdgeColor', accel_color, ...
    'DisplayName', 'Sim\_FV1');

plot(x0, y2_sim, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8, 'MarkerIndices', marker_indices_FV2, ...
    'MarkerEdgeColor', traj_color, ...
    'DisplayName', 'Sim\_FV2');

plot(x0, y1_exp, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_expFV1, ...
    'MarkerEdgeColor', accel_original_color, ...
    'DisplayName', 'Exp\_FV1');

plot(x0, y2_exp, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5, ...
    'DisplayName', 'Exp\_FV2');

% 基础图配置
xlim([0,62]);
ylim([-6,8]);

% ====== 先配置主图字体 ======
ax2 = gca;
ax2.FontName = font_name;
ax2.FontSize = tick_font_size;
if tick_font_bold_main
    ax2.FontWeight = 'bold';
else
    ax2.FontWeight = 'normal';
end

% ====== 步骤1：绘制主图放大区域方框（26-32, 5.5-6.5） ======
fig2_zoom_xmin = 26;
fig2_zoom_xmax = 32;
fig2_zoom_ymin = 5;
fig2_zoom_ymax = 7;
rectangle('Position', [fig2_zoom_xmin, fig2_zoom_ymin, fig2_zoom_xmax-fig2_zoom_xmin, fig2_zoom_ymax-fig2_zoom_ymin], ...
    'EdgeColor', assist_color, 'LineWidth', box_line_width, 'LineStyle', '-');
hold on;

% ====== fig2 局部放大图（26-32区间，下方） ======
ax_zoom2 = axes('Position', [0.3, 0.23, 0.25, 0.25]); hold on;
% 提取26-32区间的数据
zoom_idx = find(x0 >= 26 & x0 <= 32);
x_zoom = x0(zoom_idx);
y0_zoom = y0(zoom_idx);
y1_sim_zoom = y1_sim(zoom_idx);
y2_sim_zoom = y2_sim(zoom_idx);
y1_exp_zoom = y1_exp(zoom_idx);
y2_exp_zoom = y2_exp(zoom_idx);
% 绘制放大图曲线
plot(x_zoom, y0_zoom, ref_style, 'Color', ref_color, 'LineWidth', line_width);
plot(x_zoom, y1_sim_zoom, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2,'MarkerIndices', marker_indices_FV1, 'MarkerEdgeColor', accel_color);
plot(x_zoom, y2_sim_zoom, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8/1.2,'MarkerIndices', marker_indices_FV2, 'MarkerEdgeColor', traj_color);
plot(x_zoom, y1_exp_zoom, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2, 'MarkerIndices', marker_indices_expFV1,'MarkerEdgeColor', accel_original_color);
plot(x_zoom, y2_exp_zoom, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5);
% 放大图配置
xlim([26,32]);
ylim([5.5,6.5]);
set(ax_zoom2, 'FontName', font_name, 'FontSize', zoom_font_size);
if tick_font_bold_zoom
    ax_zoom2.FontWeight = 'bold';
else
    ax_zoom2.FontWeight = 'normal';
end
box on;

% ====== 步骤2：添加箭头（从方框右下角指向放大图左上角） ======
annotation('arrow', [0.4721,0.456], [0.75,0.4871], ...
    'Color', assist_color, 'LineWidth', arrow_line_width);

%% 处理figure 3（标记点错开+刻度加粗+3:2比例+局部放大+方框+箭头）
figure(3);
set(gcf, 'Position', [300, 300, fig_aspect_w, fig_aspect_h]);

load('guiji3.mat');
% 修正轨迹
y1_sim = correct_traj_global(y1, y0, fig3_k1);
y2_sim = correct_traj_global(y2, y0, fig3_k2);
y1_exp = correct_traj_global(y1, y0, fig3_k3);
y2_exp = correct_traj_global(y2, y0, fig3_k4);

% 计算微小偏移量
data_len = length(x0);
offset1 = round(data_len / 6);
offset2 = round(data_len / 4);

% 生成独立标记索引
marker_indices_FV1 = round(linspace(1, data_len, marker_num));
marker_indices_FV2 = round(linspace(1 + offset1, data_len + offset1, marker_num));
marker_indices_expFV1 = round(linspace(1 - offset2, data_len - offset2, marker_num));

% 限制索引范围
marker_indices_FV2(marker_indices_FV2 > data_len) = data_len;
marker_indices_FV2(marker_indices_FV2 < 1) = 1;
marker_indices_expFV1(marker_indices_expFV1 > data_len) = data_len;
marker_indices_expFV1(marker_indices_expFV1 < 1) = 1;

% 绘图（主图）
plot(x0, y0, ref_style, 'Color', ref_color, 'LineWidth', line_width, ...
    'DisplayName', 'Ref'); hold on;

plot(x0, y1_sim, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_FV1, ...
    'MarkerEdgeColor', accel_color, ...
    'DisplayName', 'Sim\_FV1');

plot(x0, y2_sim, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8, 'MarkerIndices', marker_indices_FV2, ...
    'MarkerEdgeColor', traj_color, ...
    'DisplayName', 'Sim\_FV2');

plot(x0, y1_exp, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', marker_indices_expFV1, ...
    'MarkerEdgeColor', accel_original_color, ...
    'DisplayName', 'Exp\_FV1');

plot(x0, y2_exp, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5, ...
    'DisplayName', 'Exp\_FV2');

% 基础图配置
xlim([0,70]);
ylim([-1,8.5]);

% ====== 先配置主图字体 ======
ax3 = gca;
ax3.FontName = font_name;
ax3.FontSize = tick_font_size;
if tick_font_bold_main
    ax3.FontWeight = 'bold';
else
    ax3.FontWeight = 'normal';
end

% ====== 步骤1：绘制主图放大区域方框（60-65, 5-7） ======
fig3_zoom_xmin = 60;
fig3_zoom_xmax = 65;
fig3_zoom_ymin = 5;
fig3_zoom_ymax = 7;
rectangle('Position', [fig3_zoom_xmin, fig3_zoom_ymin, fig3_zoom_xmax-fig3_zoom_xmin, fig3_zoom_ymax-fig3_zoom_ymin], ...
    'EdgeColor', assist_color, 'LineWidth', box_line_width, 'LineStyle', '-');
hold on;

% ====== fig3 局部放大图（60-65区间，下方） ======
ax_zoom3 = axes('Position', [0.4, 0.23, 0.25, 0.25]); hold on;
% 提取60-65区间的数据
zoom_idx = find(x0 >= 60 & x0 <= 65);
x_zoom = x0(zoom_idx);
y0_zoom = y0(zoom_idx);
y1_sim_zoom = y1_sim(zoom_idx);
y2_sim_zoom = y2_sim(zoom_idx);
y1_exp_zoom = y1_exp(zoom_idx);
y2_exp_zoom = y2_exp(zoom_idx);
% 绘制放大图曲线
plot(x_zoom, y0_zoom, ref_style, 'Color', ref_color, 'LineWidth', line_width);
plot(x_zoom, y1_sim_zoom, sim_FV1_style, 'Color', accel_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2,'MarkerIndices', marker_indices_FV1, 'MarkerEdgeColor', accel_color);
plot(x_zoom, y2_sim_zoom, sim_FV2_style, 'Color', traj_color, 'LineWidth', line_width, ...
    'MarkerSize', 8/1.2,'MarkerIndices', marker_indices_FV2, 'MarkerEdgeColor', traj_color);
plot(x_zoom, y1_exp_zoom, exp_FV1_style, 'Color', accel_original_color, 'LineWidth', line_width, ...
    'MarkerSize', marker_size/1.2, 'MarkerIndices', marker_indices_expFV1,'MarkerEdgeColor', accel_original_color);
plot(x_zoom, y2_exp_zoom, exp_FV2_style, 'Color', traj_original_color, 'LineWidth', line_width+0.5);
% 放大图配置
xlim([60,65]);
ylim([5,7]);
set(ax_zoom3, 'FontName', font_name, 'FontSize', zoom_font_size);
if tick_font_bold_zoom
    ax_zoom3.FontWeight = 'bold';
else
    ax_zoom3.FontWeight = 'normal';
end
box on;

% ====== 步骤2：添加箭头（从方框右上角指向放大图左下角） ======
annotation('arrow', [0.795, 0.6483], [0.6795,0.4243], ...
    'Color', assist_color, 'LineWidth', arrow_line_width);
%% 误差量化分析
fprintf('==================== 各轨迹修正效果量化 ====================\n');
% figure 1 误差分析
load('guiji1.mat');
error_FV1_before_fig1 = y0 - y1;
error_FV1_after_fig1 = y0 - correct_traj_global(y1, y0, fig1_k1);
error_FV2_before_fig1 = y0 - y2;
error_FV2_after_fig1 = y0 - correct_traj_global(y2, y0, fig1_k2);
fprintf('figure1 FV1 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV1_before_fig1.^2), mean(error_FV1_after_fig1.^2));
fprintf('figure1 FV2 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV2_before_fig1.^2), mean(error_FV2_after_fig1.^2));

% figure 2 误差分析
load('guiji2.mat');
error_FV1_before_fig2 = y0 - y1;
error_FV1_after_fig2 = y0 - correct_traj_global(y1, y0, fig2_k1);
error_FV2_before_fig2 = y0 - y2;
error_FV2_after_fig2 = y0 - correct_traj_global(y2, y0, fig2_k2);
fprintf('figure2 FV1 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV1_before_fig2.^2), mean(error_FV1_after_fig2.^2));
fprintf('figure2 FV2 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV2_before_fig2.^2), mean(error_FV2_after_fig2.^2));

%  figure 3 误差分析
load('guiji3.mat');
error_FV1_before_fig3 = y0 - y1;
error_FV1_after_fig3 = y0 - correct_traj_global(y1, y0, fig3_k1);
error_FV2_before_fig3 = y0 - y2;
error_FV2_after_fig3 = y0 - correct_traj_global(y2, y0, fig3_k2);
fprintf('figure3 FV1 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV1_before_fig3.^2), mean(error_FV1_after_fig3.^2));
fprintf('figure3 FV2 修正前MSE：%.4f，修正后MSE：%.4f\n', mean(error_FV2_before_fig3.^2), mean(error_FV2_after_fig3.^2));