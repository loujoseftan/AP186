%% Load Image
old_im = imread('old_im1.jpg');
old_imR = old_im(:,:,1); old_imR = double(old_imR);
old_imG = old_im(:,:,2); old_imG = double(old_imG);
old_imB = old_im(:,:,3); old_imB = double(old_imB);

%% Contrast Stretching
min_R = min(old_imR,[],'all');
min_G = min(old_imG,[],'all');
min_B = min(old_imB,[],'all');

max_R = max(old_imR,[],'all');
max_G = max(old_imG,[],'all');
max_B = max(old_imB,[],'all');

st_R = (old_imR - min_R)/(max_R - min_R);
st_G = (old_imG - min_G)/(max_G - min_G);
st_B = (old_imB - min_B)/(max_B - min_B);

st_im = cat(3,st_R,st_G,st_B);
imshow(st_im);
%% Gray World Algorithm
gwR_ave = mean(mean(old_imR));
gwG_ave = mean(mean(old_imG));
gwB_ave = mean(mean(old_imB));
gw_ave = mean([gwR_ave gwG_ave gwB_ave]);

gwR = old_imR/gwR_ave*gw_ave/255; %change to 127.5 if necessary
gwG = old_imG/gwG_ave*gw_ave/255; %change to 127.5 if necessary
gwB = old_imB/gwB_ave*gw_ave/255; %change to 127.5 if necessary

gw_im = cat(3,gwR,gwG,gwB);
imshow(gw_im);

%% White Patch Algorithm
wp = imread('white_patch1.png'); wp = double(wp);

wpR = wp(:,:,1);
wpG = wp(:,:,2);
wpB = wp(:,:,3);

wpR_ave = mean(mean(wpR));
wpG_ave = mean(mean(wpG));
wpB_ave = mean(mean(wpB));

wp_R = old_imR/wpR_ave;
wp_G = old_imG/wpG_ave;
wp_B = old_imB/wpB_ave;

wp_im = cat(3,wp_R,wp_G,wp_B);
wp_im_adjusted = wp_im*0.8; %multiplied constant may vary, depends upon choice
imshow(wp_im_adjusted); 
%% GW with CS
min_Rgw = min(gwR,[],'all');
min_Ggw = min(gwG,[],'all');
min_Bgw = min(gwB,[],'all');

max_Rgw = max(gwR,[],'all');
max_Ggw = max(gwG,[],'all');
max_Bgw = max(gwB,[],'all');

st_Rgw = (gwR - min_Rgw)./(max_Rgw - min_Rgw);
st_Ggw = (gwG - min_Ggw)./(max_Ggw - min_Ggw);
st_Bgw = (gwB - min_Bgw)./(max_Bgw - min_Bgw);

st_imgw = cat(3,st_Rgw,st_Ggw,st_Bgw);
imshow(st_imgw);
%% WP with CS
min_Rwp = min(wp_R,[],'all');
min_Gwp = min(wp_G,[],'all');
min_Bwp = min(wp_B,[],'all');

max_Rwp = max(wp_R,[],'all');
max_Gwp = max(wp_G,[],'all');
max_Bwp = max(wp_B,[],'all');

st_Rwp = (wp_R - min_Rwp)./(max_Rwp - min_Rwp);
st_Gwp = (wp_G - min_Gwp)./(max_Gwp - min_Gwp);
st_Bwp = (wp_B - min_Bwp)./(max_Bwp - min_Bwp);

st_imwp = cat(3,st_Rwp,st_Gwp,st_Bwp);
imshow(st_imwp);