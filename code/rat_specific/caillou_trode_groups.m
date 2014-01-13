function trode_groups = caillou_trode_groups(varargin)

if(nargin == 0)
    grp = 'areas';
else
    grp = varargin{1};
    grp = 'areas';
end

if(strcmp(grp,'areas'))

trode_groups{1}.name   = 'THAL';
trode_groups{1}.trodes = {'01','02','03','29','30'};
trode_groups{1}.color  = [1 0 0];

trode_groups{4}.name   = 'ADT';
trode_groups{4}.trodes = {'04','05'};
trode_groups{4}.color  = [0.5 0 0.5];

trode_groups{2}.name   = 'RSC';
trode_groups{2}.trodes = {'17','18','19','20','21','22','23','24','25','27','28','17arte','18arte'};
trode_groups{2}.color = [0 0.5 0];

trode_groups{3}.name   = 'CA1';
trode_groups{3}.trodes = {'06','08','09','10','11','12','13','14','16','16arte'};
trode_groups{3}.color = [0 0 1];
end

trode_groups{5}.name = 'BAD';
trode_groups{5}.trodes = {'07','15','15arte','26'};
trode_groups{5}.color = [0.1 0.1 0.1];
