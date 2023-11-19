% Problem set 4 example simulations for model 1
% PSY-3102-Monsoon 2022
% Apoorva Bhandari

%% Cleanup
clc;
clear;
close all;

%% Set up simulation details

nIterations = 150;
b_range = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
current_folder = pwd;

%% Set up environment

T = 1000;
K = 2;
u = [0.2,0.8];


%% Set up output variables
all_choices = NaN(T,length(b_range), nIterations); % a placeholder vector of NaNs to record choices made by agent on every trial
all_rewards = NaN(T,length(b_range), nIterations); % a placeholder vector of NaNs to record rewards earned by agent on every trial
all_choice_probabilities= NaN(T,K,length(b_range), nIterations); % a placeholder vector of NaNs to record choice probabilities on every trial


%% Run the simulations
for j = 1:length(b_range)
    b = b_range(j);

    for i = 1:nIterations % loop through trials
        
        [choices, rewards, choice_probabilities] = model1_func(b,T,K,u);
        all_choices(:,j,i) = squeeze(choices);
        all_rewards(:,j,i) = squeeze(rewards);
        all_choice_probabilities(:,:,j,i) = squeeze(choice_probabilities);

        
    end % end the trial loop


end
param_values{1} = b_range; % for models with 2 free parameters, param_values{1} = learning_rate_range; param_values{2} = beta_range;
save(fullfile(current_folder, 'model1_sim_ps4_results.mat'), 'all_choices', 'all_rewards', 'all_choice_probabilities', 'T', 'K', 'u', 'nIterations', 'param_values')