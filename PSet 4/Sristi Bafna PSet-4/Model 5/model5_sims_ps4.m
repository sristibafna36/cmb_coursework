% Problem set 4 example simulations for model 3
% PSY-3102-Monsoon 2022
% Apoorva Bhandari

%% Cleanup
clc;
clear;
close all;

%% Set up simulation details

nIterations = 150;
alpha_ck_range = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
beta_ck_range = [1, 2, 5, 11, 21];
alpha_range = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
beta_range = [1, 2, 5, 11, 21];
current_folder = pwd;

%% Set up environment

T = 1000;
K = 2;
u = [0.2,0.8];


%% Set up output variables
all_choices = NaN(T,length(alpha_ck_range)*length(beta_ck_range)*length(alpha_range)*length(beta_range), nIterations); % a placeholder vector of NaNs to record choices made by agent on every trial
all_rewards = NaN(T,length(alpha_ck_range)*length(beta_ck_range)*length(alpha_range)*length(beta_range), nIterations); % a placeholder vector of NaNs to record rewards earned by agent on every trial
all_choice_probabilities= NaN(T,K,length(alpha_ck_range)*length(beta_ck_range)*length(alpha_range)*length(beta_range), nIterations); % a placeholder vector of NaNs to record choice probabilities on every trial


%% Run the simulations
for j_k = 1:length(alpha_ck_range)
    alpha_ck = alpha_ck_range(j_k);

    for b_k = 1:length(beta_ck_range)
        beta_ck = beta_ck_range(b_k);

        for j = 1:length(alpha_range)
            alpha = alpha_range(j);

            for b = 1:length(beta_range)
                beta = beta_range(b);

                for i = 1:nIterations % loop through trials
                    
                    [choices, rewards, choice_probabilities] = model3_func(alpha_ck,beta_ck,T,K,u);
                    all_choices(:,j_k,i) = squeeze(choices);
                    all_rewards(:,j_k,i) = squeeze(rewards);
                    all_choice_probabilities(:,:,j_k,i) = squeeze(choice_probabilities);
    
            
                end

            end 
        end % end the trial loop
    
    end

end
param_values{1} = alpha_ck_range; % for models with 2 free parameters, param_values{1} = learning_rate_range; param_values{2} = beta_range;
param_values{2} = beta_ck_range;
param_values{3} = alpha_range;
param_values{4} = beta_range;
save(fullfile(current_folder, 'model5_sim_ps4_results.mat'), 'all_choices', 'all_rewards', 'all_choice_probabilities', 'T', 'K', 'u', 'nIterations', 'param_values')