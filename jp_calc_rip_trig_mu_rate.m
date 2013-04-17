function [samp, ts, setLen] = jp_calc_rip_trig_mu_rate(ripTs, mua, win)


    [startIdx, setLen, setId] = group_events(ripTs, [.5 .25]);
    

    [samp, ts] = meanTriggeredSignal(ripTs, mua.timestamps, mua.rate, win);
        
    
end
% fprintf('\n');
% 
% %%
% f = figure;
% ax = axes('NextPlot', 'add');
% T = ts * 1000;
% c = [0 0 0; .5 0 0; 0 .5 0; 0 0 .5];
% [p, l] = deal([]);
% for i = [1 2 3 4]
%     r = cell2mat({ ripSamp{i,:}}');
%     
%     m = mean(r);
%     e = std(r) * 1.96 / sqrt( size(r,1) );
%     
%     [p(i), l(i)] = error_area_plot(T, m, e, 'Parent', ax);
%     set(p(i),'EdgeColor', 'none', 'FaceColor', c(i,:) + .4);
%     set(l(i), 'color', c(i,:));
%     
%     [~, mIdx] = findpeaks(m);
%     
%     mTs = T(mIdx);
%     mTs = mTs(mTs > 0 & mTs < 200);
%     for j = 1:numel(mTs)
%         line( mTs(j) * [1 1], [min(m), max(m)], 'color', 'k');
%     end
%     
%     
%     set(gca,'XTick', unique([get(gca,'XTick'), mTs]) );
%     
% end
% 
% set(ax,'Xlim', [-200 300]);
% % legend(p, {'All', 'Singlets', 'Doublets', 'Triplets'});
% 
% % plot2svg( sprintf('/data/HPC_RSC/ripple_triggered_%s_mu.svg', upper(fld)) ,gcf);

% end
