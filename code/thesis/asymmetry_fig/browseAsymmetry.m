function f = browseAsymmetry(d)
    close all;
    f = figure('KeyPressFcn',@keyCallback);
    gd.i = 1;
    [~, sourceCells,place_cells] = get_fields(d.spikes);
    gd.fields = cmap(@(x) x.field, place_cells.clust);
    gd.sourceTrodes = sourceCells;
    gd.rat_conv_table = d.rat_conv_table;
    gd.trode_groups = d.trode_groups;
    gd.asymmetry = cmap(...
        @(x) fieldAsymmetry(x,x.field.bin_centers,x.field.rate), ...
        place_cells.clust);
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
    gd.i
    gd.sourceTrodes{gd.i}
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
    nBins = numel(gd.fields{gd.i}.bin_centers);
    xs = gd.fields{gd.i}.bin_centers(1:(nBins/2));
    ys_out = gd.fields{gd.i}.rate(1:(nBins/2));
    ys_in  = gd.fields{gd.i}.rate(end:-1:(nBins/2 + 1));
    hold off;
    area(xs,ys_out);
    hold on;
    area(xs,(-1).*ys_in,'FaceColor','r');
    plot( xs, gd.fields{gd.i}.out_rate, 'b' );
    plot( xs, (-1) * gd.fields{gd.i}.in_rate, 'r' );
    ylim([-30,30]);
    title(num2str(gd.asymmetry{gd.i}));
    end
end