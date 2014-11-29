function [fields,fieldSources,unwrappedPlaceCells] = get_fields(place_cells,varargin)

p = inputParser();
p.addParamValue('ok_directions',{'outbound','inbound'});
p.addParamValue('method', 'peak', @(x) any(strcmp(x, {'peak', 'xcorr'})));
p.addParamValue('min_peak_rate_thresh', 10);
p.addParamValue('edge_rate_thresh',1);
p.addParamValue('rate_thresh_for_multipeak',5);
p.addParamValue('multipeak_max_spacing',0.5);
p.addParamValue('max_abs_field_dist',2);
p.addParamValue('draw',false);
p.parse(varargin{:});
opt = p.Results;

fields = cell(0);
fieldSources = cell(0);
isValid = [];

% xs = unfoldBinCenters(place_cells.clust{1}); % not true after refactor

for c = 1:numel(place_cells.clust)
    place_cells.clust{c} = unrollOutboundInbound(place_cells.clust{c},opt);
    workingClust = place_cells.clust{c};
    nCellField = 0;
    while hasField(workingClust,opt)
        [thisField,thisIsValid,workingClust] = lfunTakeTopField(workingClust,opt);
        fields = [fields, thisField];
        isValid = [isValid,thisIsValid];
        nCellField = nCellField + numel(thisField);
    end
    fieldSources = [fieldSources, cmap(@(x) workingClust.name, cell(1,nCellField))];
end
unwrappedPlaceCells = sdatslice(place_cells,'names',fieldSources);
for n = 1:numel(unwrappedPlaceCells.clust)
    unwrappedPlaceCells.clust{n}.field.rate = fields{n};
end
end

function edges = mergeNeighbors(fieldEdges,fieldRate,opt)
    isClean = true;
    edges = fieldEdges;
    nSubfields = numel(fieldEdges)-1;
    for n = 2:nSubfields-1
        prevRange = [fieldEdges(n-1),fieldEdges(n)  ];
        nextRange = [fieldEdges(n),  fieldEdges(n+1)];
        isOk = @(r) max(fieldRate(r(1):r(2))) >= opt.min_peak_rate_thresh;
        if ~isOk(prevRange) || ~isOk(nextRange)
            edges(n) = [];
            isClean = false;
        end
    end
    if ~isClean
        edges = mergeNeighbors(edges,fieldRate,opt);
    end
end

function clustNew = unfoldBinCenters(clust)
    field = unwrap_linear_field(clust.field);
    clustNew = clust;
    clustNew.field = field;
end

function newClust = unrollOutboundInbound(clust,opt)
    newClust = clust;
    field = unwrap_linear_field(newClust.field,...
            'ok_directions',opt.ok_directions);
    newClust.field = field;
end

% This guy was written to return 1 field, but I'd like it to return
% possibly more, if that one has a deep valley that should split the
% field into two parts. Really ought to use phase here to break
function [topFields,isValid,adjClust] = lfunTakeTopField(clust,opt)
    if strcmp(clust.name,'cell_2323_cl-2')
        a = 1;
    end
    cRate = clust.field.rate;
    xs = clust.field.bin_centers;
    topField = zeros(size(cRate));
    isValid = true;
    adjClust = clust;
    peakP = clust.field.bin_centers(cRate == max(cRate));
    peakP = peakP(1);
    iPeak = find(cRate == max(cRate),1,'first');
    i = iPeak;
    while i <= numel(cRate) && cRate(i) > opt.edge_rate_thresh
        topField(i) = cRate(i);
        cRate(i) = 0;
        i = i + 1;
    end
    i = iPeak - 1;
    while i >= 1 && cRate(i) > opt.edge_rate_thresh
        topField(i) = cRate(i);
        cRate(i) = 0;
        i = i - 1;
    end
    adjClust.field.rate = cRate;
    fieldEdges = xs(diff(topField ~= 0) ~= 0);
    fieldEdges = ...
        [fieldEdges(1), ...
         xs(topField < opt.rate_thresh_for_multipeak & localMins(topField)),...
         fieldEdges(end)];
    nFields = numel(fieldEdges) - 1;
    topFields = cell(1,nFields);
    for n = 1:nFields
        thisField = zeros(size(cRate));
        thisKeep = xs >= fieldEdges(n) & xs <= fieldEdges(n+1);
        thisField(thisKeep) = topField(thisKeep);
        topFields{n} = thisField;
    end
end

function b = hasField(clust,opt)
    b = max(clust.field.rate) > opt.min_peak_rate_thresh;
end

function ms = localMins(xs)
  ms = [0, ...
       (xs(2:(end-1)) < xs(1:(end-2)) & xs(2:(end-1)) < xs(3:end)),...
       0];
end