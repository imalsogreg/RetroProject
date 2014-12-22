function f = bothReconstructions()

% TODO - get rid of pre-computed stuff as much as possible
%        or at least make this usable by others w/ the .mat data files
load('/home/greghale/Documents/RetroProject/otherDocuments/rawFigs/decoding.mat');
m = caillou_112812_metadata();
load('/home/greghale/Data/caillou/112812/scatterData.mat');

arteNDecodings = size(decoding,2);
arteNSpatialBins = size(decoding,1);
arteRTau = 0.02;
arteTStart = 4492.0;
arteTEnd   = 4492 + (arteNDecodings - 1)*arteRTau;
arteTsGoal = linspace(arteTStart,arteTEnd,arteNDecodings);

d.tg = m.trode_groups_fn('date',m.today,'semgent_style','areas');
d.tg = d.tg( strcmp( cmap(@(x) x.name, d.tg), 'CA1') );
d.tg{1}.color = [1 1 1];

