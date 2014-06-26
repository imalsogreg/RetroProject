function [X_reg, y_reg, field_dists, anatomical_dists, xcorr_dists, field_cells, xcorr_r, f] = full_xcorr_analysis(d,m, varargin)

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
p.addParamValue('max_abs_field_dist', 1);

%options for xcorr_dists
p.addParamValue('xcorr_dists',[]);
p.addParamValue('xcorr_r',[]);
p.addParamValue('timebouts', []);
p.addParamValue('xcorr_bin_size', 0.002);
p.addParamValue('xcorr_lag_limits', [-0.12, 0.12]);
p.addParamValue('smooth_timewin', 0.01);
p.addParamValue('r_thresh', 1e-2);

% options for anatomical_dists
p.addParamValue('anatomical_dists',[]);  %pass this to bypass computing it in full_xcorr_anal
p.addParamValue('ok_areas',{'CA1','CA3'});
p.addParamValue('swap_on_reverse',true);
p.addParamValue('ok_pairs',[]);
p.addParamValue('axis_vector',[1 -1] ./ sqrt(2) );
p.addParamValue('anatomical_groups',false);
p.addParamValue('trode_groups',[]);

p.parse(varargin{:});
opt = p.Results;

checkOkAreasAndSwapOnReverseParams(opt);

place_cells       = d.spikes;
pos_info            = d.pos_info;
rat_conv_table = d.rat_conv_table;

if(isempty(opt.ok_pairs))
    error('full_xcorr_analysis:unset_ok_pairs',...
        'Must specify ''ok_pairs'' field, usually as { {''CA3,CA1''} } or { {''CA1,CA1''} }');
end

if(~isempty(opt.field_dists))
    field_dists = opt.field_dists;
else
    [field_dists,field_cells] = get_field_dists(place_cells, 'method', opt.method, ...
        'min_peak_rate_thresh', opt.min_peak_rate_thresh, 'rate_thresh_for_multipeak',opt.rate_thresh_for_multipeak,...
        'multipeak_max_spacing', opt.multipeak_max_spacing, 'max_abs_field_dist', opt.max_abs_field_dist);
end

groups = cmap(@(x) group_of_trode(m.trode_groups,x(6:7)), field_cells);
groups = cmap(@(x) x(1).name, groups);

okPairs = zeros(numel(field_cells), numel(field_cells));
for m = 1:numel(field_cells)
    for n = 1:numel(field_cells)
        if any(strcmp(opt.ok_pairs, [groups{m},',',groups{n}]))
            okPairs(m,n) = 1;
        elseif any(strcmp(opt.ok_pairs,[groups{n},',',groups{m}]))
            okPairs(m,n) = -1;
        else
            okPairs(m,n) = 0;
        end
    end
end
%field_dists(~okPairs) = NaN;

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
    [xcorr_dists, opt.xcorr_r] = get_xcorr_dists(place_cells,field_cells, 'timebouts', opt.timebouts, 'xcorr_bin_size', opt.xcorr_bin_size,...
        'xcorr_lag_limits', opt.xcorr_lag_limits, 'r_thresh', opt.r_thresh, 'field_dists', field_dists, 'smooth_timewin', opt.smooth_timewin);
end

if(~isempty(opt.xcorr_r))
    xcorr_r = opt.xcorr_r;
else
    xcorr_r = [];
end

n_ok_xcorr_pairs = sum(sum(~isnan(xcorr_dists)))/2

if(~isempty(opt.anatomical_dists))
    anatomical_dists = opt.anatomical_dists;
elseif(~opt.anatomical_groups)
    anatomical_dists = get_anatomical_dists(place_cells, field_cells, rat_conv_table, 'axis_vector', opt.axis_vector);
elseif(opt.anatomical_groups)
    if isempty(opt.trode_groups)
          error('full_xcorr_analysis:need_trode_groups',...
              'need to pass trode_groups param to use anatomical_groups option');
    end
    anatomical_dists = get_anatomical_region_dists(place_cells, field_cells, opt.trode_groups);
end



if(~opt.anatomical_groups)
[f, X_reg, y_reg] = plot_all_dists(field_dists, xcorr_dists, anatomical_dists,...
    'xcorr_r', opt.xcorr_r);
end

if(opt.anatomical_groups)
    pairColorMap = containers.Map;
    for n = 1:numel(opt.ok_pairs)
    pairColorMap([opt.ok_pairs{n}{1},'|',opt.ok_pairs{n}{2}]) = gh_colors(n+1);
    end
  plot_all_dists_by_group(field_dists,anatomical_dists,xcorr_dists,...
      field_cells,opt.trode_groups,pairColorMap);
  X_reg = 2;
  y_reg = 2;
end

end


function checkOkAreasAndSwapOnReverseParams(opt)

if(~isempty(opt.ok_pairs))
    pairs = opt.ok_pairs;

    for p = 1:numel(pairs)
    
        thisComma = find(pairs{p} == ',');
        if isempty(thisComma)
                error('full_xcorr_analysis:checkOpts','Bad ok_pairs param');
        end
        thisTarget = {pairs{p}(1:(thisComma-1)), pairs{p}(thisComma+1:end)};
    
        %thisTarget = pairs{p};
        thisRemainder = pairs;
        thisRemainder(p) = [];
    
         
        if(any( cellfun(@(x) pairEq(thisTarget,x), thisRemainder) ))
             error('full_xcorr_analysis:repeated_pair','found repeats in ''ok_pairs'' parameter');
        end
     
        if(opt.swap_on_reverse)
            if any (cellfun(@(x) pairEq( flipPair(thisTarget), x), thisRemainder))
            error('full_xcorr_analysis:pair_matched_flip',...
                    'found a pair matching its flipped counterpart. This is probably a mistake; it means no reverses will be made.');
                end
        end
        
    end
end
end

function p = flipPair(pair)
p = pair;
p{2} = pair{1};
p{1} = pair{2};
end

function b = pairEq(pairA,pairB)
b = strcmp(pairA{1},pairB{1}) && strcmp(pairA{2},pairB{2});
end