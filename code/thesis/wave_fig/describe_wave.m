function [f1,f2,f3,f4,eeg_r,eeg_wave] = describe_wave(d,m,varargin)

[defaultChans,defaultTWin,defaultFitTWin] = ratDefaults(m);

p = inputParser();
p.addParamValue('upleft_chanlabels',defaultChans);
p.addParamValue('timewin',defaultTWin);
p.addParamValue('fitTimewin',defaultFitTWin);
p.addParamValue('eeg_r',[]);
p.addParamValue('brainPicPath','/home/greghale/Documents/Papers/RetroProject/code/thesis/wave_fig/brainFig.png');
p.parse(varargin{:});
opt = p.Results;

if ~isfield(d,'eeg_r')
    if(isempty(opt.eeg_r))
        d.eeg_r = prep_eeg_for_regress(d.eeg,'timewin_buffer',2);
    else
        d.eeg_r = opt.eeg_r;
    end
end
eeg_r = d.eeg_r;
fields = fieldnames(d.eeg_r);
for n = 1:numel(fieldnames(d.eeg_r))
    d.eeg_r.(fields{n}).data( isnan(d.eeg_r.(fields{n}).data) ) = 0;
end

[f1] = drawBrainAndExampleWaves(d,m,opt.brainPicPath,opt.timewin,opt.upleft_chanlabels);
f2 = figure; text(0,0,'RetroProject/code/thesis/wave_fig/figure_draft');
[f3,eeg_wave] = drawTimeseries(d,m,opt.fitTimewin);
f4 = 0;


end


function [f,eeg_r] = drawBrainAndExampleWaves(d,m,brainPicPath,tWin,chanlabels)

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

eeg_r = d.eeg_r;

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

function [f,eeg_regress] = drawTimeseries(d,m,timewin,timeseriesOpts)
    if (~isfield(d,'eeg_regress'))
        eeg_r = contwin_r(d.eeg_r,timewin);
        eeg_regress = gh_long_wave_regress(eeg_r,d.rat_conv_table);
        d.eeg_regress = eeg_regress;
    end
    f = figure('Color',[1,1,1]);
    ax(1) = subplot(4,1,1); gh_plot_cont(d.pos_info.lin_vel_cdat);
    set(gca,'XColor',[1,1,1]); set(gca,'XTick',[]); set(gca,'YColor',[1,1,1]); set(gca,'YTick',[]);
    ylabel('Vel (m/s)');
    ax(2) = subplot(4,1,2); plot(d.eeg_regress.timestamps,d.eeg_regress.est(1,:));

    ylabel('{\lambda} (mm/cycle)');

    ax(3) = subplot(4,1,3); plot(d.eeg_regress.timestamps,d.eeg_regress.est(2,:));
    ylabel('{\theta} (° from M/L)');
    linkaxes(ax,'x');
    ax(4) = subplot(4,1,4); plot(d.eeg_regress.timestamps,d.eeg_regress.r_squared);
    linkaxes(ax,'x');
end

function [chanLabels,tWin,fitTWin] = ratDefaults(m)

     if(strContains(m.basePath,'morpheus'))
         chanLabels = {'24','17','12'};
         tWin = [904.17 904.7]; % TODO is rat running now?
         fitTWin = [1420, 1720];
     else
         error('ratUpLeftChans:noLabelData',['Don''t know which ',...
                                             'channels to use for ',...
                                             'example wave figure']);
     end

end

function [b,twin] = strContains(a,b)
    
    b = ~isempty(regexp(a,b,'ONCE'));
       
end
