# Graduation-Project
This space is for organizing the MATLAB codes I used while working on my graduation project. If you wanna see my thesis, you can click and see my thesis pdf file. 

<Project Overview: V2X Congestion Control Study>
1. Background & Objectives

Context: With the advancement of Autonomous Driving, ensuring reliable V2X (Vehicle-to-Everything) communication is critical for road safety.

Problem Definition: Traditional congestion control lacks adaptability in dynamic traffic. This study aims to implement a DQN (Deep Q-Network) based model to optimize transmission intervals and ensure communication stability.

Goal: To evaluate the generalization performance of the reinforcement learning model when moving from simple highway scenarios to complex urban intersections.

2. Methodology

Algorithm: Developed a DQN-based Deep Reinforcement Learning model with four distinct reward structures (CBR-based, CBR+PDR, Hybrid, and Target-PDR) to find the optimal control policy.

Data & Simulation: * Training: Used real-world highway traffic data from Olympic-Daero (PM peak hours).

Testing: Evaluated the model in a complex crossroad environment modeled after Jangji-daero.

Metrics: Measured Packet Delivery Ratio (PDR) and Channel Busy Ratio (CBR) to assess communication efficiency.

3. Research Results

Key Finding: While the DQN model performed consistently in highway environments, it faced significant generalization challenges in urban intersections due to rapid vehicle density fluctuations.

Logical Analysis: Identified that training solely on highway data is insufficient for complex urban scenarios, regardless of the reward structure used.

Conclusion: The study highlights the necessity of environment-aware training and more sophisticated reward modeling to achieve robust V2X performance in diverse real-world conditions.
