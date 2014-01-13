function [f, X_reg, y_reg] = plot_all_dists(field_dists, xcorr_dists, anatomical_dists, varargin)

p = inputParser();
p.addParamValue('drop_diagonal', true);
p.addParamValue('xcorr_r',[]);
p.parse(varargin{:});
opt = p.Results;

n_cells = size(field_dists,1);

keep_bool = logical(triu( ones(n_cells, n_cells) ));
if(opt.drop_diagonal)
    keep_bool( logical(eye(n_cells, n_cells)) ) = 0;
    keep_bool = logical(keep_bool);
end

if(isempty(opt.xcorr_r))
    xcorr_r = ones(size(xcorr_dists));
else
    xcorr_r = opt.xcorr_r;
end

field_dists = lfun_condition_matrix(field_dists,keep_bool);
xcorr_dists = lfun_condition_matrix(xcorr_dists, keep_bool);
anatomical_dists = lfun_condition_matrix(anatomical_dists, keep_bool);
xcorr_r = lfun_condition_matrix(xcorr_r, keep_bool);

keep_bool = min( [~isnan(field_dists) ;...
    ~isnan(xcorr_dists) ; ...
    ~isnan(anatomical_dists)], [], 1);
keep_bool = logical(keep_bool);

field_dists = field_dists(keep_bool);
xcorr_dists = xcorr_dists(keep_bool);
anatomical_dists = anatomical_dists(keep_bool);
xcorr_r = xcorr_r(keep_bool);

%f = scatter(field_dists, xcorr_dists, 320.*xcorr_r, anatomical_dists,'filled');
f = scatter3(field_dists,anatomical_dists,xcorr_dists, 160.*xcorr_r);

X_reg = [ ones(numel(field_dists), 1), field_dists', anatomical_dists'];
y_reg = xcorr_dists';
end


function res = lfun_condition_matrix(inp, keep_bool)
    inp(~keep_bool) = NaN;
    res = reshape(inp, 1, []);
end
    