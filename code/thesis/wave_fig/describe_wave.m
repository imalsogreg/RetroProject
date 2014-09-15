%% Load data

if(strcmp(rat,'morpheus'))
rat_conv = morpheus_rat_conv_table;
trode_groups = morpheus_trode_groups;
load ~/Data/morpheus/052310/t_data.mat run_timewin pos_info place_cells eeg_r mua_r; 
% 35 place cells on track.
% 10mins presleep, 1hr postsleep
end


%% Wave parameters

dt = 0.5;
lfp_wave = gh_long_wave_regress(eeg_r, rat_conv, 'short_timewin', dt);
mua_wave = gh_long_wave_regress(mua_r, rat_conv, 'short_timewin', dt);