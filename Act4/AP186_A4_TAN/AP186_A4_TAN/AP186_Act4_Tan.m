%Initialize
nx = 100; ny = 100;
x = linspace(-1,1,100);
[X,Y] = meshgrid(x);

%Shapes
R = sqrt(X.^2 + Y.^2);
circle = zeros(nx);           %CIRCLE
circle(find(R<0.5))=1;
imwrite(circle, 'circle.png');
circ = imread('circle.png');

square = zeros(nx);           %SQUARE
square(find(abs(X)<0.5 & abs(Y)<0.5)) = 1;
imwrite(square, 'square.png');
squa = imread('square.png');

triangle = zeros(nx);         %TRIANGLE
xc = [20 50 80];
yc = [75 20 75];
mask = poly2mask(xc,yc,nx,nx);
triangle(mask)=1;
imwrite(triangle, 'triangle.png');
tria = imread('triangle.png');

bahay = zeros(nx);            %BAHAY
bahay(find(abs(X)<0.4&Y>-0.1&Y<0.7))=1;
bubongx = [30 50 70];
bubongy = [45 15 45];
mask2 = poly2mask(bubongx,bubongy,nx,nx);
bahay(mask2)=1;
imwrite(bahay,'bahay.png');
baha = imread('bahay.png');

rhombus = zeros(nx);          %RHOMBUS
rx1 = [10 50 50];
ry1 = [75 75 25];
rx2 = [50 50 90];
ry2 = [25 75 25];
r1mask = poly2mask(rx1,ry1,nx,nx);
r2mask = poly2mask(rx2,ry2,nx,nx);
rhombus(r1mask) = 1;
rhombus(r2mask) = 1;
imwrite(rhombus,'rhombus.png');
rhom = imread('rhombus.png');

%Google Maps Image
sanjose = imread('gmaps_lj_bw.png');
sanjose = rgb2gray(sanjose);


shape = sanjose;
edged = edge(shape, 'approxcanny');

%Getting adjusted X and Y coordinates

[r, c] = find(edged);

coords = [r,c];
xy = fliplr(coords);
stats_shape = regionprops(shape,'centroid');
cent_shape = cat(1,stats_shape.Centroid);
cent_shape = floor(cent_shape(~isnan(cent_shape)));
cent_shape = (cent_shape');
%centroid = [floor((max(coords(:,1))+min(coords(:,1)))/2) floor((max(coords(:,2))+min(coords(:,2)))/2) ];
x_adj = xy(:,1)-cent_shape(:,1);
y_adj = xy(:,2)-cent_shape(:,2);
xy_adj = [x_adj,y_adj];

%Getting R

%xy_adj_sq = xy_adj.^2;
%r_sq = sum(xy_adj_sq,2);
%rad = sqrt(r_sq);

%Getting Theta

%yoverx = xy_adj(:,2)./xy_adj(:,1);
angle = atan2(xy_adj(:,2),xy_adj(:,1));

%Sorting

[sorted_angle, idx] = sort(angle);
for i=1:size(idx);
    xy_sorted(i,1) = xy(idx(i),1);
    xy_sorted(i,2) = xy(idx(i),2);
end;

%Green's theorem

[rfinal,cfinal] = size(xy_sorted);
B = 0;
for i = 1:(rfinal-1);
    B = B + (xy_sorted(i,1))*(xy_sorted(i+1,2)) - (xy_sorted(i,2)*xy_sorted(i+1,1));
end;

B = (B + (xy_sorted(rfinal,1))*xy_sorted(1,2) - (xy_sorted(rfinal,2)*xy_sorted(1,1)))/2;
B

