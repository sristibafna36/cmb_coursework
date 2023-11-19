function [choices, reward, choice_probabilities] = model1_func(b, T, K, u)

% Problem set 4 example function for model 1
% PSY-3102-Monsoon 2022
% Apoorva Bhandari

%% Cleanup
clc;
close all;


%% Set up output variables
choices = NaN(T,1); % a placeholder vector of NaNs to record choices made by agent on every trial
reward = NaN(T,1); % a placeholder vector of NaNs to record rewards earned by agent on every trial
choice_probabilities= NaN(T,K); % a placeholder vector of NaNs to record choice probabilities on every trial

choice_probabilities(:,1) = b; % in this model, choice probabilities are fixed so we can assign them now
choice_probabilities(:,2) = 1-b; % in this model, choice probabilities are fixed so we can assign them now


%% Let the agent behave

for t = 1:T % loop through trials
    
    % Make the choice based on choice probabilities
    choices(t,1) = pick_choice(choice_probabilities(t,:));
    
    % Deliver the reward based on reward probabilities
    reward(t,1) = deliver_reward(choices(t,1), u);
    
end % end the trial loop


end