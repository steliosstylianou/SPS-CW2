for i = 1:10
    class(i,1) = 1;
    class(10+i,1) = 2;
    class(20+i,1) = 3;
end

mdl = fitcknn(trainfeat, class, 'NumNeighbors', 5);

%creating mesh range
xrange = [2.29 2.39]; yrange = [2.26 2.36];
%specify step for image's resolution
step = 0.0001;
[x,y] = meshgrid(2.29:step:2.39, 2.26:step:2.36);
image_size = size(x);

xy = [x(:) y(:)]; 
%getting a label for every point
label = predict(mdl,[x(:),y(:)])
decisionmap = reshape(label, image_size); 
%display boundaries
imagesc(xrange,yrange,decisionmap);
hold on;
%reverse y axis
set(gca,'ydir','normal');
cmap = [0.9765 0.6039 0.6039; 0.8157 0.9765 0.6039; 0.6039 0.9020 0.9765]
colormap(cmap);

testlabel = predict(mdl,testfeat);
trainlabel = predict(mdl,trainfeat);

scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
scatter(testfeat(21:30,1),testfeat(21:30,2),'b');

scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');


scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
