function f = reconstruction_fig()

[xs,steps] = collect_reconstruction_xcorr();

% Get reconstruction example
m = caillou_112812_metadata(); % Don't change this anymore!
exampleTimewin = [5723.5,5725];
m.linearize_opts.click_points = ...
    [174.4116  192.9724  208.9106  221.6207  233.9274  248.2515  254.3040  258.5407  256.7249  252.2865  246.0323  237.5588  228.4802  218.3927  205.0773  185.3060  166.7451  152.0175  136.4829  123.1675  109.0451  101.1769   94.1157   87.4580   81.4055   76.1601   72.5286   70.1076   69.0989   70.7128   73.9408   79.7915   86.6510   91.8964   98.1506  104.6066  112.2730  119.7377  128.2112  137.6933  148.9913  159.4822  167.7539  174.2098; ...
     228.7863  223.9527  216.4339  209.4522  200.8593  180.9882  165.9506  140.1719  113.8561   99.8926   84.3179   74.6509   62.2986   53.1686   47.2610  39.7422   34.3716   34.3716   39.2052   44.5757   53.1686   59.0763   68.2062   77.3362   88.6144   99.8926  109.5596  124.0602  135.3383  149.8389  164.8765  176.6917  186.3588  193.3405  200.8593  207.8410  213.7487  218.0451  223.9527  227.7121  229.8604  229.8604  228.2492  228.2492]';  
m.linearize_opts.click_points = m.linearize_opts.click_points(:,end:-1:1); % because the above paste is backwards...

dataPath   = [m.basePath,'/rposExampleData.mat'];
rposXCPath = [m.basePath,'/rposData.mat'];
if(~exist(dataPath))
    d = loadData(m,'segment_style','ml');
    save(dataPath,'d');
else
    load(dataPath);
    d.trode_groups = m.trode_groups_fn('date',m.today,'segment_style','ml');
end
if(exist(rposXCPath))
    load(rposXCPath)
else
    error('reconstruction_fig:no_rpos_data',['No rpos data at ',rposXCPath]);
end

d.trode_groups = ...
    d.trode_groups( cellfun(@(x) any(strcmp(x.name,{'medial','lateral'})), ...
    d.trode_groups) );
d.trode_groups{1}.color = [1,0,0];
d.trode_groups{2}.color = [0,1,0];

rpos = decode_pos_with_trode_pos(d.spikes,d.pos_info,...
    d.trode_groups,'r_tau',0.020,'field_direction','outbound');

