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


(References)
1)Sepulcre, M., Mittag, J., Santi, P., Hartenstein, H., & Gozalvez, J. (2011). Congestion and awareness control in cooperative vehicular systems. Proceedings of the IEEE, 99(7), 1260-1279

2) Autolitano, A., Reineri, M., Scopigno, R. M., Campolo, C., & Molinaro, A. (2014, November). Understanding the channel busy ratio metrics for decentralized congestion control in VANETs. In 2014 International Conference on Connected Vehicles and Expo (ICCVE) (pp. 717-722). IEEE.
   
3) A. Festag, "Cooperative intelligent transport systems standards in europe," in IEEE Communications Magazine, vol. 52, no. 12, pp. 166-172, December 2014
 
4)Balador, A., Cinque, E., Pratesi, M., Valentini, F., Bai, C., G mez, A. A., & Mohammadi, M. (2022). Survey on decentralized congestion control methods for vehicular communication. Vehicular Communications, 33, 100394

5) Ye, H., Li, G. Y., & Juang, B. H. F. (2019). Deep reinforcement learning based resource allocation for V2V communications. IEEE Transactions on Vehicular Technology, 68(4), 3163-3173
 
6)Yoon, Y., Lee, H., & Kim, H. (2023). Deep reinforcement learning‐based dual‐mode congestion control for cellular V2X environments. Electronics Letters, 59(20), e12984.

7) Hwang, J., & Lee, S. (2020). Balancing power and rate control for improved congestion control communication in cellular environments. V2X IEEE International Conference on Information and Communication Technology Convergence (ICTC), 469–474.
  
8) European Telecommunications Standards Institute. (2021). ETSI TS 103 574 V1.1.1: Intelligent Transport Systems (ITS); LTE-V2X; Distributed Congestion Control (DCC) framework. ETSI

9)Todiscco, V., Bartoletti, S., Campolo, C., Molinaro, A., Berthet, A. O., & Bazzi, A. (2021). Performance analysis of sidelink 5G-V2X Mode 2 through an open-source simulator. IEEE Access, 9, 145648–145661.

10) 3rd Generation Partnership Project. (2020). 3GPP TR 36.214 V18.0.0: Evolved Universal Terrestrial Radio Access (E-UTRA); Physical layer measurements. 3GPP
  
11) Mnih, V., Kavukcuoglu, K., Silver, D., Graves, A., Antonoglou, I., Wierstra, D., & Riedmiller, M. (2013). Playing atari with deep reinforcement learning. arXiv preprint arXiv:1312.5602.
 
12) Liu, M., Quan, W., Yu, C., Zhang, X., & Gao, D. (2021, September). Deep reinforcement learning based adaptive transmission control in vehicular networks. In 2021 IEEE 94th Vehicular Technology Conference (VTC2021-Fall) (pp. 1-5). IEEE.
