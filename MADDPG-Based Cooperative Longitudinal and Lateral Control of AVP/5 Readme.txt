1 MADDPG为 主代码的文件夹
其中，
MADDPG4_1 为 本研究算法代码 直接运行即可
rlMADDPG4PFC2.slx为主算法对应的模型
--------------------------
MADDPG4__no_rules 为 没有规则约束的MADDPG算法，用于做对比
rlMADDPG4_no_rules.slx ，对应的模型
--------------------------
RL_COMP 为对比算法，直接运行即可
rlCOMP.slx 为对应的模型，如果需要修改，将规则约束中correction1-4的参数进行调整
-------------------------
2 DDPG_DQN 为对比算法 DDPG以及DQN 代码文件夹
直接运行 DDPG_1  DQN4文件即可

DDPG算法可调用 NewDDPG1.mat NewDDPG2.mat 文件用以运行
DQN算法可调用  SimDQN1.mat SimDQN2.mat SimDQN3.mat 文件用以运行
-----------------------------------------------------------------------------------
3 出图 为出图文件夹，大多数图均在这里出，

figure1_FV1  为 工况1下 FV1的绘图代码
figure2_FV1  为 工况2下 FV1的绘图代码
以此类推
RMSE 为误差计算代码 
RMSE_ev RMSE_ed 为RMSE柱状图绘制代码

部分图用origin绘，目录位于
“E:\A-研究生工作\9-研究论文\2 part_2\3 数据\1 origin”中
-----------------------------------------------------------------------------------
4 实验 实验出图代码在这
guiji_exp_sim 为轨迹对比图
steer_exp_sim 为转向角对比图
velocity_exp_sim 为速度对比图