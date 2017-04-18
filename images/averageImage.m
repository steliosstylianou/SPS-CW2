function meanf = averageImage(name)
sum = 0; 
for i=1:10 
  value =fftv2([name,num2str(i),'.GIF']);
  sum = sum + double(value);
end
meanf = sum / 10;
meanf = log(meanf) + 1;
imagesc(meanf);
end
