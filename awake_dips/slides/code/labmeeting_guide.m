%% load up a rat
dirName = '~/Data/caillou/112812';
cd(dirName);
m = metadata;
e = loadMwlEpoch('filename',[dirName,'/epoch.epoch']);
loadTimewin = [min(e('sleep1')),max(e('sleep2'))];
d = loadData(m,'timewin',loadTimewin,'samplerate',610,'loadMUA',true);
d.eeg.data = -1 * d.eeg.data;

smallTimewin = [4500,4600];
dFreq = loadData(m,'timewin',smallTimewin,'samplerate',2000,...
                 'loadMUA',true);

load SleepLabels.mat;

%% (a minute)
b = behavioralState(d.pos_info, m.pFileName,...
                    eegByArea(d.eeg,m.trode_groups,'CA1'),'draw',true);

%%
b('sws') = mat2cell(NREM,ones(1,size(NREM,1)),2);
b('swsLight') = mat2cell(LightSleep,ones(size(LightSleep,1),1),2);
b('swsDeep')  = mat2cell(DeepSleep, ones(size(DeepSleep, 1),1),2);

%% get ripples (a minute)
[rippleEeg,~,rippleEnv] = gh_ripple_filt(eegByArea(d.eeg, m.trode_groups, 'CA1'));
envMean = rippleEnv;
envMean.data = mean(envMean.data,2);
eMean = mean(envMean.data);
eStd  = std(envMean.data);
envSmall = contresamp(rippleEnv,'resample',200/(rippleEnv.samplerate));

%% (about a minute)
[ripples,ripplePeaks] = ...
    evalEegRipplesParams(envMean, eMean+4*eStd, ...
                         eMean+1*eStd, 0.03, 0.005, eMean+2*eStd,0.01);


%% Ripple rates (very fast)
rates = mapMap(@(x) gh_event_rate_in_segments(ripplePeaks,x), b);

%% Ripple triggered lfp & mua(about 3 minutes to run)
rippTriggeredLFP = ...
    mapMap(@(x) eegTriggeredAverage(d.eeg, gh_points_in_segs(ripplePeaks,x), [-0.2,0.5]),b);
rippTriggeredMUA = ...
    mapMap(@(x) eegTriggeredAverage(d.mua_rate, gh_points_in_segs(ripplePeaks,x), [-0.2,0.5]),b);

%% Get dips (5 secs or so)
[dips,frames] = find_dips_frames(eegByArea(d.mua_rate,m.trode_groups,'RSC'), ...
                                 'mean_rate_threshold',60,'draw',true);

%% (about 1 minutes)
frameStarts = cell2mat(frames);
frameStarts = frameStarts(:,1);
frameTriggeredLFP = ...
    mapMap(@(x) eegTriggeredAverage(d.eeg, ...
                                    gh_points_in_segs(frameStarts,x),[-1,1]),b);
frameTriggeredMUA = ...
    mapMap(@(x) eegTriggeredAverage(d.mua_rate, ...
                                    gh_points_in_segs(frameStarts,x),[-1,1]),b);

%% Ripples by frame starts PSTH
events   = ripplePeaks;
triggers = cell2mat(frames);
triggers = triggers(:,1);
rippleByFramePsth = mapMap(@(x) psth_in_windows(events, triggers, ...
                                                x,'timewin',[-2,2],'samplerate',50), b);

%% Spectrogram
