function [loglikelihood] = model2_log_likelihood_func(epsilon, T, rewards, choices, choice_probabilities)

% Model2 implementation from Wilson & Collins (2019)
% PSY-3102-Monsoon 2022
% Apoorva Bhandari

%% Cleanup
clc;
close all;


%% Set up output variables
loglikelihood = 0; 

%% Let the agent behave

for t = 1:T % loop through trials 
    
    loglikelihood = loglikelihood + log(choice_probabilities(t,choices(t))); 
    
end % end the trial loop

loglikelihood = loglikelihood*-1;

end