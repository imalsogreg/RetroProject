function f = arte_time_plots()

slowPath = '~/Documents/RetroProject/thesis/rawFigs/laptopRunTS.mat';
fastPath = '~/Documents/RetroProject/thesis/rawFigs/decoding.mat';

load(slowPath);
ts0 = tsGoal(ts);
subplot(2,1,1);
plot(ts0, ts - ts0);
ylim([0,1]);

load(fastPath);
ts0 = tsGoal(ts);
subplot(2,1,2);
plot(ts0, ts - ts0);
ylim([0,0.12]);
end

% Downsample for smaller svg
% Meh, nevermind
function plotOS(xs,ys)
    x  = linspace(xs(1),xs(end),1000);
    ys = smooth(ys,5);
    y  = interp1(xs,ys,x);
    plot(x,y);
end

function ts0 = tsGoal(ts)

   ts0 = [4492:0.02:8000]; % Very caillou/112812 specific
   ts0 = ts0(1:numel(ts));

end