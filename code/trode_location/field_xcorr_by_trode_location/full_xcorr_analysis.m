function [X_reg, y_reg, field_dists, xcorr_dists, xcorr_r, anatomical_dists, f] = full_xcorr_analysis(place_cells, pos_info, rat_conv_table, varargin)

p = inputParser();

%general options
p.addParamValue('plot',true);

%options for field_dists
p.addParamValue('field_dists',[]);
p.addParamValue('method','peak');
p.addParamValue('field_direction','outbound');
p.addParamValue('min_peak_rate_thresh',15);
p.addParamValue('rate_thresh_for_multipeak', 10);
p.addParamValue('multipeak_max_spacing', 0.3);
p.addParamValue('max_abs_field_dist', 0.5);

%options for xcorr_dists
p.addParamValue('xcorr_dists',[]);
p.addParamValue('xcorr_r',[]);
p.addParamValue('timebouts', []);
p.addParamValue('xcorr_bin_size', 0.002);
p.addParamValue('xcorr_lag_limits', [-0.06, 0.06]);
p.addParamValue('smooth_timewin', 0.01);
p.addParamValue('r_thresh', 5e-5);

% options for anatomical_dists
p.addParamValue('anatomical_dists',[]);
p.addParamValue('ok_areas',{'CA1','CA3'});
p.addParamValue('axis_vector',[1 -1] ./ sqrt(2) );
p.addParamValue('anatomical_groups',false, @isbool);
p.addParamValue('trode_groups',[]);

p.parse(varargin{:});
opt = p.Results;

if(~isempty(opt.field_dists))
    field_dists = opt.field_dists;
else
    field_dists = get_field_dists(place_cells, 'method', opt.method, 'field_direction', opt.field_direction, ...
        'min_peak_rate_thresh', opt.min_peak_rate_thresh, 'rate_thresh_for_multipeak',opt.rate_thresh_for_multipeak,...
        'multipeak_max_spacing', opt.multipeak_max_spacing, 'max_abs_field_dist', opt.max_abs_field_dist);
end

if(~isempty(opt.xcorr_dists))
    xcorr_dists = opt.xcorr_dists;
else
    if(and( isempty(opt.timebouts), ~isempty(opt.field_direction)))
        if(strcmp(opt.field_direction,'outbound'))
            opt.timebouts = pos_info.out_run_bouts;
        elseif(strcmp(opt.field_direction,'inbound'))
            opt.timebouts = pos_info.in_run_bouts;
        end
    end
    [xcorr_dists, opt.xcorr_r] = get_xcorr_dists(place_cells, 'timebouts', opt.timebouts, 'xcorr_bin_size', opt.xcorr_bin_size,...
        'xcorr_lag_limits', opt.xcorr_lag_limits, 'r_thresh', opt.r_thresh, 'field_dists', field_dists, 'smooth_timewin', opt.smooth_timewin);
end

if(~isempty(opt.xcorr_r))
    xcorr_r = opt.xcorr_r;
else
    xcorr_r = [];
end

ok_xcorr_pairs = sum(sum(~isnan(xcorr_dists)))/2

if(~isempty(opt.anatomical_dists))
    anatomical_dists = opt.anatomical_dists;
elseif(~opt.anatomical_groups)
    anatomical_dists = get_anatomical_dists(place_cells, rat_conv_table, 'axis_vector', opt.axis_vector);
elseif(opt.anatomical_groups)
    if isempty(opt.trode_groups)
          error('full_xcorr_analysis:need_trode_groups',...
              'need to pass trode_groups param to use anatomical_groups option');
    end
    anatomical_dists = get_anatomical_region_dists(place_cells, opt.trode_groups);
end

if(~opt.anatomical_groups)
[f, X_reg, y_reg] = plot_all_dists(field_dists, xcorr_dists, anatomical_dists,...
    'xcorr_r', opt.xcorr_r);
end

if(opt.anatomical_groups)
    [f,X_reg_array] = plot_all_dists_by_group(field_dists,xcorr_dists, anatomical_dists);
end
    
error('treat inbound and outbound the right way');
if(strcmp(opt.field_direction,'inbound'))
    X_reg(:,2) = -1.*X_reg(:,2);
end