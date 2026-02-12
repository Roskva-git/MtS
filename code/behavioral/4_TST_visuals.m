%% 4.1 TST Behavioural tables and figures

% Author: Røskva
% Date: 10.02.26
% Last changed: 12.02.26

% Workflow:
% Step 1. Preprocess EEG + ICA
% Step 2. Manually reject ICs
% Step 3. Map logfiles onto EEG events (creates *_mapped.set)
% Step 4. Extract behavioural overview 
% Step 4.1 Create visuals
% Step 5. Epoching


%% Load data
T = readtable("C:\Users\catba\Documents\Universitetet i Oslo\Høsten 2025\MICC - Master project\Data\Behavioural overview master.xlsx.xlsx", 'VariableNamingRule','preserve');
T = convertvars(T, @ischar, @str2double);
T = convertvars(T, @isstring, @str2double);
T = convertvars(T, @iscell, @str2double);



%% Create a descriptive table

%% Remove non-informative columns
T.participantID = [];
T.session = [];

Tnum = T(:, vartype('numeric'));


%% Compute descriptives (includes all numeric variables)
Mean   = varfun(@(x) mean(x,'omitnan'),   Tnum);
SD     = varfun(@(x) std(x,'omitnan'),    Tnum);
Median = varfun(@(x) median(x,'omitnan'), Tnum);
MinVal = varfun(@(x) min(x,[],'omitnan'), Tnum);
MaxVal = varfun(@(x) max(x,[],'omitnan'), Tnum);
N      = varfun(@(x) sum(~isnan(x)),      Tnum);              % N non-NaN
SumVal = varfun(@(x) sum(x,'omitnan'),    Tnum);              % useful for trial counts

% Ensure consistent variable names
Mean.Properties.VariableNames   = Tnum.Properties.VariableNames;
SD.Properties.VariableNames     = Tnum.Properties.VariableNames;
Median.Properties.VariableNames = Tnum.Properties.VariableNames;
MinVal.Properties.VariableNames = Tnum.Properties.VariableNames;
MaxVal.Properties.VariableNames = Tnum.Properties.VariableNames;
N.Properties.VariableNames      = Tnum.Properties.VariableNames;
SumVal.Properties.VariableNames = Tnum.Properties.VariableNames;

%% Combine into one table
Desc = [Mean; SD; Median; MinVal; MaxVal; N; SumVal];
Desc.Properties.RowNames = {'Mean','SD','Median','Min','Max','N','Sum'};


%% Save as Excel
outFile = "C:\Users\catba\Documents\Universitetet i Oslo\Høsten 2025\MICC - Master project\Data\behavioural_descriptives.xlsx";

writetable(Desc, outFile, 'WriteRowNames', true, 'Sheet', 'AllNumeric');

% Count/trial variables only (nTrials..., nCorrect..., rt_n..., etc.)
vn = string(Tnum.Properties.VariableNames);
isCountVar = startsWith(vn,"n") | contains(vn,"_n_") | startsWith(vn,"rt_n") | contains(vn,"rt_n");
Tcounts = Tnum(:, isCountVar);

MeanC   = varfun(@(x) mean(x,'omitnan'), Tcounts);
SDC     = varfun(@(x) std(x,'omitnan'),  Tcounts);
MinC    = varfun(@(x) min(x,[],'omitnan'), Tcounts);
MaxC    = varfun(@(x) max(x,[],'omitnan'), Tcounts);
SumC    = varfun(@(x) sum(x,'omitnan'),  Tcounts);

MeanC.Properties.VariableNames = Tcounts.Properties.VariableNames;
SDC.Properties.VariableNames   = Tcounts.Properties.VariableNames;
MinC.Properties.VariableNames  = Tcounts.Properties.VariableNames;
MaxC.Properties.VariableNames  = Tcounts.Properties.VariableNames;
SumC.Properties.VariableNames  = Tcounts.Properties.VariableNames;

DescCounts = [MeanC; SDC; MinC; MaxC; SumC];
DescCounts.Properties.RowNames = {'Mean','SD','Min','Max','Sum'};

writetable(DescCounts, outFile, 'WriteRowNames', true, 'Sheet', 'CountsOnly');



%% Plot descriptives

T.omission_rate = T.nOmission ./ T.nTrialsStim;

figure; boxplot(T.omission_rate); 
title('Omissions'); ylabel('Proportion');

figure; boxplot([T.rt_mean_cC, T.rt_mean_cE], 'Labels', {'Correct','Error'});
title('RT by outcome'); ylabel('Seconds');

figure; boxplot([T.rt_mean_cC_switch, T.rt_mean_cC_repeat], 'Labels', {'Switch','Repeat'});
title('RT: Switch cost'); ylabel('Seconds');

figure; boxplot([T.acc_switch_response, T.acc_repeat_response], 'Labels', {'Switch','Repeat'});
title('Accuracy: Switch cost'); ylabel('Proportion correct');

figure; boxplot([T.rt_mean_cC_con, T.rt_mean_cC_inc], 'Labels', {'Congruent','Incongruent'});
title('RT: Congruency'); ylabel('Seconds');

figure; boxplot([T.acc_con_response, T.acc_inc_response], 'Labels', {'Congruent','Incongruent'});
title('Accuracy: Congruency'); ylabel('Proportion correct');

% Costs
T.switch_cost_rt = T.rt_mean_cC_switch - T.rt_mean_cC_repeat;
T.cong_cost_rt   = T.rt_mean_cC_inc - T.rt_mean_cC_con;

figure; boxplot(T.switch_cost_rt);
title('Switch cost (RT)'); ylabel('Seconds');

figure; boxplot(T.cong_cost_rt);
title('Congruency cost (RT)'); ylabel('Seconds');


% Proportions of correct, incorrect and omissions:

T.prop_correct  = T.nCorrect  ./ T.nTrialsStim;
T.prop_error    = T.nError    ./ T.nTrialsStim;
T.prop_omission = T.nOmission ./ T.nTrialsStim;

% Ensure proportions are numeric (fixes your error)
T.prop_correct  = double(T.prop_correct);
T.prop_error    = double(T.prop_error);
T.prop_omission = double(T.prop_omission);

% Mean proportions
meanProps = mean([T.prop_correct, T.prop_error, T.prop_omission], 'omitnan');

% Stacked bar
figure;
bar(meanProps, 'stacked');

ylim([0 1]);
ylabel('Proportion');
title('Response proportions');

legend({'Correct','Error','Omission'}, 'Location','best');


% Proportions of correct vs non-correct (error and omissions)

% Proportions
T.prop_correct     = T.nCorrect ./ T.nTrialsStim;
T.prop_notcorrect  = (T.nError + T.nOmission) ./ T.nTrialsStim;

% Plot
figure;
boxplot([T.prop_correct, T.prop_notcorrect], ...
        'Labels', {'Correct','Incorrect + Omission'});

ylabel('Proportion');
title('Correct vs Not Correct');
grid on;
