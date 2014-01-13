function [fig, spacing] = gh_plot_cont(cdat,varargin)

p = inputParser();
p.addParamValue('timewin',[]);
p.addParamValue('spacing',18*mean(mean(abs(cdat.data(:,1)))));
p.addParamValue('colors',[]);
p.addParamValue('shorten_x_labels',false);
p.addParamValue('draw_chanlabels',true);
p.addParamValue('font_size',20);
p.addParamValue('draw_title',true);
p.addParamValue('draw_y_ticks',true);
p.addParamValue('trode_groups',[]);
p.addParamValue('zero_nans',false);
p.addParamValue('area',false);
p.addParamValue('LineWidth',1);
p.addParamValue('draw_variance',true);
p.parse(varargin{:});
opt = p.Results;

if(~isempty(opt.timewin))
    this_cdat = contwin(cdat,opt.timewin);
else
    opt.timewin = [cdat.tstart, cdat.tend];
    this_cdat = cdat;
end

if(opt.zero_nans)
    cdat.data(isnan(cdat.data)) = 0;
end

n_samp = size(this_cdat.data,1);
n_chan = size(this_cdat.data,2);

offsets = [0:(n_chan-1)].*opt.spacing;

offsets = repmat(offsets,n_samp,1);

if(n_chan == 1)
    offsets = 0;
end

y = this_cdat.data + offsets;
x = conttimestamp(this_cdat);

if(isfield(this_cdat,'variance'))
    v = this_cdat.variance + offsets;
end

x_disp = x;
if(opt.shorten_x_labels);
    x_disp = x_disp - min(x_disp);
    if(opt.draw_title)
    title(['Time [', num2str(min(x)), '  through  ', num2str(max(x)), ']'], ...
        'FontSize', opt.font_size); 
    end
end

if(isempty(opt.colors))
    if(isempty(opt.trode_groups))
        opt.colors = zeros(n_chan, 3);
        opt.colors(:,3) = (0:(n_chan-1))./n_chan;
    else
        opt.colors = trode_colors(cdat, opt.trode_groups);
    end
end

if(opt.draw_variance && isfield(this_cdat,'variance'))
    for n = 1:n_chan
        plot(x_disp,(y(:,n)+sqrt(v(:,n)))', '-', 'Color', opt.colors(n,:)./2, 'LineWidth',1);
        hold on;
        plot(x_disp,(y(:,n)-sqrt(v(:,n)))', '-', 'Color', opt.colors(n,:)./2, 'LineWidth',1);
    end
end

for n = 1:n_chan
    if(~opt.area)
        fig = plot(x_disp,y(:,n)','-','Color',opt.colors(n,:),'LineWidth',opt.LineWidth); hold on;
    elseif(opt.area)
        fig = area(x_disp,y(:,n)',offsets(n),'FaceColor',opt.colors(n,:),'LineWidth',opt.LineWidth); hold on
    end
    if(opt.draw_chanlabels && ~isempty(cdat.chanlabels))
        text(opt.timewin(1), double(offsets(1,n)), cdat.chanlabels{n} );
    end
end

set(gca,'FontSize',opt.font_size);

xlabel('Time (seconds)','FontSize',opt.font_size);

if(~opt.draw_y_ticks)
    set(gca, 'YTickLabel', cell(0));
end

spacing = opt.spacing;