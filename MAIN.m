 %How is the data structured?   
 %NoDev = No Devaluation; HV/LV = high/low value; DevH/DevL = devaluation of the High/Low value outcome.   
 %column 1: trial, includes all types (also consumption)
 %column 2: block, 48 S-R-O trials and 4 consumption trials = 52 trials
 %column 3: block type, == 3 NoDev, == 1 DevH, == 2 DevL
 %column 4: cue type, == 1&2 HV, == 3&4 LV; 1&3 == food, 2&4 == office 5 == consumption trial
 %column 5: response type. == 1 usual best response (e.g. leading to +10 in
 %a NoDev, LV trial); == 0 usual worst response, == 3 usual high points
 %selected (consumption trial) / 4 usual low select (consumption trial), == 5 too soon, == 6 slow respo
 %column 7: Response Time (since the presentation of the Aliens on the
 %screen) in Seconds.
 %column 8: points earn this trial
 %column 9: total points so far
clear
path_to_data = 'F:\Work_current\S-R habits\S-R Habits_8 Stimuli incentive salience\Exp1 and Exp 2 - Serious analyses\data';
path_to_scripts = 'F:\Work_current\S-R habits\S-R Habits_8 Stimuli incentive salience\Exp1 and Exp 2 - Serious analyses\scripts';
cd (path_to_data)
S=dir('E*'); %'E' selects all data, E_1 selects only Experiment 1, E_2 selects only Experiment 2.


for x= 1:length(S)
 %% opening files and getting experiment and subject number
 %I am getting the subject number and experiment. This (messy) code works
 %for N < 100
    RR = S(x).name;
    if strlength(RR) == 11
        subject_n_str = RR(end-4); %subject as string
        subject_n = str2double(subject_n_str); %subject as double
        experiment_str = RR (end-8); %experiment as string
        experiment = str2double(experiment_str); %experiment as double
    elseif strlength(RR) == 12
        subject_n_str = RR(end-5:end-4);
        subject_n = str2double(subject_n_str);
        experiment_str = RR (end-9);
        experiment = str2double(experiment_str);
    else
        break
    end
subjects (x) = subject_n;
experiments (x) = experiment;
load (RR); %load the 'x' file (misterious music)
data = DATA.trial_data; %for short
%% getting the answers in the questionnaire
 output_timefood {x} = DATA.eat_veg(1); %time since last meal
 output_vegeterian {x} = DATA.eat_veg(2); %are you vegetarian/vegan?
 output_alim {x} = DATA.ali_bmi(1); %eating disorder
%% consumption trials
%consumption trials, NoDev (by block)
cons_trials = data(data(:,4)==5,:);
cons_trials_NoDev = cons_trials(cons_trials(:,3)==3,:); 
n_blocks = max (cons_trials_NoDev(:,2)); 
for i = 1:n_blocks
    correct_resp(i) = sum (cons_trials_NoDev(:,5)==3 & cons_trials_NoDev(:,2)==i);
    rt(i) = mean (cons_trials_NoDev((cons_trials_NoDev(:,5)==3 & cons_trials_NoDev(:,2)==i),7));
end
NoDev_consumption (x,:) = correct_resp; clear correct_resp 
NoDev_consumption_RT (x,:) = rt; clear rt
%consumption trials, DevH 
cons_trials_DevH = cons_trials(cons_trials(:,3)==1,:); 
correct_resp = sum (cons_trials_DevH(:,5)==4); %in these trials the correct R is low value diamond!
rt = mean (cons_trials_DevH((cons_trials_DevH(:,5)==4), 7));
DevH_consumption (x,:) = correct_resp; clear correct_resp 
DevH_consumption_RT (x,:) = rt; clear rt 
%consumption trials, DevL 
cons_trials_DevL = cons_trials(cons_trials(:,3)==2,:); 
correct_resp = sum (cons_trials_DevL(:,5)==3);
rt = mean (cons_trials_DevL((cons_trials_DevL(:,5)==3), 7));
DevL_consumption (x,:) = correct_resp; clear correct_resp 
DevL_consumption_RT (x,:) = rt; clear rt 
%% Learning trials (LT)
%NoDev(by block)
LT_trials = data(data(:,4)<5,:);
LT_trials_NoDev = LT_trials(LT_trials(:,3)==3,:);
    %NoDev_HV
      %food
for i = 1:n_blocks
    correct_resp(i) = sum (LT_trials_NoDev(:,4)==1 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i);
    time_outs(i) = sum (LT_trials_NoDev(:,4)==1 & LT_trials_NoDev(:,5)==6 & LT_trials_NoDev(:,2)==i);
    too_soon(i) =  sum (LT_trials_NoDev(:,4)==1 & LT_trials_NoDev(:,5)==5 & LT_trials_NoDev(:,2)==i);
    rt(i) = mean (LT_trials_NoDev((LT_trials_NoDev(:,4)==1 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i),7));
end
NoDev_LT_HV_food (x,:) = correct_resp; clear correct_resp 
NoDev_LT_RT_HV_food (x,:) = rt; clear rt
NoDev_time_outs_HV_food (x,:) = time_outs; clear time_outs
NoDev_too_soon_HV_food (x,:) = too_soon; clear too_soon
      %office 
for i = 1:n_blocks
    correct_resp(i) = sum (LT_trials_NoDev(:,4)==2 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i);
    time_outs(i) = sum (LT_trials_NoDev(:,4)==2 & LT_trials_NoDev(:,5)==6 & LT_trials_NoDev(:,2)==i);
    too_soon(i) =  sum (LT_trials_NoDev(:,4)==2 & LT_trials_NoDev(:,5)==5 & LT_trials_NoDev(:,2)==i);
    rt(i) = mean (LT_trials_NoDev((LT_trials_NoDev(:,4)==2 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i),7));
end
NoDev_LT_HV_office (x,:) = correct_resp; clear correct_resp 
NoDev_LT_RT_HV_office (x,:) = rt; clear rt
NoDev_time_outs_HV_office (x,:) = time_outs; clear time_outs
NoDev_too_soon_HV_office (x,:) = too_soon; clear too_soon
    %NoDev_LV
      %food
for i = 1:n_blocks
    correct_resp(i) = sum (LT_trials_NoDev(:,4)==3 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i);
    time_outs(i) = sum (LT_trials_NoDev(:,4)==3 & LT_trials_NoDev(:,5)==6 & LT_trials_NoDev(:,2)==i);
    too_soon(i) =  sum (LT_trials_NoDev(:,4)==3 & LT_trials_NoDev(:,5)==5 & LT_trials_NoDev(:,2)==i);
    rt(i) = mean (LT_trials_NoDev((LT_trials_NoDev(:,4)==3 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i),7));
end
NoDev_LT_LV_food (x,:) = correct_resp; clear correct_resp 
NoDev_LT_RT_LV_food (x,:) = rt; clear rt
NoDev_time_outs_LV_food (x,:) = time_outs; clear time_outs
NoDev_too_soon_LV_food (x,:) = too_soon; clear too_soon
      %office 
for i = 1:n_blocks
    correct_resp(i) = sum (LT_trials_NoDev(:,4)==4 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i);
    time_outs(i) = sum (LT_trials_NoDev(:,4)==4 & LT_trials_NoDev(:,5)==6 & LT_trials_NoDev(:,2)==i);
    too_soon(i) =  sum (LT_trials_NoDev(:,4)==4 & LT_trials_NoDev(:,5)==5 & LT_trials_NoDev(:,2)==i);
    rt(i) = mean (LT_trials_NoDev((LT_trials_NoDev(:,4)==4 & LT_trials_NoDev(:,5)==1 & LT_trials_NoDev(:,2)==i),7));
end
NoDev_LT_LV_office (x,:) = correct_resp; clear correct_resp 
NoDev_LT_RT_LV_office (x,:) = rt; clear rt
NoDev_time_outs_LV_office (x,:) = time_outs; clear time_outs
NoDev_too_soon_LV_office (x,:) = too_soon; clear too_soon
%% DevH
LT_trials_DevH = LT_trials(LT_trials(:,3)==1,:);
    %DevH_HV
      %food
correct_resp = sum (LT_trials_DevH(:,4)==1 & LT_trials_DevH(:,5)==0);%(:,5)==0 this is 0 because they should reverse their response
time_outs = sum (LT_trials_DevH(:,4)==1 & LT_trials_DevH(:,5)==6);
too_soon =  sum (LT_trials_DevH(:,4)==1 & LT_trials_DevH(:,5)==5);
rt = mean (LT_trials_DevH((LT_trials_DevH(:,4)==1 & LT_trials_DevH(:,5)==0), 7));
DevH_LT_HV_food (x,:) = correct_resp; clear correct_resp 
DevH_LT_RT_HV_food (x,:) = rt; clear rt
DevH_time_outs_HV_food (x,:) = time_outs; clear time_outs
DevH_too_soon_HV_food (x,:) = too_soon; clear too_soon
      %office
correct_resp = sum (LT_trials_DevH(:,4)==2 & LT_trials_DevH(:,5)==0);%(:,5)==0 this is 0 because they should reverse their response
time_outs = sum (LT_trials_DevH(:,4)==2 & LT_trials_DevH(:,5)==6);
too_soon =  sum (LT_trials_DevH(:,4)==2 & LT_trials_DevH(:,5)==5);
rt = mean (LT_trials_DevH((LT_trials_DevH(:,4)==2 & LT_trials_DevH(:,5)==0), 7));
DevH_LT_HV_office (x,:) = correct_resp; clear correct_resp 
DevH_LT_RT_HV_office (x,:) = rt; clear rt
DevH_time_outs_HV_office (x,:) = time_outs; clear time_outs
DevH_too_soon_HV_office (x,:) = too_soon; clear too_soon
    %DevH_LV
      %food
correct_resp = sum (LT_trials_DevH(:,4)==3 & LT_trials_DevH(:,5)==1);%(:,5)==1 this is 1 because they should not reverse their response
time_outs = sum (LT_trials_DevH(:,4)==3 & LT_trials_DevH(:,5)==6);
too_soon =  sum (LT_trials_DevH(:,4)==3 & LT_trials_DevH(:,5)==5);
rt = mean (LT_trials_DevH((LT_trials_DevH(:,4)==3 & LT_trials_DevH(:,5)==1), 7));
DevH_LT_LV_food (x,:) = correct_resp; clear correct_resp 
DevH_LT_RT_LV_food (x,:) = rt; clear rt
DevH_time_outs_LV_food (x,:) = time_outs; clear time_outs
DevH_too_soon_LV_food (x,:) = too_soon; clear too_soon
      %office
correct_resp = sum (LT_trials_DevH(:,4)==4 & LT_trials_DevH(:,5)==1);%(:,5)==1 this is 1 because they should not reverse their response
time_outs = sum (LT_trials_DevH(:,4)==4 & LT_trials_DevH(:,5)==6);
too_soon =  sum (LT_trials_DevH(:,4)==4 & LT_trials_DevH(:,5)==5);
rt = mean (LT_trials_DevH((LT_trials_DevH(:,4)==4 & LT_trials_DevH(:,5)==1), 7));
DevH_LT_LV_office (x,:) = correct_resp; clear correct_resp 
DevH_LT_RT_LV_office (x,:) = rt; clear rt
DevH_time_outs_LV_office (x,:) = time_outs; clear time_outs
DevH_too_soon_LV_office (x,:) = too_soon; clear too_soon
%% DevL
LT_trials_DevL = LT_trials(LT_trials(:,3)==2,:);
    %DevL_HV
      %food
correct_resp = sum (LT_trials_DevL(:,4)==1 & LT_trials_DevL(:,5)==1);%(:,5)==1 this is 1 because they should not reverse their response
time_outs = sum (LT_trials_DevL(:,4)==1 & LT_trials_DevL(:,5)==6);
too_soon =  sum (LT_trials_DevL(:,4)==1 & LT_trials_DevL(:,5)==5);
rt = mean (LT_trials_DevL((LT_trials_DevL(:,4)==1 & LT_trials_DevL(:,5)==1), 7));
DevL_LT_HV_food (x,:) = correct_resp; clear correct_resp 
DevL_LT_RT_HV_food (x,:) = rt; clear rt
DevL_time_outs_HV_food (x,:) = time_outs; clear time_outs
DevL_too_soon_HV_food (x,:) = too_soon; clear too_soon
      %office
correct_resp = sum (LT_trials_DevL(:,4)==2 & LT_trials_DevL(:,5)==1);%(:,5)==1 this is 1 because they should not reverse their response
time_outs = sum (LT_trials_DevL(:,4)==2 & LT_trials_DevL(:,5)==6);
too_soon =  sum (LT_trials_DevL(:,4)==2 & LT_trials_DevL(:,5)==5);
rt = mean (LT_trials_DevL((LT_trials_DevL(:,4)==2 & LT_trials_DevL(:,5)==1), 7));
DevL_LT_HV_office (x,:) = correct_resp; clear correct_resp 
DevL_LT_RT_HV_office (x,:) = rt; clear rt
DevL_time_outs_HV_office (x,:) = time_outs; clear time_outs
DevL_too_soon_HV_office (x,:) = too_soon; clear too_soon
    %DevH_LV
      %food
correct_resp = sum (LT_trials_DevL(:,4)==3 & LT_trials_DevL(:,5)==0);%(:,5)==0 this is 0 because they should reverse their response
time_outs = sum (LT_trials_DevL(:,4)==3 & LT_trials_DevL(:,5)==6);
too_soon =  sum (LT_trials_DevL(:,4)==3 & LT_trials_DevL(:,5)==5);
rt = mean (LT_trials_DevL((LT_trials_DevL(:,4)==3 & LT_trials_DevL(:,5)==0), 7));
DevL_LT_LV_food (x,:) = correct_resp; clear correct_resp 
DevL_LT_RT_LV_food (x,:) = rt; clear rt
DevL_time_outs_LV_food (x,:) = time_outs; clear time_outs
DevL_too_soon_LV_food (x,:) = too_soon; clear too_soon
      %office
correct_resp = sum (LT_trials_DevL(:,4)==4 & LT_trials_DevL(:,5)==0);%(:,5)==0 this is 0 because they should reverse their response
time_outs = sum (LT_trials_DevL(:,4)==4 & LT_trials_DevL(:,5)==6);
too_soon =  sum (LT_trials_DevL(:,4)==4 & LT_trials_DevL(:,5)==5);
rt = mean (LT_trials_DevL((LT_trials_DevL(:,4)==4 & LT_trials_DevL(:,5)==0), 7));
DevL_LT_LV_office (x,:) = correct_resp; clear correct_resp 
DevL_LT_RT_LV_office (x,:) = rt; clear rt
DevL_time_outs_LV_office (x,:) = time_outs; clear time_outs
DevL_too_soon_LV_office (x,:) = too_soon; clear too_soon


end
part_info = [subjects' experiments'];
consumption_out = [NoDev_consumption DevH_consumption DevL_consumption NoDev_consumption_RT DevH_consumption_RT DevL_consumption_RT];
dev_out = [DevH_LT_HV_food 	DevH_LT_HV_office 	DevH_LT_LV_food 	DevH_LT_LV_office	DevL_LT_HV_food 	DevL_LT_HV_office 	DevL_LT_LV_food 	DevL_LT_LV_office	DevH_LT_RT_HV_food 	DevH_LT_RT_HV_office 	DevH_LT_RT_LV_food 	DevH_LT_RT_LV_office	DevL_LT_RT_HV_food 	DevL_LT_RT_HV_office 	DevL_LT_RT_LV_food 	DevL_LT_RT_LV_office];
nodev_out = [NoDev_LT_HV_food NoDev_LT_HV_office NoDev_LT_LV_food NoDev_LT_LV_office NoDev_LT_RT_HV_food NoDev_LT_RT_HV_office NoDev_LT_RT_LV_food NoDev_LT_RT_LV_office];
question_out = [output_timefood' output_vegeterian' output_alim'];
% figure
% plot ([1:7],nanmean(NoDev_LT_HV_food), [1:7],nanmean(NoDev_LT_HV_office))
% figure
% plot ([1:7],nanmean(NoDev_LT_LV_food), [1:7],nanmean(NoDev_LT_LV_office))
% figure
% plot ([1:7],nanmean(NoDev_LT_RT_HV_food), [1:7],nanmean(NoDev_LT_RT_HV_office))
% figure
% plot ([1:7],nanmean(NoDev_LT_RT_LV_food), [1:7],nanmean(NoDev_LT_RT_LV_office))
figure
plot ([1:8],nanmean(dev_out(:,1:8)))
figure
plot ([1:8],nanmean(dev_out(:,9:16)))

figure
plot ([1:7],nanmean(nodev_out(:,1:7)), [1:7],nanmean(nodev_out(:,8:14)))
title('HVacc')
figure
plot ([1:7],nanmean(nodev_out(:,15:21)), [1:7],nanmean(nodev_out(:,22:28)))
title('LVacc')
figure
plot ([1:7],nanmean(nodev_out(:,29:35)), [1:7],nanmean(nodev_out(:,36:42)))
title('HVrt')
figure
plot ([1:7],nanmean(nodev_out(:,43:49)), [1:7],nanmean(nodev_out(:,50:56)))
title('LVrt')
% figure
% plot ([1:7],nanmean(NoDev_LT_LV_food), [1:7],nanmean(NoDev_LT_LV_office))
% figure
% plot ([1:7],nanmean(NoDev_LT_RT_HV_food), [1:7],nanmean(NoDev_LT_RT_HV_office))
% figure
% plot ([1:7],nanmean(NoDev_LT_RT_LV_food), [1:7],nanmean(NoDev_LT_RT_LV_office))





% errorbar(X_blocks,Pmeans(3:20),SEMP(3:20),'--or')
% ylim([0 5])


% salida = salida';
% allmeans = mean(salida,1);
% allstd = std(salida, 1);
% n = size(salida,1);
% allSEM = allstd/sqrt(n);
% %no Pressure nP
% nP = salida ((salida (:,2) == 1),:);
% nPmeans = mean(nP,1);
% nPstd = std(nP, 1);
% nPn = size(nP,1);
% SEMnP = nPstd/sqrt(nPn);
% %Pressure P
% P = salida ((salida (:,2) == 2),:);
% Pmeans = mean(P,1);
% Pstd = std(P, 1);
% Pn = size(P,1);
% SEMP = Pstd/sqrt(Pn);
% % plotting learning curves
% % for NoDev blocks
% X_blocks = [1:18];
% close all
% figure
% hold on
% errorbar(X_blocks,nPmeans (3:20),SEMnP(3:20))
% errorbar(X_blocks,Pmeans(3:20),SEMP(3:20),'--or')
% ylim([0 5])
% 
% save ('salidaFREE', 'salida')