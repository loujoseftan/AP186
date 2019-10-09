%% Create Structural Elements
se_1 = strel([0 0 0; 0 1 1; 0 1 1]); %2x2 ones
se_2 = strel([0 0 0; 0 1 0; 0 1 0]); %2x1 ones
se_3 = strel([0 0 0; 0 1 1; 0 0 0]); %1x2 ones
se_4 = strel([0 1 0; 1 1 1; 0 1 0]); %cross
se_5 = strel([0 0 1; 0 1 0; 0 0 0]); %diagonal

%% Create Shapes
square = zeros(9,9);
square(3:7,3:7) = 1;
% imshow(square);

triangle = zeros(9,9);
triangle(6,3:6) = 1;
triangle(5,4:6) = 1;
triangle(4,6) = 1;
% imshow(triangle);

hollow = zeros(14,14);
hollow(3:4,3:12) = 1;
hollow(11:12,3:12) = 1;
hollow(3:12,3:4) = 1;
hollow(3:12,11:12) = 1;
% imshow(hollow);

cross = zeros(9,9);
cross(3:7,5) = 1;
cross(5,3:7) = 1;
% imshow(cross);

%% Erosion of 5x5 Square

sqr_er1 = imerode(square, se_1); %2x2
sqr_er2 = imerode(square, se_2); %2x1
sqr_er3 = imerode(square, se_3); %1x2
sqr_er4 = imerode(square, se_4); %cross
sqr_er5 = imerode(square, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_er1);
title('SE 1');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_er2);
title('SE 2');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_er3);
title('SE 3');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_er4);
title('SE 4');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_er5);
title('SE 5');

%% Dilation of 5x5 Square

sqr_di1 = imdilate(square, se_1); %2x2
sqr_di2 = imdilate(square, se_2); %2x1
sqr_di3 = imdilate(square, se_3); %1x2
sqr_di4 = imdilate(square, se_4); %cross
sqr_di5 = imdilate(square, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_di1);
title('SE 1');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_di2);
title('SE 2');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_di3);
title('SE 3');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_di4);
title('SE 4');

figure();
subplot(1,2,1); imshow(square);
subplot(1,2,2); imshow(sqr_di5);
title('SE 5');

%% Erosion of Triangle

tri_er1 = imerode(triangle, se_1); %2x2
tri_er2 = imerode(triangle, se_2); %2x1
tri_er3 = imerode(triangle, se_3); %1x2
tri_er4 = imerode(triangle, se_4); %cross
tri_er5 = imerode(triangle, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_er1);
title('SE 1');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_er2);
title('SE 2');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_er3);
title('SE 3');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_er4);
title('SE 4');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_er5);
title('SE 5');

%% Dilation of Triangle

tri_di1 = imdilate(triangle, se_1); %2x2
tri_di2 = imdilate(triangle, se_2); %2x1
tri_di3 = imdilate(triangle, se_3); %1x2
tri_di4 = imdilate(triangle, se_4); %cross
tri_di5 = imdilate(triangle, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_di1);
title('SE 1');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_di2);
title('SE 2');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_di3);
title('SE 3');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_di4);
title('SE 4');

figure();
subplot(1,2,1); imshow(triangle);
subplot(1,2,2); imshow(tri_di5);
title('SE 5');

%% Erosion of Hollow Square

hlw_er1 = imerode(hollow, se_1); %2x2
hlw_er2 = imerode(hollow, se_2); %2x1
hlw_er3 = imerode(hollow, se_3); %1x2
hlw_er4 = imerode(hollow, se_4); %cross
hlw_er5 = imerode(hollow, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_er1);
title('SE 1');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_er2);
title('SE 2');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_er3);
title('SE 3');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_er4);
title('SE 4');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_er5);
title('SE 5');

%% Dilation of Hollow Square

hlw_di1 = imdilate(hollow, se_1); %2x2
hlw_di2 = imdilate(hollow, se_2); %2x1
hlw_di3 = imdilate(hollow, se_3); %1x2
hlw_di4 = imdilate(hollow, se_4); %cross
hlw_di5 = imdilate(hollow, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_di1);
title('SE 1');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_di2);
title('SE 2');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_di3);
title('SE 3');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_di4);
title('SE 4');

figure();
subplot(1,2,1); imshow(hollow);
subplot(1,2,2); imshow(hlw_di5);
title('SE 5');

%% Erosion of Cross

crs_er1 = imerode(cross, se_1); %2x2
crs_er2 = imerode(cross, se_2); %2x1
crs_er3 = imerode(cross, se_3); %1x2
crs_er4 = imerode(cross, se_4); %cross
crs_er5 = imerode(cross, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_er1);
title('SE 1');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_er2);
title('SE 2');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_er3);
title('SE 3');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_er4);
title('SE 4');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_er5);
title('SE 5');

%% Dilation of Cross

crs_di1 = imdilate(cross, se_1); %2x2
crs_di2 = imdilate(cross, se_2); %2x1
crs_di3 = imdilate(cross, se_3); %1x2
crs_di4 = imdilate(cross, se_4); %cross
crs_di5 = imdilate(cross, se_5); %diagonal

figure(); 
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_di1);
title('SE 1');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_di2);
title('SE 2');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_di3);
title('SE 3');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_di4);
title('SE 4');

figure();
subplot(1,2,1); imshow(cross);
subplot(1,2,2); imshow(crs_di5);
title('SE 5');

%%
figure();
subplot(5,3,1); imshow(cross); title('Shape');
subplot(5,3,2); imshow(crs_er1); title('Erosion');
subplot(5,3,3); imshow(crs_di1); title('Dilation');
subplot(5,3,4); imshow(cross); 
subplot(5,3,5); imshow(crs_er2); 
subplot(5,3,6); imshow(crs_di2); 
subplot(5,3,7); imshow(cross); 
subplot(5,3,8); imshow(crs_er3); 
subplot(5,3,9); imshow(crs_di3); 
subplot(5,3,10); imshow(cross); 
subplot(5,3,11); imshow(crs_er4); 
subplot(5,3,12); imshow(crs_di4); 
subplot(5,3,13); imshow(cross); 
subplot(5,3,14); imshow(crs_er5); 
subplot(5,3,15); imshow(crs_di5); 