function [InitialObservation, LoggedSignals] = myDCResetFunction_final_90()

% 180, 200, 220의 값을 순차적으로 반복해서 선택
persistent episodeCount;
if isempty(episodeCount)
    episodeCount = 0; % 에피소드 카운터 초기화
end

rho_values = randi([100, 400]); % 180, 200, 220 값 순서 반복
rho_initial = rho_values; % 에피소드 순서대로 선택

 rho_initial_segmentated_index = round((rho_initial) / 20) - 4;     %%랜덤으로 뽑은 rho_initial 값을 → CBR/PRR 테이블의 인덱스 값으로 매핑
 
 CBR_initial_table = [0.471129045;
                      0.546971022;
                      0.614906569;
                      0.674315107;
                      0.721577499;
                      0.761341181;
                      0.796477273;
                      0.824161055;
                      0.851615964;
                      0.87109677;
                      0.891393936;
                      0.907352874;
                      0.920753606;
                      0.92969531;
                      0.940673526;
                      0.948941533];

 PRR_initial_table = [0.983687376965022;
                      0.969412229731521;
                      0.952192776289104;
                      0.928409524853872;
                      0.893620007232527;
                      0.867536626779148;
                      0.827721181630646;
                      0.802596260728475;
                      0.767520562129657;
                      0.738438700876733;
                      0.711211716710773;
                      0.687458021512753;
                      0.660664333153334;
                      0.632371833875124;
                      0.608541649922567;
                      0.591004754759571];

CBR_initial = CBR_initial_table(rho_initial_segmentated_index, 1); % CBR 값 선택
PRR_initial = PRR_initial_table(rho_initial_segmentated_index, 1); % CBR 값 선택

LoggedSignals.State = [rho_initial; CBR_initial; PRR_initial];
InitialObservation = [LoggedSignals.State(1); LoggedSignals.State(2)];

% 에피소드 카운터 증가
episodeCount = episodeCount + 1;

end