function c = contenv (c,varargin)
% CONTENV get the signal envelope
  
  a = struct(...
      'envopt',[]);
  
  a = parseArgsLite(varargin,a);

  if isempty(a.envopt),
    disp('no envelope method requested, using mkenvopt defaults')
    a.envopt = mkenvopt;
  end
  
  [nsamps nchans] = size(c.data); %#ok
  
  disp('calculating envelope...');

  switch(a.envopt.method)
   case 'hilbert',
    % since hilbert is IIR, we need to handle NaN's specially
    if nchans > 1,
      error('hilbert envelope currently only supports one channel');
    end
    notnani = ~isnan(c.data);
    % hilbert seems to be buggy with 'single' data
    c.data(notnani) = cast(abs(hilbert(double(c.data(notnani)))), class(c.data));
    suffix = 'env_hilb';
    
   case 'hilbert_complex',
    % hilbert seems to be buggy with 'single' data
    c.data = cast(hilbert(double(c.data)), class(c.data));
    suffix = 'env_hilbc';
    
   case 'peaks',
    % localmax works across columns
    % find all minima and maxima
    pks_idx = localmax(c.data);
    pks_idx = pks_idx | localmax(-c.data);
    
    for k = 1:nchans,
      % save some memory, maybe
      cdata_type = class(c.data);
      c.data(:,k) = interp1q(cast(find(pks_idx(:,k)), cdata_type), abs(c.data(pks_idx(:,k),k)), cast((1:nsamps)',cdata_type));
    end
    
    suffix = 'env_pks';
    
   case 'rms', 
    if isempty(a.envopt.rms_window_t),
      error('''rms_window_t'' must be provided for ''rms'' method');
    end
    
    if a.envopt.rms_window_t < (1.5/c.samplerate)
      warning(['rms window will be 1 sample or less, returning original ' ...
               'signal']);
    else
      % do RMS:
      % 1) Square signal
      c.data = c.data.^2;
      % 2) calculate moving Mean of squared signal
      c = contfilt(c, 'filtopt', mkfiltopt('name', 'rms_averaging',...
                                           'filttype', 'rectwin',...
                                           'length_t', a.envopt.rms_window_t));
      % 3) return Root of mean squared signal
      c.data = sqrt(c.data);
    end
    suffix = ['_rms_' num2str(a.envopt.rms_window_t*1000) 'ms'];
    
   otherwise
    error('unsupported envelope ''method''');
  end

  % create new chanlabels
  
  if ~isempty(c.chanlabels),  
    for k = 1:nchans,
      c.chanlabels{k} = [c.chanlabels{k} suffix];
    end
  end
  
  % update data range
  c = contdatarange(c);
  
  
