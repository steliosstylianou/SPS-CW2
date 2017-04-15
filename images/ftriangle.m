function ffeat = ftriangle(image)
i = 335;
j = 160;
sum = 0;
for c = 0:45
    b = c;
    while( b <= 41)
        sum = sum + image(j+b,i+c).^2;
        b = b +1;
    end
end
ffeat = sum;
end