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

covara = cov(xa);
covarb = cov(xb);
covarc = cov(xc);

testa = testfeat(1:5,:);
testb = testfeat(6:10,:);
testc = testfeat(11:15,:);

testaOut = [mvnpdf(testfeat,mua,covara),mvnpdf(testfeat,mub,covarb),mvnpdf(testfeat,muc,covarc)];
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

x1 = xmu1-2*maxsd1:0.01:xmu1+2*maxsd1; % location of points at which x is calculated
y1 = ymu1-2*maxsd1:0.01:ymu1+2*maxsd1; % location of points at which y is calculated

[X1, Y1] = meshgrid(x1,y1); % matrices used for plotting

%X1Y1 = reshape(X1Y1, size(mua));
% Compute value of Gaussian pdf at each point in the grid
z1 = mvnpdf(X1Y1, mua, covara);
surf(x1,y1,z1);
figure;
contour(x1,y1,z1);
