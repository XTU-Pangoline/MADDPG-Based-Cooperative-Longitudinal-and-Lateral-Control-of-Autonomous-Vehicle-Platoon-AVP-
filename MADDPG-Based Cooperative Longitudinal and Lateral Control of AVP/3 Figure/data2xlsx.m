%%将数据快速导出为xlsx格式
clc;
clear;
% 加载数据
load("MADDPG_3.mat",'lateral_1', 'lateral_2')
load("DDPG_3.mat",'lateral2_1', 'lateral2_2')
load("DQN_3.mat",'lateral3_1', 'lateral3_2')

% 找到最大长度，用于对齐数据
max_len = max([length(lateral_1), length(lateral_2), length(lateral2_1), ...
               length(lateral2_2), length(lateral3_1), length(lateral3_2)]);

% 创建数据矩阵，用NaN填充不足的部分
data_matrix = NaN(max_len, 6);
data_matrix(1:length(lateral_1), 1) = lateral_1;
data_matrix(1:length(lateral_2), 2) = lateral_2;
data_matrix(1:length(lateral2_1), 3) = lateral2_1;
data_matrix(1:length(lateral2_2), 4) = lateral2_2;
data_matrix(1:length(lateral3_1), 5) = lateral3_1;
data_matrix(1:length(lateral3_2), 6) = lateral3_2;

% 创建列标题
headers = {'MADDPG_1', 'MADDPG_2', 'DDPG_1', 'DDPG_2', 'DQN_1', 'DQN_2'};

% 写入Excel
filename = '横向偏差数据3.xlsx';
writematrix(data_matrix, filename, 'Sheet', 1, 'Range', 'B2');
writecell(headers, filename, 'Sheet', 1, 'Range', 'B1');

fprintf('数据已导出到: %s\n', filename);
