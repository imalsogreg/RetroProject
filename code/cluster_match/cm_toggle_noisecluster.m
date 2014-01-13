function cm_toggle_noisecluster(f,userdata)

cm_h = guidata(f);
e_sdat = cm_h.e_sdat;
%cm_h.e_sdat;
e_sdat_id = zeros(1,numel(cm_h.e_sdat));
for i = 1:numel(cm_h.e_sdat)
    e_sdat_id(i) = get(cm_h.clust_popup(i),'Value');
end

[selection,ok] = listdlg('ListString',cm_h.enames,'SelectionMode','multiple','ListSize',[160 300],...
    'Name','Epoch Chooser','PromptString','Which epoch?');


for i = 1:numel(e_sdat)
    if(any(selection == i))
        %a = selection
        %b = i
        %c = e_sdat_id(i)
        is_noise = cm_h.e_sdat{i}.clust{e_sdat_id(i)}.is_noise_clust;
        if(isempty(is_noise))
            is_noise = 0;
        end
        cm_h.e_sdat{i}.clust{e_sdat_id(i)}.is_noise_clust = not(is_noise);
        %cm_h.e_sdat{i}.clust{e_sdat_id(i)}.is_interneuron
        
        this_id = e_sdat{i}.clust{e_sdat_id(i)}.tracking_number;
        
        for j = 1:numel(cm_h.sdat.clust)
            if(cm_h.sdat.clust{j}.tracking_number == this_id)
                %disp(['Flipped id: ', num2str(this_id),' name:',cm_h.sdat.clust{j}.name]);
                is_noise = cm_h.sdat.clust{j}.is_noise_clust;
                if(isempty(is_noise));
                    is_noise = 0;
                end
                cm_h.sdat.clust{j}.is_noise_clust = not(is_noise);
                %cm_h.sdat.clust{j}.is_noise_cluster;
            end
        end
    end
end

guidata(f,cm_h);
cm_update_views(f,userdata);