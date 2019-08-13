function phase_main = solveMainPhase_Nsteps(pspPattern)
I = pspPattern;
steps = length(I);
up_item = zeros(size(I{1, 1}));
down_item = zeros(size(I{1, 1}));

if steps == 4
    I1 = pspPattern{1,1};
    I2 = pspPattern{2,1};
    I3 = pspPattern{3,1};
    I4 = pspPattern{4,1};
    up_item = I2 - I4;
    down_item = I1 - I3;
end

if steps == 3
    I1 = pspPattern{1,1};
    I2 = pspPattern{2,1};
    I3 = pspPattern{3,1};
    up_item = sin(2*pi/3) * I2 + sin(4*pi/3) * I3;
    down_item = cos(2*pi/3) * I2 + cos(4*pi/3) * I3 + I1;
end
    
if steps == 5
    I1 = pspPattern{1,1};
    I2 = pspPattern{2,1};
    I3 = pspPattern{3,1};
    I4 = pspPattern{4,1};
    I5 = pspPattern{5,1};
    up_item = sin(2*pi/5) * I2 + sin(4*pi/5) * I3 + sin(6*pi/5) * I4 + sin(8*pi/5) * I5;
    down_item = cos(2*pi/5) * I2 + cos(4*pi/5) * I3 + cos(6*pi/5) * I4 + cos(8*pi/5) * I5 + I1;
end

if steps == 6
    I1 = pspPattern{1,1};
    I2 = pspPattern{2,1};
    I3 = pspPattern{3,1};
    I4 = pspPattern{4,1};
    I5 = pspPattern{5,1};
    I6 = pspPattern{6,1};
    up_item = sin(2*pi/6) * I2 + sin(4*pi/6) * I3 + sin(8*pi/6) * I5 + sin(10*pi/6) * I6;
    down_item = cos(2*pi/6) * I2 + cos(4*pi/6) * I3 + cos(6*pi/6) * I4 + cos(8*pi/6) * I5 + cos(10*pi/6) * I6 + cos(12*pi/6) * I1;
end

phase_main = zeros(size(I{1, 1}));
for i=1:size(I{1, 1}, 1)
    for j=1:size(I{1, 1}, 2)
        if down_item(i, j) == 0 % (I1(i,j)==I3(i,j))
            if(up_item(i, j) > 0) % (I2(i,j)>I4(i,j))
                phase_main(i,j)=3*pi/2;
            elseif(up_item(i, j) < 0) % (I2(i,j)<I4(i,j))
                phase_main(i,j)=pi/2;
            else
                phase_main(i,j)=0;
            end
        elseif down_item(i, j) > 0 % (I1(i,j)>I3(i,j))
            if (up_item(i, j) > 0) % I2(i,j)>I4(i,j)
                phase_main(i,j)=2*pi - atan(up_item(i, j)/down_item(i, j)); % I(i,j)=2*pi - atan((I2(i,j)-I4(i,j))/(I1(i,j)-I3(i,j)));
            elseif (up_item(i, j) == 0) %(I2(i,j)==I4(i,j))
                phase_main(i,j)=2*pi;
            else
                phase_main(i,j)=-atan(up_item(i, j)/down_item(i, j)); 
            end
        else
            if up_item(i, j) > 0 % I2(i,j)>I4(i,j)
                phase_main(i,j)=pi-atan(up_item(i, j)/down_item(i, j));
            elseif up_item(i, j) == 0 % (I2(i,j)==I4(i,j))
                phase_main(i,j)=pi;
            else
                phase_main(i,j)=pi-atan(up_item(i, j)/down_item(i, j));
            end
        end
    end
end