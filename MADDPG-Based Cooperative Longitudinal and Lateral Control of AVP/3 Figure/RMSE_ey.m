%% 数据准备
% 创建算法名称数组 (包含引用标记)
algorithms = {
    'DQN', 
    'DDPG', 
    'MADDPG'
};

% 任务名称数组 - 每个Case有3种速度
cases = {'Case 1', 'Case 2', 'Case 3'};
speeds = {'FV1', 'FV2'};

% 模拟数据矩阵 - 行: 算法，列: 任务×速度组合
% 列顺序: [Case1-FV1, Case1-FV2, Case2-FV1, Case2-FV2, Case3-FV1, Case3-FV2]
data = [
    0.0409, 0.0228, 0.0695, 0.0686, 0.0696, 0.0706;  %DQN
    0.0341, 0.0331, 0.0595, 0.0584, 0.0487, 0.0487; % DDPG
    0.033, 0.0195, 0.0498, 0.0473, 0.0376, 0.034; % MADDPG
];

%% 图形参数设置
% 创建颜色映射 (使用与示例图片相似的鲜明色彩)
colors = [
    "#abc3db";    
    "#81cfbe";    
    "#f19393"    
];

% 创建图窗并设置大小
figure('Position', [100, 100, 850, 300], 'Color', 'white', ...
       'Name', '横向误差RMSE对比');

%% 柱状图绘制
% 创建分组柱状图
b = bar(data', 1.0, 'grouped');  % 1为柱子宽度

% 设置柱子颜色 + 黑色边框（关键修改）
for k = 1:numel(algorithms)
    b(k).FaceColor = colors(k, :);  % 保持原有填充色
    b(k).EdgeColor = 'black';       % 边框颜色设为黑色
    b(k).LineWidth = 1;             % 边框宽度（可调整，1-1.5较合适）
end

%% 坐标轴与标签设置
% 获取当前坐标轴句柄
ax = gca;

% X轴标签设置
set(ax, 'FontName', 'Times New Roman', 'FontSize', 14, 'FontWeight','bold');
xticklabels(ax, repmat(speeds, 1, numel(cases)));
set(ax, 'TickLabelInterpreter', 'tex'); % 支持LaTeX格式

% Y轴设置
ylabel('RMSE(m)', 'FontName', 'Times New Roman', ...
       'FontSize', 16, 'FontWeight','bold');  % MAE of lateral error
ylim(ax, [0 0.08]); % 根据数据调整Y轴范围

% % 添加网格线
% set(ax, 'XGrid', 'off', ...
%         'YGrid', 'on', ...
%         'GridLineStyle', '--', ...
%         'GridColor', [0.85 0.85 0.85], ...
%         'GridAlpha', 1);
%% Case分组标记
hold on;
for i = 1:numel(cases)
    % 计算每个Case标签的中心位置
    caseCenter = (i-1)*length(speeds) + length(speeds)/2 + 0.5;
   
    % 添加Case标签（在横轴下方） - 使用Times New Roman
    text(caseCenter, -0.017, cases{i}, ...
         'FontName', 'Times New Roman', ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'middle', ...
         'FontSize', 16, ...
         'FontWeight', 'bold');
end
hold off;

% 设置坐标轴外观
box off;
set(ax, 'LineWidth', 1.2, ...
        'TickDir', 'out', ...
        'XMinorTick', 'off', ...
        'YMinorTick', 'off');

set(ax, 'TickLength', [0 0]);  % 删除X轴和Y轴的刻度线
% 调整布局
set(ax, 'Position', [0.10 0.22 0.85 0.70]); % 加大底部空间用于标签

