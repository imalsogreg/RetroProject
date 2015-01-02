function [slope,intercept] = heatRegress(xLims,yLims,heats,varargin)

p = inputParser();
%p.addParamValue('nSamples',5000);
%p.addParamValue('draw',false);
p.parse(varargin{:});
opt = p.Results;

maxH = max(max(heats));
minH = min(min(heats));
normalizedHeats = (heats - minH) / (maxH - minH);

nSampsPerBin = opt.nSamples / (numel(heats)) / mean(mean(normalizedHeats));

nRows = size(heats,1);
nCols = size(heats,2);

rowCenters = linspace(yLims(1),yLims(2),nRows);
dRow = mean(diff(rowCenters));
rowEdges = bin_edges_to_centers(rowCenters);
colCenters = linspace(xLims(1),xLims(2),nCols);
dCol = mean(diff(colCenters));
colEdges  = bin_centers_to_edges(colCenters);

sampsInBins = arrayfun(@(x) genSamples(x,nSampsPerBin), normalizedHeats,'UniformOutput',false);

sampsX = nan .* ones(1,opt.nSamples * 10);
sampsY = sampsX;
nAccum = 0;
for r = 1:nRows
    for c = 1:nCols
        thisNSamps = numel(sampsInBins{r,c});
        sampsX(nAccum+1:(nAccum+thisNSamps)) = colCenters(c) .* ones(1,thisNSamps);
        sampsY(nAccum+1:(nAccum+thisNSamps)) = rowCenters(r) .* ones(1,thisNSamps);
        nAccum = nAccum + thisNSamps;
    end
end
sampsX = sampsX(1:nAccum);
sampsY = sampsY(1:nAccum);

sampsX = sampsX + dCol/5.*randn(1,numel(sampsX));
sampsY = sampsY + dRow/5.*randn(1,numel(sampsY));

b = regress(sampsY', [sampsX',ones(size(sampsX'))]);
slope = b(1);
intercept = b(2);

if(opt.draw)
   imagesc(xLims,yLims,heats);
   hold on;
   set(gca,'YDir','normal');
   plot(sampsX,sampsY,'.');
end

end

function samps = genSamples(prob, nSampsPerBin)

  samps = rand(1,ceil(nSampsPerBin));
  samps = samps(samps <= prob);

end
