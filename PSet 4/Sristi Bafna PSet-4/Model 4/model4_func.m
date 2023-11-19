function [choices, reward, choice_probabilities ] = model4_func(alpha_c, beta_c, T, K, u)

% Model2 implementation from Wilson & Collins (2019)
% PSY-3102-Monsoon 2022
% Apoorva Bhandari

%% Cleanup
clc;
close all;


%% Set up output variables
choices = NaN(T,1); % a placeholder vector of NaNs to record choices made by agent on every trial
reward = NaN(T,1); % a placeholder vector of NaNs to record rewards earned by agent on every trial
choice_probabilities= NaN(T,K); % a placeholder vector of NaNs to record choice probabilities on every trial
CK_init = [0 0]; % Initial estimate of the value of each option (i.e. on trial 0). 
CK = NaN(T,2); % a placeholder matrix of NaNs to record value estimates
CK(1,:) = CK_init;

%% Let the agent behave

for t = 1:T % loop through trials 

    % First compute the choice probabilities based on current value
    % estimates
    choice_probabilities(t,:) = exp(CK(t,:)*beta_c)/sum(exp(CK(t,:)*beta_c));  

    % Make the choice based on choice probabilities
    choices(t,1) = pick_choice(choice_probabilities(t,:));
    
    % Deliver the reward based on reward probabilities
    reward(t,1) = deliver_reward(choices(t,1), u); 
    
    % Then update the value estimates based on the Rescorla-Wagner rule
    prediction_error =  1-CK(t,choices(t,1)); % compute prediction error as difference between actual reward and expected reward (i.e. value estimate for the chosen option) 
    CK(t+1,:) = CK(t,:); % first copy the current value estimates over to the next row of Q
    CK(t+1, choices(t,1)) = CK(t,choices(t,1)) + alpha_c*prediction_error; % update the value estimate of the chosen option 
    
end % end the trial loop