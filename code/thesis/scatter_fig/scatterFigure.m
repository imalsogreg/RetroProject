function f = scatterFigure(d,m,varargin)

    p = inputParser();
    p.addParamValue('exampleData',defaultExampleData(d,m));
    p.addParamValue('fieldDists',[]);
    p.addParamValue('timeDists',[]);
    p.addParamValue('anatomyDists',[]);
    p.addParamValue('fieldCells',[]);
    p.addParamValue('fields',[]);
    p.addParamValue('xcorr_mat',[]);
    p.addParamValue('X_reg',[]);
    p.addParamValue('y_reg',[]);
    p.addParamValue('lags',[]);
    p.addParamValue('okPairs',[]);
    %p.addParamValue('dFieldLims',[-1,1]);
    %p.addParamValue('dAnatomyLims',[-2,2]);
    p.parse(varargin{:});
    opt = p.Results;
    
    if(isempty(opt.fieldDists) || isempty(opt.timeDists) || ...
            isempty(opt.anatomyDists) || isempty(opt.fieldCells) || ...
            isempty(opt.fields) || isempty(opt.xcorr_mat) || ...
            isempty(opt.lags) || isempty(opt.X_reg) || ...
            isempty(opt.y_reg) )
        d.trode_groups = m.trode_groups_fn('date',m.today,'segment_style',opt.exampleData.trode_groups_style);
        [X_reg, y_reg, field_dists, anatomical_dists, xcorr_dists, field_cells, fields, xcorr_r, xcorr_mat, lags, okPairs, ~] = ...
            full_xcorr_analysis(d,m, ...
            'ok_directions',opt.exampleData.ok_directions,'ok_pair',opt.exampleData.okPair,'draw',false);
    else
        field_cells      = opt.fieldCells;
        fields           = opt.fields;
        xcorr_dists      = opt.timeDists;
        field_dists      = opt.fieldDists;
        anatomical_dists = opt.anatomyDists;
        xcorr_mat        = opt.xcorr_mat;
        lags             = opt.lags;
        X_reg            = opt.X_reg;
        y_reg            = opt.y_reg;
        okPairs          = opt.okPairs;
    end
    
    f = figure('Color','white');
    n = numel(opt.exampleData.fields);
    for i = 1:n
        thisFieldInd = opt.exampleData.fields(i);
        thisCellName = field_cells(thisFieldInd);
        subplot(n,3,3*(i-1)+1);
%        plotField(thisCellName, d, fields, ...
%            opt.exampleData.fields(i));
        hold on;
        for j = 1:size(opt.exampleData.rasterTWins,2);
            ax(3*(i-1)+1 + (j-1)) = subplot(n,3,3*(i-1)+1 + j);
            plotRaster(thisCellName, d, opt.exampleData.rasterTWins(:,j));
        end
    end
    
    figure('Color',[1,1,1]);
    pairs  = opt.exampleData.fields([1,2; 1,3; 2,3]);
    nPairs = size(pairs,1);
    for n = 1:nPairs
        thisPair = pairs(n,:);
        subplot(3,nPairs,(n));
        text(0,0,num2str(field_dists(thisPair(1),thisPair(2))));
        subplot(3,nPairs,(nPairs+n));
%        plotXCorr(xcorr_mat,lags,thisPair(1),thisPair(2));
        subplot(3,nPairs,(2*nPairs)+n);
        text(0,0,num2str(anatomical_dists(thisPair(1),thisPair(2))));
    end
    
    figure('Color',[1,1,1]);
    drawScatter(field_dists,anatomical_dists,xcorr_dists,X_reg,y_reg,...
        pairs,okPairs,opt);
    a = 1;
end

function drawScatter(fDists,aDists,xDists,X_reg,y_reg,pairs,okPairs,opt)

    nPairs = size(pairs,1);
    for p = 1:nPairs
        exampleFDist(1,p) = fDists(pairs(p,1),pairs(p,2));
        exampleADist(1,p) = aDists(pairs(p,1),pairs(p,2));
        exampleXDist(1,p) = xDists(pairs(p,1),pairs(p,2));
    end
    fDists(~okPairs) = NaN;
    aDists(~okPairs) = NaN;
    xDists(~okPairs) = NaN;
    fDists=reshape(fDists,1,[]);
    aDists=reshape(aDists,1,[]);
    xDists=reshape(xDists,1,[]);
    okB = not (isnan(fDists) | isnan(aDists) | isnan(xDists));
    fDists=fDists(okB);
    aDists=aDists(okB);
    xDists=xDists(okB);
    plot3(fDists,aDists,xDists,'.','Color',[0.8,0.8,0.8],'MarkerSize',32);
    hold on;    
    dFieldLims = xlim();
    dAnatomyLims = ylim();
    plot3(fDists,dAnatomyLims(1)*ones(size(fDists)), xDists,'b.');
    plot3(dFieldLims(1)*ones(size(aDists)), aDists, xDists,'r.');
    plot3(exampleFDist,exampleADist,exampleXDist,'o','MarkerSize',32);
    pairLabels = {'A vs. B', 'A vs. C', 'B vs. C'};
    for p = 1:nPairs
        text(exampleFDist(1,p),exampleADist(1,p),exampleXDist(1,p),...
            pairLabels{p});
        plot3([exampleFDist(1,p),exampleFDist(1,p)],...
              [exampleADist(1,p),dAnatomyLims(1)],...
              [exampleXDist(1,p),exampleXDist(1,p)],'--');
        plot3([exampleFDist(1,p),dFieldLims(1)],...
              [exampleADist(1,p),exampleADist(1,p)],...
              [exampleXDist(1,p),exampleXDist(1,p)],'--');
    end
    xlabel('Field Dist'); ylabel('Anatomy Dist'); zlabel('Time Dist');
    
    [b,bint,r,rint,stats] = regress(xDists', [fDists', aDists',ones(size(fDists'))]);
    
    xs = linspace(dFieldLims(1)/3,dFieldLims(2)/3,2);
    plot3(xs,dAnatomyLims(1)*ones(size(xs)),b(3)+ b(1)*xs,'b','LineWidth',3);
    xs = linspace(dAnatomyLims(1)/2, dAnatomyLims(2)/2, 2);
    plot3(dFieldLims(1)*ones(size(xs)),xs,b(3) + b(2)*xs,'r','LineWidth',3);
    b
    bint
    r
    rint
    stats
    
end

function plotField(cellName, d, fields, fieldInd)

    thisClust = sdatslice(d.spikes,'names',{cellName});
    thisField = fields{fieldInd};
    domain = d.spikes.clust{1}.field.bin_centers;
    nBin = numel(domain);
    rangeBack  = thisClust.clust{1}.field.out_rate;
    rangeFront = thisField(1:nBin);
    if(max(rangeFront) == 0)
        rangeBack  = thisClust.clust{1}.field.in_rate;
        rangeFront = thisClust.clust{1}.field((nBin+1):end);
    end
    plot(domain,0,'-k');
    hold on;
    area(domain,rangeBack,'FaceColor',[0.7,0.7,0.7]);
    area(domain(rangeFront>0),rangeBack(rangeFront > 0));
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);

end

function plotRaster(cellName, d, tWin)
    thisClust = sdatslice(d.spikes,'names',{cellName});
    thisSpikes = thisClust.clust{1}.stimes;
    thisSpikes = thisSpikes(thisSpikes >= min(tWin) & thisSpikes <= max(tWin));
    [xs,ys] = gh_raster_points(thisSpikes);
    plot(xs,ys);
    xlim(tWin);
    ylim([-0.5,1.5]);
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);
end

function plotXCorr(xcorrMat,lags,m,n)
    thisXCorr = xcorrMat{m,n};
    plot(lags,thisXCorr);
    hold on;
    mInd = find(thisXCorr == max(thisXCorr), 1, 'first');
    maxX = lags(mInd);
    maxY = thisXCorr(mInd);
    plot(lags(mInd),maxY*1.1,'v');
    ylim([0,maxY*1.2]);
    text(lags(mInd),maxY*1.1,[num2str(floor(maxX*1000)),'ms']);
end

function dat = defaultExampleData(d,m)
    if(strContains(m.pFileName,'caillou'))
        dat.fields = [11,15,16];
        dat.ok_directions = {'outbound'};
        %dat.okPair = 'medial,lateral';
        dat.okPair = 'CA1,CA1';  % Pair-restriction is only for CA3/CA1
        dat.rasterTWins = [5645.5, 5647.5; 5809.2,5809.9]';
        dat.trode_groups_style = 'areas';
    elseif(strContains(m.pFileName,'yolanda'))
        dat.fields=[1,2,3];
        dat.ok_directions = {'outbound','inbound'};
        dat.okPair = 'CA1,CA1';
        dat.rasterTWins = [5000,5001; 5002,5003]; % TODO fix
        dat.trode_groups_style = 'areas';
    else
        error('scatterFigure:noNameMatch',['No default fields for ', m.pFileName]);
    end
end


function b = strContains(s,target)

    b = ~isempty(regexp(s,target,'ONCE'));

end