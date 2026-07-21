%% 均方根误差检查
%%("FV距离偏差");
clc;clear;close all;
%%
MAE_maddpg = mean(abs(ed1))
MAE_ddpg   = mean(abs(ed2))
MAE_dqn    = mean(abs(ed3))

RMSE_maddpg = sqrt(mean(ed1.^2))
RMSE_ddpg   = sqrt(mean(ed2.^2))
RMSE_dqn    = sqrt(mean(ed3.^2))

fprintf('算法\t\tMADDPG\t\tDDPG\t\tDQN\n');
fprintf('RMSE\t%.4f\t%.4f\t%.4f\n', RMSE_maddpg,RMSE_ddpg, RMSE_dqn);
fprintf('MAE\t%.4f\t%.4f\t%.4f\n',MAE_maddpg, MAE_ddpg, MAE_dqn);
%% 
%FV1横向偏差 
clc;
MAE_maddpg = mean(abs(lateral_1))
MAE_ddpg   = mean(abs(lateral2_1))
MAE_dqn    = mean(abs(lateral3_1))

RMSE_maddpg = sqrt(mean(lateral_1.^2))
RMSE_ddpg   = sqrt(mean(lateral2_1.^2))
RMSE_dqn    = sqrt(mean(lateral3_1.^2))


fprintf('算法\t\tMADDPG\t\tDDPG\t\tDQN\n');
fprintf('RMSE\t%.4f\t%.4f\t%.4f\n', RMSE_maddpg,RMSE_ddpg, RMSE_dqn);
fprintf('MAE\t%.4f\t%.4f\t%.4f\n',MAE_maddpg, MAE_ddpg, MAE_dqn);
%% 
%%("FV2横向偏差");
clc;
MAE_maddpg = mean(abs(lateral_2))
MAE_ddpg   = mean(abs(lateral2_2))
MAE_dqn    = mean(abs(lateral3_2))

RMSE_maddpg = sqrt(mean(lateral_2.^2))
RMSE_ddpg   = sqrt(mean(lateral2_2.^2))
RMSE_dqn    = sqrt(mean(lateral3_2.^2))

fprintf('算法\t\tMADDPG\t\tDDPG\t\tDQN\n');
fprintf('RMSE\t%.4f\t%.4f\t%.4f\n', RMSE_maddpg,RMSE_ddpg, RMSE_dqn);
fprintf('MAE\t%.4f\t%.4f\t%.4f\n',MAE_maddpg, MAE_ddpg, MAE_dqn);
 

