%% 速度实验与仿真对比图绘制
clc; clear; close all;

%% 第一步：固定figure参数（适配1280×800屏幕，与第一份代码完全一致，无动态计算）
screen_width = 1280;   % 固定屏幕宽度（你的屏幕参数）
screen_height = 800;   % 固定屏幕高度（你的屏幕参数）
n_cols = 3;            % 3列（工况）
n_rows = 2;            % 2行（FV1/FV2）
margin = 50;           % 屏幕边缘留白（固定，与第一份代码一致）
gap = 20;              % figure间间距（固定，与第一份代码一致）
% 核心：固定4:3尺寸（宽360，高270），适配1280×800，无溢出
single_fig_width = 360;    
single_fig_height = 270;   

% 构建6个figure的位置矩阵（Position：[left, bottom, width, height]）- 列优先，固定计算
fig_positions = [];
for col = 1:n_cols  
    current_left = margin + (col-1)*single_fig_width + (col-1)*gap;  % 固定左坐标
    for row = 1:n_rows  
        current_bottom = screen_height - margin - row*single_fig_height - (row-1)*gap;  % 固定下坐标
        fig_positions = [fig_positions; current_left, current_bottom, single_fig_width, single_fig_height];
    end
end
%% 初始化figure编号（确保6个图独立不覆盖）
current_fig_idx = 1;

%% cond.1：加载Exp1.mat（对应最左列2个figure，上下摆放FV1/FV2，仅仿真数据）
fprintf('\n------------------------ cond.1：Exp1.mat ------------------------\n');
load("Exp1.mat");

% cond.1 - 曲线1（fig1，最左列上方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_1_1 = 17;        % 可单独修改：平滑窗口
poly_ord_1_1 = 2;        % 可单独修改：平滑多项式阶数
downsample_step_1_1 = 100;  % 可单独修改：降采样步长（60000点→600点，步长越大点数越少）
noise_amp_1_1 = 0.02;   % 可单独修改：该曲线噪声强度
fig_title_1_1 = 'cond.1 - FV1';
% 新增传入：降采样步长、噪声强度
plot_sim_with_noise(v1, downsample_step_1_1, win_len_1_1, poly_ord_1_1, noise_amp_1_1, fig_title_1_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.1 - 曲线2（fig2，最左列下方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_1_2 = 35;        % 可单独修改：平滑窗口
poly_ord_1_2 = 3;        % 可单独修改：平滑多项式阶数
downsample_step_1_2 = 200;  % 可单独修改：降采样步长（60000点→300点）
noise_amp_1_2 = 0.02;   % 可单独修改：该曲线噪声强度（与曲线1不同）
fig_title_1_2 = 'cond.1 - FV2';
plot_sim_with_noise(v2, downsample_step_1_2, win_len_1_2, poly_ord_1_2, noise_amp_1_2, fig_title_1_2, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

%% cond.2：加载Exp2.mat（对应中间列2个figure，上下摆放FV1/FV2，仅仿真数据）
fprintf('\n------------------------ cond.2：Exp2.mat ------------------------\n');
load("Exp2.mat");

% cond.2 - 曲线1（fig3，中间列上方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_2_1 = 19;        % 可单独修改：平滑窗口
poly_ord_2_1 = 2;        % 可单独修改：平滑多项式阶数
downsample_step_2_1 = 150;  % 可单独修改：降采样步长
noise_amp_2_1 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_2_1 = 'cond.2 - FV1';
plot_sim_with_noise(v1, downsample_step_2_1, win_len_2_1, poly_ord_2_1, noise_amp_2_1, fig_title_2_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.2 - 曲线2（fig4，中间列下方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_2_2 = 27;        % 可单独修改：平滑窗口
poly_ord_2_2 = 2;        % 可单独修改：平滑多项式阶数
downsample_step_2_2 = 250;  % 可单独修改：降采样步长
noise_amp_2_2 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_2_2 = 'cond.2 - FV2';
plot_sim_with_noise(v2, downsample_step_2_2, win_len_2_2, poly_ord_2_2, noise_amp_2_2, fig_title_2_2, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

%% cond.3：加载Exp3.mat（对应最右列2个figure，上下摆放FV1/FV2，仅仿真数据）
fprintf('\n------------------------ cond.3：Exp3.mat ------------------------\n');
load("Exp3.mat");

% cond.3 - 曲线1（fig5，最右列上方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_3_1 = 31;        % 可单独修改：平滑窗口
poly_ord_3_1 = 3;        % 可单独修改：平滑多项式阶数
downsample_step_3_1 = 120;  % 可单独修改：降采样步长
noise_amp_3_1 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_3_1 = 'cond.3 - FV1';
plot_sim_with_noise(v1, downsample_step_3_1, win_len_3_1, poly_ord_3_1, noise_amp_3_1, fig_title_3_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.3 - 曲线2（fig6，最右列下方）：单独设置【采样步长/平滑/噪声强度】参数
win_len_3_2 = 19;        % 可单独修改：平滑窗口
poly_ord_3_2 = 3;        % 可单独修改：平滑多项式阶数
downsample_step_3_2 = 180;  % 可单独修改：降采样步长
noise_amp_3_2 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_3_2 = 'cond.3 - FV2';
plot_sim_with_noise(v2, downsample_step_3_2, win_len_3_2, poly_ord_3_2, noise_amp_3_2, fig_title_3_2, current_fig_idx, fig_positions(current_fig_idx, :));

fprintf('\n------------------------ 所有figure绘制完成（3列2行列优先布局，4:3比例） ------------------------\n');

%% 自定义函数：仿真数据+降采样+独立调节噪声对比（刻度加粗+仅v斜体）
function plot_sim_with_noise(sim_data, downsample_step, win_len, poly_ord, noise_amp, fig_title, fig_idx, fig_pos)
    % 功能：完成仿真数据降采样→平滑→加独立随机噪声，对比绘图（刻度加粗+仅v斜体）
    % 输入参数：
    %   sim_data - 原始仿真数据（60000个点）
    %   downsample_step - 降采样步长（步长越大，采样后点数越少，越稀疏）
    %   noise_amp - 该曲线独立噪声强度（自定义，互不干扰）
    %   fig_pos - figure位置参数 [left, bottom, width, height]（已保证4:3比例）

    % 1. 打印核心变量的长度和维度（关键排查）
    fprintf('\n===== 第%d个figure：%s =====\n', fig_idx, fig_title);
    fprintf('原始仿真数据长度：%d，维度：%d×%d\n', length(sim_data), size(sim_data,1), size(sim_data,2));

    % 2. 数据预处理：强制转为列向量，统一数据维度格式
    sim_data = sim_data(:);
    len_sim_original = length(sim_data);

    % 3. 核心新增：降采样处理（先减点，再平滑，提升效率+优化噪声效果）
    % 按步长索引取值，保留数据趋势，减少密集点数（60000点→len_sim_original/downsample_step点）
    sim_data_downsampled = sim_data(1:downsample_step:end);
    sim_data_downsampled = sim_data_downsampled(:);
    len_sim = length(sim_data_downsampled);
    fprintf('降采样后仿真数据长度：%d（步长=%d），维度：%d×%d\n', len_sim, downsample_step, size(sim_data_downsampled,1), size(sim_data_downsampled,2));

    % 4. 仿真数据平滑处理（对降采样后的数据平滑，效率更高）
    if mod(win_len, 2) ~= 1  % 校验窗口长度是否为奇数，避免SG滤波器报错
        warning('窗口长度必须为奇数，已自动修正为%d', win_len + 1);
        win_len = win_len + 1;
    end
    sim_data_smoothed = sgolayfilt(sim_data_downsampled, poly_ord, win_len);
    sim_data_smoothed = sim_data_smoothed(:);
    fprintf('平滑后仿真数据长度：%d，维度：%d×%d\n', length(sim_data_smoothed), size(sim_data_smoothed,1), size(sim_data_smoothed,2));

    % 5. 核心优化：添加独立随机高斯白噪声（噪声强度由传入参数控制，每曲线不同）
    % 公式：加噪声数据 = 平滑仿真数据 + 独立噪声强度 × 标准高斯分布随机数（纯随机）
    noisy_sim_data = sim_data_smoothed + noise_amp * randn(size(sim_data_smoothed));
    noisy_sim_data = noisy_sim_data(:);
    fprintf('加噪声后仿真数据（模拟实验）长度：%d，维度：%d×%d\n', length(noisy_sim_data), size(noisy_sim_data,1), size(noisy_sim_data,2));

    % 6. 构建0-60秒时间轴（与降采样后的数据长度匹配，时间均匀分布）
    time_axis = linspace(0, 60, len_sim);
    time_axis = time_axis(:);

    % 7. 长度校验通过后绘图（刻度加粗+仅v斜体+新罗马字体，figure已为4:3比例）
    if length(time_axis) == length(sim_data_smoothed) && length(time_axis) == length(noisy_sim_data)
        % 创建/激活指定编号的figure，设置位置和背景色（pos已保证4:3比例）
        figure(fig_idx);
        set(gcf, ...
            'Color', 'white', ...
            'Position', fig_pos);
        
        % 绘制对比曲线（蓝：平滑原始仿真数据，红：加噪声仿真数据（模拟实验））        
        hold on;
        plot(time_axis, noisy_sim_data, 'Color', '#ec2b24','LineStyle','-','LineWidth',1.5);     % 加独立随机噪声（模拟实验）
        plot(time_axis, sim_data_smoothed, 'Color', 'b','LineStyle','--','LineWidth',1.5); % 原始仿真（降采样+平滑）
        % 8. 图形美化：恢复标签+保持仅v斜体+格式规范
        % xlabel('Time (s)', 'FontSize',12, 'FontName','Times New Roman');
        % 关键：\itv\rm_x (m/s) - 仅v斜体，x和单位正体，符合要求
        % ylabel('\itv\rm_x (m/s)', 'FontSize',12, 'FontName','Times New Roman', 'Interpreter','TeX');
        % title(fig_title, 'FontSize',14, 'FontName','Times New Roman');
        
        % 9. 设置横坐标固定刻度：0、20、40、60
        xticks([]);
        % xticklabels({'0', '20', '40', '60'});
        
        % 10. 核心保留：刻度加粗+新罗马字体统一
        set(gca, 'FontName','Times New Roman', 'FontSize',15, 'FontWeight','bold');
        box on;
        hold off;
    else
        error('第%d个figure：数据长度不匹配！时间轴(%d)、平滑仿真数据(%d)、加噪声仿真数据(%d)', ...
            fig_idx, length(time_axis), length(sim_data_smoothed), length(noisy_sim_data));
    end
end