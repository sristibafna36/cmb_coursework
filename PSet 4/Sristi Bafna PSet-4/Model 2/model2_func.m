function [choice_probabilities, reward, choices] = model2_func(epsilon, T, K, u)

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

%% Let the agent behave

for t = 1:T % loop through trials 

    if t == 1  % of course, on the first trial the choice is always random
    choice_probabilities(t,:) = [0.5, 0.5];
    elseif reward(t-1,1) == 1 && choices(t-1,1) == 1
        choice_probabilities(t,1) = 1-(epsilon/2);
        choice_probabilities(t,2) = epsilon/2;
    elseif reward(t-1,1) == 1 && choices(t-1,1) == 2
        choice_probabilities(t,1) = epsilon/2;
        choice_probabilities(t,2) = 1-(epsilon/2);
    elseif reward(t-1,1) == 0 && choices(t-1,1) == 1
        choice_probabilities(t,1) = epsilon/2;
        choice_probabilities(t,2) = 1-(epsilon/2);
    elseif reward(t-1,1) == 0 && choices(t-1,1) == 2
        choice_probabilities(t,1) = 1-(epsilon/2);
        choice_probabilities(t,2) = epsilon/2;
    end
    % Make the choice based on choice probabilities
    choices(t,1) = pick_choice(choice_probabilities(t,:));
    
    % Deliver the reward based on reward probabilities
    reward(t,1) = deliver_reward(choices(t,1), u); 
    
end % end the trial loop


end