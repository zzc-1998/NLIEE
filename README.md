# NLIEE
This is the code for the paper "A No-reference Evaluation Metric for Low-light Image Enhancement ".
# Run Code
## demo.m    

```
img1 = imread('Low_light\001_lowlight.png');  
img2 = imread('Enhanced\001_Enhance_1.png');  
quality_score = NLIEE_SVR(img1,img2)  
```
  
The current model under folder "SVR" is trained on the whole LIEA database from "Perceptual Quality Assessment of Low-light Image Enhancement".

# Citation
If you find our work useful, please cite our paper as:
```
@INPROCEEDINGS{lowlight2021zhang 
author={Zhang, Zicheng and Sun, Wei and Min, Xiongkuo and Zhu, Wenhan and Wang, Tao and Lu, Wei and Zhai, Guangtao},  
booktitle={2021 IEEE International Conference on Multimedia and Expo (ICME)},  
title={A No-Reference Evaluation Metric for Low-Light Image Enhancement},  
year={2021},  
volume={},  
number={}, 
pages={1-6}, 
doi={10.1109/ICME51207.2021.9428312}}
```

