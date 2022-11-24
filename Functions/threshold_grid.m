function [p_free, binaryMapImage] = threshold_grid(map, thres)

% get occupancy probabilities p(m) = p(m_i = occ)
p_occ  = occupancyMatrix(map);
p_free = ones(size(p_occ)) - p_occ;

[r, c]         = size(p_free); % get row and column
binaryMapImage = zeros(r,c);

% Apply threshold to p(m_i = free)
for i = 1:r
    for j = 1:c
        if p_free(i,j) < thres
            p_free(i,j)         = 0 ;
            binaryMapImage(i,j) = 0;
        else
            p_free(i,j)         = p_free(i,j);
            binaryMapImage(i,j) = 1;
        end
    end
end