function [BW,maskedRGBImage,processedMasked,result] = colorSegmentation(RGB)

I = RGB;

channel1Min = 0.000;
channel1Max = 255.000;

channel2Min = 0.000;
channel2Max = 255.000;

channel3Min = 0.000;
channel3Max = 149.000;

sliderBW = (I(:,:,1) >= channel1Min) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

maskedRGBImage = RGB;

maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

se = strel('disk',5);

open = imopen(BW,se);

processedMasked = imclose(open,se);

s = size(BW);
result = RGB;

for i = 1:s(1)
    for j = 1:s(2)
        if processedMasked(i,j) == 0
            for k = 1:3
                result(i,j,k) = 0;
            end
        end
    end
end

figure
montage({BW,maskedRGBImage,processedMasked,result})

end

