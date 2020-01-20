function img_area = select_pts_in_area(img, rect)


%function img_area = select_pts_in_area(img, rect)
%rect = [x1, x1; y1, y2]

minx = min(rect(1,:));
miny = min(rect(2,:));
maxx = max(rect(1,:));
maxy = max(rect(2,:));

idx = find( (img(2,:)>minx).*(img(3,:)>miny).*(img(2,:)<maxx).*(img(3,:)<maxy));
img_area = img(:, idx);


