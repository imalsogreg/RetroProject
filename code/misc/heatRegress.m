function [slope,intercept] = heatRegress(xLims,yLims,heats,varargin)

p = inputParser();
p.addParamValue('nSamples',500);
p.parse(varargin{:});
opt = p.Results;

maxH = max(max(heats));
minH = min(min(heats));
normalizedHeats = (heats - minH) / (maxH - minH);

nSampsPerBin = opt.nSamples / (numel(heats)) / sum(sum(normalizedHeats));

nRows = size(heats,1);
nCols = size(heats,2);

rowEdges = linspace(yLims(1),yLims(2),nRows);
dRow = rowEdges(2)-rowEdges(1);
rowCenters = edgesToCenters(rowEdges);
colEdges = linspace(xLims(1),xLims(2),rCols);
dCol = colEdges(2) - colEdges(1);
colCenters = edgesToCetners(colEdges);

sampsInBins = arrayfun(@(x) genSamples(x,nSampsPerBin), normalizedHeats);

sampsX = nan .* ones(1,opt.nSamples * 10);
sampsY = sampsX;
nAccum = 0;
for r = 1:nRows
    for c = 1:nCols
        thisNSamps = numel(sampsInBins{r,c});
        sampsX(nAccum:(nAccum+thisNSamps)) = colCenters(c) .* ones(1,thisNSamps);
        sampsY(nAccum:(nAccum+thisNSamps)) = rowCenters(r) .* ones(1,thisNSamps);
        nAccum = nAccum + thisNSamps;
    end
end
sampsX = sampsX(1:nAccum);
sampsY = sampsY(1:nAccum);

sampsX = sampsX + dCol.*rand(1:numel(sampsX)) - (dCol/2);
sampsY = sampsY + dRow.*rand(1:numel(sampsY)) - (dRow/2);

b = regress(sampsY', [sampsX',ones(size(sampsX'))]);
slope = b(1);
intercept = b(2);

end

function samps = genSamples(prob, nSampsPerBin)

  samps = rand(1,nSampsPerBin);
  samps = samps(samps <= prob);

end
