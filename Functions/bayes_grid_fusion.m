function [map_global] = bayes_grid_fusion(fix_prob, tmov_prob, global_res)

[r,c]       = size(fix_prob);
global_prob = zeros(r,c);
for i = 1:r
    for j = 1:c
        global_prob(i,j) = (fix_prob(i,j)*tmov_prob(i,j))...
            /((fix_prob(i,j)*tmov_prob(i,j)) ...
            + ((1-fix_prob(i,j))*(1-tmov_prob(i,j))));
    end
end
map_global  = occupancyMap(global_prob, global_res);
end

