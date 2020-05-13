function Dec = Gray2Dec(GrayCode)
len = length(GrayCode);
GrayCode = fliplr(GrayCode);
%Gray2Bin
Bin(len) = GrayCode(len);
for i = len:-1:2
    tmp1 = Bin(i);
    tmp2 = GrayCode(i-1);
    Bin(i-1) = xor(tmp1, tmp2);
end
%Bin2Dec
Dec = 0;
for i = 1:len
    Dec = Dec + Bin(i) * 2^(i-1);
end
end

    