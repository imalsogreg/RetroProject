function f = scatterFigure(d,m,varargin)

    p = inputParser();
    p.addParamValue('exampleData',defaultExampleData(d,m));
    p.addParamValue('fieldDists',[]);
    p.addParamValue('timeDists',[]);
    p.addParamValue('anatomyDists',[]);
    p.addParamValue('fieldCells',[]);
    p.addParamValue('fields',[]);
    p.addParamValue('xcorr_mat',[]);
    p.parse(varargin{:});
    opt = p.Results;
    
    if(isempty(opt.fieldDists) || isempty(opt.timeDists) || ...
            isempty(opt.anatomyDists) || isempty(opt.fieldCells) || ...
            isempty(opt.fields) || isempty(opt.xcorr_mat))
        [X_reg, y_reg, field_dists, anatomical_dists, xcorr_dists, field_cells, fields, xcorr_r, xcorr_mat, ~] = ...
            full_xcorr_analysis(d,m, ...
            'ok_directions',opt.exampleData.ok_directions,'ok_pair',opt.exampleData.okPair,'draw',false);
    else
        field_cells      = opt.fieldCells;
        fields           = opt.fields;
        xcorr_dists      = opt.timeDists;
        field_dists      = opt.fieldDists;
        anatomical_dists = opt.anatomyDists;
        xcorr_mat        = opt.xcorr_mat;
    end
    
    f = figure('Color','white');
    n = numel(opt.exampleData.fields);
    for i = 1:n
        thisFieldInd = opt.exampleData.fields(i);
        thisCellName = field_cells(thisFieldInd);
        subplot(n,3,3*(i-1)+1);
        plotField(thisCellName, d, fields, ...
            opt.exampleData.fields(i));
        hold on;
        for j = 1:size(opt.exampleData.rasterTWins,2);
            ax(3*(i-1)+1 + (j-1)) = subplot(n,3,3*(i-1)+1 + j);
            plotRaster(thisCellName, d, opt.exampleData.rasterTWins(:,j));
        end
    end
    %linkaxes(ax,'x');
    
    figure('Color',[1,1,1]);
    pairs  = [1,2; 1,3; 2,3];
    nPairs = size(pairs,2);
    for n = 1:nPairs
        thisPair = pairs(n,:);
        subplot(3,nPairs,(n*(nPairs-1))+1);
        text(0,0,num2str(field_dists(thisPair(1),thisPair(2))));
        subplot(3,nPairs,(n*(nPairs-1))+2);
        plotXCorr(xcorr_mat,thisPair(1),thisPair(2));
        subplot(3,nPairs,(n*(nPairs-1))+3);
    end
    
    
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

function plotXCorr(xcorrMat,m,n)
    % Do this!
end

function dat = defaultExampleData(d,m)
    if(strContains(m.pFileName,'caillou'))
        dat.fields = [11,22,14];
        dat.ok_directions = {'outbound'};
        dat.okPair = 'medial,lateral';
        dat.rasterTWins = [5645.5, 5647.5; 5809.2,5809.9]';
    else
        error('scatterFigure:noNameMatch',['No default fields for ', m.pFileName]);
    end
end


function b = strContains(s,target)

    b = ~isempty(regexp(s,target,'ONCE'));

end