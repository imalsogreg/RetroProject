function f = browseAsymmetry(d)
    close all;
    f = figure('KeyPressFcn',@keyCallback);
    gd.i = 1;
    [gd.fields, gd.sourceCells,gd.xs,gd.place_cells] = get_fields(d.spikes);
    gd.sourceTrodes = cmap(@(x) x(6:7), gd.sourceCells);
    gd.rat_conv_table = d.rat_conv_table;
    gd.trode_groups = d.trode_groups;
    gd.handles = guihandles(f);

    guidata(f,gd);

end

function keyCallback(f,e)

    gd = guidata(f);

    if(strcmp(e.Key,'uparrow'))
        gd.i = max(gd.i-1,1);
    elseif(strcmp(e.Key,'downarrow'))
        gd.i = min(gd.i + 1, numel(gd.fields));
    end

    guidata(f,gd);
    myDraw(f,gd);

end

function myDraw(f,gd)
    if(isfield(gd,'i'))
    figure(f);
    subplot(1,2,1);
    draw_trodes(gd.rat_conv_table,'trode_groups',gd.trode_groups,...
        'highlight_names',gd.sourceTrodes(gd.i));
    hold off;

    subplot(1,2,2);
    clust = gd.place_cells.clust{gd.i};
    nBins = numel(clust.field.bin_centers);
    xs = clust.field.bin_centers(1:(nBins/2));
    ys = clust.field.rate(1:(nBins/2)) + ...
           clust.field.rate(end:-1:(nBins/2 + 1));
    hold off;
    area(xs,ys);
    hold on;
    plot( xs, clust.field.out_rate, 'b' );
    plot( xs, clust.field.in_rate, 'r' );

    end
end