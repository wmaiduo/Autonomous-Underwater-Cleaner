RGB = imread('leave_on_pool.jpg');
blueChannel = RGB(:,:,3);
histogram(blueChannel,'Normalization','probability');
[f,xi] = ksdensity(blueChannel(:));
hold on
plot(xi,f)
dy = diff(f)./diff(xi);

count = 0;
isLastPositive = -100;
isCurrentPositive = -100;

for i = 1:99
    if (dy(i) ~= 0) && (f(i) > 0.0001)
        isLastPositive = isCurrentPositive;
        if dy(i) > 0
            isCurrentPositive = 1;
        elseif dy(i) < 0
            isCurrentPositive = 0;
        end
        if (abs(isCurrentPositive-isLastPositive) == 1)
            count = count + 1;
        end
    end
end

