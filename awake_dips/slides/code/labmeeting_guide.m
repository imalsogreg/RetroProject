%% load up a rat
dirName = '~/Data/caillou/112812';
cd(dirName);
m = metadata;
e = loadMwlEpoch('filename',[dirName,'/epoch.epoch']);
loadTimewin = [min(e('sleep1')),max(e('sleep2'))];
d = loadData(m,'timewin',loadTimewin,'samplerate',610,'loadMUA',false);

%%
b = behavioralState(d.pos_info, m.pFileName,eegByArea(d.eeg,m.trode_groups,'CA1'),'draw',true);

%% get ripples
[rippleEeg,~,rippleEnv] = gh_ripple_filt(eegByArea(d.eeg, m.trode_groups, 'CA1'));
envMean = rippleEnv;
envMean.data = mean(envMean.data,2);
eMean = mean(envMean.data);
eStd  = std(envMean.data);
envSmall = contresamp(rippleEnv,'resample',200/(rippleEnv.samplerate));
%%
[ripples,ripplePeaks] = evalEegRipplesParams(envMean, eMean+4*eStd, eMean+1*eStd, 0.03, 0.005, eMean+2*eStd,0.01);


%% Ripple rates

rates = mapMap(@(x) gh_event_rate_in_segments(ripplePeaks,x), b);

%% Ripple triggered lfp

rippTriggeredHpc = mapMap(@(x) eegTriggeredAverage(d.eeg, gh_points_in_segs(ripplePeaks,x), [-0.2,0.5]),b);