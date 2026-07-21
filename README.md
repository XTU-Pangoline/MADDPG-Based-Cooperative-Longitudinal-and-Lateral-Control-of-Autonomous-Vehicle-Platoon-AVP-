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
1. MADDPG (Main Control Algorithm)
    This folder contains the proposed multi-agent control architecture and its variants.
    MADDPG4_1/
        Description: The main proposed algorithm with the predictive rule-based constraint module.
        Usage: Run the main script directly.
        Core Model: rlMADDPG4PFC2.slx.

    MADDPG4__no_rules/
    Description: The ablation study version of the MADDPG algorithm without the predictive rule-based constraint module.
        Usage: Run the main script directly.
        Core Model: rlMADDPG4_no_rules.slx.

    RL_COMP/
    Description: Another comparative algorithm (details in the manuscript).
        Usage: Run rlCOMP.slx directly.
        Note: To modify the logic in the constraint module, adjust the parameters in the correction1-4 blocks.

    2. DDPG_DQN (Baseline Comparisons)
    This folder contains the baseline controllers for comparison.
    Usage:
        Run the DDPG_1 script to execute the DDPG algorithm.
        Run the DQN4 script to execute the DQN algorithm.
        Trained Models: The DDPG algorithm calls NewDDPG1.mat and NewDDPG2.mat; the DQN algorithm calls SimDQN1.mat, SimDQN2.mat, and SimDQN3.mat.

    3. Plotting (Simulation Results)
    This folder contains the scripts to reproduce the simulation figures presented in the manuscript.
        figure1_FV1, figure2_FV1, etc.: Plotting scripts for FV1 performance under different scenarios.
        RMSE/: Calculation of Root Mean Square Error (RMSE) (RMSE_ev, RMSE_ed) and code to plot the RMSE bar charts.

    💡 Important Note: Some statistical figures in the manuscript were generated using OriginLab software. The source project files for these Origin figures are     located in a local directory. To run these plots, please update the file path in 3 Figure scripts to your local Origin project path, or export the data to .csv and plot them in your own OriginLab instance.

    4. Experiment (HIL Results)
    This folder contains scripts to generate the Hardware-in-the-Loop (HIL) experimental result figures.
        guiji_exp_sim: Compares the simulated and experimental trajectories.
        steer_exp_sim: Compares the simulated and experimental steering angles.
        velocity_exp_sim: Compares the simulated and experimental velocity profiles.

    🚀 Quick Start Guide
    Set up environment: Ensure MATLAB and the required toolboxes are installed.
    Run the main algorithm: Navigate to 1 MADDPG/MADDPG4_1 and run the main MATLAB script. This will launch the Simulink simulation based on rlMADDPG4PFC2.slx.
    Reproduce figures: After the simulation runs, you can execute the scripts in 3 Figure to generate the figures.

Note: The simulation data file is too large to upload to GitHub. Click the link to download the mat results package, extract it, and place it in the corresponding directory to reproduce the plotting results.
https://1drv.ms/f/c/6030f637fb84bfdb/IgAqo8BQ-Ax-Rqb9HkaXD4SkAZ7iRfn5UK16lhYLkMlmnRc?e=dzYYWt
