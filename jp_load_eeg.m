function varargout = jp_load_eeg(animal, day, epoch, regions, varargin)

% ARGS = parseArgs(varargin, ARGS);

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

%% Load EEG Data
EEG = jp_import_eeg(edir);

ts = jp_calc_timestamps(EEG.tstart, EEG.tend, EEG.samplerate);
keepIdx = ts >= epochTime(1) & ts <= epochTime(2);
ts = ts(keepIdx);

EEG.tstart = ts(1);
EEG.tend = ts(end);

EEG.data = EEG.data(keepIdx,:);

%% Iterate over each region

nRegion = numel(regions);
varargout = cell( nargout, 1);

if nRegion ~= nargout
    warning('%d regions specified but %d will be returned', nRegion, nargout);
end

for iRegion = 1 : min(nRegion, nargout)
    region = regions{iRegion};
       
    ttLoadList = find( strcmp( ttAnatomy, region ) );
    chanTT = str2double( EEG.chanlabels );
    
    eeg = EEG;

    chanDiscardIdx = ~ismember(chanTT, ttLoadList);

    eeg.data(:, chanDiscardIdx) = [];
    eeg.chanlabels( chanDiscardIdx ) = [];
    eeg.datarange( chanDiscardIdx ,:) = [];
    eeg.region = region;
    varargout{iRegion} = eeg;
    
end



end