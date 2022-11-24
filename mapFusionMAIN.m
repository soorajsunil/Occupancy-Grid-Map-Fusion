clc; clear;  addpath('Functions/'); addpath('Data/'); 

fix = load('demo_1.mat');
mov = load('demo_2.mat');

[fix.global] = local_to_global(fix.map, mov.map);

% CONSTRUCT MAP IMAGES:
thres = 0.99; 
[p_fix, i_fix] = threshold_grid(fix.global, thres);
[p_mov, i_mov] = threshold_grid(mov.map, thres); 

% KAZE-SIFT KEYPOINT DETECTION, DESCRIPTION, AND MATCHING:
[tform, inliers_fix, inlier_mov] = KAFT(i_fix, i_mov);

% MAP TRANSFORMATION:
outputView = imref2d(size(occupancyMatrix(fix.global)));
tmov_prob  = imwarp(occupancyMatrix(mov.map), tform, 'FillValues', ...
    0.5,'OutputView', outputView, 'interp', 'nearest');

% PROBABILITY GRID FUSION:
[global_map] = bayes_grid_fusion(occupancyMatrix(fix.global), ....
    tmov_prob, fix.map.Resolution);
%% PLOT

% DISPLAY LOCAL MAPS:
figure('Name','LOCAL MAP - FIXED'); 
show(fix.map); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');

figure('Name','LOCAL MAP - MOVING'); 
show(mov.map); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');

% DISPLAY MATCHED INLIER POINTS:
figure('Name','INLIER POINTS'); 
showMatchedFeatures(i_fix, i_mov, inliers_fix, inlier_mov, ...
    'method', 'montage', 'PlotOptions', {'mx', 'bx', 'y-'}); 
legend('Matched inliers in fixed map','Matched inliers in moving map', ...
    'Interpreter','latex');
title(['Number of inliers = ' num2str(length(inliers_fix))], ...
    'Interpreter','latex')
set(gca, 'fontsize', 14,'FontName','Times New Roman')

% DISPLAY GLOBAL MAP:
figure('Name','GLOBAL MAP'); 
show(global_map); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');

rmpath('Functions/')
rmpath('Data/')