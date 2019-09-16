I = imread('C:\Users\loujoseftan\Dropbox\SciNotes\Act 7\ROI.jpg');
I = double(I); //I is the image of the region of interest
imshow(I);
R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
Int = R+G+B;
Int(find(Int==0))=100000;
r = R./ Int; g = G./Int;
BINS = 32;
rint = round(r*(BINS-1) + 1);
gint = round(g*(BINS-1) + 1);

colors = gint(:) + (rint(:)-1)*BINS;
hist = zeros(BINS,BINS);
for row = 1:BINS
    for col = 1:(BINS-row+1)
        hist(row,col) = length(find(colors==(((col + (row-1)*BINS)))));
    end;
end;

imshow(hist)
imwrite(hist,'C:\Users\loujoseftan\Dropbox\SciNotes\Act 7\Histogram.jpg' )

SB = imread('C:\Users\loujoseftan\Dropbox\SciNotes\Act 7\SB.jpg');
SB = double(SB);
R2 = SB(:,:,1);
G2 = SB(:,:,2);
B2 = SB(:,:,3);
I2 = R2 + G2 + B2;
I2(find(I2==0))=100000;
r2 = R2./I2;
g2 = G2./I2;

backproj = zeros(size(r2,1),size(r2,2))
for i = 1:size(r2,1)
    for j = 1:size(r2,2)
        rproj = round(r2(i,j)*(BINS-1)+1);
        gproj = round(g2(i,j)*(BINS-1)+1);
        backproj(i,j) = hist(rproj, gproj);
    end;    
end

imshow(backproj)
imwrite(backproj,'C:\Users\loujoseftan\Dropbox\SciNotes\Act 7\Non-Parametric Segmentation.jpg' )
