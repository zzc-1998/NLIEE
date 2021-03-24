# NLIEE
This is the code for the paper "A No-reference Evaluation Metric for Low-light Image Enhancement ".
# Run Code
demo.m   
% Input:  (1) img1: low-light image  
%         (2) img2: enhacned image    
% Output: (1) score: the quality score    
% Usage:  Given a haze image img1 and a dehaze image img2, whose dynamic range is 0-255    
img1 = imread('Low_light\001_lowlight.png');  
img2 = imread('Enhanced\001_Enhance_1.png');  
quality_score = NLIEE_SVR(img1,img2)  
The current model under folder "SVR" is trained on the whole LIEA database.
