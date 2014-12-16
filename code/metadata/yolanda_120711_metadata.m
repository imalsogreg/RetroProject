function m = metadata()

% Notes: see notes.txt

m.today = '120711';
m.basePath = ['~/Data/yolanda/',m.today];
m.loadTimewin = [6199 7048];  % Run only
m.checkedArteCorrectionFactor = false;
m.arteCorrectionFactor = 0;
m.rat_conv_table = yolanda_rat_conv_table();

% Position
m.pFileName = [m.basePath,'/l',m.today(3:4),'.p'];
m.linearize_opts.circular_track = true;
m.linearize_opts.calibrate_length = 0.78;
m.linearize_opts.click_points = ...
 [139.8618  242.6267  251.8433  258.7558  261.0599  253.2258  246.7742  238.4793  226.9585  214.0553  203.4562  196.0829  194.2396  199.7696  198.8479  191.4747 181.7972  168.4332  155.5300  144.4700  137.0968  135.7143  131.5668; ...
  33.2602   42.7632   47.1491   56.6520   69.8099  195.5409  209.4298  216.7398  223.3187  220.3947  213.8158  199.9269  188.9620  131.9444  115.8626  104.1667 96.8567   95.3947   98.3187  103.4357  115.1316  120.9795  214.5468
]';
m.linearize_opts.calibrate_points = [ 134.7  257.8; ...
                                      134.1  145.8];

m.mua_filelist_fn = @yolanda_mua_filelist;
m.trode_groups_fn = @yolanda_trode_groups;
m.trode_groups = m.trode_groups_fn('date',m.today);

m.ad_tts = {'24','23','22','21','20','19','17','16','15','27','11','01','30','28','02','26'};

m.arte_tts = {'08','07','06','05','04','03'};

m.systemList = {'ad','ad','arte'};

m.f1File   = 'j07.eeg';
m.f1TrodeLabels = {'24','23','22','21','20','19','17','16'};
m.f1Inds   = 1:8;
m.f2File   = 'k07.eeg';
m.f2TrodeLabels = {'15','27','11','01','30','28','02','26'};
m.f2Inds   = 1:8;

m.f3File = 'arte_lfp0.eeg';
m.f3Inds = [1:4,7,8];
m.f3TrodeLabels = {'08','07','06','05','04','03'};

m.singleThetaChan = '24';

% MUA
m.keepGroups = {'CA1','CA3'};
m.width_window = [-Inf,Inf];
m.threshold = 150;

% Place cells
m.keep_list = [1 2 9 10 11 13 14 15 16 17 18 20 21 23 ...
               24 26 29 30 31 32 33 36 38 39 40 41 42 ...
               43 44 45 46 49 50 53 54 55 58 59 60 61 ...
               62 64 65 67 69 70 72 74 78 79];
