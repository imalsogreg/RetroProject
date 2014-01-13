function h = draw_trodes(rat_conv_table,varargin)



p = inputParser();
p.addParamValue('trode_labels',[]);
p.addParamValue('pref_x',[]);
p.addParamValue('pref_y',[]);
p.addParamValue('pref_len',[]);
p.addParamValue('pref_height',[]);
p.addParamValue('MarkerSize',300);
p.addParamValue('draw_names',true);
p.addParamValue('axis_padding',[]);
p.addParamValue('trode_groups',[]);
p.addParamValue('date',[]);
p.addParamValue('trode_groups_args',cell(0));
p.addParamValue('trode_colors',[]); % <-- unually you want to use trode_groups instead
p.addParamValue('filled',false);
p.parse(varargin{:});
opt = p.Results;



if(~isempty(opt.trode_labels))
    table_labels = rat_conv_table.data(strcmp(rat_conv_table.label, 'comp'),:);
    keep_bool = cellfun( @(x) any(strcmp(x,opt.trode_labels)), table_labels);
    rat_conv_table.data = rat_conv_table.data(:,keep_bool);
end

trode_names = rat_conv_table.data( strcmp('comp',rat_conv_table.label), : );
trode_xy = mk_trodexy(trode_names, rat_conv_table);
trode_xs = trode_xy(:,1);
trode_ys = trode_xy(:,2);

len = max(trode_xs) - min(trode_xs);
height = max(trode_ys) - min(trode_ys);

if(isempty(opt.pref_x))
    opt.pref_x = mean(trode_xs);
end
if(isempty(opt.pref_y))
    opt.pref_y = mean(trode_ys);
end
if(isempty(opt.pref_len))
    opt.pref_len = len;
end
if(isempty(opt.pref_height))
    opt.pref_height = height;
end


trode_xs = (trode_xs - mean(trode_xs))/len * opt.pref_len + opt.pref_x;
trode_ys = (trode_ys - mean(trode_ys))/height * opt.pref_height + opt.pref_y;

if(~isempty(opt.trode_groups))
    if (~isempty(opt.date))
        dateArgs = {'date',opt.date};
    else
        dateArgs = cell(0);
    end
    trode_cs = trode_colors(trode_names, opt.trode_groups);
else
    if(~isempty(opt.trode_colors))
        n_trodes = numel(trode_names);
        % Just use trode_colors, repmatting it to n_trodes length if necessary
        trode_cs = repmat(opt.trode_colors, n_trodes / size(opt.trode_colors,1), 1);
    else
        trode_cs = zeros(numel(trode_names), 3);
    end
end

if(opt.filled)
    fi = {'filled'};
else
    fi = cell(0);
end

h = scatter(trode_xs,trode_ys,opt.MarkerSize,trode_cs, fi{:});
hold on;


if(opt.draw_names)
    text(trode_xs,trode_ys,trode_names);
end

axis equal;
