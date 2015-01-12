function [dips, frames] = find_dips_frames(mua_rate,varargin)

p = inputParser();
p.addParamValue('mean_rate_threshold', 30);
p.addParamValue('smooth_sec',0.005);
p.addParamValue('trode_groups',[]);
p.addParamValue('area_for_threshold','RSC');
p.addParamValue('frame_length_range', [0.01 10]);
p.addParamValue('draw',false);
p.parse(varargin{:});
opt = p.Results;

if(~isempty(opt.area_for_threshold))
    if(~isempty(opt.trode_groups))
        mua_rate = contchans_trode_group(mua_rate,opt.trode_groups,opt.area_for_threshold);
    else
        error('find_dips_frames:need_both_params','Need trode_groups and area_for_threshold or neither');
    end
end
    
dip_crit = seg_criterion('cutoff_value', opt.mean_rate_threshold,...
    'threshold_is_positive',false,...
    'bridge_max_gap',0.005,'min_width_pre_bridge',0.020);

mua_mean = mua_rate;
mua_mean.data = mean(double(mua_mean.data),2);
mua_mean.chanlabels = {'meanRate'};
nSmooth = floor(mua_mean.samplerate * opt.smooth_sec);
if(nSmooth > 1)
    mua_mean.data = smooth(mua_mean.data,nSmooth);
end

dips = gh_signal_to_segs(mua_mean,dip_crit);

frames = gh_invert_segs(dips);

%c1 = 

frames = ...
    frames(cellfun(@(x) (diff(x) >= min(opt.frame_length_range) && ...
    diff(x) <= max(opt.frame_length_range)), frames, 'UniformOutput',true));

if(opt.draw)
    gh_plot_cont(mua_mean);
    hold on;
    gh_draw_segs({frames, dips}, 'names',{'frames','dips'},'ys',{[-100 0],[-200 -100]});
end