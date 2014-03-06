function trode_groups = yolanda_trode_groups(varargin)

p = inputParser();
p.addParamValue('areas',[]);
p.addParamValue('date','121111');
p.addParamValue('silent',false);
p.parse(varargin{:});
opt = p.Results;

n = @(x) str2num(date_ad_to_alpha(x));
d = opt.date;

if( n(d) >= n('120711') && n(d) <= n('121111'))
    trode_groups{1}.name   = 'CA1';
    trode_groups{1}.trodes = {'11','12','15','16','17','18','19','20','21','22','23','24'};
    trode_groups{1}.color  = [1 0 0];


    trode_groups{2}.name   = 'CA3';
    trode_groups{2}.trodes = {'30','29','28','27','26','25','01','02','03','04','05','06','07','08','09','13','14'};
    trode_groups{2}.color = [0 1 0];

    trode_groups{3}.name   = 'reference';
    trode_groups{3}.trodes = {};
    trode_groups{3}.color = [0 0 1];

    trode_groups{4}.name = 'bad';
    trode_groups{4}.trodes = {'10'};
    trode_groups{4}.color  = [0 0 0];

end

if(n(d) > n('121111'))
  error('need to find trode groups for Sept 14th onward.');

end

if(n(d) < n('120711') || n(d) > n('121111'))
    trode_groups = 0;
    if(~opt.silent)
        error('yolanda_trode_groups:bad_date',['No data for the date ', d]);
    end
end
