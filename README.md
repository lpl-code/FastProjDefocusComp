# FastProjDefocusComp
## 1. To reproduce the "Efficiency Evaluation" (shown in "Section Ⅳ-A" of the manuscript), please run "computeCompensationImage_demo.m".
> **Note:**  The original image can be replaced by modifying the variable value "image_no" in the 7th line of "computeCompensationImage_demo.m", the allowable value of 'image_no' is from 1 to 15.

> **Note:**  "image_no = 1, 2, 3" stands for "Lena", "Baby" and "House" respectively, as shown in Table I.

## 2. To reproduce an example of the proposed method used "in Real Scenes with a Tilted Surface" (shown in "Section Ⅳ-B" of the manuscript), please run "real_scene_demo.m".
> **Note:** "real_scene_demo.m" performs following actions in order, 1) solving the "Transfer" from the camera to the projector's coordinate frame, 2) estimating kernel *αf* and Γ, and 3) generating the compensation image.
> **Note:** The original image can be replaced by modifying the variable value "image_no" in the 6th line of "real_scene_demo.m", the allowable value of "image_no" is from 1 to 7.

## 3. Before running the demo file "computeCompensationImage_demo.m" or "real_scene_demo.m", make sure the path to the current folder be set to ".\FastProjBlurComp-master".

## 4.  Explaination of important code files:
### 4.1 Codes for "Efficiency Evaluation"

|Name|Function|
|----|--------|
|optimization_method.m| Generating the compensation image by using "Previous Iterative Optimization Method". <br> **Note:** Previous method consumes prohibitive time that generally **more than 10 minutes**.|
|proposed_method.m| Generating the compensation image by using the proposed "Edge Intensification-based Algorithm", as discussed in Section Ⅱ-B.|

### 4.2 Codes for "Experiments in Real Scene"

|Name|Function|
|----|--------|
|pist_main.m| Solving the "Transfer" from the camera to the projector's coordinate frame, as discussed in "Section Ⅲ-B".|
|kernelEstimation.m| Estimating the "Defocus Kernel (PSF)" (kernel *αf* and Γ), as discussed in "Section Ⅲ-A".|
|compensationImage.m| Generating the "Compensation Image" in real scence by using the proposed using the proposed "Edge Intensification-based Algorithm".|

## 5.  Explaination of important subfolders used for kernel estimation in "data" folder:

|Name|Function|
|----|--------|
|subfolder "DOT"| Captured images of the "Dot Patterns", as discussed in "Section Ⅲ-A" and "Figure 5"|
|subfolder "RE1"| Caputred images of the "Horizontal Sinusoidal Projections", as discussed in "Section Ⅲ-B" and "Figure 5"|
|subfolder "RE6"| Caputred images of the "Vertical Sinusoidal Projections", as discussed in "Section Ⅲ-B" and "Figure 5"|

## 6. All of the codes have been successfully implemented in MATLAB R2018b. Feel free to contact us if you have any further quesitons.



