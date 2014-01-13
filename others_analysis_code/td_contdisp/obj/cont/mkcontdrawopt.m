function dopt = mkcontdrawopt(varargin)
% MKCONTDRAWOPT make display structure for contstructs
%
% $$$    -contdrawopt
% $$$      -plottype {'line', 'area', 'image'}
% $$$      -dispname - name to be displayed
% $$$      -areazero value to use for base of area plot (0) 
% $$$      -color
% $$$      -linestyle
% $$$      -datalim - limits of data to be plotted (ylim for 1-D data, clim for 2-D data)
% $$$      -levels - e.g. threshold lines for 1-D data
% $$$      -levelscolf - dim color of levels relative to data plot (0.7)
% $$$      -cmap - colormap for 2d data ([] = hot(64))
% $$$      -cmapwin - indexes of start and end of colormap region to use ([] = use all)
%
% color and linestyle args get used as colororder and linestyleorder for
% 'line' plots with multiple columns of data.
  
  dopt = struct(...
      'plottype', [],... % guess based on data
      'subsample', true,...
      'dispname', [],...
      'color', [],... 
      'linestyle', {{'-','--',':','-.'}},... 
      'datalim', [],...
      'levels', [],...
      'levelscolf', 0.7,...
      'cmap', hot(64),...
      'cmapwin', [],...
      'drawlegend', true,...
      'drawxaxis', true,...
      'drawyaxis', true); 

  dopt = parseArgs(varargin,dopt);
  
  if ~isempty(dopt.plottype) && ~any(strcmp(dopt.plottype, ...
                                            {'line' 'area' 'image'})),
    error('unsupported ''plottype''');
  end

  if ~isempty(dopt.datalim) && ~all(size(dopt.datalim) == [1 2]);
    error('''datalim'' must be 1 x 2 numeric');
  end  
  