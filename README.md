# FastProjDefocusComp
## 0. Before running the demo file "computeCompensationImage_demo.m", "real_scene_demo.m", "binary-decoding-evaluation.m", "metrics_for_vgroove.m", "metrics_for_textured.m", and "noise_level_est.m", make sure the path to the current folder be set to ".\FastProjBlurComp-master".

## 1. To reproduce the "Efficiency Evaluation" (shown in "Section Ⅳ-A" of the manuscript), please run "computeCompensationImage_demo.m".
> **Note:**  The original image can be replaced by modifying the variable value "image_no" in the 7th line of "computeCompensationImage_demo.m", the allowable value of 'image_no' is from 1 to 15.

> **Note:**  "image_no = 1, 2, 3" stands for "Lena", "Baby" and "House" respectively, as shown in Table I.

## 2. To reproduce an example of the proposed method used "in Real Scenes with a Tilted Surface" (shown in "Section Ⅳ-B" of the manuscript), please run "real_scene_demo.m".
> **Note:** "real_scene_demo.m" performs following actions in order, 1) solving the "Transfer" from the camera to the projector's coordinate frame, 2) estimating kernel *αf* and Γ, and 3) generating the compensation image.

> **Note:** The original image can be replaced by modifying the variable value "image_no" in the 6th line of "real_scene_demo.m", the allowable value of "image_no" is from 1 to 7.

## 3. To reproduce the metrics calculation results listed in TABLE Ⅲ on both v-groove (see Fig. 11) and textured surface (see Fig. 12), please run "metrics_for_vgroove.m" and "metrics_for_textured.m", respectively.

## 4. To reproduce the experiment of binary-decoding-based evaluation method on a tilted surface (see Fig. 13), please run "binary_decoding_evaluation.m".

## 5. To reproduce the estimation results of the camera error level of the raw captured images, as listed in TABLE Ⅵ, please run "noise_level_est.m".

> **Note:** We use the code provided by Wenzhao Zhao, which is described in the following article:

[26] W. Zhao, Q. Liu, Y. Lv, and B. Qin, "Texture variation adaptive image denoising with nonlocal PCA," IEEE Transactions on Image Processing. 

## 6.  Explaination of important code files:
### 6.1 Codes for "Efficiency Evaluation"

|Name|Function|
|----|--------|
|optimization_method.m| Generating the compensation image by using "Previous Iterative Optimization Method". <br> **Note:** Previous method consumes prohibitive time that generally **more than 10 minutes**.|
|proposed_method.m| Generating the compensation image by using the proposed "Edge Intensification-based Algorithm", as discussed in Section Ⅱ-B.|

### 6.2 Codes for "Experiments in Real Scene"

|Name|Function|
|----|--------|
|pist_main.m| Solving the "Transfer" from the camera to the projector's coordinate frame, as discussed in "Section Ⅲ-B".|
|kernelEstimation.m| Estimating the "Defocus Kernel (PSF)" (kernel *αf* and Γ), as discussed in "Section Ⅲ-A".|
|compensationImage.m| Generating the "Compensation Image" in real scence by using the proposed using the proposed "Edge Intensification-based Algorithm".|

### 6.3 Codes for "Binary-decoding based evaluation"

|Name|Function|
|----|--------|
|decode_conGraycode_version2.m| Decoding from the captured binary-encoded images, which is generally used in the context of structured-light 3D measurement, as discussed in "Section Ⅳ-C".|

### 6.4 Codes for "Estimation of the level of camera errors"

|Name|Function|
|----|--------|
|noise_evaluation_acva.m| Estimating the camera errors based on Poisson-Gaussian noise model, by using the code provided in [26].|

## 7.  Explaination of important subfolders used for kernel estimation in "data" folder:

|Name|Function|
|----|--------|
|subfolder "DOT"| Captured images of the "Dot Patterns", as discussed in "Section Ⅲ-A" and "Figure 5"|
|subfolder "RE1"| Caputred images of the "Horizontal Sinusoidal Projections", as discussed in "Section Ⅲ-B" and "Figure 5"|
|subfolder "RE6"| Caputred images of the "Vertical Sinusoidal Projections", as discussed in "Section Ⅲ-B" and "Figure 5"|
|folder "vgroove1-lite"| Captured images from the complex surface, v-groove, as discussed in "Section Ⅳ-B" and "Figure 11"|
|folder "textured_lite"| Captured images from the complex surface, textured surface, as discussed in "Section Ⅳ-B" and "Figure 12"|
|folder "binary-30-lite"| Captured images of the "gray-code binary-encoded patterns", as discussed in "Section Ⅳ-C" and "Figure 13"|

## 8. All of the codes have been successfully implemented in MATLAB R2018b. Feel free to contact us if you have any further quesitons.



