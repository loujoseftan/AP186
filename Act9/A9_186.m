% Loading and Segmenting the Sheet Music
im = imread('ff_prelude.jpg'); im = rgb2gray(im);
bw_im = im < 200;
% figure(1); imshow(bw_im);

% Removing the lines from the Sheet Music
se1 = strel('line',3,90);
notes = imerode(bw_im,se1);
notes = bwareaopen(notes,160);
se2 = strel('line',3,20);
notes = imerode(notes,se2);
se3 = strel('line',3,20);
notes = imdilate(notes,se3);
% figure(2); imshow(notes);

% Segmenting the heads and the bars separately
L = bwconncomp(notes);
stats_notes = regionprops(notes,'Centroid', 'Area');
idx_heads = find([stats_notes.Area] < 35 & [stats_notes.Area] > 12); 
note_heads = ismember(labelmatrix(L), idx_heads);  %Note Heads
% figure(3); imshow(note_heads);
idx_bars = find([stats_notes.Area] > 35 | [stats_notes.Area] < 12); 
note_bars = ismember(labelmatrix(L), idx_bars); %Note Bars
% figure(4); imshow(note_bars);

% Segmenting the lines
se4 = strel('line', 40, 0);
lines = imerode(bw_im, se4);
L_lines = bwconncomp(lines);
stats_lines = regionprops(lines, 'Centroid', 'Area');
idx_lines = find([stats_lines.Area] > 369);
note_lines = ismember(labelmatrix(L_lines), idx_lines); %Lines
% figure(5); imshow(note_lines);

% Locations of heads and bars
note_head_props = regionprops(note_heads, 'Centroid');
note_head_locs = cat(1, note_head_props.Centroid);
% figure(6); imshow(bw_im); hold on;
% plot(note_head_locs(:,1), note_head_locs(:,2),'*');

note_bars_props = regionprops(note_bars, 'Extrema');
note_bars_locs = cat(1, note_bars_props.Extrema);
% figure(7); imshow(bw_im); hold on;
% plot(note_bars_locs(:,1), note_bars_locs(:,2),'*');

% Locations of lines
note_line_props = regionprops(note_lines, 'Centroid');
note_line_locs = cat(1, note_line_props.Centroid);
[note_line_locs(:,2), idx] = sort(note_line_locs(:,2));
note_line_locs(:,1) = note_line_locs(idx);
% figure(8); imshow(note_lines); hold on;
% plot(note_line_locs(:,1), note_line_locs(:,2),'*');

% Spaces between lines

% 1st two lines
d_set1a = [];
d_set1b = [];
d_set1_between = abs(note_line_locs(1,2) - note_line_locs(6,2));
d_set12 = abs(note_line_locs(10,2) - note_line_locs(11,2));

for  i = 1:4
    d_set1a(i) = abs(note_line_locs(i,2) - note_line_locs(i+1,2));
    d_set1b(i) = abs(note_line_locs(i+5,2) - note_line_locs(i+6,2));
end

d1a_ave = mean(d_set1a); d1b_ave = mean(d_set1b);

set1 = bw_im(floor(146.5018 - d_set12/2) : ceil(222.4982 + d_set12/2),:);
set1_heads = note_heads(floor(146.5018 - d_set12/2):ceil(222.4982 + d_set12/2),:);
set1_lines = note_lines(floor(146.5018 - d_set12/2):ceil(222.4982 + d_set12/2),:);
set1_line_props = regionprops(set1_lines, 'Centroid');
set1_line_locs = cat(1, set1_line_props.Centroid);
[set1_line_locs(:,2), idx2] = sort(set1_line_locs(:,2));
set1_line_locs(:,1) = set1_line_locs(idx2);
set1_head_props = regionprops(set1_heads, 'Centroid');
set1_head_locs = cat(1, set1_head_props.Centroid);
% figure(9); imshow(set1_heads);
% hold on; plot(set1_head_locs(1:2,1),set1_head_locs(1:2,2),'*');

% test = find(set1_head_locs(1:16,1) < 203);

% Notes
t = [0:1/9000:0.130];
note = @(f) sin(2*pi*f*t);

ffnotes = zeros(1,64);
ffnotes2 = zeros(1,64);

for i = 1:16
    %G4 to C4 + B4 and A4 [TOP]
    if  set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(19);
        ffnotes2(i) = freqnotes2(19);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(18);
        ffnotes2(i) = freqnotes2(18);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(17);
        ffnotes2(i) = freqnotes2(17);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(16);
        ffnotes2(i) = freqnotes2(16);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - 3*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(15);
        ffnotes2(i) = freqnotes2(15);
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - 4*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4 - 4*d1a_ave) % B4
        ffnotes(i) = freqnotes(21);
        ffnotes2(i) = freqnotes2(21);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 4*d1a_ave) && set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(20);
        ffnotes2(i) = freqnotes2(20);
    %B3 to C3 [TOP]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - d1a_ave)
        ffnotes(i) = freqnotes(14);
        ffnotes2(i) = freqnotes2(14);
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(13);
        ffnotes2(i) = freqnotes2(13);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4) && set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(12);
        ffnotes2(i) = freqnotes2(12);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(11);
        ffnotes2(i) = freqnotes2(11);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(10);
        ffnotes2(i) = freqnotes2(10);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(9);
        ffnotes2(i) = freqnotes2(9);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 - d1a_ave/4) && set1_head_locs(i,2) < ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(8);
        ffnotes2(i) = freqnotes2(8);
    %B3 to C3 [BOTTOM]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - d1a_ave + d_set1_between) && set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - d1a_ave + d_set1_between)
        ffnotes(i) = freqnotes(14);
        ffnotes2(i) = freqnotes2(14);
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4 + d_set1_between) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(13);
        ffnotes2(i) = freqnotes2(13);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 + d_set1_between) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(12);
        ffnotes2(i) = freqnotes2(12);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4 + d_set1_between) && set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(11);
        ffnotes2(i) = freqnotes2(11);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4 + d_set1_between) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(10);
        ffnotes2(i) = freqnotes2(10);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - d1a_ave/4 + d_set1_between) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(9);
        ffnotes2(i) = freqnotes2(9);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 - d1a_ave/4 + d_set1_between) & set1_head_locs(i,2) < ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 + d1a_ave/4 + d_set1_between)
        ffnotes(i) = freqnotes(8);
        ffnotes2(i) = freqnotes2(8);
    %B2 to C2 [BOTTOM]
    elseif set1_head_locs(i,2) > (set1_line_locs(9,2) - d1a_ave/4) && set1_head_locs(i,2) < (set1_line_locs(9,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(7);
        ffnotes2(i) = freqnotes2(7);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(6);
        ffnotes2(i) = freqnotes2(6);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(5);
        ffnotes2(i) = freqnotes2(5);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 + d1a_ave) && set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(4);
        ffnotes2(i) = freqnotes2(4);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4 + d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(3);
        ffnotes2(i) = freqnotes2(3);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 + 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 + 2*d1a_ave)
        ffnotes(i) = freqnotes(2);
        ffnotes2(i) = freqnotes2(2);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4 + 2*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4 + 2*d1a_ave)
        ffnotes(i) = freqnotes(1);
        ffnotes2(i) = freqnotes2(1);
    end
end


for i = 17:48
    % C7 [TOP]
    if  set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 5.5*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 5.5*d1a_ave)
        ffnotes(i) = freqnotes(36);
        ffnotes2(i) = freqnotes2(36);
    %B6 to C6 [TOP]
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(35);
        ffnotes2(i) = freqnotes2(35);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(34);
        ffnotes2(i) = freqnotes2(34);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(33);
        ffnotes2(i) = freqnotes2(33);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(32);
        ffnotes2(i) = freqnotes2(32);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - 5*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(31);
        ffnotes2(i) = freqnotes2(31);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(30);
        ffnotes2(i) = freqnotes2(30);
    elseif set1_head_locs(i,2) > (set1_line_locs(4,2) - 5*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(4,2) + d1a_ave/4 - 4*d1a_ave) % B4
        ffnotes(i) = freqnotes(29);
        ffnotes2(i) = freqnotes2(29);
    %B5 to C5 [TOP]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(28);
        ffnotes2(i) = freqnotes2(28);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(27);
        ffnotes2(i) = freqnotes2(27);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(26);
        ffnotes2(i) = freqnotes2(26);
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(25);
        ffnotes2(i) = freqnotes2(25);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(24);
        ffnotes2(i) = freqnotes2(24);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(23);
        ffnotes2(i) = freqnotes2(23);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(22);
        ffnotes2(i) = freqnotes2(22);
    %C6 [BOTTOM]
    elseif set1_head_locs(i,2) > (set1_line_locs(6,2) - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(6,2) + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(29);
        ffnotes2(i) = freqnotes2(29);
    %B5 to C5 [BOTTOM]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(28);
        ffnotes2(i) = freqnotes2(28);
    elseif set1_head_locs(i,2) > (set1_line_locs(7,2) - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(7,2) + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(27);
        ffnotes2(i) = freqnotes2(27);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 - d1a_ave/4 - 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 + d1a_ave/4 - 2*d1a_ave)
        ffnotes(i) = freqnotes(26);
        ffnotes2(i) = freqnotes2(26);
    elseif set1_head_locs(i,2) > (set1_line_locs(6,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(6,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(25);
        ffnotes2(i) = freqnotes2(25);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(24);
        ffnotes2(i) = freqnotes2(24);
    elseif set1_head_locs(i,2) > (set1_line_locs(7,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(7,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(23);
        ffnotes2(i) = freqnotes2(23);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(22);
        ffnotes2(i) = freqnotes2(22);
    %B4 to C4 [BOTTOM]
    elseif set1_head_locs(i,2) > (set1_line_locs(8,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(8,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(21);
        ffnotes2(i) = freqnotes2(21);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(8,2)+set1_line_locs(9,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(8,2)+set1_line_locs(9,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(20);
        ffnotes2(i) = freqnotes2(20);
    elseif set1_head_locs(i,2) > (set1_line_locs(9,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(9,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(19);
        ffnotes2(i) = freqnotes2(19);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(18);
        ffnotes2(i) = freqnotes2(18);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(17);
        ffnotes2(i) = freqnotes2(17);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 + d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(16);
        ffnotes2(i) = freqnotes2(16);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4 + d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(15);
        ffnotes2(i) = freqnotes2(16);
    end
end

for i = 49:64
    % C5 [TOP]
    if  set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 5*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 5*d1a_ave)
        ffnotes(i) = freqnotes(22);
        ffnotes2(i) = freqnotes2(22);
    % B4 to C4 [TOP]
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4 - 4*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(21);
        ffnotes2(i) = freqnotes2(21);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - 4*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(20);
        ffnotes2(i) = freqnotes2(20);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4 - 4*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(19);
        ffnotes2(i) = freqnotes2(19);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4 - 4*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(18);
        ffnotes2(i) = freqnotes2(18);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - 4*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(17);
        ffnotes2(i) = freqnotes2(17);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 - d1a_ave/4 - 4*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 + d1a_ave/4 - 4*d1a_ave)
        ffnotes(i) = freqnotes(16);
        ffnotes2(i) = freqnotes2(16);
    elseif set1_head_locs(i,2) > (set1_line_locs(4,2) - 4*d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(4,2) + d1a_ave/4 - 4*d1a_ave) % B4
        ffnotes(i) = freqnotes(15);
        ffnotes2(i) = freqnotes2(15);
    %B3 to C3 [TOP]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4 - d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4 - d1a_ave)
        ffnotes(i) = freqnotes(14);
        ffnotes2(i) = freqnotes2(14);
    elseif set1_head_locs(i,2) > (set1_line_locs(1,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(1,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(13);
        ffnotes2(i) = freqnotes2(13);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 - d1a_ave/4) && set1_head_locs(i,2) < ( (set1_line_locs(1,2)+set1_line_locs(2,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(12);
        ffnotes2(i) = freqnotes2(12);
    elseif set1_head_locs(i,2) > (set1_line_locs(2,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(2,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(11);
        ffnotes2(i) = freqnotes2(11);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(2,2)+set1_line_locs(3,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(10);
        ffnotes2(i) = freqnotes2(10);
    elseif set1_head_locs(i,2) > (set1_line_locs(3,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(3,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(9);
        ffnotes2(i) = freqnotes2(9);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(3,2)+set1_line_locs(4,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(8);
        ffnotes2(i) = freqnotes2(8);
    % C4 [BOTTOM]
    elseif set1_head_locs(i,2) > (set1_line_locs(6,2) - d1a_ave - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(6,2) + d1a_ave/4 - d1a_ave) % B4
        ffnotes(i) = freqnotes(15);
        ffnotes2(i) = freqnotes2(15);
    % B3 to C3 [BOTTOM]
    elseif set1_head_locs(i,2) > ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 - d1a_ave/4 - d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 + d1a_ave/4 - d1a_ave)
        ffnotes(i) = freqnotes(14);
        ffnotes2(i) = freqnotes2(14);
    elseif set1_head_locs(i,2) > (set1_line_locs(6,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(6,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(13);
        ffnotes2(i) = freqnotes2(13);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 - d1a_ave/4) && set1_head_locs(i,2) < ( (set1_line_locs(6,2)+set1_line_locs(7,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(12);
        ffnotes2(i) = freqnotes2(12);
    elseif set1_head_locs(i,2) > (set1_line_locs(7,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(7,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(11);
        ffnotes2(i) = freqnotes2(11);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(7,2)+set1_line_locs(8,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(10);
        ffnotes2(i) = freqnotes2(10);
    elseif set1_head_locs(i,2) > (set1_line_locs(8,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(8,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(9);
        ffnotes2(i) = freqnotes2(9);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(8,2)+set1_line_locs(9,2))/2 - d1a_ave/4) & set1_head_locs(i,2) < ( (set1_line_locs(8,2)+set1_line_locs(9,2))/2 + d1a_ave/4)
        ffnotes(i) = freqnotes(8);
        ffnotes2(i) = freqnotes2(8);
    % B2 to C2 [BOTTOM]
    elseif set1_head_locs(i,2) > (set1_line_locs(9,2) - d1a_ave/4) && set1_head_locs(i,2) < (set1_line_locs(9,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(7);
        ffnotes2(i) = freqnotes2(7);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 - 3*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 - 3*d1a_ave)
        ffnotes(i) = freqnotes(6);
        ffnotes2(i) = freqnotes2(6);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4)
        ffnotes(i) = freqnotes(5);
        ffnotes2(i) = freqnotes2(5);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 + d1a_ave) && set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(4);
        ffnotes2(i) = freqnotes2(4);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4 + d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4 + d1a_ave)
        ffnotes(i) = freqnotes(3);
        ffnotes2(i) = freqnotes2(3);
    elseif set1_head_locs(i,2) > ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 - d1a_ave/4 + 2*d1a_ave) & set1_head_locs(i,2) < ( (set1_line_locs(9,2)+set1_line_locs(10,2))/2 + d1a_ave/4 + 2*d1a_ave)
        ffnotes(i) = freqnotes(2);
        ffnotes2(i) = freqnotes2(2);
    elseif set1_head_locs(i,2) > (set1_line_locs(10,2) - d1a_ave/4 + 2*d1a_ave) & set1_head_locs(i,2) < (set1_line_locs(10,2) + d1a_ave/4 + 2*d1a_ave)
        ffnotes(i) = freqnotes(1);
        ffnotes2(i) = freqnotes2(1);
    
    end
end

s = [note(ffnotes(1)) + note(ffnotes(2)),note(ffnotes(3)) + note(ffnotes(4)),note(ffnotes(5)) + note(ffnotes(6)),...
    note(ffnotes(7)) + note(ffnotes(8)),note(ffnotes(9)) + note(ffnotes(10)),note(ffnotes(11)) + note(ffnotes(12)),...
    note(ffnotes(13)) + note(ffnotes(14)),note(ffnotes(15)) + note(ffnotes(16)),note(ffnotes(17)) + note(ffnotes(18)),...
    note(ffnotes(19)) + note(ffnotes(20)), note(ffnotes(21)) + note(ffnotes(22)), note(ffnotes(23)) + note(ffnotes(24)), ...
    note(ffnotes(25)) + note(ffnotes(26)), note(ffnotes(27)) + note(ffnotes(28)), note(ffnotes(29)) + note(ffnotes(30)), ...
    note(ffnotes(31)) + note(ffnotes(32)), note(ffnotes(33)) + note(ffnotes(34)), note(ffnotes(35)) + note(ffnotes(36)), ...
    note(ffnotes(37)) + note(ffnotes(38)), note(ffnotes(39)) + note(ffnotes(40)), note(ffnotes(41)) + note(ffnotes(42)), ...
    note(ffnotes(43)) + note(ffnotes(44)), note(ffnotes(45)) + note(ffnotes(46)), note(ffnotes(47)) + note(ffnotes(48)), ...
    note(ffnotes(49)) + note(ffnotes(50)), note(ffnotes(51)) + note(ffnotes(52)), note(ffnotes(53)) + note(ffnotes(54)), ...
    note(ffnotes(55)) + note(ffnotes(56)), note(ffnotes(57)) + note(ffnotes(58)), note(ffnotes(59)) + note(ffnotes(60)), ...
    note(ffnotes(61)) + note(ffnotes(62)), note(ffnotes(63)) + note(ffnotes(64)), note(ffnotes2(1)) + note(ffnotes2(2)),note(ffnotes2(3)) + note(ffnotes2(4)),note(ffnotes2(5)) + note(ffnotes2(6)),...
    note(ffnotes2(7)) + note(ffnotes2(8)),note(ffnotes2(9)) + note(ffnotes2(10)),note(ffnotes2(11)) + note(ffnotes2(12)),...
    note(ffnotes2(13)) + note(ffnotes2(14)),note(ffnotes2(15)) + note(ffnotes2(16)),note(ffnotes2(17)) + note(ffnotes2(18)),...
    note(ffnotes2(19)) + note(ffnotes2(20)), note(ffnotes2(21)) + note(ffnotes2(22)), note(ffnotes2(23)) + note(ffnotes2(24)), ...
    note(ffnotes2(25)) + note(ffnotes2(26)), note(ffnotes2(27)) + note(ffnotes2(28)), note(ffnotes2(29)) + note(ffnotes2(30)), ...
    note(ffnotes2(31)) + note(ffnotes2(32)), note(ffnotes2(33)) + note(ffnotes2(34)), note(ffnotes2(35)) + note(ffnotes2(36)), ...
    note(ffnotes2(37)) + note(ffnotes2(38)), note(ffnotes2(39)) + note(ffnotes2(40)), note(ffnotes2(41)) + note(ffnotes2(42)), ...
    note(ffnotes2(43)) + note(ffnotes2(44)), note(ffnotes2(45)) + note(ffnotes2(46)), note(ffnotes2(47)) + note(ffnotes2(48)), ...
    note(ffnotes2(49)) + note(ffnotes2(50)), note(ffnotes2(51)) + note(ffnotes2(52)), note(ffnotes2(53)) + note(ffnotes2(54)), ...
    note(ffnotes2(55)) + note(ffnotes2(56)), note(ffnotes2(57)) + note(ffnotes2(58)), note(ffnotes2(59)) + note(ffnotes2(60)), ...
    note(ffnotes2(61)) + note(ffnotes2(62)), note(ffnotes2(63)) + note(ffnotes2(64)),note(ffnotes(1)) + note(ffnotes(2)),note(ffnotes(3)) + note(ffnotes(4)),note(ffnotes(5)) + note(ffnotes(6)),...
    note(ffnotes(7)) + note(ffnotes(8)),note(ffnotes(9)) + note(ffnotes(10)),note(ffnotes(11)) + note(ffnotes(12)),...
    note(ffnotes(13)) + note(ffnotes(14)),note(ffnotes(15)) + note(ffnotes(16)),note(ffnotes(17)) + note(ffnotes(18)),...
    note(ffnotes(19)) + note(ffnotes(20)), note(ffnotes(21)) + note(ffnotes(22)), note(ffnotes(23)) + note(ffnotes(24)), ...
    note(ffnotes(25)) + note(ffnotes(26)), note(ffnotes(27)) + note(ffnotes(28)), note(ffnotes(29)) + note(ffnotes(30)), ...
    note(ffnotes(31)) + note(ffnotes(32)), note(ffnotes(33)) + note(ffnotes(34)), note(ffnotes(35)) + note(ffnotes(36)), ...
    note(ffnotes(37)) + note(ffnotes(38)), note(ffnotes(39)) + note(ffnotes(40)), note(ffnotes(41)) + note(ffnotes(42)), ...
    note(ffnotes(43)) + note(ffnotes(44)), note(ffnotes(45)) + note(ffnotes(46)), note(ffnotes(47)) + note(ffnotes(48)), ...
    note(ffnotes(49)) + note(ffnotes(50)), note(ffnotes(51)) + note(ffnotes(52)), note(ffnotes(53)) + note(ffnotes(54)), ...
    note(ffnotes(55)) + note(ffnotes(56)), note(ffnotes(57)) + note(ffnotes(58)), note(ffnotes(59)) + note(ffnotes(60)), ...
    note(ffnotes(61)) + note(ffnotes(62)), note(ffnotes(63)) + note(ffnotes(64)), note(ffnotes2(1)) + note(ffnotes2(2)),note(ffnotes2(3)) + note(ffnotes2(4)),note(ffnotes2(5)) + note(ffnotes2(6)),...
    note(ffnotes2(7)) + note(ffnotes2(8)),note(ffnotes2(9)) + note(ffnotes2(10)),note(ffnotes2(11)) + note(ffnotes2(12)),...
    note(ffnotes2(13)) + note(ffnotes2(14)),note(ffnotes2(15)) + note(ffnotes2(16)),note(ffnotes2(17)) + note(ffnotes2(18)),...
    note(ffnotes2(19)) + note(ffnotes2(20)), note(ffnotes2(21)) + note(ffnotes2(22)), note(ffnotes2(23)) + note(ffnotes2(24)), ...
    note(ffnotes2(25)) + note(ffnotes2(26)), note(ffnotes2(27)) + note(ffnotes2(28)), note(ffnotes2(29)) + note(ffnotes2(30)), ...
    note(ffnotes2(31)) + note(ffnotes2(32)), note(ffnotes2(33)) + note(ffnotes2(34)), note(ffnotes2(35)) + note(ffnotes2(36)), ...
    note(ffnotes2(37)) + note(ffnotes2(38)), note(ffnotes2(39)) + note(ffnotes2(40)), note(ffnotes2(41)) + note(ffnotes2(42)), ...
    note(ffnotes2(43)) + note(ffnotes2(44)), note(ffnotes2(45)) + note(ffnotes2(46)), note(ffnotes2(47)) + note(ffnotes2(48)), ...
    note(ffnotes2(49)) + note(ffnotes2(50)), note(ffnotes2(51)) + note(ffnotes2(52)), note(ffnotes2(53)) + note(ffnotes2(54)), ...
    note(ffnotes2(55)) + note(ffnotes2(56)), note(ffnotes2(57)) + note(ffnotes2(58)), note(ffnotes2(59)) + note(ffnotes2(60)), ...
    note(ffnotes2(61)) + note(ffnotes2(62)), note(ffnotes2(63)) + note(ffnotes2(64))];

% soundsc(s);

s3 = (s - min(s,[],'all'))/(max(s,[],'all') - min(s,[],'all'));
audiowrite('ff_prelude.wav',s3, 8192);