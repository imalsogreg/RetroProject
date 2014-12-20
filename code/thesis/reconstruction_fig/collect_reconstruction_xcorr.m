function xc = collect_reconstruction_xcorr()

metadatas = { yolanda_112511_metadata()  ...
            , yolanda_120711_metadata()  ...
            , morpheus_052310_metadata() ...
            , caillou_112812_metadata() };

nSessions = numel(metadatas);
xc = cell(1,nSessions);
        
for i = 1:nSessions
    m = metadatas{i};
    baseData = [m.basePath,'/scatterData.mat'];
    xcData   = [m.basePath,'/rposData.mat'];

    if(exist(baseData))
        d = loadData(m,'segment_style','ml');
        save(baseData,d);
    else
        load(baseData);
    end

    if(exist(xcData))
        [rs,steps] = reconstruction_xcorr_shift(d,m,'medial','lateral', ...
            'only_direction',opt.ratDefault.okDirection );
        save(xcData, 'rs','steps');
    else
        load(xcData);
    end
    
end
end

function dat = defaultData(m)
% Rat-specific config goes here.
    if(strContains(m.basePath,'yolanda') & strContains(m.basePath,'120711'))
         dat.okDirections = {'outbound','inbound'};
    elseif(strContains(m.basePath,'yolanda') && strContains(m.basePath','112511'))
        dat.okDirections = {'outbound','inbound'};
    elseif(strContains(m.basePath,'caillou'))
        dat.okDirections = {'outbound'};
    elseif(strContains(m.basePath,'morpheus'))
        dat.okDirections = {'outbound','inbound'};
    else
        error('collect_reconstruction_xcorr:unknown_rat',...
            ['couldn''t get data for recording session at ',m.basePath]);
    end
end

