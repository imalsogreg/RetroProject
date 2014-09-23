function [f1,f2,f3,f4] = describe_wave(d,m,varargin)

[defaultChans,defaultTWin,defaultFitTWin] = ratDefaults(m);

p = inputParser();
p.addParamValue('upleft_chanlabels',defaultChans);
p.addParamValue('timewin',defaultTWin);
p.addParamValue('fitTimewin');
p.addParamValue('eeg_r',[]);
p.addParamValue('brainPicPath','/home/greghale/Documents/Papers/RetroProject/code/thesis/wave_fig/brainFig.png');
p.parse(varargin{:});
opt = p.Results;

if ~isfield(d,'eeg_r')
    if(isempty(opt.eeg_r))
        d.eeg_r = prep_eeg_for_regress(eeg_r);
    else
        d.eeg_r = opt.eeg_r;
    end
end

f1 = drawBrainAndExampleWaves(d,m,opt.brainPicPath,opt.timewin,opt.upleft_chanlabels);
f2 = figure; text(0,0,'RetroProject/code/thesis/wave_fig/figure_draft');
f3 = drawTimeseries(d,m,opt.fitTimewin);
%dt = 0.5;
%lfp_wave = gh_long_wave_regress(eeg_r, rat_conv, 'short_timewin', dt);
%mua_wave = gh_long_wave_regress(mua_r, rat_conv, 'short_timewin', dt);


end


function f = drawBrainAndExampleWaves(d,m,brainPicPath,tWin,chanlabels)

figWidth  = 600;
figHeight = 400;
aspect = figWidth/figHeight;

f = figure('Color',[1,1,1],'Position',[100,100,figWidth,figHeight]);
subplot(1,2,1);
image([-7.75,7.75],[9.9,-15.8], imread(brainPicPath));
set(gca,'YDir','normal');
hold on;
for n = 1:numel(chanlabels)
    [x,y,c] = trodePosAndColor(chanlabels{n},d.trode_groups, d.rat_conv_table);
    plot(x,y,'.','Color',c,'MarkerSize',25);
end
axis equal;
axis off;
set(gca,'Position',[0,0,0.4,1]);

eeg = contwin_r(contchans_r(d.eeg_r,'chanlabels',chanlabels),safeTimeWin(tWin,d.eeg));
peaks = gh_troughs_from_phase(contchans_r(eeg,'chanlabels',chanlabels{1}));
subplot(1,2,2);
gh_plot_cont(eeg.raw,'spacing',-0.4,'colors',repmat([0.7,0.7,0.7],numel(chanlabels),1));
hold on;
gh_plot_cont(eeg.theta,'spacing',-0.4,'trode_groups',d.trode_groups,'LineWidth',3);
xlim(tWin);
[xs,ys] = gh_raster_points(peaks,'y_range',[-1.1,0.1]);
plot(xs,ys,'k--');
axis off;

plot ([0.1,0,0]+tWin(1)+0.1,[0,0,0.1]-1.3,'k-','LineWidth',3); % Scale bar
text(0+tWin(1)+0.1,0.05-1.3, '100uV','HorizontalAlignment','right');
text(0.05+tWin(1)+0.1,0-1.35, '100ms','HorizontalAlignment','center');
set(gca,'Position',[0.4,0,0.6,1]);

end

function [x,y,c] = trodePosAndColor(tName,trode_groups,rat_conv_table)
    g = trode_group(tName,trode_groups);
    c = g.color;
    x = trode_conv(tName,'comp','brain_ml',rat_conv_table);
    y = trode_conv(tName,'comp','brain_ap',rat_conv_table);
end

function tWin = safeTimeWin(tWin, cdat)
tWin = [max(cdat.tstart,tWin(1)-2), min(cdat.tend,tWin(2)+2)];
end



function [chanLabels,tWin,fitTWin] = ratDefaults(m)

     if(strContains(m.basePath,'morpheus'))
         chanLabels = {'24','17','12'};
         tWin = [904.17 904.7]; % TODO is rat running now?
         fitTWin = [900,1000];
     else
         error('ratUpLeftChans:noLabelData',['Don''t know which ',...
                                             'channels to use for ',...
                                             'example wave figure']);
     end

end

function [b,twin] = strContains(a,b)
    
    b = ~isempty(regexp(a,b,'ONCE'));
       
end
