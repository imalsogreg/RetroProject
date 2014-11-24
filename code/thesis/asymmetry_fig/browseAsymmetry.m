function f = browseAsymmetry(d)

    f = figure('KeyPressFcn',@keyCallback);

    gd.i = 1;
    gd.fields       = get_fields(d.spikes);
    gd.sourceTrodes = cmap(@(x) x(6:7), gd.fields.clust)
    gd.handles = guihandles(f);

    guidata(f,gd);

end

function keyCallback(f,e)

    gd = guidata(f);

    if(strcmp(e.Key,'uparrow'))
        gd = max(gd-1,1);
    elseif(strcmp(e.key,'downarrow'))
        gd = min(gd + 1, numel(gd.fields));
    end

    guidata(f,gd);
    myDraw(f,gd);

end

function myDraw(f,gd)
    
    figure(f);
    subplot(1,2,1);
    draw_trodes(gd.rat_conv_table,'trode_groups',gd.trode_groups,...
        'highlight_names',gd.sourceTrodes(gd.i));
    hold off;

    subplot(1,2,2);
    clust = gd.fields.clust(gd.i);
    nBins = numel(clust.bin_centers);
    xs = clust.bin_centers(1:(nBins/2));
    ys = clust.rate(1:(nBins/2)) + clust.rate(end:-1:(nBins/2 + 1));
    plot( xs, clust.out_run_rate, 'b' );
    hold on;
    plot( xs, clust.in_run_rate, 'r' );
    area(xs,ys);
    
end