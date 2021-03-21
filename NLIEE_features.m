function feat = NLIEE_features(img1,img2)
%% pre-processing
%img1 low-light image
%img2 enhanced image
feat = [];
constant = 0.01;
% local mean and variance
img1_gray = double(rgb2gray(img1));
img2_gray = double(rgb2gray(img2));
win = fspecial('gaussian',7,7/6);
win = win/sum(sum(win));
mu1 = imfilter(img1_gray,win,'replicate');
mu_sq1 = mu1.*mu1;
sigma1 = sqrt(abs(imfilter(img1_gray.*img1_gray,win,'replicate') - mu_sq1));
mu2 = imfilter(img2_gray,win,'replicate');
mu_sq2 = mu2.*mu2;
sigma2 = sqrt(abs(imfilter(img2_gray.*img2_gray,win,'replicate') - mu_sq2));
% normalized local variance
nv1 = sigma1./(mu1+1);
nv2 = sigma2./(mu2+1);
%% luminance gaussian parameter dim-1
structdis     = (img2_gray-mu2)./(sigma2+1);
[alpha overallstd]       = estimateggdparam(structdis(:));
feat                     = [feat alpha overallstd^2]; 
%% Color features dim-2
img1_hsv = rgb2hsv(img1);
img2_hsv = rgb2hsv(img2);
% h feature
h1 = entropy(img1_hsv(:,:,1));
h2 = entropy(img1_hsv(:,:,1));
h = h2/(h1+constant);
%s feature
s1 = entropy(img1_hsv(:,:,2));
s2 = entropy(img1_hsv(:,:,2));
s = s2/(s1+constant);
feat = [feat h s];
%% Noise feature dim-3
lowContrastArea = sigma1 < mean2(sigma1);
lowLightArea = mu1 < mean2(mu1);
noise_area = lowContrastArea & lowLightArea;
W = fspecial('gaussian',[5,5],1); 
im_gaussian = imfilter(img2_gray, W, 'replicate');
im_median = medfilt2(img2_gray,[3,3]);
cha_gau = img2_gray - im_gaussian;
cha_jiaoyan = img2_gray - im_median;
feat = [feat nanmean(cha_gau(noise_area)) nanmean(cha_jiaoyan(noise_area))];
%% Overall Structure Similarity dim-4
% variance similarity
sigmaSIM = (2*sigma1.*sigma2)./(sigma1.^2+sigma2.^2);
sigmaSIM_mean = nanmean(sigmaSIM(:));
% normalized variance similarity
nvSIM = (2*nv1.*nv2)./(nv1.^2+nv2.^2);
nvSIM_mean = nanmean(nvSIM(:));
% normalize image similarity
imgNor1 = (img1_gray-mu1) ./ (sigma1+1)+3;
imgNor2 = (img2_gray-mu2) ./ (sigma2+1)+3;
imgNorSIM = (2*imgNor1.*imgNor2)./(imgNor1.^2+imgNor2.^2);
imgNorSIM_mean = nanmean(imgNorSIM(:));
% log edge similarity
img1_log = double(edge(img1_gray,'log'));
img2_log = double(edge(img2_gray,'log'));
logSIM =(2*img1_log.*img2_log+0.01)./(img1_log.^2+img2_log.^2+0.01);
logSIM_mean = nanmean(logSIM(:));
feat = [feat sigmaSIM_mean nvSIM_mean imgNorSIM_mean logSIM_mean];
%% Structure Enhancement features dim-4
% structure enhance in low light areas
feat =[ feat nanmean(sigmaSIM(lowLightArea)) nanmean(nvSIM(lowLightArea)) nanmean(imgNorSIM(lowLightArea)) nanmean(logSIM(lowLightArea))];
%% Over-enhancement features dim-4
% over-enhacnement in low contrast areas
highEnhancementArea = sigma2-sigma1 > mean2(sigma2-sigma1);
area = lowContrastArea & highEnhancementArea;
feat =[ feat nanmean(sigmaSIM(area)) nanmean(nvSIM(area)) nanmean(imgNorSIM(area)) nanmean(logSIM(area))];
end