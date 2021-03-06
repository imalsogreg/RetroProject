function mua_list = jk_mua_filelist()

base_path = '/home/greghale/JK/100808';
day = '08';
%base_path = '/home/greghale/JK/092708';
%base_path = '/home/greghale/JK/092508';

mua_list.file_list = {[base_path, '/a1',day,'/a1',day,'.pxyabw'],...
    [base_path, '/a2',day,'/a2',day,'.pxyabw'],...
    [base_path, '/b1',day,'/b1',day,'.pxyabw'],...
    [base_path, '/b2',day,'/b2',day,'.pxyabw'],...
    [base_path, '/c1',day,'/c1',day,'.pxyabw'],...
    [base_path, '/c2',day,'/c2',day,'.pxyabw'],...
    [base_path, '/d1',day,'/d1',day,'.pxyabw'],...
    [base_path, '/d2',day,'/d2',day,'.pxyabw'],...
    [base_path, '/e1',day,'/e1',day,'.pxyabw'],...
    [base_path, '/e2',day,'/e2',day,'.pxyabw'],...
    [base_path, '/f1',day,'/f1',day,'.pxyabw'],...
    [base_path, '/f2',day,'/f2',day,'.pxyabw'],...
    };

mua_list.comp_list = {'a1','a2','b1','b2','c1','c2','d1','d2','g1','g2','f1','f2'};