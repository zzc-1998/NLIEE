% Input:  (1) img1: low-light image
%         (2) img2: enhacned image
% Output: (1) score: the quality score
%% 
%  Please make sure that 
%  demo.m, estimateggdparam.m, NLIEE_features.m, NLIEE_SVR.m, and file SVR
%  are in the same directory
img1 = imread('Low_light\001_lowlight.png');
img2 = imread('Enhanced\001_Enhance_1.png');
%img2 = imread('Low_light\001_Enhance_2.png');
%img2 = imread('Low_light\001_Enhance_3.png');
quality_score = NLIEE_SVR(img1,img2)

