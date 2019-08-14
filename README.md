# FastProjDefocusComp
## 1. To realize the *simulation results* (shown in *section Ⅱ-C* of the manuscript), please run 'simulation_demo.m'.
> **Note:**  The original image can be replaced by modifying the variable value 'image_no' in the 7th line of 'simulaiton_demo.m', the allowable value of 'image_no' is from 1 to 15.

## 2. To realize the *experimental results in real scenes* (shown in *section Ⅲ* of the manuscript), please run 'real_scene_demo.m'.
> **Note:** The original image can be replaced by modifying the variable value 'image_no' in the 6th line of 'real_scene_demo.m', the allowable value of 'image_no' is from 1 to 7.

## 3. Before running the demo file 'simulation_demo.m' or 'real_scene_demo.m', make sure the path to the current folder be set to '*.\FastProjBlurComp*'.

## 4.  Explaination of some important code files：

|Name|Function|
|----|--------|
|pist_main.m|Use for solving the *point-to-point conversion* from the camera to the projector's coordinate frame, as discussed in *section Ⅱ-D*.|
|kernelEstimation.m|Use for estimating the *defocus parameters* (kernel *α* *f* and *Γ*), as discussed in *section Ⅱ-D*.|
|compensationImage.m|Use for generating the *compensation image* in real scence, as discussed in *section Ⅱ-B*. |
|optimization_method|Use for generating the compensation image in simulation by using *previous* optimization method.|
|proposed_method|Use for generating the compensation image in simulation by using the *proposed* method.|


## 5. All of the codes have been successfully implemented in MATLAB R2018b (9.5.0.944444). Feel free to contact us if you have any further quesitons.
