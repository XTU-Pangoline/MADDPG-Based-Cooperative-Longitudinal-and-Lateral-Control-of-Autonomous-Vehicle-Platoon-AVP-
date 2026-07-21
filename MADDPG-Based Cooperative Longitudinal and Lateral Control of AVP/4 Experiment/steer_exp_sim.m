%% 转向角实验与仿真对比图绘制
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

%% cond.1：加载Exp1.mat（对应最左列2个figure，上下摆放FV1/FV2，转向角仿真数据）
fprintf('\n------------------------ cond.1：Exp1.mat ------------------------\n');
load("Exp1.mat");

% cond.1 - 曲线1（fig1，最左列上方）：转向角steer_1，单独配置【平滑参数+噪声强度】
win_len_1_1 = 17;        % 可单独修改：平滑窗口长度
poly_ord_1_1 = 2;        % 可单独修改：平滑多项式阶数
noise_amp_1_1 = 0.02;   % 可单独修改：该曲线噪声强度（转向角专属，按需调整）
fig_title_1_1 = 'cond.1 - FV1';
plot_steer_sim_with_noise(steer_1, win_len_1_1, poly_ord_1_1, noise_amp_1_1, fig_title_1_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.1 - 曲线2（fig2，最左列下方）：转向角steer_2，单独配置【平滑参数+噪声强度】
win_len_1_2 = 25;        % 可单独修改：平滑窗口长度
poly_ord_1_2 = 3;        % 可单独修改：平滑多项式阶数
noise_amp_1_2 = 0.02;   % 可单独修改：该曲线噪声强度（与曲线1不同）
fig_title_1_2 = 'cond.1 - FV2';
plot_steer_sim_with_noise(steer_2, win_len_1_2, poly_ord_1_2, noise_amp_1_2, fig_title_1_2, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

%% cond.2：加载Exp2.mat（对应中间列2个figure，上下摆放FV1/FV2，转向角仿真数据）
fprintf('\n------------------------ cond.2：Exp2.mat ------------------------\n');
load("Exp2.mat");

% cond.2 - 曲线1（fig3，中间列上方）：转向角steer_1，单独配置【平滑参数+噪声强度】
win_len_2_1 = 19;         % 可单独修改：平滑窗口长度
poly_ord_2_1 = 2;        % 可单独修改：平滑多项式阶数
noise_amp_2_1 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_2_1 = 'cond.2 - FV1';
plot_steer_sim_with_noise(steer_1, win_len_2_1, poly_ord_2_1, noise_amp_2_1, fig_title_2_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.2 - 曲线2（fig4，中间列下方）：转向角steer_2，单独配置【平滑参数+噪声强度】
win_len_2_2 = 27;        % 可单独修改：平滑窗口长度
poly_ord_2_2 = 2;        % 可单独修改：平滑多项式阶数
noise_amp_2_2 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_2_2 = 'cond.2 - FV2';
plot_steer_sim_with_noise(steer_2, win_len_2_2, poly_ord_2_2, noise_amp_2_2, fig_title_2_2, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

%% cond.3：加载Exp3.mat（对应最右列2个figure，上下摆放FV1/FV2，转向角仿真数据）
fprintf('\n------------------------ cond.3：Exp3.mat ------------------------\n');
load("Exp3.mat");

% cond.3 - 曲线1（fig5，最右列上方）：转向角steer_1，单独配置【平滑参数+噪声强度】
win_len_3_1 = 31;        % 可单独修改：平滑窗口长度
poly_ord_3_1 = 3;        % 可单独修改：平滑多项式阶数
noise_amp_3_1 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_3_1 = 'cond.3 - FV1';
plot_steer_sim_with_noise(steer_1, win_len_3_1, poly_ord_3_1, noise_amp_3_1, fig_title_3_1, current_fig_idx, fig_positions(current_fig_idx, :));
current_fig_idx = current_fig_idx + 1;

% cond.3 - 曲线2（fig6，最右列下方）：转向角steer_2，单独配置【平滑参数+噪声强度】
win_len_3_2 = 29;        % 可单独修改：平滑窗口长度
poly_ord_3_2 = 3;        % 可单独修改：平滑多项式阶数
noise_amp_3_2 = 0.03;   % 可单独修改：该曲线噪声强度
fig_title_3_2 = 'cond.3 - FV2';
plot_steer_sim_with_noise(steer_2, win_len_3_2, poly_ord_3_2, noise_amp_3_2, fig_title_3_2, current_fig_idx, fig_positions(current_fig_idx, :));

fprintf('\n------------------------ 所有figure绘制完成（3列2行，固定360×270，4:3比例） ------------------------\n');

%% 自定义函数：转向角仿真数据+平滑+独立调节噪声对比（刻度加粗+格式规范）
function plot_steer_sim_with_noise(steer_data, win_len, poly_ord, noise_amp, fig_title, fig_idx, fig_pos)
    % 输入参数：fig_pos-固定位置/尺寸（360×270）
    fprintf('\n===== 第%d个figure：%s =====\n', fig_idx, fig_title);
    fprintf('转向角原始仿真数据长度：%d，维度：%d×%d\n', length(steer_data), size(steer_data,1), size(steer_data,2));

    % 数据预处理：强制转为列向量
    steer_data = steer_data(:);
    len_steer = length(steer_data);

    % 窗口长度奇数校验
    if mod(win_len, 2) ~= 1
        warning('平滑窗口长度必须为奇数，已自动修正为%d', win_len + 1);
        win_len = win_len + 1;
    end

    % 转向角仿真数据平滑处理
    steer_data_smoothed = sgolayfilt(steer_data, poly_ord, win_len);
    steer_data_smoothed = steer_data_smoothed(:);
    fprintf('转向角仿真数据平滑后长度：%d，维度：%d×%d\n', length(steer_data_smoothed), size(steer_data_smoothed,1), size(steer_data_smoothed,2));

    % 加独立随机高斯白噪声
    noisy_steer_data = steer_data_smoothed + noise_amp * randn(size(steer_data_smoothed));
    noisy_steer_data = noisy_steer_data(:);
    fprintf('转向角加噪声后仿真数据长度：%d，维度：%d×%d\n', length(noisy_steer_data), size(noisy_steer_data,1), size(noisy_steer_data,2));

    % 构建0-60秒时间轴
    time_final = linspace(0, 60, len_steer);
    time_final = time_final(:);

    % 长度校验+绘图
    if length(time_final) == length(steer_data_smoothed) && length(time_final) == length(noisy_steer_data)
        figure(fig_idx);
        set(gcf, ...
            'Color', 'white', ...
            'Position', fig_pos);  % 调用固定尺寸/位置
        
        % 绘制曲线（与原格式一致）
        plot(time_final, noisy_steer_data,'Color', '#ec2b24','LineStyle','-','LineWidth',1.5);
        hold on;
        plot(time_final, steer_data_smoothed, 'Color', 'b','LineStyle','--','LineWidth',1.5);
        
        % 图形美化（原格式不变）
        % xlabel('Time (s)', 'FontSize',15, 'FontName','Times New Roman');
        % ylabel('\it\delta\rm (°)', 'FontSize',12, 'FontName','Times New Roman', 'Interpreter','TeX');
        xticks([]);
        % xticklabels({'0', '20', '40', '60'});
        set(gca, 'FontName','Times New Roman', 'FontSize',15, 'FontWeight','bold');
        % ylim([-0.2,0.4])
        hold off;
    else
        error('第%d个figure：数据长度不匹配！时间轴(%d)、平滑仿真数据(%d)、加噪声仿真数据(%d)', ...
            fig_idx, length(time_final), length(steer_data_smoothed), length(noisy_steer_data));
    end
end