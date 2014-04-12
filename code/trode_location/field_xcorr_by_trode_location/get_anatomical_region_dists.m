function dists_mat = get_anatomical_region_dists(place_cells, field_cells, trode_groups, varargin)

% A THIRD copy-paste of the monkeypatch. I have no discipline...
pcNames = cmap(@(x) x.name, place_cells.clust);
inds = zeros(1,numel(field_cells));
for n = 1:numel(inds)
        inds(n) = find(strcmp(field_cells{n},pcNames),1,'first');
end
place_cells.clust = place_cells.clust(inds);

group_names = cmap(@(x) x.name, trode_groups);
dists_mat = zeros(numel(group_names),numel(group_names));
for r = 1:numel(place_cells.clust)
    for c = 1:numel(place_cells.clust)
        if r == c
            dists_mat(r,c) = NaN;
        else
            dists_mat(r,c) = lfun_area_pair_code(place_cells.clust{r}, ...
                                                              place_cells.clust{c},...
                                                              trode_groups);
        end
    end
end
end

function r = lfun_area_pair_code(cellA, cellB, trode_groups)
indA = group_of_trode(trode_groups, cellA.comp,'return_val','ind');
indB = group_of_trode(trode_groups, cellB.comp,'return_val','ind');
if (numel(indA) == 1 && numel(indB) == 1)
    r = indB - indA;
else
    error('lfun_area_pair_code:too_many_matches',...
        'Cell matched O or mulitple trode group areas');
end
end