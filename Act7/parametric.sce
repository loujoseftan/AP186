ROI = imread('C:\Users\loujoseftan\Dropbox\SciNotes\ROI.jpg');
ROI = double(ROI);
R1 = ROI(:,:,1);
G1 = ROI(:,:,2);
B1 = ROI(:,:,3);
I1 = R1 + G1 + B1;
I1(find(I1==0))=100000;
r1 = R1./I1;
g1 = G1./I1;

meanr = mean(r1);
sigmar = stdev(r1);
meang = mean(g1);
sigmag = stdev(g1);

SB = imread('C:\Users\loujoseftan\Dropbox\SciNotes\SB.jpg');
SB = double(SB);
R2 = SB(:,:,1);
G2 = SB(:,:,2);
B2 = SB(:,:,3);
I2 = R2 + G2 + B2;
I2(find(I2==0))=100000;
r2 = R2./I2;
g2 = G2./I2;

pr = (1/(sigmar*sqrt(2*%pi)))*exp(-((r2 - meanr).^2)/(2*sigmar.^2));
pg = (1/(sigmag*sqrt(2*%pi)))*exp(-((g2 - meang).^2)/(2*sigmag.^2));
S = pr.*pg;

imwrite(S,'C:\Users\loujoseftan\Dropbox\SciNotes\Parametric Segmentation.jpg')
