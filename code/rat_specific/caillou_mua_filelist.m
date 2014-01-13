function mua_list = caillou_mua_filelist(comp_list,date)

base_path = ['~/Data/caillou/',date];
day = date(3:4);

mua_list.file_list = {...
    [base_path, '/01',day,'/01',day,'.pxyabw'],...
    [base_path, '/02',day,'/02',day,'.pxyabw'],...
    [base_path, '/03',day,'/03',day,'.pxyabw'],...
    [base_path, '/04',day,'/04',day,'.pxyabw'],...
    [base_path, '/05',day,'/05',day,'.pxyabw'],...
    [base_path, '/06',day,'/06',day,'.pxyabw'],...
    [base_path, '/07',day,'/07',day,'.pxyabw'],...
    [base_path, '/08',day,'/08',day,'.pxyabw'],...
    [base_path, '/09',day,'/09',day,'.pxyabw'],...
    [base_path, '/10',day,'/10',day,'.pxyabw'],...
    [base_path, '/11',day,'/11',day,'.pxyabw'],...
    [base_path, '/12',day,'/12',day,'.pxyabw'],...
    [base_path, '/13',day,'/13',day,'.pxyabw'],...
    [base_path, '/14',day,'/14',day,'.pxyabw'],...
    [base_path, '/15',day,'/15',day,'.pxyabw'],...
    [base_path, '/16',day,'/16',day,'.pxyabw'],...
    [base_path, '/17',day,'/17',day,'.pxyabw'],...
    [base_path, '/18',day,'/18',day,'.pxyabw'],...
    [base_path, '/19',day,'/19',day,'.pxyabw'],...
    [base_path, '/20',day,'/20',day,'.pxyabw'],...
    [base_path, '/21',day,'/21',day,'.pxyabw'],...
    [base_path, '/22',day,'/22',day,'.pxyabw'],...
    [base_path, '/23',day,'/23',day,'.pxyabw'],...
    [base_path, '/24',day,'/24',day,'.pxyabw'],...
    [base_path, '/25',day,'/25',day,'.pxyabw'],...
    [base_path, '/26',day,'/26',day,'.pxyabw'],...
    [base_path, '/27',day,'/27',day,'.pxyabw'],...
    [base_path, '/28',day,'/28',day,'.pxyabw'],...
    [base_path, '/29',day,'/29',day,'.pxyabw'],...
    [base_path, '/30',day,'/30',day,'.pxyabw'],...
    };

mua_list.comp_list = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'};

if(not(isempty(comp_list)))
keep_comp = ones(1,numel(mua_list.comp_list));
    for i = 1:numel(mua_list.comp_list)
        keep_comp(i) = sum(strcmp(mua_list.comp_list{i},comp_list));
        if(keep_comp(i) > 1)
            error('rat_mua_filelist:comp_list_error',['comp ',mua_list.comp_list{i},' matched more than one comp in internal comp_list.']);
        end
    end
    keep_comp

    mua_list.comp_list = mua_list.comp_list(logical(keep_comp))
    mua_list.file_list = mua_list.file_list(logical(keep_comp))
    for i = 1:numel(comp_list)
        if(~any(strcmp(comp_list{i}, mua_list.comp_list)))
            error('rat_mua_filelist:no_comp_match',['comp from complist: ', comp_list{i},' did not match any comps in internal comp_list.']);
        end
    end
end