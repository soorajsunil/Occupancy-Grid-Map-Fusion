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

% DISPLAY LOCAL MAPS:

figure('Name','LOCAL MAP'); 
show(fix.global); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');

figure('Name','FIXED MAP'); 
show(fix.map); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');

figure('Name','MOVING MAP'); 
show(mov.map); title('')
xlabel('$x$ (m)','Interpreter','latex');
ylabel('$y$ (m)','Interpreter','latex');


% % DISPLAY MATCHED INLIER POINTS:
% figure('Name','INLIER POINTS'); 
% showMatchedFeatures(i_fix, i_mov, inliers_fix, inlier_mov, ...
%     'method', 'montage', 'PlotOptions', {'mx', 'bx', 'y-'}); 
% legend('Matched inliers in fixed map','Matched inliers in moving map', ...
%     'Interpreter','latex');
% title(['Number of inliers = ' num2str(length(inliers_fix))], ...
%     'Interpreter','latex')
% set(gca, 'fontsize', 14,'FontName','Times New Roman')
% 
% % DISPLAY GLOBAL MAP:
% figure('Name','GLOBAL MAP'); 
% show(global_map); title('')
% xlabel('$x$ (m)','Interpreter','latex');
% ylabel('$y$ (m)','Interpreter','latex');

rmpath('Functions/')
rmpath('Data/')

%%


% clear map slamAlg 
% 

% 
% 
% 
% [tform_ab, inPts_a, inPts_b] = mapFusionKAZE(I_free_a, I_free_b, m_a, m_b);
% 
% 
% 
% disp(tform_ab)
% 
% x_n = [inPts_a.inPts_a.Location(:,1), inPts_a.inPts_a.Location(:,2)]; 
% y_n = [inPts_a.inPts_a.Location(:,1), inPts_a.inPts_a.Location(:,2)]; 

% x_0 = [sum(x_n(:,1))/length(x_n), sum(x_n(:,2))/length(x_n)]; 
% y_0 = [sum(y_n(:,1))/length(y_n), sum(y_n(:,2))/length(y_n)]; 
% 
% 
% a_n   = (x_n - x_0)';
% b_n   = (y_n - y_0)'; 
% 
% 
% H = b_n*a_n';
% 
% [U, S, V] = svd(H);
% 
% 
% R = V*U';
% 
% t = x_0' - R*y_0' ;
% 
% 
% for k = 1:length(y_n)
% x_bar(k,:) = R*y_n(k,1:2)' + t; 
% end
% 
% tform = rigid2d(R,t');
% 
% disp(tform)
% 
% hold on 
% plot(inPts_a.inPts_a.inPts_a.Location(:,1), inPts_a.inPts_a.inPts_a.Location(:,2), 'r+','MarkerSize',18)
% %plot(inPts_b.Location(:,1), inPts_b.Location(:,2), 'bx')
% plot(x_bar(:,1), x_bar(:,2), 'x')




