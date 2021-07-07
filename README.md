# NLIEE
This is the code for the paper "A No-reference Evaluation Metric for Low-light Image Enhancement ".
# Run Code
## demo.m    

···
img1 = imread('Low_light\001_lowlight.png');  
img2 = imread('Enhanced\001_Enhance_1.png');  
quality_score = NLIEE_SVR(img1,img2)  
···
  
The current model under folder "SVR" is trained on the whole LIEA database from "Perceptual Quality Assessment of Low-light Image Enhancement".

# Citation
If you find our work useful, please cite our paper as:
```
```

