% ========================================================================
% run_dcc_dqn_PMdist_main.m
%  - PM 분포 기반 DQN 학습 및 PDR_target (85%, 90%) 비교 시각화
%  - Baseline: Tgen={100,200,300} [ms]
%  - Output: DQN(85%), DQN(90%) 결과 비교 그래프
% ========================================================================
clear; close all; clc; rng(1,'twister');

%% [1] 시뮬레이션 데이터 로드
tmp = load('simTbl_T100_density.mat'); T100 = tmp.T;
tmp = load('simTbl_T200_density.mat'); T200 = tmp.T;
tmp = load('simTbl_T300_density.mat'); T300 = tmp.T;

rho = T100.rho(:);
PRR_100 = T100.PRR_T100(:);
PRR_200 = T200.PRR_T200(:);
PRR_300 = T300.PRR_T300(:);
CBR_200 = T200.CBR_T200(:);   % 상태 입력용 CBR

%% [2] 공통 파라미터
ACTIONS = [100 200 300];
TARGETS = [0.85 0.90];
LINE_W  = 2.0;

PRR_DQN = zeros(length(rho), numel(TARGETS));

%% [3] 두 가지 PDR_TARGET에 대해 각각 학습 실행
for ti = 1:numel(TARGETS)
    PDR_TARGET = TARGETS(ti);
    assignin('base','PDR_TARGET_GLOBAL',PDR_TARGET);

    % --- 환경 정의 ---
    obsInfo = rlNumericSpec([2 1],'LowerLimit',[0;0],'UpperLimit',[max(rho);1]);
    actInfo = rlFiniteSetSpec(ACTIONS);
    env = rlFunctionEnv(obsInfo,actInfo,'myDCStepFunction7_PMdist','myDCResetFunction7_PMdist');

    % --- DQN 에이전트 설정 ---
    statePath = [
        featureInputLayer(2)
        fullyConnectedLayer(32)
        reluLayer
        fullyConnectedLayer(32)
        reluLayer
        fullyConnectedLayer(numel(ACTIONS))
        ];
    criticOpts = rlRepresentationOptions('LearnRate',1e-3,'GradientThreshold',1);
    critic = rlQValueRepresentation(statePath,obsInfo,actInfo,criticOpts);

    agentOpts = rlDQNAgentOptions(...
        'UseDoubleDQN',true,...
        'TargetSmoothFactor',1e-3,...
        'ExperienceBufferLength',1e5,...
        'DiscountFactor',0.99,...
        'MiniBatchSize',64,...
        'EpsilonGreedyExploration',struct('Epsilon',1.0,'EpsilonDecay',0.9995,'EpsilonMin',0.05));

    agent = rlDQNAgent(critic,agentOpts);

    % --- 학습 옵션 ---
    trainOpts = rlTrainingOptions(...
        'MaxEpisodes',4000,...
        'MaxStepsPerEpisode',2,...
        'StopTrainingCriteria','AverageReward',...
        'StopTrainingValue',-5,...
        'ScoreAveragingWindowLength',30,...
        'Verbose',false,...
        'Plots','none');

    fprintf('=== Training DQN (PDR_target=%.2f) ===\n', PDR_TARGET);
    trainStats = train(agent,env,trainOpts);
    save(sprintf('dqn_agent_PMdist_%.0f.mat',PDR_TARGET*100),'agent');

    %% --- DQN 학습 결과 기반 PRR 계산 ---
    for i = 1:length(rho)
        obs = [rho(i); CBR_200(i)];
        act = getAction(agent,obs);
        switch act
            case 100, PRR_DQN(i,ti) = PRR_100(i);
            case 200, PRR_DQN(i,ti) = PRR_200(i);
            case 300, PRR_DQN(i,ti) = PRR_300(i);
        end
    end
end

%% [4] 시각화 (Fig.2 스타일)
figure('Color','w','Position',[80 90 1200 520]);
tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

for ti = 1:numel(TARGETS)
    nexttile;
    hold on; grid on; box on;
    plot(rho, PRR_100, 'r--','LineWidth',LINE_W-0.5);
    plot(rho, PRR_200, 'g--','LineWidth',LINE_W-0.5);
    plot(rho, PRR_300, 'k--','LineWidth',LINE_W-0.5);
    plot(rho, PRR_DQN(:,ti), 'b-','LineWidth',LINE_W);
    yline(TARGETS(ti), 'b:','LineWidth',1.2);

    % QoS 영역 표시 (0.85~0.90 사이)
    ylimit = ylim;
    xPatch = [min(rho)+50 max(rho)-50 max(rho)-50 min(rho)+50];
    yPatch = [TARGETS(ti)-0.02 TARGETS(ti)-0.02 TARGETS(ti)+0.02 TARGETS(ti)+0.02];
    patch(xPatch,yPatch,[0.8 0.9 1],'FaceAlpha',0.2,'EdgeColor','none');

    xlabel('Vehicle density \rho [veh/km]');
    ylabel('Average PDR');
    title(sprintf('DQN (PDR_{target}=%.0f%%)',TARGETS(ti)*100));
    legend('T_{gen}=100ms','200ms','300ms','DQN Policy','PDR_{target}','Location','southwest');
    ylim([ylimit(1) 1]);
end

sgtitle('DQN vs ETSI Baseline by Vehicle Density');
fprintf('✅ Finished: DQN comparison plots generated.\n');
