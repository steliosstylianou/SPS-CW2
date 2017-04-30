function ffeat = frectangle3(image)
sum = 0;
for x = 480:520
    for y = 60:90
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end