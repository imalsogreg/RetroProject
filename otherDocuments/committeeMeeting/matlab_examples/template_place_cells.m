function place_cells = template_place_cells()
% Data structure to hold a collection of place cells

% Array of place field centers.  first column: x, second column: y
place_cells.field_centers = []; 

% Peak firing rates
place_cells.peak_rates = [];

% Field sizes
place_cells.field_sizes = [];

% Distinguish between bidirectional and uni-directional fields
% -1: Inbound,  1: Outbound,  0: Bidirectional
place_cells.directionality = [];