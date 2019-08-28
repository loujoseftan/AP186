dark_im = imread('dark_im.jpg');
dark_im = imrotate(dark_im, -90);
gray_im = rgb2gray(dark_im);
figure(1); imshow(dark_im);
figure(2); imshow(gray_im);
px = size(gray_im);
[counts, x] = imhist(gray_im);
PDF = counts/numel(gray_im);

figure(3); plot(PDF);

CDF = cumsum(PDF);
figure(4); plot(CDF);

ya = CDF;
xa = atanh(ya);
figure(5);
plot(xa,ya);

new_im = zeros(px);
for i = 1:255
    %disp(i)
    clear cy cx;
    index = find(gray_im == i);
    nCDF = CDF(i);
    n_value = xa(find(ya==nCDF));
    new_im(index) = n_value;
end

figure(6); imshow(new_im);

[counts_new, x_new] = imhist(new_im);
PDF_new = counts_new/numel(new_im);
CDF_new = cumsum(PDF_new);
figure(7); plot(CDF_new);