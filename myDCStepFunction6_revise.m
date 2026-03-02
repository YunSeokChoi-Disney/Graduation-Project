function [NextObs,Reward,IsDone,LoggedSignals] = myDCStepFunction6(Action,LoggedSignals)
% Step for DCC-DQN (bin-based state & table lookup)
% - 관측: [bin_id ; cbr_bin]  (두 번째는 166ms 기준 bin CBR)
% - 보상: -REWARD_SCALE * | PRR_bin(bin, action) - PDR_TARGET |
% - 에피소드 길이: LoggedSignals.MAX_STEPS (기본 2 스텝)

    % ----- 1) 상태/액션 파싱 -----
    bin  = round(double(LoggedSignals.bin_id));                 % 1..K
    cbr  = double(LoggedSignals.cbr);                           % 0..1
    ACTS = LoggedSignals.ACTIONS(:).';                          % [100 166 333]
    if isstruct(Action) && isfield(Action,'Index')              % 안정 파싱
        aIdx = Action.Index;
    else
        % 숫자 ms를 index로 변환
        a = double(Action);
        [~,aIdx] = min(abs(ACTS - a));
    end
    aIdx = max(1,min(3,aIdx));

    % ----- 2) 보상 계산 -----
    prr    = LoggedSignals.PRR_bin(bin, aIdx);
    target = LoggedSignals.PDR_TARGET;
    Reward = -LoggedSignals.REWARD_SCALE * abs(prr - target);

    % ----- 3) 다음 상태 업데이트 -----
    % 여기서는 bin을 유지(정책 평가용/2-step 에피소드). 원하면 무작위 bin 재샘플 가능.
    LoggedSignals.stepCount = LoggedSignals.stepCount + 1;
    IsDone = LoggedSignals.stepCount >= LoggedSignals.MAX_STEPS;

    % 관측은 [bin_id ; cbr_bin] 유지
    NextObs = [bin; cbr];

    % (선택) episode 종료 시 다음 reset에서 다른 bin이 뽑히므로 탐색 다양성 확보
end
