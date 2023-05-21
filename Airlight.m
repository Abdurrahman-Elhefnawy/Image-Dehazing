function A = Airlight(HazeImg, wsz)
% estimating the global airlight
%
hsv = rgb2hsv(HazeImg);
GrayImg = hsv(:, :, 3);
[nRows, nCols, bt] = size(HazeImg);

% computing dark channel
DarkImg = min(double(HazeImg), [], 3);
DarkImg = ordfilt2(DarkImg, 1, ones(wsz), 'symmetric');
% 
topDark = sort(DarkImg(:), 'descend');
idx = round(0.001 * length(topDark));
val = topDark(idx); 
id_set = find(DarkImg >= val);  % the top 0.1% brightest pixels in the dark channel
BrightPxls = GrayImg(id_set);
iBright = find(BrightPxls >= max(BrightPxls));
id = id_set(iBright); id = id(1);
row = mod(id, nRows);
col = floor(id / nRows) + 1;

% A is a vector
A = HazeImg(row, col, :);
A = double(A(:));

