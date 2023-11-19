% Model1 implementation from Wilson & Collins (2019) 
% - random responding with bias

% Apoorva Bhandari

%% Cleanup 
clc; 
clear; 
close all; 

%% Set up the experiment/world
T = 1000; % number of trials
K = 2; % number of options
u = [0.2, 0.8]; % reward probabilities

%% Set up the agent: (model 1 - random responding with bias)
b = 0.55; % This is the bias parameter. It represents the probability of choosing option 1. 
choices = NaN(T,1); % a placeholder vector of NaNs to record choices made by agent on every trial
reward = NaN(T,1); % a placeholder vector of NaNs to record rewards earned by agent on every trial
choice_probabilities= NaN(T,2); % a placeholder vector of NaNs to record choice probabilities on every trial

choice_probabilities(:,1) = b; % in this model, choice probabilities are fixed so we can assign them now
choice_probabilities(:,2) = 1-b; % in this model, choice probabilities are fixed so we can assign them now

correct_choice = 2; % just specifying which option is 'correct' in that it has a higher payoff 

%% Let the agent behave 

for t = 1:T % loop through trials 
    
    % We need to write code here that determines the choice made on trial t
    % given the choice probabilities. To do this, we should generate a
    % random number between 0 and 1, and then use the random number
    % generated to determine whether option 1 or option is selected such
    % that on average, the choice probabilities are respected. 
    choice_random_number = rand; % generate a random number between 0 and 1 
    
    if choice_random_number < b
        choices(t,1) = 1; % if yes, choose option 1 (and record it in the right place) 
    else
        choices(t,1) = 2; % choose option 2 (and record it in the right place) 
    end
    
    % Deliver the reward based on reward probabilities
    reward(t,1) = deliver_reward(choices(t,1), u); 
    
end % end the trial loop

%% Plot a figure that displays the cumulative reward as a function of trial number 

figure(); % create an empty figure 
plot(1:1000, cumsum(reward), 'k-', 'LineWidth', 1) % plot the cumulative reward line
ylim([0,1000]) % set the limits of the y axis
xlabel('Reward', 'FontSize', 18) % label the x-axis
ylabel('Trials', 'FontSize', 18) % label the y-axis
ax = gca;
ax.FontSize = 14;

%% Plot a histogram of choices made

figure(); % create an empty figure
histogram(choices) % plot the historgram
xticks([1,2]) % set where the ticks will be present on the x axis

xlabel('Choice Made', 'FontSize', 18); % label the x-axis
ylabel('Trials', 'FontSize', 18); % label the y-axis
ax = gca;
ax.FontSize = 14;

%% Plot the data as the probability of 'Staying' with the previous choice as a function of whether or not you were rewarded 
% NB: For model 1, this plot stay behavior should not depend on whether a
% reward was received 

stay = NaN(1,T-1); % a place holder vector to store whether a particular trial is a stay trial or not
prevrew = zeros(1,T-1); % a placeholder vector to store whether the previous trial was rewarded or not

for t = 2:T % loop from trial 2 through T (1000)
    if choices(t,1) == choices(t-1,1) % if it was a stay trial
        stay(t-1) = 1; % yes
    else % if it was not
        stay(t-1) = 0; % no 
    end
         prevrew(t-1) = reward(t-1,1); % store the reward on prev trial  
end

figure() % create an empty figure
plot([0 1], [mean(stay(prevrew==0)), mean(stay(prevrew==1)) ], ['o-k'], 'Linewidth', 2, 'MarkerSize', 25, 'MarkerFaceColor', [1 1 1]); % plot the stay line

xlabel('Reward', 'FontSize', 18); % label the x-axis
ylabel('P(stay)', 'FontSize', 18); % label the y-axis
ax = gca;
ax.FontSize = 14;