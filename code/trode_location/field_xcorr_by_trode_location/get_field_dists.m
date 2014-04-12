function [dists,fieldSources] = get_field_dists(place_cells, varargin)

p = inputParser();
p.addParamValue('method', 'peak', @(x) any(strcmp(x, {'peak', 'xcorr'})));
p.addParamValue('min_peak_rate_thresh', 15);
p.addParamValue('rate_thresh_for_multipeak',5);
p.addParamValue('multipeak_max_spacing',0.5);
p.addParamValue('max_abs_field_dist',2)
p.addParamValue('draw',false);
p.parse(varargin{:});
opt = p.Results;

% THE NEW WAY - Don't make a matrix of place cells.  Make a matrix of place fields
% Unwrap outbound and inbound.  Take xcorr of two fields on the same neuron?  Sure,
% it's fine, because (by definition) they won't have enough of a cross-correlation
% to be included in the final regression
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

binCenters = place_cells.clust{1}.field.bin_centers;

dists = zeros(numel(fields),numel(fields));
if (strcmp(opt.method,'peak'))
    for r = 1:numel(fields)
        for c = (r+1):numel(fields)
              dists(r,c) = distByPeak(binCenters,fields{r},fields{c});
              if( abs(dists(r,c)) > opt.max_abs_field_dist )
                dists(r,c) = NaN;
              end
              dists(c,r) = -1 * dists(r,c);
        end
    end
elseif(strcmp(opt.method,'xcorr'))
    for r = 1:numel(fields)
        for c = (r+1):numel(fields)
          dists(r,c) = distByXcorr(binCenters,fields{r},fields{c});  
        end
    end
else
        error('get_field_dists:method_opt_impossible',...
            'Impossible case');
end

if(opt.draw)
    subplot(1,2,1);
    lfunDraw(place_cells,fields,fieldSources,dists);
    subplot(1,2,2);
    colormap('cool');
    imagesc(dists);
end

end

function dist = distByPeak(binCenters,fieldA,fieldB)
    peakB = binCenters(find(fieldB == max(fieldB),1,'first'));
    peakA = binCenters(find(fieldA == max(fieldA),1,'first'));
%    warning('check comment on next line is true');
    dist = peakA - peakB;  % Distance from B forward to A matches xcorr semantics
end

function dist = distByXcorr(binCenters,fieldA,fieldB)
    db = binCenters(2) - binCenters(1);
    maxb = 2; % 1 meter max lag
    nLags = ceil(maxb / db);
    lagb = [-nLags.*db : db : nLags*db];
    peakA = binCenters( find(fieldA == max(fieldA),1,'first'));
    peakB = binCenters( find(fieldB == max(fieldB),1,'first'));
    if abs(peakB - peakA ) < 1
        x = xcorr(fieldA,fieldB,nLags);
        dist = lagb( find(x == max(x),1,'first'));
    else
        dist = sign(peakB - peakA) * 1;
    end
end

function f = lfunDraw(place_cells,fields,fieldLabels,distsMat)
    bin_centers = place_cells.clust{1}.field.bin_centers;
    
    isDiffName = [0, 1 - strcmp(fieldLabels(1:(end-1)), fieldLabels(2:end))];
    baselines = cumsum(isDiffName);
    colorInd = 1:numel(baselines); % doesn't do what I want
    
    for n = 1:numel(fields)
        area(bin_centers, fields{n} ./ max(fields{n}) + baselines(n) - 1,...
            baselines(n) - 1,'FaceColor',gh_colors(colorInd(n))); hold on;
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
