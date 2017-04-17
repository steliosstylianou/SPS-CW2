xa = trainfeat(1:10,:);
xb = trainfeat(11:20,:);
xc = trainfeat(21:30,:);

hold on;
scatter(xa(:, 1), xa(:,2), 'r', 'o');
scatter(xb(:, 1), xb(:,2), 'b', 'x');
scatter(xc(:, 1), xc(:,2), 'c', '*');

% train the gaussians
mua = mean(xa);
mub = mean(xb);
muc = mean(xc);

xmu1 = mua(1);
ymu1 = mua(2);
xmu2 = mub(1);
ymu2 = mub(2);
xmu3 = muc(1);
ymu3 = muc(2);

cova = cov(xa);
covb = cov(xb);
covc = cov(xc);

cova = eye(2);
covb = eye(2);
covc = eye(2);

testa = testfeat(1:5,:);
testb = testfeat(6:10,:);
testc = testfeat(11:15,:);

testaOut = [mvnpdf(testfeat,mua,cova),mvnpdf(testfeat,mub,covb),mvnpdf(testfeat,muc,covc)];
[maxaOut, class] = max(testaOut,[],2);

xsd1 = std(xa(:,1));
xsd2 = std(xb(:,1));
xsd3 = std(xc(:,1));

ysd1 = std(xa(:,2));
ysd2 = std(xb(:,2));
ysd3 = std(xc(:,2));

maxsd1 = max(xsd1,ysd1);
maxsd2 = max(xsd2,ysd2);
maxsd3 = max(xsd3,ysd3);

x = linspace(2.27,2.37,1000);
y = linspace(2.27,2.37,1000);

[X,Y] = meshgrid(x,y);


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

hold on;

contour(X,Y,z1,[P1,P1]);
contour(X,Y,z2,[P2,P2]);
contour(X,Y,z3,[P3,P3]);

hold off;

ratioP1P2 = z1./z2;

ratioP2P3 = z2./z3;

ratioP1P3 = z3./z1;


hold on;
contour(X,Y,ratioP1P2,[1,1],'g');
contour(X,Y,ratioP2P3,[1,1],'b');
contour(X,Y,ratioP1P3,[1,1],'r');

