function eeg_r = contchans_r(eeg_r,varargin)

eeg_r.raw = contchans(eeg_r.raw,varargin{:});
eeg_r.theta = contchans(eeg_r.theta,varargin{:});
eeg_r.phase = contchans(eeg_r.phase,varargin{:});
eeg_r.env = contchans(eeg_r.env,varargin{:});

