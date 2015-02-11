function f = swwBarChart(r)

    means  = cellfun(@mean,r);
    n      = cellfun(@numel,r);
    stds   = cellfun(@std,r);
    sterrs = real(stds ./ sqrt(n-1));
    
    [XX,OF] = meshgrid( [1:size(r,2)], [1:size(r,1)]);
    nSeries = size(means,2);
    nLevels = size(means,1);
    
    f = bar(means);
    
    hold on;
    
    arrayfun(@(h,e,i,j) drawError(h,e,nSeries,nLevels,i,j),...
        means,sterrs,XX,OF);

end

function drawError(h,e,m,n,i,j)

    barToBarWidth = 1/(m+1.5);
    x = j + ((i) - (n-1)/2)*barToBarWidth;
    serif_xs = barToBarWidth*[-0.3,0.3] + x;
    stem_xs  = repmat(mean(serif_xs,2),1,2);
    
    serif_top_ys = repmat(h+e,1,2)
    serif_bot_ys = repmat(h-e,1,2);
    stem_ys      = [serif_top_ys(1),serif_bot_ys(1)];

    
    plot(serif_xs, serif_top_ys );
    plot(serif_xs, serif_bot_ys );
    plot(stem_xs,  stem_ys      ); 
end