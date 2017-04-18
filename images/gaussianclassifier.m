xa = trainfeat(1:10,:);
xb = trainfeat(11:20,:);
xc = trainfeat(21:30,:);

% train the gaussians
mua = mean(xa);
mub = mean(xb);
muc = mean(xc);

cova = cov(xa);
covb = cov(xb);
covc = cov(xc);

testaOutTest = [mvnpdf(testfeat,mua,cova),mvnpdf(testfeat,mub,covb),mvnpdf(testfeat,muc,covc)];
[maxaOutTest, classTest] = max(testaOutTest,[],2);

testaOutAB = [mvnpdf(addfeat,mua,cova),mvnpdf(addfeat,mub,covb),mvnpdf(addfeat,muc,covc)];
[maxaOutAB, classAB] = max(testaOutAB,[],2);

x = linspace(2.29,2.39,1000);
y = linspace(2.26,2.36,1000);

[X,Y] = meshgrid(x,y);
xy = [X(:) Y(:)]; 

testaOutPlot = [mvnpdf(xy,mua,cova),mvnpdf(xy,mub,covb),mvnpdf(xy,muc,covc)];
[maxaOutPlot, classPlot] = max(testaOutPlot,[],2);

map = reshape(classPlot, size(X)); 
%display boundaries


%reverse y axis
set(gca,'ydir','normal');
cmap = [0.9765 0.6039 0.6039; 0.8157 0.9765 0.6039; 0.6039 0.9020 0.9765]
colormap(cmap);

z1 = mvnpdf([X(:),Y(:)], mua, cova);
z2 = mvnpdf([X(:),Y(:)], mub, covb);
z3 = mvnpdf([X(:),Y(:)], muc, covc);

z1 = reshape(z1, size(X));
z2 = reshape(z2, size(X));
z3 = reshape(z3, size(X));
% Compute value of Gaussian pdf at each point in the grid

E1 = 2*pi * sqrt(det(cova));
P1 = (1/E1) * exp(-3);
E2 = 2*pi * sqrt(det(covb));
P2 = (1/E2) * exp(-3);
E3 = 2*pi * sqrt(det(covc));
P3 = (1/E3) * exp(-3);

ratioP1P2 = z1./z2;

ratioP2P3 = z2./z3;

ratioP1P3 = z3./z1;


hold on;
imagesc([2.29 2.39],[2.26 2.36],map);
%contour(X,Y,ratioP1P2,[1,1]);
%contour(X,Y,ratioP2P3,[1,1]);
%contour(X,Y,ratioP1P3,[1,1]);



%elipsoids
scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');


scatter(testfeat(1:10,1),testfeat(1:10,2), 'r');
scatter(testfeat(11:20,1),testfeat(11:20,2),'g');
scatter(testfeat(21:30,1),testfeat(21:30,2),'b');

scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');
%figure;


contour(X,Y,z1,[P1,P1],'r');
contour(X,Y,z2,[P2,P2],'g');
contour(X,Y,z3,[P3,P3],'b');
