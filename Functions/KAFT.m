function [tform, inliers_fix, inlier_mov, pairs_fix, pairs_mov] = KAFT(i_fix, i_mov)

% Kepoint detection and extraction
pts_fix = detectKAZEFeatures(i_fix,'Diffusion','region');
pts_mov = detectKAZEFeatures(i_mov,'Diffusion', 'region');
[features_1, valid_pts_fix] = extractFeatures(i_fix, pts_fix, 'Method','SIFT');
[features_2, valid_pts_mov] = extractFeatures(i_mov, pts_mov, 'Method','SIFT');

% Keypoint Matching
pair_idx  = matchFeatures(features_1,features_2, 'Unique', true);
pairs_fix = valid_pts_fix(pair_idx(:,1),:);
pairs_mov = valid_pts_mov(pair_idx(:,2),:);

% M-estimator sample consensus (MSAC) algorithm
[tform, inlier_idx] = estimateGeometricTransform2D(pairs_mov, pairs_fix,... 
    'similarity');

inliers_fix = pairs_fix(inlier_idx,:);
inlier_mov  = pairs_mov(inlier_idx,:);