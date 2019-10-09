im = imread('cell.jpg');

lab_im = rgb2lab(im);
ab = lab_im(:,:,2:3);
ab = im2single(ab);
nColors = 3;
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);
% imshow(pixel_labels, []);

mask = pixel_labels == 2;

bw_im = mask;
bw_im(50:53,4) = 1;
bw_im(241,66) = 1;
bw_im(137:144, 4) = 1;
bw_im(88:92, 4) = 1;
bw_im = imfill(bw_im, 'holes');
bw_im = bwareaopen(bw_im,36);
bw_im = imfill(bw_im, [95 249]);
bw_im = imfill(bw_im, [92 250]);
bw_im = imfill(bw_im, [218 247]);
bw_im = imfill(bw_im, [249 249]);
bw_im = imfill(bw_im, [249 169]);
imshow(bw_im);

% cells = im.*uint8(bw_im);
% imshow(cells);
%%
roi = imread('roi.jpg'); roi = double(roi); % change roi to file of choice
% imshow(roi);
R_roi = roi(:,:,1);
G_roi = roi(:,:,2);
B_roi = roi(:,:,3);
I = R_roi + G_roi + B_roi;
I(find(I==0)) = 100000;
r_roi = R_roi ./ I;
g_roi = G_roi ./ I;
BINS = 32;
r_roi_int = round(r_roi*(BINS-1) + 1);
g_roi_int = round(g_roi*(BINS-1) + 1);

colors = g_roi_int(:) + (r_roi_int(:)-1).*BINS;
histo = zeros(BINS,BINS);
for row = 1:BINS;
    for col = 1:(BINS-row+1);
        histo(row,col) = length(find(colors==(((col + (row-1)*BINS)))));
    end
end
% figure(1); imshow(imrotate(histo,90));

mbeth = imread('cell.jpg'); mbeth = double(mbeth)/255; % change image to image file of choice
R_mbeth = mbeth(:,:,1);
G_mbeth = mbeth(:,:,2);
B_mbeth = mbeth(:,:,3);
I2 = R_mbeth + G_mbeth + B_mbeth;
I2(find(I2==0))=100000;
r_mbeth = R_mbeth ./ I2;
g_mbeth = G_mbeth ./ I2;

backproj = zeros(size(r_mbeth,1),size(r_mbeth,2));
for i = 1:size(r_mbeth,1)
    for j = 1:size(r_mbeth,2)
        rproj = round(r_mbeth(i,j)*(BINS-1)+1);
        gproj = round(g_mbeth(i,j)*(BINS-1)+1);
        backproj(i,j) = histo(rproj, gproj);
    end;    
end
% figure(2); imshow(backproj);
mask = repmat(backproj,1);
% mask = mask>0;
mask = mask/max(mask,[],'all');
a = find(mask>0&mask<1);
mask(a)=1
mask = cast(mask,'like',mbeth);
seg = mbeth.*repmat(mask,[1,1,3]);
% figure(3); imshow(seg);
% montage({mask, seg})
figure(1);
% subplot(2,3,1); imshow(mbeth);
% subplot(2,3,2); imshow(uint8(roi));
% subplot(2,3,3); imshow(imrotate(histo,90));
% subplot(2,3,4); imshow(backproj);
imshow(mask);
se = strel('disk',3);
test = imopen(mask,se);
imshow(mask);
% subplot(2,3,6); imshow(seg);
%%
L = bwconncomp(bw_im);
stats1 = regionprops(bw_im,'Area');
idx = find([stats1.Area] > 240); 
idx2 = find([stats1.Area] < 240); 
connecteds = ismember(labelmatrix(L), idx);
separateds = ismember(labelmatrix(L), idx2);
montage({connecteds, separateds});

%%
W = watershed(connecteds);
Lrgb = label2rgb(W);
imshow(Lrgb)
imshow(imfuse(connecteds,Lrgb))
bw2 = ~bwareaopen(~connecteds, 10);
imshow(bw2)
D = -bwdist(~connecteds);
imshow(D,[])
Ld = watershed(D);
imshow(label2rgb(Ld))
bw2 = connecteds;
bw2(Ld == 0) = 0;
imshow(bw2)
mask = imextendedmin(D,2);
imshowpair(connecteds,mask,'blend')
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
bw3 = connecteds;
bw3(Ld2 == 0) = 0;
imshow(bw3)

%% Merge
merged = separateds | bw3;
imshow(merged);
montage({im, merged});
%%
merge = bwlabel(merged,4);
stats2 = regionprops(merge, 'all');
imshow(im);
hold on
for k = 1 : length(stats2)
     BB = stats2(k).BoundingBox;
     rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
end
xy = cat(1,stats2.Centroid);
plot(xy(:,1), xy(:,2), '*');
%% Area
whole_idx = find([stats2.Area] > 120);
whole = ismember(merge, whole_idx);
whol = bwlabel(whole);
stats_whol = regionprops(whol,'Area', 'Eccentricity', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength');
mean_a = mean([stats_whol.Area]);
std_a = std([stats_whol.Area]);
mean_e = mean([stats_whol.Eccentricity]);
std_e = std([stats_whol.Eccentricity]);
mean_p = mean([stats_whol.Perimeter]);
std_p = std([stats_whol.Perimeter]);
mean_maj = mean([stats_whol.MajorAxisLength]);
std_maj = std([stats_whol.MajorAxisLength]);
mean_min = mean([stats_whol.MinorAxisLength]);
std_min = std([stats_whol.MinorAxisLength]);

major = [stats_whol.MajorAxisLength];
minor = [stats_whol.MinorAxisLength];

binRange = linspace(11,20,50);

hmaj = histcounts(major, [binRange Inf]);
hmin = histcounts(minor, [binRange Inf]);

figure
bar(binRange, [hmaj; hmin]', 1);
set(gca, 'FontSize', 25);
xlabel('Length');
ylabel('No. of cells');