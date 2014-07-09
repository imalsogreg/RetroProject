function f = sv_place_cell_pair(d,m,okPairs,varargin)
% f = SV_PHASE_PAIR (sdat, ['rat_conv_table',conv_table], ['m',blue_cell_index],
%                          ['n',green_cell_index],['draw_extras',bool],
%                          ['trode_groups', trode_groups], ['overlay', bool],
%                          ['draw_phase_extents',true])
% Draws spikes of two units at their track positions (x) and theta phase (y)
% Units input must be in an sdat struct that has gone through assign_field
% and assign_theta_phase
%
% Flip blue cell id with LEFT and RIGHT arrow keys.  Green cell with UP and DOWN

p = inputParser();
p.addParamValue('m',1,@isreal);
p.addParamValue('n',2,@isreal);
p.parse(varargin{:});
opt = p.Results;

[~,~,fieldDists,anatomicalDists,xCorrDists,fieldCells,fields,xcorr_r,xcorr_mat] = ...
    full_xcorr_analysis(d,m,'ok_pairs',okPairs,'draw',false);


pcNames = cmap(@(x) x.name, d.spikes.clust);
inds = cellfun(@(x) find( strcmp(pcNames,x),1,'first'), fieldCells);
place_cells = d.spikes;
place_cells.clust = place_cells.clust(inds);

data.m = p.Results.m;
data.n = p.Results.n;
data.d = d;
data.sdat = place_cells;
data.fields = fields;
data.fieldDists = fieldDists;
data.anatomicalDists = anatomicalDists;
data.xCorrDists = xCorrDists;
data.xCorrMat = xcorr_mat;

data.f = figure('Position',[50 50 400 300],'KeyPressFcn',@localfn_figure_keypress);


data.opt = opt;
data.rat_conv_table = d.rat_conv_table;
guidata(data.f,data);
f = data.f;

localfn_plots(f);

end

function localfn_plots(f)
  dat = guidata(f);
  subplot(2,3,1); localfn_plot_trode_pos(dat.m,dat.n,dat.d);
  subplot(2,3,3); localfn_plot_xcorr(dat.m,dat.n,dat.xCorrMat,dat.xCorrDists);
  subplot(2,3,2); localfn_plot_field(dat.m,dat.d);
  subplot(2,3,4); localfn_plot_field(dat.n,dat.d);
  subplot(2,3,5); localfn_plot_mat(dat.m,dat.n,dat.xCorrDists)
  subplot(2,3,6); localfn_plot_mat(dat.m,dat.n,dat.fieldDists);
end

function localfn_plot_mat(m,n,mat)
  mat(isnan(mat)) = 0;
  matMax = max(max(mat));
  rowBrightness = (1:(length(mat)) == m).*0.5 + 0.5;
  colBrightness = (1:(length(mat)) == n).*0.5 + 0.5;
  mat = max(mat,(rowBrightness' * colBrightness));
  imagesc(mat)
end


function localfn_figure_keypress(src,eventdata)
data = guidata(src);

if strcmp(eventdata.Key,'rightarrow')
    data.m = data.m + 1;
elseif strcmp(eventdata.Key, 'leftarrow')
    data.m = data.m - 1;
elseif strcmp(eventdata.Key, 'uparrow')
    data.n = data.n - 1;
elseif strcmp(eventdata.Key, 'downarrow')
    data.n = data.n + 1;
end

guidata(data.f,data);
localfn_plots(data.f);
end

function localfn_plot_trode_pos(m,n,d)
  hold off;
  draw_trodes(d.rat_conv_table,'highlight_names',...
      [d.spikes.clust{m}.name,d.spikes.clust{n}.name]);
end

function localfn_plot_field(n,d)
  xs = d.spikes.clust{n}.field.bin_centers;
  r  = d.spikes.clust{n}.field.out_rate + ...
       d.spikes.clust{n}.field.in_rate(end:-1:1);
  plot(xs,r);
end

function localfn_plot_xcorr(m,n,xcMat,xcDists)
  nElem = numel(xcMat{m,n});
  xs = linspace (-nElem/2, nElem/2, nElem) .* 0.002;
  hold off;
  if(sum(isnan(xcMat{m,n})) == 0 && numel(xcMat{m,n}) == numel(xs))
      plot(xs,xcMat{m,n});
      hold on;
      plot(xcDists(m,n), max(xcMat{m,n}));
      maxInds = (xcMat{m,n} == max(xcMat{m,n}));
      if (numel(maxInds) > 0)
          plot( xs(maxInds(1)), max(xcMat{m,n}));
      end
  end
end