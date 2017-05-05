function [classes] = ss15293(classifier_num) 
% (classifier_num = 1 -> KNN, 2-> NEAREST CENTROID, 3->GAUSSIAN)

%read and extract features from all images
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

for i=1:10
    pic = fftv2(['S',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(i,1) = ftriangle(modpic);
    testfeat(i,2) = frectangle(modpic);
    
    pic = fftv2(['T',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(10+i,1) = ftriangle(modpic);
    testfeat(10+i,2) = frectangle(modpic);

    pic = fftv2(['V',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(20+i,1) = ftriangle(modpic);
    testfeat(20+i,2) = frectangle(modpic);    
end
    
pic = fftv2('A1.GIF');
modpic = log(pic) + 1;
addfeat(1,1) = ftriangle(modpic);
addfeat(1,2) = frectangle(modpic);

pic = fftv2('B1.GIF');
modpic = log(pic) + 1;
addfeat(2,1) = ftriangle(modpic);
addfeat(2,2) = frectangle(modpic);

%Feature Standardisation
testfeat  = bsxfun(@minus, testfeat,mean(trainfeat));
testfeat  = bsxfun(@rdivide, testfeat,std(trainfeat));

addfeat  = bsxfun(@minus, addfeat,mean(trainfeat));
addfeat  = bsxfun(@rdivide, addfeat,std(trainfeat));

trainfeat  = bsxfun(@minus, trainfeat,mean(trainfeat));
trainfeat  = bsxfun(@rdivide, trainfeat,std(trainfeat));

% PLOTTING FEATURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hold on;
%scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
%scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
%scatter(testfeat(21:30,1),testfeat(21:30,2),'b');
%scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
%scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
%scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');
%scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
%scatter(addfeat(2,1),addfeat(2,2),20,'c');

%Classifier function calls
if (classifier_num == 1) 
    classes = knnclassifier(trainfeat, testfeat, addfeat) ;
elseif (classifier_num == 2) 
    classes = nearestcentroid(trainfeat, testfeat, addfeat) ;
elseif (classifier_num == 3) 
    classes = gaussianclassifier(trainfeat, testfeat, addfeat) ;
end
end

% FUNCTION FOR CALCULATING AVERAGE FOURIER SPECTRUM
function meanimages = averageImage(name)
sum = 0; 
for i=1:10 
  value =fftv2([name,num2str(i),'.GIF']);
  sum = sum + double(value);
end
meanf = sum / 10;
meanf = log(meanf) + 1;
imagesc(meanf);
end

%FFT FUNCTION
function f = fftv2(imagename)
f = imread(imagename); %read in image
z = fft2(double(f)); % do fourier transform
q = fftshift(z); % puts u=0,v=0 in the centre
f = (abs(q)); % magnitude spectrum
%Phaseq=angle(q); % phase spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usually for viewing purposes
%imagesc(log(abs(q)+1));
%figure;
%imagesc(log(abs(q.^2)+1));
%colorbar;
end

%TRIANGLE FEATURE
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

%RECTANGLE FEATURE
function ffeat = frectangle(image)
sum = 0;
for x = 310:333
    for y = 160:192
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end

% FEATURES THAT WERE NOT USED AS THE PREVIOUS ONES OFFERED BETTER
% SEPARATION
function ffeat = frectangle2(image)
sum = 0;
for x = 335:375
    for y = 190:212
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end

function ffeat = frectangle3(image)
sum = 0;
for x = 480:520
    for y = 60:90
        sum = sum + image(y,x).^2;
    end
end
ffeat = sum;
end

%GAUSSIAN CLASSIFIER FUNCTION
function [trainclasses] = gaussianclassifier(trainfeat, testfeat, addfeat )
xa = trainfeat(1:10,:);
xb = trainfeat(11:20,:);
xc = trainfeat(21:30,:);

% train the gaussians:
%finding means
mua = mean(xa);
mub = mean(xb);
muc = mean(xc);

%finding covariances

cova = cov(xa);
covb = cov(xb);
covc = cov(xc);

%Calculating PDF of each distribution and finding the max between these
testaOutTest = [mvnpdf(testfeat,mua,cova),mvnpdf(testfeat,mub,covb),mvnpdf(testfeat,muc,covc)];
[maxaOutTest, classTest] = max(testaOutTest,[],2);

testaOutAB = [mvnpdf(addfeat,mua,cova),mvnpdf(addfeat,mub,covb),mvnpdf(addfeat,muc,covc)];
[maxaOutAB, classAB] = max(testaOutAB,[],2);


%Plotting Boundaries 
x = linspace(-2,2.2,1000);
y = linspace(-2,2,1000);

[X,Y] = meshgrid(x,y);
xy = [X(:) Y(:)]; 

testaOutPlot = [mvnpdf(xy,mua,cova),mvnpdf(xy,mub,covb),mvnpdf(xy,muc,covc)];
[maxaOutPlot, classPlot] = max(testaOutPlot,[],2);

map = reshape(classPlot, size(X)); 

%displaying boundaries

set(gca,'ydir','normal');  %reverse y axis
cmap = [0.9765 0.6039 0.6039; 0.8157 0.9765 0.6039; 0.6039 0.9020 0.9765];
colormap(cmap);

% Compute value of Gaussian pdf at each point in the grid
z1 = mvnpdf([X(:),Y(:)], mua, cova);
z2 = mvnpdf([X(:),Y(:)], mub, covb);
z3 = mvnpdf([X(:),Y(:)], muc, covc);

z1 = reshape(z1, size(X));
z2 = reshape(z2, size(X));
z3 = reshape(z3, size(X));

%mahalanobis distance 6
E1 = 2*pi * sqrt(det(cova));
P1 = (1/E1) * exp(-3);
E2 = 2*pi * sqrt(det(covb));
P2 = (1/E2) * exp(-3);
E3 = 2*pi * sqrt(det(covc));
P3 = (1/E3) * exp(-3);

ratioP1P2 = z1./z2;

ratioP2P3 = z2./z3;

ratioP1P3 = z3./z1;

trainclasses = classTest;

%PLOTTING FUNCTIONS
hold on;
imagesc([-2 2.2],[-2 2],map);

%Show Boundaries
contour(X,Y,ratioP1P2,[1,1]);
contour(X,Y,ratioP2P3,[1,1]);
contour(X,Y,ratioP1P3,[1,1]);

%Show points on the scatter plot
scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');
scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
scatter(testfeat(21:30,1),testfeat(21:30,2),'b');
scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
%figure;

%Show ellipses
contour(X,Y,z1,[P1,P1],'r');
contour(X,Y,z2,[P2,P2],'g');
contour(X,Y,z3,[P3,P3],'b');
end 

function [classes] = knnclassifier(trainfeat, testfeat, addfeat )

for i = 1:10
    class(i,1) = 1;
    class(10+i,1) = 2;
    class(20+i,1) = 3;
end

%Creating a knn classifier using our training data and  k = 5 
mdl = fitcknn(trainfeat, class, 'NumNeighbors', 5);

%creating mesh range
xrange = [-2 2.2]; yrange = [-2 2];
%specifies step for image's resolution (we used a smaller step for submission
%than the one mentioned in the report as higher steps required a lot of
%time to compute
step = 0.01;
[x,y] = meshgrid(-2:step:2.2, -2:step:2);
image_size = size(x);

%getting a label for every point
label = predict(mdl,[x(:),y(:)]);
decisionmap = reshape(label, image_size); 
%display boundaries
imagesc(xrange,yrange,decisionmap);
hold on;
%reverse y axis
set(gca,'ydir','normal');
cmap = [0.9765 0.6039 0.6039; 0.8157 0.9765 0.6039; 0.6039 0.9020 0.9765];
colormap(cmap);

testlabel = predict(mdl,testfeat);

scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
scatter(testfeat(21:30,1),testfeat(21:30,2),'b');

scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');


scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
classes =testlabel;
end

function label = nearcen(point,s,t,v,siz)
%finding distances between all points and all centroids
for i=1:siz
distS =  pdist2(s,point(i,:));
distT =  pdist2(t,point(i,:));
distV =  pdist2(v,point(i,:));
%finding min distance
mindist = min([distS, distT, distV]);

%assigning to the point the class with min distance
if (mindist == distS) 
    label(i,1) = 1;
elseif (mindist == distT)
    label(i,1) = 2;
elseif (mindist == distV)
    label(i,1) = 3;
end
end
end

function [classes] = nearestcentroid(trainfeat,testfeat,addfeat)
%initialising centroids
centroidS = mean(trainfeat(1:10,:));
centroidT = mean(trainfeat(11:20,:));
centroidV  = mean(trainfeat(21:30,:));

%Showing boundaries
figure;
xrange = [-2 2.2]; yrange = [-2 2];
%specifies step for image's resolution (we used a smaller step for submission
%than the one mentioned in the report as higher steps required a lot of
%time to compute
step = 0.01;

[x,y] = meshgrid(-2:step:2.2, -2:step:2);
image_size = size(x);
xy = [x(:) y(:)]; 

%getting a label for every point
label = nearcen(xy,centroidS,centroidT,centroidV,numel(x));
decisionmap = reshape(label, image_size); 

%display boundaries
hold on;
imagesc(xrange,yrange,decisionmap);
%reverse y axis
set(gca,'ydir','normal');
cmap = [0.9765 0.6039 0.6039; 0.8157 0.9765 0.6039; 0.6039 0.9020 0.9765];
colormap(cmap);

scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
scatter(testfeat(21:30,1),testfeat(21:30,2),'b');
scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');
scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
voronoi([centroidS(:, 1); centroidT(:, 1); centroidV(:, 1);], [centroidS(:, 2); centroidT(:, 2); centroidV(:, 2);]);
axis([-2 2.2 -2 2.2]);
classes = nearcen(testfeat,centroidS,centroidT,centroidV,30);


end
