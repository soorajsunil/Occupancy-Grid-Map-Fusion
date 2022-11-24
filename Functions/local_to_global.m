function [global_fix, global_mov] = local_to_global(local_fix, local_mov)

% shift the local coordinates to origin
local_fix.LocalOriginInWorld = [0, 0];
local_mov.LocalOriginInWorld = [0, 0];
% Find the max. size to approximately accomodate two maps

xmax_fix = local_fix.XLocalLimits(2);
ymax_fix = local_fix.YLocalLimits(2);

xmax_mov = local_mov.XLocalLimits(2);
ymax_mov = local_mov.YLocalLimits(2);

xy_max  = ymax_fix + ymax_mov + xmax_fix + xmax_mov;
%xy_max   = xmax_a + ymax_b;

[global_fix] = resize_map(local_fix, xy_max);
[global_mov] = resize_map(local_mov, xy_max);

end


function [resized_map] = resize_map(map, xy_max)
% Get the resolution of the map
res = map.Resolution;
% Create an empty map with the same resolution as the input map
resized_map = occupancyMap(xy_max, xy_max, res);
% Find an approximate center to place the input map into the output frame
ij = round(resized_map.GridSize./4);
% Get the probability laye of the input map
prob_local = getOccupancy(map);
% Get the probability layer of the empty output map
prob_resized = getOccupancy(resized_map);
% Get the size of the input map
[h, w] = size(prob_local);
% Iterate and update probabilities
for m = ij(1):(ij(1)+h-1)
    for  n = ij(2):(ij(2)+w-1)
        prob_resized(m,n) = prob_local(m-(ij(1)-1),n-(ij(2)-1));
    end
end
resized_map = occupancyMap(prob_resized, res);
end

