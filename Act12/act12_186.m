numfiles = 20;
ims = cell(20,1);

for k = 1:numfiles
    fname = sprintf('orange%d.jpg', k);
    fn = fullfile('C:', 'Users', 'LJ', 'Desktop', 'LJ AP186', 'Act12', 'samples', 'oranges', fname);
    ims{k} = imread(fn);
end
%%
rois = cell(20,1);
for k = 1:numfiles
    rois{k} = imcrop(ims{k});
end
%% fix
for k = [17]
    rois{k} = imcrop(ims{k});
end
%%
hsvrois = cellfun(@rgb2hsv, rois, 'UniformOutput', false);

hrois = cell(20,1); srois = cell(20,1); vrois = cell(20,1);
for k = 1:numfiles
    hrois{k} = hsvrois{k}(:,:,1);
    srois{k} = hsvrois{k}(:,:,2);
    vrois{k} = hsvrois{k}(:,:,3);
end

mn = @(x) mean(x,'all');
meanh = cellfun(mn, hrois);

histos = cellfun(@patchz,rois, 'UniformOutput', false);
masks = cellfun(@nonpara, ims, histos,'UniformOutput',false);
%%
masks2 = cellfun(@binzz, masks, 'UniformOutput',false);
%%
fillz = @(x) imfill(x,'holes');
masks3= cellfun(fillz,masks2,'UniformOutput',false);
%%
se = strel('disk',10);
cloze = @(x) imclose(x,se);
masks4 = cellfun(cloze,masks3,'UniformOutput',false);
masks5 = cellfun(fillz,masks4,'UniformOutput', false);
%%
lbl = cellfun(@bwlabel,masks5,'UniformOutput',false);
stats = @(x) regionprops(x,'Area','Eccentricity');
stats_o = cellfun(stats,lbl,'UniformOutput',false);
%%
eccen_o = [0.2695 0.2595 0.1743 0.2381 0.2575 0.1761 0.2233 0.1434 0.2303 0.1502 0.3164 0.2479 0.4116 0.2416 0.3817 0.4448 0.3401 0.2392 0.1581 0.3724];
hue_o = meanh;





%% bananas and mangoes
mims = cell(20,1); bims = cell(20,1);
for k = 1:numfiles
    fname1 = sprintf('mango%d.jpg', k);
    fn1 = fullfile('C:', 'Users', 'LJ', 'Desktop', 'LJ AP186', 'Act12', 'samples', 'mangoes', fname1);
    fname2 = sprintf('banana%d.jpg', k);
    fn2 = fullfile('C:', 'Users', 'LJ', 'Desktop', 'LJ AP186', 'Act12', 'samples', 'banana', fname2);
    mims{k} = imread(fn1);
    bims{k} = imread(fn2);
end
%%
mrois = cell(20,1);
for k = 1:numfiles
    mrois{k} = imcrop(mims{k});
end
%% fix
for k = [12]
    mrois{k} = imcrop(mims{k});
end
%%
hsvmrois = cellfun(@rgb2hsv, mrois, 'UniformOutput', false);

hmrois = cell(20,1); smrois = cell(20,1); vmrois = cell(20,1);
for k = 1:numfiles
    hmrois{k} = hsvmrois{k}(:,:,1);
    smrois{k} = hsvmrois{k}(:,:,2);
    vmrois{k} = hsvmrois{k}(:,:,3);
end

mn = @(x) mean(x,'all');
meanmh = cellfun(mn, hmrois);

mhistos = cellfun(@patchz,mrois, 'UniformOutput', false);
mmasks = cellfun(@nonpara, mims, mhistos,'UniformOutput',false);
%%
mmasks2 = cellfun(@binzz, mmasks, 'UniformOutput',false);
%%
mmasks3= cellfun(fillz,mmasks2,'UniformOutput',false);
%%
mmasks4 = cellfun(cloze,mmasks3,'UniformOutput',false);
mmasks5 = cellfun(fillz,mmasks4,'UniformOutput', false);
%%
mlbl = cellfun(@bwlabel,mmasks5,'UniformOutput',false);
stats_m = cellfun(stats,mlbl,'UniformOutput',false);
%%
eccen_m = [0.8580 0.7255 0.8485 0.6800 0.6991 0.5294 0.5291 0.6194 0.4242 0.6504 0.8694 0.7155 0.7507 0.6959 0.6364 0.8566 0.7851 0.7690 0.8472 0.6484];
hue_m = meanmh;



%%
brois = cell(20,1);
for k = 1:numfiles
    brois{k} = imcrop(bims{k});
end
%%
hsvbrois = cellfun(@rgb2hsv, brois, 'UniformOutput', false);

hbrois = cell(20,1); sbrois = cell(20,1); vbrois = cell(20,1);
for k = 1:numfiles
    hbrois{k} = hsvbrois{k}(:,:,1);
    sbrois{k} = hsvbrois{k}(:,:,2);
    vbrois{k} = hsvbrois{k}(:,:,3);
end

mn = @(x) mean(x,'all');
meanbh = cellfun(mn, hbrois);

bhistos = cellfun(@patchz,brois, 'UniformOutput', false);
bmasks = cellfun(@nonpara, bims, bhistos,'UniformOutput',false);
%%
bmasks2 = cellfun(@binzz, bmasks, 'UniformOutput',false);
%%
bmasks3= cellfun(fillz,bmasks2,'UniformOutput',false);
%%
bmasks4 = cellfun(cloze,bmasks3,'UniformOutput',false);
bmasks5 = cellfun(fillz,bmasks4,'UniformOutput', false);
%%
blbl = cellfun(@bwlabel,bmasks5,'UniformOutput',false);
stats_b = cellfun(stats,blbl,'UniformOutput',false);
%%
%%
eccen_b = [0.8980 0.9361 0.9172 0.8622 0.9025 0.9456 0.9159 0.9143 0.9337 0.9246 0.9587 0.9349 0.9300 0.9467 0.8660 0.9175 0.9486 0.9588 0.9294 0.9078];
hue_b = meanbh;
%% plots
plot(eccen_o, hue_o,'ro'); hold on;
plot(eccen_m, hue_m,'go');
plot(eccen_b, hue_b,'yo');
xlabel('Eccentricity');
ylabel('Hue');
%%
function histo = patchz(x)
    pR = double(x(:,:,1));
    pG = double(x(:,:,2));
    pB = double(x(:,:,3));

    I = pR+pG+pB;
    I(find(I==0)) = 1000000;
    nR = pR./I;
    nG = pG./I;
    nB = pB./I;

    BINS = 60;
    rint = round(nR*(BINS-1)+1);
    gint = round(nG*(BINS-1)+1);
    colors = gint(:) + (rint(:)-1)*BINS;
    histo = zeros(BINS,BINS);
    for row = 1:BINS
        for col = 1:(BINS-row+1)
            histo(row,col)= length(find(colors==(((col+(row-1)*BINS)))));
        end;
    end;
end

function bproj = nonpara(im, histo)
    im = double(im);

    imR = im(:,:,1);
    imG = im(:,:,2);
    imB = im(:,:,3);

    imI = imR+imG+imB;
    imI(imI==0)=100000000;
    RIm = imR./imI; GIm = imG./imI;
    
    BINS = 60;
    [ro,co] = size(imR);
    bproj = zeros(ro,co);


    for i = 1:co
        for j = 1:ro
            rbp = round(RIm(j,i)*(BINS-1)+1);
            gbp = round(GIm(j,i)*(BINS-1)+1);
            bproj(j,i) = histo(rbp,gbp);
        end
    end
end

function binz = binzz(x)
    binz = repmat(x,1);
    binz = binz/max(binz,[],'all');
    a = find(binz>0&binz<1);
    binz(a)=1;
end