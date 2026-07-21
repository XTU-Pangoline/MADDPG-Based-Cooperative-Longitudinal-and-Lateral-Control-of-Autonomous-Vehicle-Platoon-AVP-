%% MADDPG 在MSN三种工况下的控制表现
% 利用4个DDPG智能体分别控制加速度和前轮转向角实现路径跟踪
clc
clear
close all
%% 
% % 检查是否有可用的 CUDA 设备
% if gpuDeviceCount > 0
%     gpuDevice(1); % 设置第一个 CUDA 设备为当前设备
%     device = 'gpu';
% else
%     device = 'cpu';
% end
% opengl('save', 'software');
%% 
m = 1600;   % 车辆总质量(kg)
Iz = 2875;  % 横摆惯性矩(mNs^2)
lf = 1.4;   % 重心到前轮纵向距离(m)
lr = 1.6;   % 重心到后轮纵向距离(m)
Cf = 19000; % 前轮胎转弯刚度(N/rad)
Cr = 33000; % 后轮胎转弯刚度(N/rad)
tau = 0.5;  % 纵向时间常数

D_default = 1.5;  %静止默认间距(m)
t_gap = 1.4;    %时间间隔(s)
v_set = 1.5;     %驱动设置速度(m/s)

amin_ego = -0.5;    %加速度下限
amax_ego = 0.4;     %加速度上限
umin_ego = -0.2618;  %转向角下限
umax_ego = 0.2618;   %转向角上限


Ts = 0.1;           %采样时间Ts
Tf = 60;            %模拟持续时间Tf

%切换工况 
% 1：ramp-S工况；
% 2：sine-N工况
% 3：step-M工况
target = 3;
mdl = "rlMADDPG4PFC2";

x0_LV = 3;   

if target == 1
    v0_LV = 1;
elseif target == 2
    v0_LV = 0.65;
else
    v0_LV = 0.9;
end
%跟随车1
x0_FV1 = 1.5;   
v0_FV1 = 0.5;    
%跟随车2
x0_FV2 = 0;   
v0_FV2 = 0.5;    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e1_initial = 0;  %横向偏差初始值 -0.2   -0.05
e2_initial = 0.26; %相对偏航角初始值 0.32  0.05
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
open_system(mdl)
load_system(mdl)
%%
% 状态与动作空间
obsInfo1 = rlNumericSpec([4 1]);
actInfo1 = rlNumericSpec([1 1],'LowerLimit',amin_ego ,'UpperLimit',amax_ego);
obsInfo2 = rlNumericSpec([9 1]);
actInfo2 = rlNumericSpec([1 1],'LowerLimit',umin_ego,'UpperLimit',umax_ego);
observationInfo = {obsInfo1,obsInfo2,obsInfo1,obsInfo2};
actionInfo = {actInfo1,actInfo2,actInfo1,actInfo2};
%% 
blks = mdl + ["/Agent1", "/Agent2", "/Agent3", "/Agent4"];
env = rlSimulinkEnv(mdl,blks,observationInfo,actionInfo);
env.ResetFcn = @(in)Reset(in);
rng(0)
%% 
agent1 = createDDPGAgent1(obsInfo1,actInfo1,Ts);
agent2 = createDDPGAgent2(obsInfo2,actInfo2,Ts);
agent3 = createDDPGAgent1(obsInfo1,actInfo1,Ts);
agent4 = createDDPGAgent2(obsInfo2,actInfo2,Ts);
%% 
maxepisodes = 5000;
maxsteps = ceil(Tf/Ts);
trainingOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes,...
    'MaxStepsPerEpisode',maxsteps,...
    'Verbose',false,...
    'Plots','training-progress',...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',[513,1100,513,1100]); 
%% 
% load('SimMADDPG1.mat');
% load('SimMADDPG2.mat');
load('SimMADDPG3.mat');

% trainingStats = train([agent1,agent2,agent3,agent4],env,trainingOpts);
% save('SimMADDPG2.mat','agent1','agent2','agent3','agent4','trainingStats', '-v7.3');

sim(mdl)
%% 
function in = Reset(in)
% reset 随机初始化
in = setVariable(in,'x0_lead',3+randi(5,1,1));    % 随机化引导车初始位置
in = setVariable(in,'e1_initial', 0.1*(-1+2*rand)); % 随机化横向偏差
in = setVariable(in,'e2_initial', 0.1*(-1+2*rand)); % 随机化相对偏航角
end