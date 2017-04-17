centroidS = mean(trainfeat(1:10,:));
centroidT = mean(trainfeat(11:20,:));
centroidV  = mean(trainfeat(21:30,:));

%figure;
%voronoi([centroidS(:, 1); centroidT(:, 1); centroidV(:, 1);], [centroidS(:, 2); centroidT(:, 2); centroidV(:, 2);]);
figure;
xrange = [2.25 2.40]; yrange = [2.25 2.40];
%specify step for image's resolution
step = 0.0001;

[x,y] = meshgrid(2.25:step:2.40, 2.25:step:2.40);
image_size = size(x);
xy = [x(:) y(:)]; 

%getting a label for every point
label = nearcen(xy,centroidS,centroidT,centroidV,numel(x));
decisionmap = reshape(label, image_size); 
%decisionmap = label;
%display boundaries
imagesc(xrange,yrange,decisionmap);
hold on;
%reverse y axis
set(gca,'ydir','normal');
% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1]
colormap(cmap);

testlabel = predict(mdl,testfeat);
trainlabel = predict(mdl,trainfeat);

scatter(testfeat(1:5,1),testfeat(1:5,2), 'r');
scatter(testfeat(6:10,1),testfeat(6:10,2),'g');
scatter(testfeat(11:15,1),testfeat(11:15,2),'b');

scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');


scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
