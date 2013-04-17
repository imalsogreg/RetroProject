function varargout = jp_load_multiunit(animal, day, epoch, regions, varargin)

ARGS.CALC_RATE = 1;
ARGS.RATE_DT = .01;
ARGS.SMOOTH = 1;
ARGS.SMOOTH_DT = .01;
ARGS = parseArgs(varargin, ARGS);

edir = jp_working_dir(animal, day);

epochTime = jp_load_epoch(edir, epoch);

if isempty(epochTime)
    error('The specified epoch: %s could not be found in: %s/epoch.epoch', epoch, edir)
end

if ~exist(edir,'dir')
    warning('%s does not exist');
end

if ~iscell(regions)
    regions = {regions};
end

if ~all( cellfun(@(x) any( strcmp( jp_list_valid_regions(), x)), regions))
    error('Invalid list of regions provided. Acceptable options are: HPC, RSC, THAL');
end
    
ttAnatData = jp_load_tt_anatomy(animal, day);
if isempty(ttAnatData)
    error('No anatomy data defined for:%s', edir);
end

ttList = cell2mat( ttAnatData(:, 1 ) ); %#ok ignored variable
ttAnatomy = ttAnatData(:,2);


%% Load all MultiUnit data from Disk
MUA = jp_import_mu(edir);

%% Iterate over each region

nRegion = numel(regions);
varargout = cell( nargout, 1);

if nRegion ~= nargout
    warning('%d regions specified but %d will be returned', nRegion, nargout);
end

for iRegion = 1 : min(nRegion, nargout)
    region = regions{iRegion};
       
    ttLoadList = find( strcmp( ttAnatomy, region ) );



    clustTT = str2double( cellfun( ... 
            @(x) ( getfield(x, 'comp')), MUA.clust,'UniformOutput', 0)' ); %#ok

    clustDiscardIdx = ~ismember(clustTT, ttLoadList);
    
    mua = MUA;
    mua.clust(clustDiscardIdx) = [];
    mua.nclust = numel(mua.clust);

    if ARGS.CALC_RATE == 1
        mua = jp_calc_mu_rate(mua, epochTime, ARGS.RATE_DT);

        if ARGS.SMOOTH == 1
            mua.rate = smoothn(mua.rate, ARGS.RATE_DT, ARGS.SMOOTH_DT );
        end
    end
    
    mua.region = region;
    varargout{iRegion} = mua;
    
end

end