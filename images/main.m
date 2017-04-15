featurematrix = [];
for i = 1:10
    class(i,1) = 1;
    class(10+i,1) = 2;
    class(20+i,1) = 3;
end

for i = 1:10
    pic = fftv2(['S',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(i,1) = ftriangle(modpic);
    trainfeat(i,2) = frectangle(modpic);
    
    pic = fftv2(['T',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(10+i,1) = ftriangle(modpic);
    trainfeat(10+i,2) = frectangle(modpic);

    pic = fftv2(['V',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(20+i,1) = ftriangle(modpic);
    trainfeat(20+i,2) = frectangle(modpic);    
end

trainfeat = log(log(trainfeat));
mdl = fitcknn(trainfeat, class, 'NumNeighbors', 5);


xrange = [2.27 2.37]; yrange = [2.27 2.37];
step = 0.0002;
[x,y] = meshgrid(2.27:step:2.37, 2.27:step:2.37);
image_size = size(x);
xy = [x(:) y(:)]; 
label = predict(mdl,[x(:),y(:)])
decisionmap = reshape(label, image_size); 
%show the image
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');

 
% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1]
colormap(cmap);
