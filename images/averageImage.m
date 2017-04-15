function meanf = averageImage(name)
picture = fftv2([name,num2str(1),'.GIF']);
sum = double(picture); % Inialize to first image.
for i=2:10 % Read in remaining images.
  value =fftv2([name,num2str(i),'.GIF']);
  sum = sum + double(value);
end;
meanf = sum / 10;
meanf = log(meanf) + 1