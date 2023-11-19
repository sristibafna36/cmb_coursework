% Model3 implementation from Wilson & Collins (2019) 
% - Rescorla-Wagner + Softmax actions election 

% Apoorva Bhandari

%% Cleanup 
clc; 
clear; 
close all; 

%% Set up the experiment/world
T = 1000; % number of trials
K = 2; % number of options
u = [0.2, 0.8]; % reward probabilities

%% Set up the agent: (model 3 - Rescorla-Wagner + Softmax action selection)
alpha = 0.1; % This is the learning rate parameter. It represents how much the prediction error impacts the estimate of values. 
beta = 2; % This is inverse temperature parameter. It determines how noisily choices are made given the values. Higher values mean less noisy. 
Q_init = [0.5 0.5]; % Initial estimate of the value of each option (i.e. on trial 0). 
choices = NaN(T,1); % a placeholder vector of NaNs to record choices made by agent on every trial
reward = NaN(T,1); % a placeholder vector of NaNs to record rewards earned by agent on every trial
choice_probabilities = NaN(T,2); % a placeholder vector of NaNs to record choice probabilities on every trial
Q = NaN(T,2); % a placeholder matrix of NaNs to record value estimates
Q(1,:) = Q_init;
correct_choice = 2; % just specifying which option is 'correct' in that it has a higher payoff 

%% Let the agent behave 

for t = 1:T % loop through trials 

    % First compute the choice probabilities based on current value
    % estimates
    choice_probabilities(t,:) = exp(beta*Q(t,:)) / sum(exp(beta*Q(t,:))); 

    % Make the choice based on choice probabilities
    choices(t,1) = pick_choice(choice_probabilities(t,:));
    
    % Deliver the reward based on reward probabilities
    reward(t,1) = deliver_reward(choices(t,1), u); 
    
    % Then update the value estimates based on the Rescorla-Wagner rule
    prediction_error = reward(t,1) - Q(t,1) ; % compute prediction error as difference between actual reward and expected reward (i.e. value estimate for the chosen option) 
    Q(t+1,:) = Q(t,:); % first copy the current value estimates over to the next row of Q
    Q(t+1, choices(t,1)) = Q(t,choices(t,1)) + alpha*prediction_error; % update the value estimate of the chosen option 
    
end % end the trial loop

%% Plot a figure that displays the cumulative reward as a function of trial number 

figure(); % create an empty figure 
plot(1:1000, cumsum(reward), 'k-', 'LineWidth', 1) % plot the cumulative reward line
ylim([0,1000]) % set the limits of the y axis
xlabel('Trials', 'FontSize', 18) % label the x-axis
ylabel('Rewards', 'FontSize', 18) % label the y-axis
ax = gca;
ax.FontSize = 14;

%% Plot a histogram of choices made

figure(); % create an empty figure
histogram(choices) % plot the historgram
xticks([1,2]) % set where the ticks will be present on the x axis

xlabel('Choice Made'); % label the x-axis
ylabel('Trials'); % label the y-axis
ax = gca;
ax.FontSize = 14;

%% Plot the data as the probability of 'Staying' with the previous choice as a function of whether or not you were rewarded 
% NB: For model 1, this plot stay behavior should not depend on whether a
% reward was received 

stay = NaN(1,T-1); % a place holder vector to store whether a particular trial is a stay trial or not
prevrew = zeros(1,T-1); % a placeholder vector to store whether the previous trial was rewarded or not

for t = 2:T % loop from trial 2 through T (1000)
    if choices(t) == choices(t-1) % if it was a stay trial
        stay(t-1) = 1; % yes
    else % if it was not
        stay(t-1) = 0; % no 
    end
         prevrew(t-1) = reward(t-1); % store the reward on prev trial  
end

figure() % create an empty figure
plot([0 1], [mean(stay(prevrew==0)), mean(stay(prevrew==1)) ], ['o-k'], 'Linewidth', 2, 'MarkerSize', 25, 'MarkerFaceColor', [1 1 1]); % plot the stay line
xlim([-0.25, 1.25]); % set the limits of the x axis
ylim([0,1]); % set the limits of the y axis
xticks([0,1]) % set where the ticks will be present on the x axis
xlabel('Reward'); % label the x-axis
ylabel('P(stay)'); % label the y-axis
ax = gca;
ax.FontSize = 14;

%% Plot a figure that displays the cumulative value estimate as a function of trial number 

figure(); % create an empty figure 
y1 =zeros(1000,1); %holds value estimate for option 1
y2 =zeros(1000,1); %holds value estimate for option 2
x = zeros(1000,1); %array for trials - we need this as we can plot vectors of the same
%dimension against each other. 
for t = 1:T
    y1(t,1) = Q(t,1); % stores value estimate for option 1 at each trial in the corresponding position
    y2(t,1) = Q(t,2); % stores value estimate for option 2 at each trial in the corresponding position
    x(t,1) = t; % stores trial number 
end

plot(x,y1,'r--',x,y2,'k-') %plotting

xlim([0, 1000]); % set the limits of the x axis
ylim([0,1]) % set the limits of the y axis
xlabel('Trials', 'FontSize', 18) % label the x-axis
ylabel('Value Estimate', 'FontSize', 18) % label the y-axis
ax = gca;
ax.FontSize = 14;