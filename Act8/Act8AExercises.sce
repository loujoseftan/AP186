//Structure Elements
se1 = imcreatese('rect',2,2);
se2 = imcreatese('rect',2,1);
se3 = imcreatese('rect',1,2);
se4 = imcreatese('cross',3,3);
se5 = imcreatese('rect',2,2);
se5(1,2)=0
se5(2,1)=0
disp(se1)
disp(se2)
disp(se3)
disp(se4)
disp(se5)

//2x2 Square Erosion and Dilation
sqr = zeros(9,9);
sqr(3:7,3:7)=1;
scf();imshow(sqr)

imout1 = imerode(sqr,se1)
imout2 = imerode(sqr,se2)
imout3 = imerode(sqr,se3)
imout4 = imerode(sqr,se4)
imout5 = imerode(sqr,se5)

scf();imshow(imout1)
scf();imshow(imout2)
scf();imshow(imout3)
scf();imshow(imout4)
scf();imshow(imout5)

imout6 = imdilate(sqr,se1)
imout7 = imdilate(sqr,se2)
imout8 = imdilate(sqr,se3)
imout9 = imdilate(sqr,se4)
imout10 = imdilate(sqr,se5)

scf();imshow(imout6)
scf();imshow(imout7)
scf();imshow(imout8)
scf();imshow(imout9)
scf();imshow(imout10)

//Triangle 4boxbase 3boxheight
tgl = zeros(9,9);
tgl(7,3:6)=1;
tgl(6,4:6)=1;
tgl(5,6)=1;
scf();imshow(tgl)

imout11 = imerode(tgl,se1)
imout12 = imerode(tgl,se2)
imout13 = imerode(tgl,se3)
imout14 = imerode(tgl,se4)
imout15 = imerode(tgl,se5)

scf();imshow(imout11)
scf();imshow(imout12)
scf();imshow(imout13)
scf();imshow(imout14)
scf();imshow(imout15)

imout16 = imdilate(tgl,se1)
imout17 = imdilate(tgl,se2)
imout18 = imdilate(tgl,se3)
imout19 = imdilate(tgl,se4)
imout20 = imdilate(tgl,se5)

scf();imshow(imout16)
scf();imshow(imout17)
scf();imshow(imout18)
scf();imshow(imout19)
scf();imshow(imout20)

//Hollow 10x10 Square 2 Boxes Thick
hlw = zeros(14,14)
hlw(3:4,3:12)=1
hlw(11:12,3:12)=1
hlw(3:12,3:4)=1
hlw(3:12,11:12)=1
scf();imshow(hlw)

imout21 = imerode(hlw,se1)
imout22 = imerode(hlw,se2)
imout23 = imerode(hlw,se3)
imout24 = imerode(hlw,se4)
imout25 = imerode(hlw,se5)

scf();imshow(imout21)
scf();imshow(imout22)
scf();imshow(imout23)
scf();imshow(imout24)
scf();imshow(imout25)

imout26 = imdilate(hlw,se1)
imout27 = imdilate(hlw,se2)
imout28 = imdilate(hlw,se3)
imout29 = imdilate(hlw,se4)
imout30 = imdilate(hlw,se5)

scf();imshow(imout26)
scf();imshow(imout27)
scf();imshow(imout28)
scf();imshow(imout29)
scf();imshow(imout30)

//5x5 Cross
crs = zeros(9,9)
crs(3:7,5)=1
crs(5,3:7)=1
scf();imshow(crs)

imout31 = imerode(crs,se1)
imout32 = imerode(crs,se2)
imout33 = imerode(crs,se3)
imout34 = imerode(crs,se4)
imout35 = imerode(crs,se5)

scf();imshow(imout31)
scf();imshow(imout32)
scf();imshow(imout33)
scf();imshow(imout34)
scf();imshow(imout35)

imout36 = imdilate(crs,se1)
imout37 = imdilate(crs,se2)
imout38 = imdilate(crs,se3)
imout39 = imdilate(crs,se4)
imout40 = imdilate(crs,se5)

scf();imshow(imout36)
scf();imshow(imout37)
scf();imshow(imout38)
scf();imshow(imout39)
scf();imshow(imout40)
