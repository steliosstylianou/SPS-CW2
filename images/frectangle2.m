function ffeat = frectangle2(image)
sum = 0;
for x = 335:375
    for y = 190:212
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end