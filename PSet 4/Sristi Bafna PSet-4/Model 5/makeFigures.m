%%%%% Bob Wilson & Anne Collins
%%%%% 2018
%%%%% Code to produce figure 2 in submitted paper "Ten simple rules for the
%%%%% computational modeling of behavioral data"
%%%%% Modified by Apoorva Bhandari for PSY-3102 Spring 2022 course
%%%%% 2022

function makeFigures(model_number)
close all

% set up colors
global AZred AZblue AZcactus AZsky AZriver AZsand AZmesa AZbrick

AZred = [171,5,32]/256;
AZblue = [12,35,75]/256;
AZcactus = [92, 135, 39]/256;
AZsky = [132, 210, 226]/256;
AZriver = [7, 104, 115]/256;
AZsand = [241, 158, 31]/256;
AZmesa = [183, 85, 39]/256;
AZbrick = [74, 48, 39]/256;

% model choice
model_names = {'random responding', 'e-win-stay-switch-lose', 'rescorla-wagner', 'choice-kernel'};
model_name = model_names{model_number};


%% p(correct) analysis
param_names{1,1} = 'bias';
param_names{2,1} = 'epsilon';
param_names{3,1} = 'learning rate';
param_names{3,2} = 'inverse temp';
param_names{4,1} = 'learning rate';
param_names{4,2} = 'inverse temp';

%% load the data 

load(sprintf('model%1.0f_sim_ps4_results.mat', model_number))

[~, correct_answer] = max(u);

all_correct = (all_choices == correct_answer); 
correct_early = nanmean(all_correct(1:10,:,:));
correct_late = nanmean(all_correct(end-9:end,:,:));



%% plot p(correct) behavior
figure();
subplot(1,2,1)
E = nanmean(correct_early,3);
L = nanmean(correct_late,3);

% figure(1); clf;
% ax = easy_gridOfEqualFigures([0.2 0.1], [0.08 0.14 0.05 0.03]);
set(gcf, 'Position', [284   498   704   300])

ax(1) = gca;
hold on;
l1 = plot(param_values{1}, E);
xlabel(param_names{model_number,1})
ylabel('p(correct)')
title('early trials', 'fontweight', 'normal')

if ~isempty(param_names{model_number,2})
    for i = 1:length(param_values{2})
        leg{i} = [sprintf('%s = %s',param_names{model_number, 2}, num2str(param_values{2}(i)))];
    end
    leg2 = legend(l1(end:-1:1), {leg{end:-1:1}});
    
    
    set([leg2], 'fontsize', 12)
    set(leg2,...
        'Position',[0.461734126054358 0.629999973407158 0.107244318181818 0.261666666666667],...
        'FontSize',12);
    
end

subplot(1,2,2);
hold on;
ax(2) = gca;
l2 = plot(param_values{1}, L);
xlabel(param_names{model_number,1})
% ylabel('p(correct)')
title('late trials', 'fontweight', 'normal')
for i = 1:length(l1)
    if ~isempty(param_names{model_number,2})
        f = (i-1)/(length(l1)-1);
        
        set([l1(i) l2(i)], 'color', AZred*f + AZblue*(1-f));
    elseif isempty(param_names{model_number,2})
        f = 1;
        set([l1(i)], 'color', AZred*f + AZblue*(1-f));
        
    end
    
end
set([l1 l2], 'linewidth', 3)
set(gca, 'yticklabel', [])
set(ax(1:2), 'ylim', [0.4 1.02])
set(ax, 'fontsize', 18, 'tickdir', 'out')


sgtitle(sprintf('Model %1.0f %s', model_number, model_name), 'FontSize',18, 'FontWeight', 'bold')
end
