function [fields,fieldSources] = get_fields(place_cells,varargin)

p = inputParser();
p.addParamValue('method', 'peak', @(x) any(strcmp(x, {'peak', 'xcorr'})));
p.addParamValue('min_peak_rate_thresh', 15);
p.addParamValue('rate_thresh_for_multipeak',5);
p.addParamValue('multipeak_max_spacing',0.5);
p.addParamValue('max_abs_field_dist',2);
p.addParamValue('draw',false);
p.parse(varargin{:});
opt = p.Results;

fields = cell(0);
fieldSources = cell(0);
isValid = [];
for c = 1:numel(place_cells.clust)
    place_cells.clust{c} = unrollOutboundInbound(place_cells.clust{c});
    workingClust = place_cells.clust{c};
    nCellField = 0;
    while hasField(workingClust,opt)
        [thisField,thisIsValid,workingClust] = lfunTakeTopField(workingClust,opt);
        fields = [fields, thisField];
        isValid = [isValid,thisIsValid];
        nCellField = nCellField + 1;
    end
    fieldSources = [fieldSources, cmap(@(x) workingClust.name, cell(1,nCellField))];
end
end


function clust = unrollOutboundInbound(clust)
    bc = clust.field.bin_centers;
    lastBin = bc(end);
    db = diff(bc(1:2));
    unfoldedBinCenters = bc + lastBin + db;
    newBinCenters = [bc, unfoldedBinCenters];
    oldOutbound = clust.field.out_rate;
    oldInbound   = clust.field.in_rate;
    newField = [oldOutbound, oldInbound(end:-1:1)];
    clust.field.bin_centers = newBinCenters;
    clust.field.rate = newField;
end

function [topField,isValid,adjClust] = lfunTakeTopField(clust,opt)
    cRate = clust.field.rate;
    topField = zeros(size(cRate));
    isValid = true;
    adjClust = clust;
    peakP = clust.field.bin_centers(cRate == max(cRate));
    peakP = peakP(1);
    iPeak = find(cRate == max(cRate),1,'first');
    i = iPeak;
    while i <= numel(cRate) && cRate(i) > opt.rate_thresh_for_multipeak
        topField(i) = cRate(i);
        cRate(i) = 0;
        i = i + 1;
    end
    i = iPeak - 1;
    while i >= 1 && cRate(i) > opt.rate_thresh_for_multipeak
        topField(i) = cRate(i);
        cRate(i) = 0;
        i = i - 1;
    end
    adjClust.field.rate = cRate;
end

function b = hasField(clust,opt)
    b = max(clust.field.rate) > opt.min_peak_rate_thresh;
end
