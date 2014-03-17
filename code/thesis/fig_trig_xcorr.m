function rt = fig_trig_xcorr(d,m,varargin)

p = inputParser();
p.addParamValue('r_tau',0.015);
p.addParamValue('min_vel',0.2);
p.parse(varargin{:});
opt = p.Results;

% Get outbound triggered avg
rpos = decode_pos_with_trode_pos(d.spikes,d.pos_info,d.trode_groups,...
   'r_tau',opt.r_tau,'field_direction','outbound');

rtOutbound = gh_triggered_reconstruction(rpos,d.pos_info,'lfp',d.eeg, ...
    'lfp_chan',d.thetaChanInd,'min_vel',opt.min_vel);

% Get inbound triggered avg
rpos = decode_pos_with_trode_pos(d.spikes,d.pos_info,d.trode_groups,...
   'r_tau',opt.r_tau,'field_direction','inbound');

rtInbound = gh_triggered_reconstruction(rpos,d.pos_info,'lfp',d.eeg, ...
    'lfp_chan',d.thetaChanInd,'min_vel',-1 * opt.min_vel);

rt = triggeredReconstructionMergeDirections(rtOutbound,rtInbound);