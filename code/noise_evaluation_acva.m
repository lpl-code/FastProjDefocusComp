%% Program for "Texture variation adaptive image denoising with nonlocal PCA".
%% The algorithm is described in the following article:
%% W. Zhao, Q. Liu, Y. Lv, and B. Qin, "Texture variation adaptive image denoising with nonlocal PCA," IEEE Transactions on Image Processing [26]. 
function sigma = noise_evaluation_acva(z)
rima = z;
data = rima;

data1 = data;%
[m,n] = size(data1);

Patch_width = 8;
d = Patch_width;
s = size(rima);
stride = 1;
X = image2cols(data1, d, stride);   %extracting image patches
[M,N] = size(X);

if  isempty(X)
    sigma=0;
else
    [M,L]=size(X);
    if M>L
        X=X';
        [M,L]=size(X);
    end
    mx=mean(X, 1);
    X=X-repmat(mx,[M, 1]);

    [~,Eg]=eig(X*X'/(L));
    Eg=diag(Eg);

    sigmaest1=zeros(M-1,1);
    sigmaest2=zeros(M-1,1);
    for i=M:-1:2

        sigmaest1(i-1)=sum(Eg(1:i,:))/i;
        sigmaest2(i-1)=(Eg(i)-Eg(2))/4/(sqrt((M)/L)); 

    end
    [~,ind]=min(abs(sigmaest1-sigmaest2));
    %
    sigma=sqrt(abs(sigmaest1(ind)));%abs
end