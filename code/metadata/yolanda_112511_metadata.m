function m = metadata()

% Notes: see notes.txt

m.today = '112511';
m.basePath = ['~/Data/yolanda/',m.today];
m.loadTimewin = [4893 5834];  % Run only
m.checkedArteCorrectionFactor = false;
m.rat_conv_table = yolanda_rat_conv_table;
m.arteCorrectionFactor = 0;

% Position
m.pFileName = [m.basePath,'/l',m.today(3:4),'.p'];
m.linearize_opts.circular_track = false;
m.linearize_opts.calibrate_length = 0.78;
%m.linearize_opts.click_points = ...
% [139.8618  242.6267  251.8433  258.7558  261.0599  253.2258  246.7742  238.4793  226.9585  214.0553  203.4562  196.0829  194.2396  199.7696  198.8479  191.4747 181.7972  168.4332  155.5300  144.4700  137.0968  135.7143  131.5668; ...
%  33.2602   42.7632   47.1491   56.6520   69.8099  195.5409  209.4298  216.7398  223.3187  220.3947  213.8158  199.9269  188.9620  131.9444  115.8626  104.1667 96.8567   95.3947   98.3187  103.4357  115.1316  120.9795  214.5468
%]';
m.linearize_opts.click_points = ...
    [134.3141  141.2961  148.4484  156.2819  163.9451  171.4380  177.7389  186.4238  194.9385  203.9640  212.6490  220.4825  227.1239  233.7654  241.7692  247.2185 253.5194  257.7767  259.9905  261.0123  260.6717  260.3311  259.8202  259.3094  259.1391  258.6282  257.7767  256.2441  254.0303  250.2838  246.0265  241.4286 236.1495  230.3595  224.5695  217.0766  210.9461  206.6887  202.0908  198.6850  196.3009  196.3009  198.3444  199.7067  200.3879  200.3879  197.3226  192.2138 185.2318  177.9092  173.1410  165.9886  159.8581  151.5137  147.0861  142.4882  139.0823  137.0388  135.1656  134.3141  134.1438  133.9735  133.6329  133.2923  133.6329  133.6329; ...
    26.9397   26.9397   28.2328   29.0948   29.0948   30.3879   30.8190   31.6810   31.6810   33.8362   34.6983   34.6983   35.9914   37.2845   38.5776   41.1638  45.9052   52.3707   60.5603   70.9052   83.8362   99.7845  114.8707  131.2500  143.3190  156.6810  172.1983  183.4052  194.1810  202.8017  208.8362  212.7155  216.5948  218.7500  218.7500  217.4569  214.4397  211.4224  206.2500  198.9224  189.8707  179.9569  167.0259  150.2155  139.4397  127.8017  117.4569  106.6810  97.6293   94.1810   94.1810   94.1810   95.4741   96.3362   99.3534  103.2328  107.1121  117.0259  129.5259  142.0259  154.5259  168.7500  181.6810  195.4741  210.1293  217.4569 ...
    ]';       
m.linearize_opts.calibrate_points = [ 134.7  257.8; ...
                                      134.1  145.8];


m.mua_filelist_fn = @yolanda_mua_filelist;
m.trode_groups_fn = @yolanda_trode_groups;
m.trode_groups = m.trode_groups_fn('date',m.today,'segment_style','areas');

m.ad_tts = {'24','23','22','21','20','19','17','16','15','29','02','28','11','26','08','06'};

m.arte_tts = {'05','04','03','09','01'};

m.systemList = {'ad','ad','arte'};

m.f1File   = 'j25.eeg';
m.f1TrodeLabels = {'24','23','22','21','20','19','17','16'};
m.f1Inds   = 1:8;
m.f2File   = 'k25.eeg';
m.f2TrodeLabels = {'15','29','02','28','11','26','08','06'};
m.f2Inds   = 1:8;

m.f3File = 'arte_lfp0.eeg';
m.f3Inds = [2:6];
m.f3TrodeLabels = {'05','04','03','09','01'};

m.singleThetaChan = '24';

% MUA
m.keepGroups = {'CA1','CA3'};
m.width_window = [-Inf,Inf];
m.threshold = 150;

% Place cells
m.keep_list = [ 4     7     9    11    13    15    16    17    21    24 ...
               25    27    28    31    33    34    36    38 ...
               40    41    43    44    45    46    48    49    50 ...
               52    53    54    55    56    60    61    62    64    65 ...
               69    71    72    73    74    75    76    77    79    81 ...
               83    86    90 ];


