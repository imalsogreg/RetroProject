function [dist_matrix,place_cells_out] = get_field_dists(place_cells, varargin)

p = inputParser();
p.addParamValue('method', 'peak', @(x) any(strcmp(x, {'peak', 'xcorr'})));
p.addParamValue('field_direction', 'outbound', @(x) any(strcmp(x, {'outbound', 'inbound'})));
p.addParamValue('min_peak_rate_thresh', 15);
p.addParamValue('rate_thresh_for_multipeak',5);
p.addParamValue('multipeak_max_spacing',0.5);
p.addParamValue('max_abs_field_dist',0.6)
p.parse(varargin{:});
opt = p.Results;

% THE NEW WAY - Don't make a matrix of place cells.  Make a matrix of place fields
% Unwrap outbound and inbound.  Take xcorr of two fields on the same neuron?  Sure,
% it's fine, because (by definition) they won't have enough of a cross-correlation
% to be included in the final regression

fields = [];
for c = 1:numel(place_cells.clust)
    this_outbound = g
end

% % THE OLD WAY
% % make an array of place_cells, each row is the same cell over and over again
% n_units = numel(place_cells.clust);
% place_cells.clust = repmat( reshape(place_cells.clust,[],1),1, n_units );
% 
% if(strcmp(opt.method, 'peak'))
%     dist_fun = @lfun_peak_dist;
% elseif(strcmp(opt.method,'xcorr'))
%     dist_fun = @lfun_xcorr_dist;
% end
% 
% dist_matrix = cellfun( @(x,y) lfun_peak_dist(x,y,opt), place_cells.clust, (place_cells.clust)');
% if(~isempty(opt.max_abs_field_dist));
%     dist_matrix( abs(dist_matrix) > opt.max_abs_field_dist) = NaN;
% end
% 
% dist_matrix(logical( tril(ones(n_units))) ) = NaN;
% 
% place_cells_out = place_cells;
% place_cells_out.clust = cellfun( @(x) lfun_assign_peak_pos(x,opt), place_cells.clust,'UniformOutput',false);

end


function dist = lfun_peak_dist(cellA, cellB, opt)
    if(or(~lfun_isvalid(cellA,opt), ~lfun_isvalid(cellB,opt)))
        dist = NaN;
        return;
    end
    [p,r_A] = lfun_get_field(cellA,opt);
    [~,r_B]  = lfun_get_field(cellB,opt);
    peak_a = p( r_A == max(r_A));
    peak_b = p( r_B == max(r_B));
    % max is just in case two bins have the same firing rate
    dist = double(max(peak_b) - max(peak_a));
    
end

function cellA_out = lfun_assign_peak_pos(cellA, opt)
    cellA_out = cellA;
    if(~lfun_isvalid(cellA,opt))
        cellA_out.peak_pos = NaN;
        return;
    end
    [p, r_A] = lfun_get_field(cellA,opt);
    peak_pos = p(r_A == max(r_A));
    cellA_out.peak_pos = peak_pos;
end


function dist = lfun_xcorr_dist(cellA, cellB, opt)
  if(or(~lfun_isvalid(cellA,opt), ~lfun_isvalid(cellB,opt)))
        dist = NaN;
        return;
  end
    dist = 0;
  
end

function valid = lfun_isvalid(cellA, opt)
    valid = 1;  %innocent until proven guilty
    [p,r] = lfun_get_field(cellA,opt);
    dp = p(2)-p(1);
    % test that we've crossed the rate threshold
    if(~isempty(opt.min_peak_rate_thresh))
        if(max(r) < opt.min_peak_rate_thresh)
            valid = 0;
            return;
        end
    end
    % test that first and last peaks aren't too far apart (eliminate
    % multi-peaks cells)
    if(~isempty(opt.multipeak_max_spacing))
        local_max_bool = [0, and(r(2:(end-1)) >= r(1:(end-2)), r(2:(end-1)) >= r(3:end)), 0];
        cross_thresh_bool = (r >= opt.rate_thresh_for_multipeak);
        p_of_max = p(and(local_max_bool, cross_thresh_bool));
        if(numel(p) > 1)
            if(max(p_of_max) - min(p_of_max) > opt.multipeak_max_spacing)
                valid = 0;
                return;
            end
        end
    end
end

function [p,r] = lfun_get_field(cellA,opt)
    p = cellA.field.bin_centers;
    if(strcmp(opt.field_direction, 'outbound'))
        r = cellA.field.out_rate;
    elseif(strcmp(opt.field_direction,'inbound'))
        r = cellA.field.in_rate;
    end
end