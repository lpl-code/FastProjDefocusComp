# FastProjDefocusComp
## 1. To reproduce the "Efficiency Evaluation" (shown in "section Ⅳ-A" of the manuscript), please run 'computeCompensationImage_demo.m'.
> **Note:**  The original image can be replaced by modifying the variable value 'image_no' in the 7th line of 'computeCompensationImage_demo.m', the allowable value of 'image_no' is from 1 to 15.

> **Note:**  "image_no = 1, 2, 3" stands for "Lena", "Baby" and "House" respectively, as shown in Table I.

## 2. To reproduce an example of the proposed method used "in Real Scenes* (shown in "section Ⅳ-B" of the manuscript), please run 'real_scene_demo.m'.
> **Note:** The original image can be replaced by modifying the variable value 'image_no' in the 6th line of 'real_scene_demo.m', the allowable value of 'image_no' is from 1 to 7.

## 3. Before running the demo file "computeCompensationImage_demo.m" or 'real_scene_demo.m', make sure the path to the current folder be set to ".\FastProjBlurComp-master".

## 4.  Explaination of important code files:
### 4.1 Codes for "Efficiency Evaluation"

|Name|Function|
|----|--------|
|optimization_method.m| Generating the compensation image by using "Previous Iterative Optimization Method". <br> **Note:** Previous method consumes prohibitive time that generally **more than 10 minutes**.|
|proposed_method.m| Generating the compensation image by using the "proposed method".|

### 4.2 Codes for "Experiments in Real Scene"

|Name|Function|
|----|--------|
|pist_main.m| Solving the "Transfer" from the camera to the projector's coordinate frame, as discussed in "section Ⅲ-B".|
|kernelEstimation.m| Estimating the "defocus kernel (PSF)" (kernel *αf* and Γ), as discussed in "section Ⅲ-A".|
|compensationImage.m| Generating the "compensation image" in real scence by using the proposed method, as discussed in "section Ⅳ-B". |

## 5.  Explaination of important subfolders used for kernel estimation in "data" folder:
### 5.1 
|Name|Function|
|----|--------|
|subfolder "DOT"| Captured images of the "Dot patterns", as discussed in "section Ⅲ-A" and "Figure 5"|
|subfolder "RE1"| Caputred images of the "Horizontal sinusoidal projections", as discussed in "section Ⅲ-B" and "Figure 5"|
|subfolder "RE6"| Caputred images of the "Vertical sinusoidal projections", as discussed in "section Ⅲ-B" and "Figure 5"|

## 6. All of the codes have been successfully implemented in MATLAB R2018b. Feel free to contact us if you have any further quesitons.



