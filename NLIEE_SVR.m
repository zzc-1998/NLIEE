function score = NLIEE_SVR(img1,img2)
%% svm module
FeatureTest = NLIEE_features(img1,img2);
CurrentPath = pwd;
svrdir = strcat(pwd,'\SVR\');
cd (svrdir);
fid = fopen('test_ind.txt','w');
    for itr_im = 1:size(FeatureTest,1)
        for itr_param = 1:size(FeatureTest,2)
            fprintf(fid,'%d:%f ',itr_param,FeatureTest(itr_im,itr_param));
        end
        %fprintf(fid,'\n');
    end
fclose(fid);
delete test_ind_scaled
system('svm-scale -r range test_ind.txt >> test_ind_scaled');
system('svm-predict  -b 1  test_ind_scaled model output.txt>dump');
load output.txt;
score = output;
cd (CurrentPath);
end


