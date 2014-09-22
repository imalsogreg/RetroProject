function describe_wave(d,m,varargin)

[defaultChans,defaultTWin] = ratDefaults(m);

p = inputParser();
p.addParamValue('upleft_chanlabels',defaultChans);
p.addParamValue('timewin',defaultTWin);
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

drawBrainAndExampleWaves(d,m,opt.brainPicPath,opt.timewin,opt.upleft_chanlabels);

%dt = 0.5;
%lfp_wave = gh_long_wave_regress(eeg_r, rat_conv, 'short_timewin', dt);
%mua_wave = gh_long_wave_regress(mua_r, rat_conv, 'short_timewin', dt);


end


function f = drawBrainAndExampleWaves(d,m,brainPicPath,tWin,chanlabels)

f = figure;
subplot(1,2,1);
image([-7.75,7.75],[9.9,-15.8], imread(brainPicPath));
set(gca,'YDir','normal');
hold on;
for n = 1:numel(chanlabels)
    [x,y,c] = trodePosAndColor(chanlabels{n},d.trode_groups, d.rat_conv_table);
    plot(x,y,'.','Color',c,'MarkerSize',20);
end
axis equal;


eeg = contwin_r(contchans_r(d.eeg_r,'chanlabels',chanlabels),safeTimeWin(tWin,d.eeg));
peaks = gh_troughs_from_phase(contchans_r(eeg,'chanlabels',chanlabels{1}));
subplot(1,2,2);
gh_plot_cont(eeg.raw,'spacing',-0.4);
hold on;
gh_plot_cont(eeg.theta,'spacing',-0.4,'trode_groups',d.trode_groups,'LineWidth',3);
xlim(tWin);
[xs,ys] = gh_raster_points(peaks,'y_range',[-1,0.1]);
plot(xs,ys,'k--');

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



function [chanLabels,tWin] = ratDefaults(m)

     if(strContains(m.basePath,'morpheus'))
         chanLabels = {'23','15','12'};
         tWin = [822.7,823.2]; % TODO is rat running now?
     else
         error('ratUpLeftChans:noLabelData',['Don''t know which ',...
                                             'channels to use for ',...
                                             'example wave figure']);
     end

end

function [b,twin] = strContains(a,b)
    
    b = ~isempty(regexp(a,b,'ONCE'));
       
end
