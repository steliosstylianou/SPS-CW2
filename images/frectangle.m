function ffeat = frectangle(image)
sum = 0;
for x = 310:333
    for y = 160:192
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end