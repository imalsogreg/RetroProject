function c = contresamp(c,varargin)
% CONTRESAMP resample data in a cont struct, return new cont struct
%
%  -does appropriate filtering, intelligently chooses decimate rather than
%  upfirdn when possible.
%
%  -upsampling not well tested
%
% 
% param/value pair args:
%
%  'resample', fraction to up/downsample signal
  
  a = struct(...
      'resample',[],...
      'tol', 0.001,...
      'res_filtlen', 10);
  
  a = parseArgsLite(varargin,a);

  % keep it, for later
  datatype = class(c.data);
  [nrows ncols] = size(c.data);
  
  if ~isempty(a.resample),
    
    if a.resample > 1,
      warning('upsampling not well tested');
    end
    
    if abs(1/a.resample-fix(1/a.resample)) <= eps
      % integer factor, we can use decimate
      dec_f = floor(1/a.resample);
      res_f = 1/dec_f;
      
      % use a 30-pt FIR filter to conserve memory (decimate usually uses
      % IIR/filtfilt)
      filtlen = 30; % the default for decimate, just being explicit
      
      % pre-allocate, preserve datatype of c.data
      data_dec = zeros(ceil(nrows/dec_f), ncols, datatype);
      disp('decimating...');
      for col = 1:ncols,
        data_dec(:,col) = decimate(c.data(:,col),dec_f,filtlen,'fir');
      end
      c.data = data_dec;
      clear data_dec;
      
      c.samplerate = c.samplerate/dec_f;

      %% decimate has 0 group delay (i.e. first point represents same
      %start time), but since it takes every 'rth' point, the last sample
      %in the sequence will likely not be from the same time as the last
      %sample in the input. Recalculate its time from the samplerate
      c.tend = c.tstart + (size(c.data,1) ./c.samplerate);
      
    else
      
      % 'resample'
      % use a wider tolerance than default (1e-6) to get smaller terms
      % for resampling.
      [res_num res_den] = rat(a.resample, a.resample.*a.tol);
      res_f = res_num/res_den;
      
      filtlen = a.res_filtlen;
      
      % pre-allocate
      data_res = zeros(ceil(nrows*res_f), ncols);
      for col = 1:ncols,
        disp('resampling...');
        % upfirdn (called by resample) can't handle single type data. bug
        % filed with mathworks 11/14/06, confirmed by MW as fixed in R14SP2)
        data_res(:,col) = resample(double(c.data(:,col)),res_num,res_den,filtlen);
      end
      c.data = cast(data_res,datatype); % back to original data type
      clear data_res;
      
      % we could also recalc this by determining where new tend is (old tend -
      % some samples). But for, e.g. 1e7 samples, at around 1kHz, float
      % error is around 1e-6, i.e. 1 microsecond, and this is way simpler. I
      % think we're okay.
      c.samplerate = c.samplerate*res_f;
      
      % for resample, the filtlen param is proportional to the length filter
      % used. doc/help resample say filtlen samples of *input* are used, so
      % we're going to mark as bad that many at start and end, then
      % multiply by 

      
    end
      
    % # of unreliable samples in resampled signal = filter length/dec_f
    c.nbad_start = ceil(c.nbad_start * res_f) + ceil(filtlen * res_f);
    c.nbad_end = ceil(c.nbad_end * res_f) + ceil(filtlen * res_f);

    % calculate new data range
    c = contdatarange(c);

  else
    disp('no resample requested');
  end
    
  