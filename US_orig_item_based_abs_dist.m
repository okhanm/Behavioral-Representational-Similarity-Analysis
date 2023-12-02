%% US Data original items: RDM measure is absolute distance - item based

clear all
close all

% load data
data = readtable("Justice_intuition_pilot_US.xlsx",VariableNamingRule = 'preserve');

% corresponding punishments for all items
cooper_chin = [4, 60, 100, 8, 40, 4, 50, 40, 5,	4, 20, 10, 60, 120,	20,	50,	80,	40,	5, 5, 6, 10, 50, 10, 30, 8,	120, 30, 40, 80, 40, 3,	5, 20, 1, 10, 60, 1, 3, 40, 120, 50, 40, 120, 6, 100, 7, 120, 40, 20, 4];
max_year = [40,	20,	20,	20,	20,	10,	10,	10,	10, 7, 7, 7, 7,	5, 5, 2, 2,	2, 7, 1, 1,	0.25, 0.25,	40, 10,	2, 10, 5, 2, 40, 2,	7, 20, 2, 1, 0.25, 5, 5, 20, 10, 2, 5, 7, 2, 1, 2, 5, 5, 5, 7, 1, 10];

% excluding participants
included_sub = data(data.exclude == 0,:);

% extracting ratings from each portion for all items and converting them into array
shame_Penn_all = table2array (included_sub (:, 16:67));
shame_Tang_all = table2array (included_sub (:, 68:118));
devalue_Penn_all = table2array (included_sub (:, 119:170));
devalue_Tang_all = table2array (included_sub (:, 171:221));
wrong_Penn_all = table2array (included_sub (:, 222:273));
wrong_Tang_all = table2array (included_sub (:, 274:324));
year_Penn_all = table2array (included_sub (:, 325:376));
year_Tang_all = table2array (included_sub (:, 377:427));

% computing item-based mean
m_shame_Penn_all = mean(shame_Penn_all);
m_shame_Tang_all = mean(shame_Tang_all);
m_devalue_Penn_all = mean(devalue_Penn_all);
m_devalue_Tang_all = mean(devalue_Tang_all);
m_wrong_Penn_all = mean(wrong_Penn_all);
m_wrong_Tang_all = mean(wrong_Tang_all);
m_year_Penn_all = mean(year_Penn_all);
m_year_Tang_all = mean(year_Tang_all);

% extracting original items
m_shame_Penn_orig = m_shame_Penn_all(:,1:23);
m_shame_Penn_orig(:,19) = [];

m_shame_Tang_orig = m_shame_Tang_all(:,1:26);

m_devalue_Penn_orig = m_devalue_Penn_all(:,1:23);
m_devalue_Penn_orig(:,19) = [];

m_devalue_Tang_orig = m_devalue_Tang_all(:,1:26);

m_wrong_Penn_orig = m_wrong_Penn_all(:,1:23);
m_wrong_Penn_orig(:,19) = [];

m_wrong_Tang_orig = m_wrong_Tang_all(:,1:26);

m_year_Penn_orig = m_year_Penn_all(:,1:23);
m_year_Penn_orig(:,19) = [];

m_year_Tang_orig = m_year_Tang_all(:,1:26);

%% Computing RDMs

% all conditions are included, only original items
condition_list = {m_shame_Penn_orig, m_devalue_Penn_orig, m_wrong_Penn_orig, m_year_Penn_orig, m_shame_Tang_orig, m_devalue_Tang_orig, m_wrong_Tang_orig, m_year_Tang_orig};

for ii = 1:length(condition_list)
    condition = condition_list(ii);
    condition = cell2mat(condition);
    
    for l = 1:length(condition(1,:)) % for all items
        for k = 1:length(condition(1,:))
            
            temp_dist = abs(condition(1,l) - condition(1,k));
            sqrt_temp_dist(l,k) = temp_dist;
        end
    end
    if ii < 5
        all_dist_penn(:,:,ii) = sqrt_temp_dist;
    else
        all_dist_tang(:,:,ii-4) = sqrt_temp_dist;
    end
    
end
%% Plotting

plot_names = {'Shame', 'Devaluation', 'Wrongness', 'Time'};
global_title = {'US Data - Title 18 (abs distance)', 'US Data - Tang (abs distance)'};

for ii = 1:2
    for i = 1:4
        
        
        figure(ii)
        subplot(2,2,i);
        
        if ii == 2
            all_dist = all_dist_tang;
        else
            all_dist = all_dist_penn;
        end
        
        imagesc(all_dist(:,:,i));
        axis equal
        axis tight
        title(plot_names{i}); % sub titles
        sgtitle(global_title(ii))
    end
end
%% transforming matrices into vector by taking lower triangle
% For penn   
for i = 1:4
    
    temp_lower_trig = tril(all_dist_penn(:,:,i), -1);
    
    for ii = 1:size(temp_lower_trig,1)
        temp_lower_trig(ii,ii:end) = NaN;
    end
    
    all_dis_vec_penn(:,i) = temp_lower_trig(~isnan(temp_lower_trig));
    
end

US_orig_ib_abs_dist_penn = all_dis_vec_penn; 

% For tang 
for i = 1:4
    
    temp_lower_trig = tril(all_dist_tang(:,:,i), -1);
    
    for ii = 1:size(temp_lower_trig,1)
        temp_lower_trig(ii,ii:end) = NaN;
    end
    
    all_dis_vec_tang(:,i) = temp_lower_trig(~isnan(temp_lower_trig));
    
end

US_orig_ib_abs_dist_tang = all_dis_vec_tang; 






