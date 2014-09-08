function [ rs,steps ] = reconstruction_xcorr_shift(d,m,area0,areaTau, varargin )
%RECONSTRUCTION_XCORR_SHIFT Slide one rpos wrt the other, check correlation
% at each shift
p = inputParser();
p.addParamValue('xcorr_range',0.2);
p.addParamValue('xcorr_step', 0.005);
p.addParamValue('r_tau',0.010);
p.addParamValue('only_direction',[]);
p.parse(varargin{:});
opt = p.Results;

placeCells0   = placeCellsOfGroup(d.spikes, area0,   d.trode_groups);
placeCellsTau = placeCellsOfGroup(d.spikes, areaTau, d.trode_groups);

% Do one pass just to get the trigger times
throwawayRpos = gh_decode_pos(placeCells0,d.pos_info,'r_tau',opt.r_tau);
[~,trigTimes] = gh_triggered_reconstruction(throwawayRpos,d.pos_info);
rposTrig0 = triggeredBidirectTimeshift(placeCells0,d.pos_info);
rTimewin = [min(d.pos_info.timestamp),max(d.pos_info.timestamp)];
steps = -opt.xcorr_range : opt.xcorr_step : opt.xcorr_range;

rs = arrayfun(@(s) triggeredBidirectTimeshift(placeCellsTau,posInfo,s,...
    trigTimes,opt.r_tau,rTimewin,opt.only_direction,rposTrig0));

end


function r2 = triggeredBidirectTimeshift(placeCells,posInfo,tDelay,trigTimes,rTau,rTimewin,onlyDir,trigRPos0)

    rpOut = gh_decode_pos(placeCells,posInfo,'r_tau',rTau,'r_timewin',rTimewin+tDelay,'field_direction','outbound');
    rpIn  = gh_decode_pos(placeCells,posInfo,'r_tau',rTau,'r_timewin',rTimewin+tDelay,'field_direction','inbound');

    rpTrigOut = gh_triggered_reconstruction(rpOut,posInfo,'min_vel', min_vel,'trig_times',trigTimes);
    rpTrigIn  = gh_triggered_reconstruction(rpIn, posInfo,'min_vel',-min_vel,'trig_times',trigTimes);

    if(strcmp(onlyDir,'outbound'))
        rpTrig = rpTrigOut;
    elseif(strcmp(onlyDir,'inbound'))
        rpTrig = rpTrigIn;
    elseif(isempty(onlyDir))
        rpTrig = rpTrigOut;
        for n = 1:numel(rpTrig)
            rpTrig(n).pdf_by_t = rpTrig(n).pdf_by_t + rpTrigIn(n).pdf_by_t(end:-1:1,:);
        end
    else
        error('reconstruction_xcorr_shift:unrecognizedOnlyDirection',...
            ['Didn''t recognize only_direction option:',onlyDir]);
    end
    
    r2 = corr(reshape(trigRPos0,[],1), reshape(rpTrig,[],1));
    
end

function pc = placeCellsOfGroup(pc0, groupName, trodeGroups)
    groupNames = cmap(@(x) x.name,trodeGroups);
    groupInd = find(strcmp(groupNames,groupName),1);
    if(isempty(groupInd))
        error('reconstructoin_xcorr_shift:noGroup',...
            ['Found no trode group named ',groupName]);
    end
    group = trodeGroups{groupInd};
    inds = group.trodes;
    pc = sdatslice(pc0,'trodes',inds);

end