function describe_wave(d,m,varargin)

[defaultChans,defaultTWin] = ratDefaults(m);

p = inputParser();
p.addParamValue('upleft_chanlabels',defaultChans);
p.addParamValue('timewin',defaultTWin);
p.addParamValue('eeg_r',[]);
p.addParamValue('brainPicPath','/home/greghale/Documents/Papers/RetroProject/code/thesis/wave_fig/brainFig.png');
p.parse(varargin{:});
opt = p.Results;

if(isempty(opt.eeg_r))
    d.eeg_r = prep_eeg_for_regress(eeg_r);
else
    d.eeg_r = opt.eeg_r;
end

drawBrainAndExampleWaves(d,m,opt.brainPicPath,opt.timewin,opt.upleft_chanlabels);

%dt = 0.5;
%lfp_wave = gh_long_wave_regress(eeg_r, rat_conv, 'short_timewin', dt);
%mua_wave = gh_long_wave_regress(mua_r, rat_conv, 'short_timewin', dt);


end


function f = drawBrainAndExampleWaves(d,m,brainPicPath,tWin,chanlabels)

f = figure;
subplot(1,2,1);
image([-7.75,7.75],[-9.9,15.8], imread(brainPicPath));
axis equal;

eeg = contwin_r(contchans_r(d.eeg_r,'chanlabels',chanlabels),safeTimeWin(tWin,d.eeg));
subplot(1,2,2);
gh_plot_cont(eeg.raw,'spacing',0.4);
hold on;
gh_plot_cont(eeg.theta,'spacing',0.4,'trode_groups',d.trode_groups,'LineWidth',3);
xlim(tWin);


end


function tWin = safeTimeWin(tWin, cdat)
tWin = [max(cdat.tstart,tWin(1)-2), min(cdat.tend,tWin(2)+2)];
end



function [chanLabels,tWin] = ratDefaults(m)

     if(strContains(m.basePath,'morpheus'))
         chanLabels = {'10','15','24'};
         tWin = [760,760.5];
     else
         error('ratUpLeftChans:noLabelData',['Don''t know which ',...
                                             'channels to use for ',...
                                             'example wave figure']);
     end

end

function [b,twin] = strContains(a,b)
    
    b = ~isempty(regexp(a,b,'ONCE'));
       
end
