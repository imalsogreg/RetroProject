function g = trode_group( tName, trode_groups )

g = trode_groups{ cellfun(@(x) any(strcmp(x.trodes, tName)), trode_groups) };