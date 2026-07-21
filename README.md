# MADDPG-Based Cooperative Longitudinal and Lateral Control of Autonomous Vehicle Platoon (AVP)

This repository contains the complete source code, Simulink models, and plotting scripts for the paper: **[Insert Your Paper Title Here]**. The code implements the proposed MADDPG-based controller with a predictive rule-based constraint mechanism, as well as benchmark algorithms (DDPG, DQN) for comparative analysis.

## 📋 System Requirements & Dependencies
- **MATLAB**: R2022b or later (Recommended)
- **Required MATLAB Toolboxes**:
  - Deep Learning Toolbox
  - Reinforcement Learning Toolbox
  - Simulink
  - MATLAB ROS Toolbox (if using ROS interfaces)
- **Optional Software**: OriginLab (required for generating specific statistical plots; see Section 3 for details)

## 📂 Repository Structure
```text
/
├── 1 MADDPG/                 # Core algorithm of the proposed method
├── 2 DDPG_DQN/               # Baseline algorithms (DDPG & DQN)
├── 3 Figure/                    # Plotting scripts for simulation results
└── 4 Experiment/                    # Plotting scripts for HIL experimental results
