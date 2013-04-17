function data = jp_load_region_data(edir, region, unitArgs, posArgs, muaArgs, eegArgs)

ARGS.MUA.RATE_DT = .01;
ARGS.EEG.DETECT_RIPPLES = 1;

[data.epochNames, data.epochTimes] = jp_load_epoch(edir);

if ~exist(edir,'dir')
    warning('%s does not exist');
end

if all( ~strcmp(region, {'CA1', 'RSX', 'ADT'}) )
    error('Invalid brain region provided:%s', region);
end
    
ttAnatData = jp_load_tt_anatomy(edir);
if isempty(ttAnatData)
    error('No anatomy data defined for:%s', edir);
end

ttList = cell2mat( ttAnatData(:, 1 ) ); %#ok ignored variable 
ttAnatomy = ttAnatData(:,2);

ttLoadList = find( strcmp( ttAnatomy, region ) );

if ~isempty(unitArgs)
    
    units = jp_import_units(edir);
    
    clustTT = str2double( cellfun( ... 
            @(x) ( getfield(x, 'comp')), units.clust,'UniformOutput', 0)' ); %#ok
    
    clustDiscardIdx = ~ismember(clustTT, ttLoadList);
    units.clust(clustDiscardIdx) = [];
   
    data.units = units;
    
else
    
    data.units = [];
    
end

if ~isempty(posArgs)
    
    pos = jp_import_pos(edir);
    data.pos = pos;
    
end

if ~isempty(muaArgs)
    
    if iscell(muaArgs)
        muaArgs = parseArgs(muaArgs, ARGS.MUA);
    end
    
    mua = jp_import_mu(edir);
    
    clustTT = str2double( cellfun( ... 
            @(x) ( getfield(x, 'comp')), mua.clust,'UniformOutput', 0)' ); %#ok
    
    clustDiscardIdx = ~ismember(clustTT, ttLoadList);
    mua.clust(clustDiscardIdx) = [];
    mua.nclust = numel(mua.clust);
    data.mua = mua; 
    
    
    
else
    data.mua = [];    
end

if ~isempty(eegArgs)
    
    eeg = jp_import_eeg(edir);
    chanTT = str2double( eeg.chanlabels );
    chanDiscardIdx = ~ismember(chanTT, ttLoadList);
    
    eeg.data(:, chanDiscardIdx) = [];
    eeg.chanlabels( chanDiscardIdx ) = [];
   
    data.eeg = eeg;
    
else
    data.eeg = [];
end

end